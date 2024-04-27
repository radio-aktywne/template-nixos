# Boot configuration
{
  boot = {
    initrd = {
      # This was autodetected by nixos-generate-config
      availableKernelModules = [
        "ahci"
        "xhci_pci"
        "virtio_pci"
        "sr_mod"
        "virtio_blk"
      ];
    };

    kernel = {
      sysctl = {
        # Enable SysRq
        # But only for logging level, keyboard, sync, remount, signals and reboot
        "kernel.sysrq" = 244;

        # Ignore incoming ICMP redirects to prevent MITM attacks
        "net.ipv4.conf.all.accept_redirects" = false;
        "net.ipv4.conf.all.secure_redirects" = false;
        "net.ipv4.conf.default.accept_redirects" = false;
        "net.ipv4.conf.default.secure_redirects" = false;
        "net.ipv6.conf.all.accept_redirects" = false;
        "net.ipv6.conf.default.accept_redirects" = false;

        # Ignore outgoing ICMP redirects to prevent MITM attacks
        "net.ipv4.conf.all.send_redirects" = false;
        "net.ipv4.conf.default.send_redirects" = false;

        # Increase socket buffer size
        "net.core.rmem_max" = 2500000;
        "net.core.wmem_max" = 2500000;
      };
    };

    # This was autodetected by nixos-generate-config
    kernelModules = [
      "kvm-intel"
    ];

    kernelParams = [
      # Reboot after 10 seconds on panic
      "kernel.panic=10"

      # Panic on failure
      "boot.panic_on_fail"
    ];

    loader = {
      systemd-boot = {
        # Keep maximum 5 previous generations
        configurationLimit = 5;

        # Try to autodetect the best resolution
        consoleMode = "auto";

        # Disable editing kernel parameters
        editor = false;

        # Use systemd-boot as bootloader
        enable = true;

        netbootxyz = {
          # Enable netboot.xyz to be able to boot any OS from network
          enable = true;

          # This is needed for correct ordering of boot entries
          sortKey = "z0_netbootxyz";
        };

        memtest86 = {
          # Enable memtest86 to be able to test RAM
          enable = true;

          # This is needed for correct ordering of boot entries
          sortKey = "z1_memtest86";
        };
      };
    };
  };
}
