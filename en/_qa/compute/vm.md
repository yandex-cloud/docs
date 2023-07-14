---
title: "VM instances FAQ"
description: "Answers to frequently asked questions about VM instances in the {{ yandex-cloud }} infrastructure. Technical characteristics, operations with instances. The VM configuration (memory, vCPU) that you can use."
keywords:
  - vm
  - VM instances
---

# Virtual machines

### Technical specifications {#technical-parameters}

#### What VM configuration (memory, vCPU) can I use? {#configure-vm}

{% include [support-channels](../../_includes/compute/compute-resources.md) %}

For more information, see [{#T}](../../compute/concepts/performance-levels.md).

#### How can I change the amount of RAM and the number of cores allocated to a VM? {#update-type}

For more information, see [{#T}](../../compute/operations/vm-control/vm-update-resources.md).

#### How do I create a multi-interface VM? {#multi-interface}

You can only add a network interface when [creating a VM](../../compute/operations/index.md#vm-create). Currently, multiple interfaces can only be created using network images from [{{ marketplace-full-name }}](/marketplace?categories=network).

### VM parameters {#parameters-vm}

#### How do I increase quotas? {#increase-quotas}

To increase [quotas](../../compute/concepts/limits.md#compute-quotas), submit a request on [this page]({{ link-console-quotas }}). Select the service (or services) and specify which quota values you need.

After creating the request, the message appears in the [support section]({{ link-console-support }}) where you can track its status. In some cases, it may be necessary to get approval from the service to ensure the availability of resources and/or to increase your account balance.

#### Is nested virtualization supported? Can I host my VMs inside other VMs? {#nested-virtualization}

Nested virtualization is not supported for security reasons. If you did not find a suitable public image for a VM, you can upload your own image and create a VM based on it. Follow this guide: [{#T}](../../compute/operations/vm-create/create-from-user-image.md).

#### Is data saved when I edit my VM parameters? {#data-saved-after-change-parameters}

Yes, the data should be saved. However, please note that you should not restart your VM when writing data to the system [disk](../../compute/concepts/disk.md) because this might result in file system corruption.

To edit the parameters of your VM, follow these steps:
1. Take a [snapshot](../../compute/concepts/snapshot.md) of the disk: see [{#T}](../../compute/operations/disk-control/create-snapshot.md).
1. Shut down the VM normally: see [{#T}](../../compute/operations/vm-control/vm-stop-and-start.md).
1. Edit the VM parameters: see [{#T}](../../compute/operations/vm-control/vm-update-resources.md).
1. Wait until the operation is completed (the **{{ ui-key.yacloud.compute.switch_operations }}** section in the {{ compute-name }} service).
1. Start the VM.
1. Make sure that the new parameters were applied.

#### Can I reduce vCPU or vRAM for a VM? {#reduce-cpu-ram}

Yes, you can. However, if the load on the vCPU and/or vRAM was high enough when you changed the parameters, the VM may fail to start if you decrease these parameters.

If the load on the server is small and uniform, we recommend decreasing the parameters to avoid extra charges.

#### Can I change the FQDN? {#change-fqdn}

The [FQDN](../../vpc/concepts/address.md#fqdn) is issued to the VM at the time of its creation, and you cannot change it.

If you want to change the FQDN, delete the VM and create a new one. To preserve the consistency of the data:
1. Stop the VM: see [{#T}](../../compute/operations/vm-control/vm-stop-and-start.md#stop).
1. Take a snapshot of the disk: see [{#T}](../../compute/operations/disk-control/create-snapshot.md).
1. Create a new VM by selecting the snapshot as the source of its boot disk: see [{#T}](../../compute/operations/vm-create/create-from-snapshots.md). Specify the FQDN you need during creation.

#### Can the UUID of a VM change? {#change-uuid}

Standard operations for changing VM configuration, such as changing the number of vCPUs, the amount of vRAM, and adding disks, will not affect the UUID. However, in some cases, the UUID may change. For example, this may happen when updating BIOS or performing similar operations that affect the hardware part of the service.

Keep this in mind when using third-party software licenses. The best solution is to purchase a license that does not have any link to the UUID.

#### How do I change metadata after creating a VM? {#change-metadata-after-creating}

Use the [updateMetadata](../../compute/api-ref/Instance/updateMetadata.md) API method.

This method enables you to update the [metadata](../../compute/concepts/vm-metadata.md) in the service without affecting the guest operating system run by the VM. If you need to update a parameter inside your VM after its creation, in most cases, the best way is to recreate the VM from a snapshot or make changes manually.

### VM operations {#operations-on-vm}

#### Can I copy or clone an existing VM? {#clone-vm}

Yes, you can take snapshots of the disks attached to a VM and use them when creating a new VM.


#### Can I move my VM to a different availability zone? {#move-az}

You cannot directly change the [availability zone](../../overview/concepts/geo-scope.md) where the VM is hosted. However, you can create a copy of the VM in the availability zone you need.


#### Can I move my VM to a different folder? {#move-to-project}

You can move a VM to another [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) within a single [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud). For more information, see [{#T}](../../compute/operations/vm-control/vm-change-folder.md).

#### If I accidentally delete my VM, can I restore it? {#delete-vm2}

No, you cannot. If you delete a VM, this cannot be undone.

To avoid losing your data in case of accidental deletion, you can configure disk backups using snapshots or specify that the disks should not be automatically deleted when deleting the VM.