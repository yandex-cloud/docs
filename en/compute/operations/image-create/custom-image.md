# Preparing a disk image

{% note info %}

You can only use images prepared following this guide.

You can also view out-of-the-box images in [{{ marketplace-full-name }}](/marketplace).

{% endnote %}

You can use your own file with a Linux [VM](../../concepts/vm.md) [disk](../../concepts/disk.md) [image](../../concepts/image.md). Once your image is prepared, [upload it](upload.md) to {{ compute-name }}.

If you have developed software that might be helpful to others, consider [listing](../../../marketplace/operations/create-product.md) it in {{ marketplace-full-name }}.

{% note warning %}

Images with an [UEFI/EFI](https://en.wikipedia.org/wiki/UEFI) bootloader are not compatible with {{ compute-name }}. To boot from disks larger than 2 TB with the [GUID Partition Table (GPT)](https://en.wikipedia.org/wiki/GUID_Partition_Table), use the [GRUB 2](https://www.gnu.org/software/grub/manual/grub/html_node/BIOS-installation.html) bootloader.

{% endnote %}

## Configuring the OS to meet the requirements {#requirements}

{% include [image-create-requirements](../../../_includes/compute/image-create-requirements.md) %}

### Installing virtio drivers {#virtio}

To successfully upload your image, make sure to install the `virtio-blk`, `virtio-net`, and `virtio-pci` drivers. To use {{ compute-name }} [file storages](../../concepts/filesystem.md), install `virtiofs`.

Most modern distributions include the `virtio` drivers by default. They can be compiled as separate `.ko` files or built into the kernel itself.

Follow the steps below to check if the drivers are installed in your OS. If not, add them.
1. Check if the drivers are built into the kernel:

   {% cut "How to check it" %}

   Run this command:

   ```sh
   grep -E -i "VIRTIO_(BLK|NET|PCI|FS)" /boot/config-$(uname -r)
   ```

   If you see no lines starting with `CONFIG_VIRTIO_BLK=`, `CONFIG_VIRTIO_NET=`, `CONFIG_VIRTIO_PCI=`, and `CONFIG_VIRTIO_FS=` on your screen, recompile the Linux kernel with the virtio drivers. Otherwise, proceed to the next steps.

   {% endcut %}

1. If you get the `CONFIG_VIRTIO_BLK=y`, `CONFIG_VIRTIO_NET=y`, `CONFIG_VIRTIO_PCI=y`, and `CONFIG_VIRTIO_FS=y` lines in _Step 1_, make sure the drivers are included in the kernel:

   {% cut "How to check if drivers are included in a kernel" %}

   Run this command:

   ```sh
   grep -E "virtio(_blk|_net|_pci|fs)" /lib/modules/"$(uname -r)"/modules.builtin
   ```

   * If you get the lines with the `virtio_net.ko`, `virtio_blk.ko`, `virtio_pci.ko` and `virtiofs.ko` file names, the drivers are included in the kernel and you do not need to install them.
   * If you see no such lines on your screen, recompile the Linux kernel with the virtio drivers.

   {% endcut %}

1. If you get the `CONFIG_VIRTIO_BLK=m`, `CONFIG_VIRTIO_NET=m`, `CONFIG_VIRTIO_PCI=m`, and `CONFIG_VIRTIO_FS=m` lines in _Step 1_, check that the drivers are installed as kernel modules:

   {% cut "How to check kernel modules" %}

   {% list tabs group=operating_system %}

   - CentOS/Fedora {#centos}

     Run this command:

     ```sh
     sudo lsinitrd /boot/initramfs-$(uname -r).img | grep -E "virtio(_blk|_net|_pci|fs)"
     ```

     * If you get the lines with the `virtio_net.ko.xz`, `virtio_blk.ko.xz`, `virtio_pci.ko.xz`, and `virtiofs.ko.xz` file names, the drivers are installed as kernel modules.
     * If you see no such lines on your screen, create a backup of the `initramfs` file and install the drivers:

       ```sh
       sudo cp /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r).img.bak
       sudo mkinitrd -f --with=virtio_blk --with=virtio_net --with=virtio_pci --with=virtiofs /boot/initramfs-$(uname -r).img $(uname -r)
       ```

       If you get an error saying `Command 'mkinitrd' not found`, use `dracut` to install the drivers:

       ```sh
       sudo dracut -f --add-drivers "virtio_blk virtio_net virtio_pci virtiofs" /boot/initramfs-$(uname -r).img $(uname -r)
       ```

       Then, reboot your system and check if the drivers are now included in the `initramfs` file and loaded:

       ```sh
       sudo lsinitrd /boot/initramfs-$(uname -r).img | grep -E "virtio(_blk|_net|_pci|fs)"
       find /lib/modules/"$(uname -r)"/ -name "virtio*" | grep -E "(blk|net|pci|fs)"
       ```

       Each command should output lines with the `virtio_net.ko.xz`, `virtio_blk.ko.xz`, `virtio_pci.ko.xz`, and `virtiofs.ko.xz` file names.

   - Debian/Ubuntu {#ubuntu}

     Run the following command:

     ```sh
     lsinitramfs /boot/initrd.img-$(uname -r) | grep -E "virtio(_blk|_net|_pci|fs)"
     ```

     * If you get the lines with the `virtio_net.ko`, `virtio_blk.ko`, `virtio_pci.ko`, and `virtiofs.ko` file names, the drivers are installed as kernel modules.
     * If you see no such lines on your screen, install the drivers:

       ```sh
       echo -e "virtio_blk\nvirtio_net\nvirtio_pci\nvirtiofs" | sudo tee -a /etc/initramfs-tools/modules
       sudo update-initramfs -u
       ```

       Then, reboot your system and check if the drivers are now included in the `initrd` file and loaded:

       ```sh
       lsinitramfs /boot/initrd.img-$(uname -r) | grep -E "virtio(_blk|_net|_pci|fs)"
       find /lib/modules/"$(uname -r)"/ -name "virtio*" | grep -E "(blk|net|pci|fs)"
       ```

       Each command should output lines with the `virtio_net.ko`, `virtio_blk.ko`, `virtio_pci.ko`, and `virtiofs.ko` file names.

   {% endlist %}

   {% endcut %}

### Configuring the serial console {#serial-console}

A [serial console](../serial-console/index.md) enables accessing a VM regardless of the [network](../../../vpc/concepts/network.md#network) or OS state. Use the serial console to troubleshoot your VM or when you have SSH access issues. For more information, see [{#T}](../serial-console/index.md).

To enable serial console access to your VM, configure the image to use `ttyS0` (COM1) as the system console:
1. In the `/etc/default/grub` file with GRUB settings, add `console=ttyS0` to the `GRUB_CMDLINE_LINUX` parameter value. The line with this parameter should look like this:

   ```sh
   GRUB_CMDLINE_LINUX="foo=bar baz console=ttyS0"
   ```

1. Make sure the `/etc/securetty` file with a list of terminals the `root` user can use to log in to the OS contains the `ttyS0` line. If there is no such file, create one.

   {% note info %}

   In some operating systems, `/etc/securetty` is not used and the `root` user can access all terminals by default. To configure access using this file, add a specification for the `pam_securetty.so` module to the `/etc/pam.d/login` file. For more information, see `man pam_securetty` and `man pam.d`.

   {% endnote %}

1. Run the following commands:

   {% list tabs group=operating_system %}

   - CentOS/Fedora {#centos}

     ```sh
     sudo stty -F /dev/ttyS0 9600 # Sets the recommended baud rate for the `ttyS0` terminal to 9600.
     sudo grub2-mkconfig -o /boot/grub2/grub.cfg # Generates a GRUB configuration file.
     sudo systemctl start getty@ttyS0 # Starts `getty` on `ttyS0`.
     sudo systemctl enable getty@ttyS0 # Tells the system to start `getty` every time it boots up.
     ```

   - Debian/Ubuntu {#ubuntu}

     ```sh
     sudo stty -F /dev/ttyS0 9600 # Sets the recommended baud rate for the `ttyS0` terminal to 9600.
     sudo update-grub # Generates a GRUB configuration file.
     sudo systemctl start getty@ttyS0 # Starts `getty` on `ttyS0`.
     sudo systemctl enable getty@ttyS0 # Tells the system to start `getty` every time it boots up.
     ```

   {% endlist %}

1. Reboot the OS.

After [creating a VM from your image](upload.md#create-vm-from-user-image), you need to additionally [configure it for using the serial console](../serial-console/index.md). 

## Disabling cloud platform verification when creating an image in Amazon EC2 {#ec2}

When using an AMI to create an image in Amazon EC2, `cloud-init` verifies that the VM is running within the Amazon EC2 environment. VMs launched in {{ compute-full-name }} will fail the verification and may run incorrectly.

To avoid this, disable metadata verification on your VMs: in the `/etc/cloud/cloud.cfg.d` directory, create a configuration file, e.g., `99-ec2-datasource.cfg`, and add the following code to it:

```yaml
#cloud-config
datasource:
  Ec2:
    strict_id: false
```

## Installing drivers to enable GPU compatibility {#gpu-drivers}


If you need to use a [GPU](../../concepts/gpus.md) with your VM, make sure to [install NVIDIA drivers](../vm-operate/install-nvidia-drivers.md) while preparing the image.

## Creating an image file {#create-image-file}

{% include [available-image-format](../../../_includes/compute/available-image-format.md) %}

We recommend using the `Qcow2` format with an optimized cluster size for faster import. To convert your image from other formats, use `qemu-img`:

```bash
qemu-img convert -p -O qcow2 -o cluster_size=2M <your_image_file_name> <new_image_file_name>
```

{% note info %}

Do not use compression or archiving utilities when preparing the image file. To make creating VMs faster, [optimize](../../concepts/image.md#images-optimized-for-deployment) the image.

{% endnote %}