# Preparing your disk image

{% note info %}

You can only use images prepared following this guide.

You can also view out-of-the-box images in [{{ marketplace-full-name }}](/marketplace).

{% endnote %}

You can use your own file with a Linux-based [VM](../../concepts/vm.md) [disk](../../concepts/disk.md) [image](../../concepts/image.md). Once your image is prepared, [upload it](upload.md) to {{ compute-name }}.


If you made software that might be helpful to other others, [offer](../../../marketplace/operations/create-product.md) it on {{ marketplace-full-name }}.


## Configure the OS to meet the requirements {#requirements}

{% include [image-create-requirements](../../../_includes/compute/image-create-requirements.md) %}

### Install the virtio drivers {#virtio}

To successfully upload your image, make sure to install the `virtio-blk`, `virtio-net`, and `virtio-pci` drivers. To use {{ compute-name }} [file storage](../../concepts/filesystem.md), install `virtiofs` drivers.

Most modern distributions contain the `virtio` drivers by default. They can be compiled as separate `.ko` files or be part of the kernel itself.

Follow the guide below to check if the drivers are installed; if they are not, add them.
1. Find out whether the drivers are included in the kernel configuration:

   {% cut "How do I find out?" %}

   Run the following command:

   ```sh
   grep -E -i "VIRTIO_(BLK|NET|PCI|FS)" /boot/config-$(uname -r)
   ```

   If no lines starting with `CONFIG_VIRTIO_BLK=`, `CONFIG_VIRTIO_NET=`, `CONFIG_VIRTIO_PCI=`, and `CONFIG_VIRTIO_FS=` are displayed, you should recompile the Linux kernel with the virtio drivers. Otherwise, proceed to the next steps.

   {% endcut %}

1. If the `CONFIG_VIRTIO_BLK=y`, `CONFIG_VIRTIO_NET=y`, `CONFIG_VIRTIO_PCI=y`, and `CONFIG_VIRTIO_FS=y` lines are returned in step 1, check whether the drivers are included in the kernel:

   {% cut "How to check if drivers are included in a kernel" %}

   Run the following command:

   ```sh
   grep -E "virtio(_blk|_net|_pci|fs)" /lib/modules/"$(uname -r)"/modules.builtin
   ```

   * If the lines with the `virtio_net.ko`, `virtio_blk.ko`, `virtio_pci.ko`, and `virtiofs.ko` filenames are returned, the drivers are part of the kernel and you do not need to install them.
   * If not, recompile the Linux kernel with the virtio drivers.

   {% endcut %}

