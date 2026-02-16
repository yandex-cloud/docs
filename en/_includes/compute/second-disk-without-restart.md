On a Linux VM deployed from [{{ marketplace-name }}]({{ link-cloud-marketplace }}) or custom images with the [driver kit installed](../../compute/operations/image-create/custom-image.md#requirements), a secondary disk you attach will be available as a new device without rebooting the VM.

To successfully attach a disk, the VM operating system must be fully booted or stopped; otherwise the operation will fail. If an error occurs, stop the VM and try again.

On a Windows VM, a secondary disk you attach will only show up as a new device after a reboot.