{
  inputs = {
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    devshell.url = "github:numtide/devshell";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [ inputs.devshell.flakeModule ];

      perSystem =
        { pkgs, ... }:
        {
          devshells.default = {
            packages = with pkgs; [
              asciidoctor-with-extensions

              (pkgs.writeShellApplication {
                name = "build";

                text = ''
                  asciidoctor-pdf \
                    -a date="$(date +'%Y-%m-%d %H:%M')" index.adoc \
                      --out-file sculpin-from-scratch.pdf
                '';
              })

              (pkgs.writeShellApplication {
                name = "watch";

                runtimeInputs = with pkgs; [
                  coreutils
                  entr
                ];

                text = ''
                  find . -type f -name "*.adoc" | entr build
                '';
              })
            ];
          };
        };
    };
}
