
# Virtual machines

### Technical specifications {#technical-parameters}

#### What VM configuration (memory, vCPU) can I use? {#configure-vm}

{% include [support-channels](../../_includes/compute/compute-resources.md) %}

For more information, see [{#T}](../../compute/concepts/performance-levels.md).

#### How do I change the amount of RAM and the number of vCPUs allocated to my VM? {#update-type}

For more information, see [{#T}](../../compute/operations/vm-control/vm-update-resources.md).

#### How do I create a multi-interface VM? {#multi-interface}

You can add a network interface only when [creating a VM](../../compute/operations/index.md#vm-create). Currently, you can only create multiple interfaces on network images from [{{ marketplace-full-name }}](/marketplace?categories=network). 

You can also create a [NAT instance](../../vpc/tutorials/nat-instance) to use multiple network interfaces.

### VM parameters {#parameters-vm}

#### How do I increase my quotas? {#increase-quotas}

To increase [quotas](../../compute/concepts/limits.md#compute-quotas), [submit a request]({{ link-console-quotas }}). Select the service (or services) and specify the quota values you need.

After creating the request, you will be able to view it and track its status in the [support section]({{ link-console-support }}). In some cases, you may need to obtain confirmation from the service regarding resource availability and/or top up your account balance.

#### Is nested virtualization supported? Can I deploy custom VMs within a VM? {#nested-virtualization}

Nested virtualization is not supported for security reasons. If you did not find a suitable public VM image, you can upload a custom image and use it to create your VM. Use this guide: [{#T}](../../compute/operations/vm-create/create-from-user-image.md).

#### Will my data be safe if I update the VM settings? {#data-saved-after-change-parameters}

Yes, your data should stay safe. However, please note that you should not restart your VM when writing data to the system [disk](../../compute/concepts/disk.md) as this might result in file system corruption.

To update the parameters of your VM, follow these steps:
1. Create a [snapshot](../../compute/concepts/snapshot.md) of the disk (see [{#T}](../../compute/operations/disk-control/create-snapshot.md) for details).
1. Shut down the VM gracefully (see [{#T}](../../compute/operations/vm-control/vm-stop-and-start.md) for details).
1. Update the VM parameters (see [{#T}](../../compute/operations/vm-control/vm-update-resources.md) for details).
1. Wait for the operation to complete (the **{{ ui-key.yacloud.compute.operations_kRLeR }}** section in {{ compute-name }}).
1. Start the VM.
1. Make sure the new parameters are applied.

#### Can I reduce vCPU or vRAM for my VM? {#reduce-cpu-ram}

Yes, you can. However, if the vCPU and/or vRAM utilization was already high prior to updating the parameters, the VM may fail to start after they are reduced.

Still, if the server load is small and consistently distributed, we recommend reducing the parameters to avoid extra charges.

#### Can I change the FQDN? {#change-fqdn}

A VM gets its [FQDN](../../vpc/concepts/address.md#fqdn) upon creation, and you cannot change it.

If you need to change the FQDN, delete the VM and create a new one. To ensure data consistency:
1. Stop the VM (see [{#T}](../../compute/operations/vm-control/vm-stop-and-start.md#stop) for details).
1. Create a snapshot of the disk (see [{#T}](../../compute/operations/disk-control/create-snapshot.md) for details).
1. Create a new VM by selecting the snapshot as the source of its boot disk. For details, see [{#T}](../../compute/operations/vm-create/create-from-snapshots.md). While creating, specify the FQDN you need.

#### Can the UUID of a VM change? {#change-uuid}

Typical VM configuration updates, such as changing the number of vCPUs, the amount of vRAM, and adding disks, do not affect the UUID. However, in some cases, the UUID may change. For example, this may happen when updating BIOS or performing similar operations that affect the service's hardware components.

Keep this in mind when using third-party software licenses. The best solution is to purchase a license that does not have any link to the UUID.

#### Can I install the required software on a VM when creating it? {#preinstall-software}

Yes, you can. To do this, specify a custom script with commands to install the required software in the metadata of the VM you are creating. For more information, see [{#T}](../../compute/operations/vm-create/create-with-cloud-init-scripts.md).

#### How do I change metadata after creating a VM? {#change-metadata-after-creating}

Use the [updateMetadata](../../compute/api-ref/Instance/updateMetadata.md) API method.

This method enables you to update the [metadata](../../compute/concepts/vm-metadata.md) in the service without affecting the guest OS run by the VM. If you need to update a parameter within your VM after its creation, in most cases, the best way is to recreate the VM from a snapshot or make the changes manually.

### VM operations {#operations-on-vm}

#### Can I copy or clone an existing VM? {#clone-vm}

Yes, you can create snapshots of the disks attached to your VM and use them when creating a new VM.

#### Can I move my VM to a different availability zone? {#move-az}

You cannot directly change the [availability zone](../../overview/concepts/geo-scope.md) hosting your VM. However, you can create a VM copy in the availability zone you need.

#### Can I move my VM to a different folder? {#move-to-project}

You can move your VM to a different [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) within a single [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud). For more information, see [{#T}](../../compute/operations/vm-control/vm-change-folder.md).

#### Can I recover my VM if I accidentally delete it? {#delete-vm2}

No, you cannot. Deleting a VM is irreversible and cannot be undone.

To prevent data loss if you accidentally delete a VM, you can either set up disk backups using snapshots or configure the disks so that they are not automatically deleted along with the VM.