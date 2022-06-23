---
title: Questions and answers (QA) – Virtual machines
description: Answers to frequently asked questions about virtual machines in Yandex Cloud infrastructure. Technical characteristics, operations with virtual machines. What virtual machine configuration (memory, processor) you can use.
keywords:
  - vm
  - virtual machines
---

# Virtual machines

### Technical specifications {#technical-parameters}

#### What VM configuration (memory, vCPU) can I use? {#configure-vm}

{% include [support-channels](../../_includes/compute/compute-resources.md) %}

For more information, see [{#T}](../concepts/performance-levels.md).

#### How can I change the amount of RAM and the number of cores allocated to a VM? {#update-type}

For more information, see [{#T}](../operations/vm-control/vm-update-resources.md).

#### How do I create a multi-interface VM? {#multi-interface}

You can only add a network interface when [creating a VM](../operations/index.md#vm-create). Currently, multiple interfaces can only be created using network images from the [Marketplace](https://cloud.yandex.com/marketplace?categories=network).

### VM parameters {#parameters-vm}

#### How do I increase quotas {#increase-quotas}

To increase quotas, submit a request on [this page]({{ link-console-quotas }}). Select the service (or services) and specify which quota values you need.

After creating the request, the message appears in the [support section]({{ link-console-support }}), where you can track its implementation. In some cases, it may be necessary to get approval from the service to ensure the availability of resources, and/or to increase the balance of your personal account.

#### Does nested virtualization work / Is it possible to host your own VMs inside a virtual machine {#nested-virtualization}

Nested virtualization isn't supported for security reasons. If you don't find a suitable public image for a VM, you can upload your own image and create a VM from it. See: [{#T}](../operations/vm-create/create-from-user-image.md).

#### Is the data saved when I change a VM's parameters {#data-saved-after-change-parameters}

Yes, the data should be saved. However, please note that it isn't recommended to restart the VM when writing to the system disk because this can lead to file system corruption.

To change a VM's parameters, we recommend taking the following steps:
1. Take a snapshot of the disk: see [{#T}](../operations/disk-control/create-snapshot.md).
1. Turn off the VM as normal: see [{#T}](../operations/vm-control/vm-stop-and-start.md).
1. Change the VM's parameters: see [{#T}](../operations/vm-control/vm-update-resources.md).
1. Wait until the operation is completed (the **Operations** section in the {{ compute-name }} service).
1. Start the VM.
1. Make sure that the new parameters were applied.

#### Is it possible to reduce the vCPU/vRAM for a VM {#reduce-cpu-ram}

You can. However, if the load on the vCPU and/or vRAM was already significant before changing the parameters, after lowering the parameters, the VM may not start.

If the load on the server is small and at the same time uniform, it's even recommended to reduce the parameters so as not to overpay.

#### What's the difference between GPU and vGPU {#gpu-vs-vgpu}

The main difference is that the GPU can be used for mathematical calculations and machine learning, and the vGPU can also be used for graphics tasks.

In addition, their cost, support of multiple processors, and licensing differ. For a detailed description and comparison of the GPU and vGPU, see [{#T}](../concepts/gpus.md).

#### Is it possible to change the FQDN {#change-fqdn}

The FQDN is issued to the VM at the time of its creation, and you cannot change it.

If you want to change the FQDN, you need to delete the VM and create a new one. To preserve the consistency of the data:
1. Stop the VM: see [{#T}](../operations/vm-control/vm-stop-and-start.md#stop).
1. Take a snapshot of the disk: see [{#T}](../operations/disk-control/create-snapshot.md).
1. Create a new VM by selecting the snapshot as the source of the boot disk: see [{#T}](../operations/vm-create/create-from-snapshots.md). Specify the necessary FQDN during creation.

#### Can a VM's UUID change {#change-uuid}

Standard procedures for changing a VM, such as changing the number of vCPUs, the amount of vRAM, and adding disks, don't affect the UUID. However, in some cases, the UUID may change. For example, with updating the BIOS or similar procedures that affect the "hardware" part of the service.

Keep this in mind when using third-party software licenses. It's best if you can purchase a license that isn't tied to the UUID.

#### How do I change metadata after creating a VM {#change-metadata-after-creating}

Use the API method [updateMetadata](../api-ref/Instance/updateMetadata.md).

This method allows you to update the metadata in the service, but without growing it into the guest operating system inside the VM. If you need to update a parameter inside a VM after it's created, in most cases, the best way is to recreate the VM from the snapshot or make changes manually.

### Operations on VMs {#operations-on-vm}

#### Can I copy or clone an existing VM? {#clone-vm}

Yes, you can take snapshots of disks attached to a VM and use them when creating a new VM.



#### Can I move my VM to a different availability zone? {#move-az}

You cannot directly change the availability zone where the VM is hosted. However, you can create a copy of the VM in the availability zone you need.



#### Can I move my VM to a different folder? {#move-to-project}

You cannot directly change the folder that the VM belongs to. However, you can create a copy of the VM in the appropriate folder.

#### If I accidentally delete my VM, can I restore it? {#delete-vm2}

No, you can't. Deleting a VM is an irreversible operation.

To avoid losing your data in case of accidental deletion, you can configure disk backups using snapshots or specify that the disks should not be automatically deleted when deleting the VM.