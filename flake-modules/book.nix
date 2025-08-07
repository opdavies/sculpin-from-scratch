{
  perSystem =
    { pkgs, ... }:
    {
      devshells.book.packages =
        with pkgs;
        let
          inherit (pkgs) writeShellApplication;
        in
        [
          asciidoctor-with-extensions

          (writeShellApplication {
            name = "build";

            runtimeInputs = [
              pkgs.coreutils
            ];

            text = ''
              asciidoctor-pdf \
                -a date="$(date +'%Y-%m-%d %H:%M')" index.adoc \
                  --out-file sculpin-from-scratch.pdf
            '';
          })

          (writeShellApplication {
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
}
