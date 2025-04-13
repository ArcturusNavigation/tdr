<!-- markdownlint-disable MD013 -->

# Autonomy Technical Design Reports

An assorted collection of reports presented during Arcturus Autonomy design reviews

---

## Licensing

Content in this repository is licensed under Creative Commons Attribution-ShareAlike 4.0 International by the Arcturus Autonomy subteam.

You are free (and encouraged) to redistribute any product of this work in any form, but you must provide appropriate attribution by linking to the original (use <https://github.com/ArcturusAutonomy/tdr>). You may not relicense this work, regardless of how you distribute it.

Essentially, this work is and must remain open access and the original should be cited wherever used (so viewers may determine originality).

## Building

If you don't have Nix, you should [install it](https://github.com/DeterminateSystems/nix-installer). It will be [quite useful](https://github.com/orgs/ArcturusNavigation/repositories?q=lang%3Anix&type=all).

This project uses the [Nix](https://nixos.org) build system with [Typix](https://loqusion.github.io/typix/) for declarative and reproducible [Typst](https://typst.app/) document builds. The [Stargazer theme](https://touying-typ.github.io/docs/themes/stargazer) for [Touying](https://touying-typ.github.io/) is used for most presentations. Run the following commands to build and preview any document within this repository:

```sh
cd src/<document>
nix run .#build
```

Open the generated PDF to see the result. If you use `nix run .#watch`, changes will be automatically applied as you save the Typst source.
Lastly, run `nix flake check` to trigger a series of automatic checks for each document.
