# Options for migrating a VM image to {{ yandex-cloud }}


## Case description {#case-description}

You need to migrate a virtual machine from another infrastructure provider or a local hypervisor and then run it in {{ yandex-cloud }}.

## Solution {#case-resolution}

You can migrate your VM, but first you need to create an image from its boot disk by following [this guide](../../../compute/operations/image-create/create-from-image.md) or using a third-party Hystax Acura solution.

The choice depends on how your VM is hosted on the hypervisor and what level of access to its contents you have:

* If the VM runs under a third-party cloud provider, the easiest migration option is to [use Hystax Acura](../../../tutorials/infrastructure-management/hystax-migration.md).
* If your virtual machine resides on a physical hypervisor within a corporate network, the easiest way to migrate it is to [create a VM disk image](../../../compute/operations/image-create/custom-image.md), export the image from the hypervisor environment, convert it to QCOW2 (preferred) or VMDK format, and then [upload it to {{ objstorage-name }}](../../../compute/operations/image-create/upload.md).

{% note info %}

If you plan to migrate a Microsoft Windows® VM, please review the [policy for hosting such VMs in {{ yandex-cloud }}](../../../microsoft/licensing.md) beforehand.

{% endnote %}