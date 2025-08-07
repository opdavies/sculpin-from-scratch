{
  perSystem =
    { pkgs, ... }:
    {
      devshells.book = {
        packages = with pkgs; [
          asciidoctor-with-extensions
          coreutils
        ];

        commands = [
          {
            name = "create-book-all";
            command = ''
              create-book-html
              create-book-pdf
              create-book-epub
            '';
          }

          {
            name = "create-book-epub";
            command = ''
              asciidoctor-epub3 \
                -a date="$(date +'%Y-%m-%d %H:%M')" index.adoc \
                  --out-file build/sculpin-from-scratch.epub
            '';
          }

          {
            name = "create-book-html";
            command = ''
              asciidoctor \
                -a date="$(date +'%Y-%m-%d %H:%M')" index.adoc \
                  --out-file build/sculpin-from-scratch.html
            '';
          }

          {
            name = "create-book-pdf";
            command = ''
              asciidoctor-pdf \
                -a date="$(date +'%Y-%m-%d %H:%M')" index.adoc \
                  --out-file build/sculpin-from-scratch.pdf
            '';
          }
        ];
      };
    };
}
