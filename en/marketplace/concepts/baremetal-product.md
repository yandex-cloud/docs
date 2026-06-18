# Creating a Linux-based {{ baremetal-name }} product to upload to {{ marketplace-name }}

To add a product for {{ baremetal-full-name }} to {{ marketplace-name }}, you need to upload the image to {{ yandex-cloud }}. You can add products based on Linux. This section will help you create a Linux-based image.

## Creating an image {#create}

{{ baremetal-name }} product images hosted in {{ marketplace-name }} must meet all requirements listed [below](#requirements). Also check out the additional [recommendations](#recommendations).

A {{ baremetal-name }} image is an archive containing a complete copy of the OS file system, starting from the root folder, which includes:

* Files.
* Nested directories.
* Symbolic and hard links, with their original structure and connections preserved. 

Supported formats: `tar.bz2` and `tar.gz`.

Create an image in one of the following ways:

* In a chroot environment using utilities provided by the operating system; e.g., for the Debian family, it is `debootstrap`.
* Use the virtual machine disk image and extract the files from it.
* Take an image from a pre-deployed system.

## Image requirements {#requirements}

### System setup {#system-setup}

* The `tty0` terminal is configured as the serial console. To do this, set the vCPU parameter: `console=tty0`.
* The `cloud-init` package was installed and data from previous `cloud-init` runs, if any, was cleared; e.g., in Ubuntu, using the `cloud-init clean --logs --seed` command.
* There are no network interface settings except `lo`. The network configuration will be created when you order the server through `cloud-init`.
* If your image requires special settings for [generating a network configuration via `cloud-init`](https://docs.cloud-init.io/en/latest/reference/network-config.html#network-configuration-outputs), add them to the`/etc/cloud/cloud.cfg.d/99_override_network.cfg` file. The following settings are used by default:

   * For the Debian family: `renderers: ["netplan"]`, `activators: ["netplan"]`.
   * For the RedHat family: `renderers: ["sysconfig"]`, `activators: ["network-manager"]`.

* The `mdadm` package has been installed for working with software RAID arrays.
* The kernel module for working with software RAID arrays is included in the `initrd` image. If the `mdadm` package was installed separately, update `initrd`:

   * For the Debian family: `update-initramfs -u`.
   * For the RedHat family: `dracut --regenerate-all -f`.

* Automatic assembly of software RAID arrays is enabled in the kernel parameters. To enable it, add the `rd.auto` parameter.
* Packages have been installed for working with `UEFI`:

   * For the Debian family: `grub-efi-amd64-bin` and `dosfstools`.
   * For the RedHat family: `grub2-efi-x64` and `shim-x64`.

* The system firewall is configured to only allow the minimum ports required for your applications to run securely and the SSH port (by default, 22/TCP).
* The SSH server starts automatically at server startup.
* SSH password-based access is disabled for all users and is only allowed via key-based authentication.
* The services running your application are resilient to server reboots.

### Image cleanup {#image-cleanup}

* The following folders do not contain any files or subfolders:

   * `/dev`
   * `/proc`
   * `/run`
   * `/sys`
   * `/tmp`
   * `/var/tmp`

* The `/var/log` folder does not contain any files. Subfolders are allowed as long as they do not also contain files.
* The `/etc/machine-id` file exists and contains no data.
* There is no file named `/var/lib/dbus/machine-id` or it does not contain data.
* The package manager cache has been cleared. In case of `apt`, the contents of the `/var/cache/apt` and `/var/lib/apt/lists` folders have been deleted, with the folders themselves preserved.
* The console command history has been cleared (`.bash_history`, `.zsh_history`, etc.).
* Information about settings previously received via `DHCP` has been deleted. For example, in Ubuntu, depending on the version and settings, it may be the `/var/lib/NetworkManager/*.lease` or `/var/lib/dhcp/dhclient.leases` file.

## Recommendations for an image {#recommendations}

The requirements below are not mandatory, but we recommend that you follow them.

### Security {#security}

Make sure that:

* The image does not contain any system users other than those needed by applications.
* The image does not contain pre-generated SSH keys or passwords.

   {% note warning %}

   Application passwords must be generated when the VM starts to enable a user to change them when logging in for the first time via the serial console or SSH.

   {% endnote %}

* The `/etc/sudoers*` file grants no excessive privileges to users.

### System setup {#system-configuration}

* The `Europe/Moscow` (+03:00) time zone is set.
* Time synchronization with `NTP` public servers is set up, e.g., as described in [this tutorial](../../tutorials/infrastructure-management/ntp.md).
* `systemd` goals responsible for energy saving are prohibited, e.g., using the `systemctl mask` command:

   * `sleep.target`
   * `suspend.target`
   * `hibernate.target`
   * `hybrid-sleep.target`

* There is only one kernel version installed on the system. This will speed up product deployment and ensure a predictable user experience.
* Automatic package updates are disabled.
* Automatic firmware updates for hardware are disabled (e.g., `fwupd.service` in Ubuntu). {{ baremetal-name }} independently manages equipment firmware.
* Package repositories use mirrors in the .RU zone (e.g., [mirror.yandex.ru](http://mirror.yandex.ru)). This will speed up downloads and protect you from issues when accessing blocked resources.
* Drivers for all devices are saved. {{ baremetal-name }} provides multiple server configurations, and your image should run on varying hardware.
* The image includes a small set of system utilities that will help the user if issues arise:

   * `curl`
   * `dig`
   * `ethtool`
   * `lshw`
   * `lspci`
   * `mtr`
   * `ping`
   * `traceroute`
   * `vim`
