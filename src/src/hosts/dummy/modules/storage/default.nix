# Storage configuration
{config, ...}: {
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/${config.constants.disk.partitions.main.label}";

      # use ext4 for root
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/${config.constants.disk.partitions.boot.label}";

      # /boot uses FAT32, but mount only recognizes vfat type
      fsType = "vfat";

      # Obviously
      neededForBoot = true;
    };
  };

  services = {
    smartd = {
      # Enable smartmontools daemon
      enable = true;

      extraOptions = [
        # This prevents smartd from failing if no SMART capable devices are found (like in a VM)
        "-q never"
      ];
    };
  };
}
