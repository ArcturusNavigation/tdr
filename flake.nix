{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      pre-commit-hooks,
      flake-utils,
    }:
    let
      supportedSystems = flake-utils.lib.defaultSystems;
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      checks = forAllSystems (system: {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixfmt-rfc-style.enable = true;
            typstyle.enable = true;
            markdownlint.enable = true;
            mdsh.enable = true;
            deadnix.enable = true;
            nil.enable = true;
            statix.enable = true;
            typos.enable = true;
            check-merge-conflicts.enable = true;
            commitizen.enable = true;
            gitlint.enable = true;
            forbid-new-submodules.enable = true;
            check-case-conflicts.enable = true;
            check-executables-have-shebangs.enable = true;
            check-shebang-scripts-are-executable.enable = true;
            check-symlinks.enable = true;
            check-vcs-permalinks.enable = true;
            end-of-file-fixer.enable = true;
            mixed-line-endings.enable = true;
            tagref.enable = true;
            trim-trailing-whitespace.enable = true;
            check-yaml.enable = true;
            yamlfmt.enable = true;
            check-json.enable = true;
            actionlint.enable = true;
          };
        };
      });

      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
        };
      });

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    };
}
