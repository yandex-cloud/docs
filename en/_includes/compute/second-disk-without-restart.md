On a Linux VM deployed from [{{ marketplace-name }}]({{ link-cloud-marketplace }}) or custom images with the [driver kit installed](../../compute/operations/image-create/custom-image.md#requirements), the connected extra disk will be available as a new device without rebooting the VM.

For the disk to be successfully connected, the VM operating system must be fully booted or stopped, otherwise the operation will fail. If an error occurs, stop the VM and try again.

On a Windows VM, the connected extra disk will be available as a new device only after the VM reboots.