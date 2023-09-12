# Options to migrate a VM image to Yandex Cloud

## Issue description {#case-description}
You need to migrate a VM from another infrastructure provider or a local hypervisor and run it in Yandex Cloud.

## Solution {#case-solution}
You can move your VM, but first you need to build an image from its boot disk based on [our recommendations](../../../compute/operations/image-create/create-from-image.md) or using the third-party Hystax Acura solution.
The choice depends on how your VM is hosted on the hypervisor and what level of access to its contents you have:

- If your VM is hosted by a third party cloud provider, the easiest migration path is by the [Hystax Acura solution](../../../tutorials/infrastructure-management/hystax-migration.md).
- If you host your VM on a physical hypervisor in a corporate network, the easiest way is to [prepare your VM disk for migration](../../../compute/operations/image-create/custom-image.md), export your VM disk image from the hypervisor environment, convert the image to QCOW2 (preferred) or VMDK format, and [upload the disk image to Object Storage](../../../compute/operations/image-create/upload.md).

{% note info %}

If you are going to migrate a Windows-based VM, please review the policy of [hosting such VMs in Yandex Cloud](../../../microsoft/licensing.md).

{% endnote %}
