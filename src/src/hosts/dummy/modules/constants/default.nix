# Reusable constants are defined here
# All options have default values
# You can use them in other modules
{lib, ...}: {
  options = {
    constants = {
      disk = {
        partitions = {
          boot = {
            label = lib.mkOption {
              default = "boot";
              description = "Label for the boot partition";
              type = lib.types.str;
            };
          };

          main = {
            label = lib.mkOption {
              default = "main";
              description = "Label for the main partition";
              type = lib.types.str;
            };
          };
        };

        path = lib.mkOption {
          default = "/dev/sda";
          description = "Path to the disk";
          type = lib.types.path;
        };
      };

      name = lib.mkOption {
        default = "dummy";
        description = "Name of the machine";
        type = lib.types.str;
      };

      network = {
        hostId = lib.mkOption {
          default = "9f86d081";
          description = "Unique identifier for the machine";
          type = lib.types.str;
        };
      };

      platform = lib.mkOption {
        default = "x86_64-linux";
        description = "Platform of the machine";
        type = lib.types.str;
      };

      vm = {
        cpu = {
          cores = lib.mkOption {
            default = 4;
            description = "Number of CPU cores";
            type = lib.types.int;
          };
        };

        disk = {
          partitions = {
            main = {
              label = lib.mkOption {
                default = "main";
                description = "Label for the main partition";
                type = lib.types.str;
              };
            };
          };

          path = lib.mkOption {
            default = "/dev/vda";
            description = "Path to the disk in the virtual machine";
            type = lib.types.path;
          };

          size = lib.mkOption {
            default = 8192;
            description = "Size of the disk in MB";
            type = lib.types.int;
          };
        };

        memory = {
          size = lib.mkOption {
            default = 4096;
            description = "Size of the memory in MB";
            type = lib.types.int;
          };
        };
      };
    };
  };
}
