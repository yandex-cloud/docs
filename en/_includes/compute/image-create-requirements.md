Make sure the following requirements for boot disk images are met:
* The `virtio-net`, `virtio-blk`, and `virtio-pci` drivers are installed. If you are going to attach [file storages](../../compute/concepts/filesystem.md) to your [VM](../../compute/concepts/vm.md), you also need to install the `virtiofs` driver. For details, see [this guide](../../compute/operations/image-create/custom-image.md#virtio).
* The `ttyS0` terminal (COM1) is configured as the [serial console](../../compute/operations/serial-console/index.md). For details, see [this guide](../../compute/operations/image-create/custom-image.md#serial-console).
* The network interface runs correctly when starting the VM and gets the [IP address](../../vpc/concepts/address.md) via DHCP.
* The `cloud-init` package is installed and configured to work with our [metadata service](../../compute/operations/vm-info/get-info.md#inside-instance). Run `sudo yum install cloud-init` to install the package for CentOS or `sudo apt update && sudo apt install -y cloud-init` to install it for Debian or Ubuntu.
* For an image based on an AMI, cloud platform verification for the VM instance is disabled in the `cloud-init` settings. For details, see [this guide](../../compute/operations/image-create/custom-image.md#ec2).
* The system firewall is configured to only allow the minimum ports required for your applications to run securely and the SSH port (by default, 22 TCP).
* The SSH server starts automatically at VM startup.
* The services running your application are resilient to VM reboots.
* The boot disk uses MBR partitioning.
* The disk is mounted by its UUID rather than by name.
* The file system is not encrypted.
