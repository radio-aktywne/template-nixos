# Install script
{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    installScript = lib.mkOption {
      # Create shell script with some setup code added automatically
      default = pkgs.writeShellApplication {
        name = "install";

        # pkgs.substituteAll returns a path to a file, so we need to read it
        text = builtins.readFile (
          # This is used to provide data to the script by replacing some strings
          pkgs.substituteAll {
            src = ./install.sh;

            boot = config.constants.disk.partitions.boot.label;
            disk = config.constants.disk.path;
            flake = inputs.self;
            host = config.constants.name;
            main = config.constants.disk.partitions.main.label;
            mkfsext4 = "${pkgs.e2fsprogs}/bin/mkfs.ext4";
            mkfsfat = "${pkgs.dosfstools}/bin/mkfs.fat";
            nixosinstall = "${pkgs.nixos-install-tools}/bin/nixos-install";
            parted = "${pkgs.parted}/bin/parted";
          }
        );
      };
    };
  };
}
