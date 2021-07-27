---
title: Questions and answers (QA) – Virtual machines
description: Answers to frequently asked questions about virtual machines in Yandex.Cloud infrastructure. Technical characteristics, operations with virtual machines. What virtual machine configuration (memory, processor) you can use.
keywords:
  - vm
  - virtual machines

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Virtual machines

### Technical specifications {#technical-parameters}

#### What VM configuration (memory, vCPU) can I use? {#configure-vm}

{% include [support-channels](../../_includes/compute/compute-resources.md) %}

Learn more in [{#T}](../concepts/performance-levels.md).

#### How can I change the amount of RAM and the number of cores allocated to a VM? {#update-type}

Learn more in [{#T}](../operations/vm-control/vm-update-resources.md).

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

#### If I lose a private key file from a Linux VM, how else can I log in to it? {#lost-sshkey}

If you configured the [serial console](../operations/serial-console/index.md), you can use it to connect to the VM.

You can also access your data the following way:
1. [Create a snapshot](../operations/disk-control/create-snapshot.md) of the boot disk.
1. [Create a VM](../operations/vm-create/create-linux-vm.md) from a public image.
1. [Attach](../operations/vm-control/vm-attach-disk.md) the disk restored from the snapshot to the VM.

You can then export your data or restore access to the VM.

To restore access:
1. Change the SSH key in the `/home/<username>/.ssh/authorized_keys` file.
1. Make a snapshot of the attached disk.
1. [Create a VM with the disk from the snapshot](../operations/vm-create/create-from-snapshots.md).