1. If the `CONFIG_VIRTIO_BLK=m`, `CONFIG_VIRTIO_NET=m`, `CONFIG_VIRTIO_PCI=m`, and `CONFIG_VIRTIO_FS=m` lines are returned in step 1, check whether the drivers are installed as kernel modules:

   {% cut "How to check if drivers belong to a module" %}

   {% list tabs group=operating_system %}

   - CentOS/Fedora {#centos}

      Run the following command:

      ```sh
      sudo lsinitrd /boot/initramfs-$(uname -r).img | grep -E "virtio(_blk|_net|_pci|fs)"
      ```

      * If the lines with the `virtio_net.ko.xz`, `virtio_blk.ko.xz`, `virtio_pci.ko.xz`, and `virtiofs.ko.xz` filenames are returned, the drivers are installed as kernel modules.
      * If not, create a backup of the `initramfs` file and install the drivers:

         ```sh
         sudo cp /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r).img.bak
         sudo mkinitrd -f --with=virtio_blk --with=virtio_net --with=virtio_pci --with=virtiofs /boot/initramfs-$(uname -r).img $(uname -r)
         ```

         If you receive an error saying `Command 'mkinitrd' not found`, use `dracut` to install the drivers:

         ```sh
         sudo dracut -f --add-drivers "virtio_blk virtio_net virtio_pci virtiofs" /boot/initramfs-$(uname -r).img $(uname -r)
         ```

         Then restart the OS and check that the drivers appear in the `initramfs` file and are loaded:

         ```sh
         sudo lsinitrd /boot/initramfs-$(uname -r).img | grep -E "virtio(_blk|_net|_pci|fs)"
         find /lib/modules/"$(uname -r)"/ -name "virtio*" | grep -E "(blk|net|pci|fs)"
         ```

         After running each of the commands, the lines with the `virtio_net.ko.xz`, `virtio_blk.ko.xz`, `virtio_pci.ko.xz`, and `virtiofs.ko.xz` filenames should be returned.

   - Debian/Ubuntu {#ubuntu}

      Run the following command:

      ```sh
      lsinitramfs /boot/initrd.img-$(uname -r) | grep -E "virtio(_blk|_net|_pci|fs)"
      ```

      * If the lines with the `virtio_net.ko`, `virtio_blk.ko`, `virtio_pci.ko`, and `virtiofs.ko` filenames are returned, the drivers are installed as kernel modules.
      * If not, install the drivers:

         ```sh
         echo -e "virtio_blk\nvirtio_net\nvirtio_pci\nvirtiofs" | sudo tee -a /etc/initramfs-tools/modules
         sudo update-initramfs -u
         ```

         Then restart the OS and check that the drivers appear in the `initrd` file and are loaded:

         ```sh
         lsinitramfs /boot/initrd.img-$(uname -r) | grep -E "virtio(_blk|_net|_pci|fs)"
         find /lib/modules/"$(uname -r)"/ -name "virtio*" | grep -E "(blk|net|pci|fs)"
         ```

         After running each of the commands, the lines with the `virtio_net.ko`, `virtio_blk.ko`, `virtio_pci.ko`, and `virtiofs.ko` filenames should be returned.

   {% endlist %}

   {% endcut %}

### Configure the serial console {#serial-console}

The [serial console](../serial-console/index.md) allows you to access your VM regardless of the [network](../../../vpc/concepts/network.md#network) or OS status. Use the serial console to troubleshoot your VM or when you have issues with SSH access. For more information, see [{#T}](../serial-console/index.md).

To connect to your VM using the serial console, set up the `ttyS0` terminal (COM1 port) as a system console for your image:
1. In the `/etc/default/grub` file with GRUB settings, add `console=ttyS0` to the `GRUB_CMDLINE_LINUX` parameter value. The line with this parameter should look like this:

   ```sh
   GRUB_CMDLINE_LINUX="foo=bar baz console=ttyS0"
   ```

1. Check that the `/etc/securetty` file with a list of terminals, through which the `root` user can log in to the OS, contains the `ttyS0` line. If there is no such file, create one.

   {% note info %}

   In some operating systems, the `/etc/securetty` file is disabled and the `root` user is allowed to access all terminals by default. To configure access using this file, add to the `/etc/pam.d/login` file a pointer to the `pam_securetty.so` module. For more information, see `man pam_securetty` and `man pam.d`.

   {% endnote %}

1. Run the following commands:

   {% list tabs group=operating_system %}

   - CentOS/Fedora {#centos}

     ```sh
     sudo stty -F /dev/ttyS0 9600 # Sets the recommended baud rate for the ttyS0 terminal at 9600.
     sudo grub2-mkconfig -o /boot/grub2/grub.cfg # Generates a configuration file for GRUB.
     sudo systemctl start getty@ttyS0 # Starts getty on the ttyS0 terminal.
     sudo systemctl enable getty@ttyS0 # Specifies that getty should be run every time the OS is started.
     ```

   - Debian/Ubuntu {#ubuntu}

     ```sh
     sudo stty -F /dev/ttyS0 9600 # Sets the recommended baud rate for the ttyS0 terminal at 9600.
     sudo update-grub # Generates a configuration file for GRUB.
     sudo systemctl start getty@ttyS0 # Starts getty on the ttyS0 terminal.
     sudo systemctl enable getty@ttyS0 # Specifies that getty should be run every time the OS is started.
     ```

   {% endlist %}

1. Restart the OS.

After [creating a VM from your image](upload.md#create-vm-from-user-image), you should additionally [configure it to work with the serial console](../serial-console/index.md).

## Disable verification of the cloud platform when creating an image in Amazon EC2 {#ec2}

If you are creating an image in Amazon EC2 based on an Amazon Machine Image, `cloud-init` checks that the VM can be run in Amazon EC2. VMs in {{ compute-full-name }} will fail the check and may run incorrectly.

To avoid this, disable metadata verification on your VMs. To do this, in the `/etc/cloud/cloud.cfg.d` directory, create a configuration file, e.g., `99-ec2-datasource.cfg`, and add the following code to it:

```yaml
#cloud-config
datasource:
  Ec2:
    strict_id: false
```

## Install drivers to enable compatibility with GPUs {#gpu-drivers}


If working with a VM requires a [GPU](../../concepts/gpus.md), [install NVIDIA drivers](../vm-operate/install-nvidia-drivers.md) while preparing the image.

## Create an image file {#create-image-file}

The supported formats are `Qcow2`, `VMDK`, and `RAW`.

We recommend that you use `Qcow2` format with an optimized cluster size for faster import. To convert your image from other formats, use the `qemu-img` utility:

```bash
qemu-img convert -p -O qcow2 -o cluster_size=2M <your_image_file_name> <new_image_file_name>
```

{% note info %}

Do not use file compression or archiving software when preparing the image file. To speed up creating VMs from an image, you can [optimize](../../concepts/image.md#images-optimized-for-deployment) it.

{% endnote %}