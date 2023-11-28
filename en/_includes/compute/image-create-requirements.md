Boot disk images must meet the following requirements:
* The `virtio-net`, `virtio-blk`, and `virtio-pci` drivers are installed. If you are going to attach [file storages](../../compute/concepts/vm.md) to your [VM](../../compute/concepts/filesystem.md), you also need to install the `virtiofs` driver. For more information, refer to [this guide](../../compute/operations/image-create/custom-image.md#virtio).
* The `ttyS0` terminal (COM1 port) is set up as a [serial console](../../compute/operations/serial-console/index.md). For more information, refer to [this guide](../../compute/operations/image-create/custom-image.md#serial-console).
* The network interface runs correctly when starting a VM and obtains the [IP address](../../vpc/concepts/address.md) via DHCP.
* The `cloud-init` package is installed and configured to work with our [metadata service](../../compute/operations/vm-info/get-info.md#inside-instance). To install the package for CentOS, run the `sudo yum install cloud-init` command. To install it for Debian or Ubuntu, run `sudo apt update && sudo apt install -y cloud-init`.
* If you created an image based on an Amazon Machine Image (AMI), verification of the cloud platform where the VM instance is run is disabled in the `cloud-init` settings. For more information, refer to [this guide](../../compute/operations/image-create/custom-image.md#ec2).
* In the system firewall settings, the minimum required set of ports for running your applications and a port for SSH access (by default, 22 TCP) are open.
* The SSH server starts automatically at VM startup.
* Services running your application are resistant to VM reboots.
* The boot disk uses MBR partitioning.
* The disk is mounted by its UUID rather than by name.
* The file system is not encrypted.