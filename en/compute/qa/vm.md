# Virtual machines

## Technical parameters

#### What VM configuration (memory, vCPU) can I use? {#configure-vm}

[!INCLUDE-NOTITLE [compute-resources]](../_includes_service/compute-resources.md)]

For more information, see the section [[!TITLE]](../concepts/vm-types.md).

#### How can I change the amount of RAM and the number of cores allocated to a VM? {#update-type}

[!INCLUDE [change-vm-resources](../_includes_service/change-vm-resources.md)]

## Operations on VMs

#### Can I copy or clone an existing VM? {#clone-vm}

Yes, you can take snapshots of disks attached to a VM and use them when creating a new VM.

#### Can I move my VM to a different availability zone? {#move-az}

You cannot directly change the availability zone the VM lives in. However, you can create a copy of the VM in the availability zone you need.

#### Can I move my VM to a different folder? {#move-to-project}

You cannot directly change the folder the VM belongs to. However, you can create a copy of the VM in the appropriate folder.

#### If I accidentally delete my VM, can I restore it? {#delete-vm2}

No, you can't. Deleting a VM is an operation that cannot be undone.

To avoid losing your data in case of accidental deletion, you can configure disk backup using snapshots, or specify that the disks should not be automatically deleted when deleting the VM.

