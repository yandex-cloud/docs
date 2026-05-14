{% note tip %}

To use a [UEFI/EFI](https://en.wikipedia.org/wiki/UEFI) bootloader, select the `Gen 2` [hardware generation](../../compute/concepts/hardware-generations.md) when creating your image and {{ compute-name }} VM instance. For more information about creating a VM instance running on virtualized `Gen 2` hardware, see [this guide](../../compute/operations/vm-create/create-gen2-vm.md).

To boot from disks larger than 2 TB with the [GUID Partition Table (GPT)](https://en.wikipedia.org/wiki/GUID_Partition_Table) on VM instances running on `Gen 1.1` and `Gen 1.2` hardware, use the [GRUB 2](https://www.gnu.org/software/grub/manual/grub/html_node/BIOS-installation.html) bootloader.

{% endnote %}