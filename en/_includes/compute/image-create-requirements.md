Boot disk images must meet the following requirements:

* The `virtio-net`, `virtio-blk`, and `virtio-pci` drivers are installed. If you are going to attach [file storage](../../compute/concepts/filesystem.md), you also need to install the `virtiofs` driver. See [this guide](../../compute/operations/image-create/custom-image.md#virtio) for details.
* The `ttyS0` terminal (COM1 port) is set up as a [serial console](../../compute/operations/serial-console/index.md). See [this guide](../../compute/operations/image-create/custom-image.md#serial-console) for details.
* The network interface runs correctly when starting a VM and obtains the IP address via DHCP.
* The `cloud-init` package is installed and configured to work with our [metadata service](../../compute/operations/vm-info/get-info.md#inside-instance). To install the package for CentOS, run the `sudo yum install cloud-init` command. To install it for Debian or Ubuntu, run `sudo apt update && sudo apt install -y cloud-init`.
* If you created an image based on an Amazon Machine Image (AMI), the verification of the cloud platform where the VM instance is running is disabled in the `cloud-init` settings. See [this guide](../../compute/operations/image-create/custom-image.md#ec2) for details.
* In the system firewall settings, the minimum required set of ports for running your applications and a port for SSH access (by default, this is port 22 TCP) are open.
* The SSH server starts automatically at VM startup.
* The services running your application are resistant to VM reboots.
* GPT disk partitioning is used.
* The disk is mounted by its UUID rather than by name.