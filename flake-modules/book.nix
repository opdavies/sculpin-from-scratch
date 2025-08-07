{
  perSystem =
    { pkgs, ... }:
    {
      devshells.book = {
        packages = with pkgs; [
          asciidoctor-with-extensions
          coreutils
          just
        ];
      };
    };
}
