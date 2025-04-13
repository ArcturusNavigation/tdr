{
  description = "tdr 1";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      typix,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        typixLib = typix.lib.${system};

        src = ./.;
        commonArgs = {
          typstSource = "main.typ";
          fontPaths = [ ];
          virtualPaths = [ ];
        };
        generatePackagePaths = builtins.map (x: "packages/preview/" + x);
        typst-packages = pkgs.fetchFromGitHub {
          owner = "typst";
          repo = "packages";
          rev = "c73b8832d4281d55dc1f3c139bc239a6083ed6a3";
          hash = "sha256-3eWlCxPdic0sZ0o/9yTxWtswtaa7SBQ8nufaKfF5pNA=";

          sparseCheckout = generatePackagePaths [
            "touying"
            "cetz"
            "cetz-plot"
            "oxifmt"
          ];
        };
        typstPackagesSrc = pkgs.symlinkJoin {
          name = "typst-packages-src";
          paths = [
            "${typst-packages}/packages"
            # more typst packages can be added here
          ];
        };
        typstPackagesCache = pkgs.stdenv.mkDerivation {
          name = "typst-packages-cache";
          src = typstPackagesSrc;
          dontBuild = true;
          installPhase = ''
            mkdir -p "$out/typst/packages"
            cp -LR --reflink=auto --no-preserve=mode -t "$out/typst/packages" "$src"/*
          '';
        };

        # compile a typst project, *without* copying the result
        # to the current directory
        build-drv = typixLib.buildTypstProject (
          commonArgs
          // {
            inherit src;
            XDG_CACHE_HOME = typstPackagesCache;
          }
        );

        # compile a typst project, and then copy the result
        # to the current directory
        build-script = typixLib.buildTypstProjectLocal (
          commonArgs
          // {
            inherit src;
            XDG_CACHE_HOME = typstPackagesCache;
          }
        );

        # watch a project and recompile on changes
        watch-script = typixLib.watchTypstProject commonArgs;
      in
      {
        packages.default = build-drv;

        apps = rec {
          default = watch;
          build = flake-utils.lib.mkApp {
            drv = build-script;
          };
          watch = flake-utils.lib.mkApp {
            drv = watch-script;
          };
        };

        devShells.default = typixLib.devShell {
          inherit (commonArgs) fontPaths virtualPaths;
          packages = [
            # WARNING: don't run `typst-build` directly, instead use `nix run .#build`
            # See https://github.com/loqusion/typix/issues/2
            build-script
            watch-script
            pkgs.typstyle
          ];
        };

        formatter = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
      }
    );
}
