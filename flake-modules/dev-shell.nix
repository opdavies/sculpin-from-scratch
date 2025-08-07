{ inputs, ... }:

{
  imports = [ inputs.devshell.flakeModule ];

  perSystem =
    { pkgs, ... }:
    {
      devshells.default.packages = with pkgs; [
        (php.buildEnv {
          extraConfig = ''
            error_reporting = E_ALL & ~E_DEPRECATED & ~E_USER_DEPRECATED
          '';
        })

        phpPackages.composer
      ];
    };
}
