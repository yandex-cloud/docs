# Disks and snapshots

#### How much disk space can I use for a VM? {#disk-size}

For disk limitations, see [{#T}](../concepts/limits.md).

#### Can I resize a disk? {#disk-resize}

Yes, you can change the disk size via the {{ yandex-cloud }} API.

#### What happens to my data when a VM is deleted? {#delete-vm}

When you select a disk to attach to a VM, you can specify whether the disk should be deleted along with the VM. You can choose this option when creating a VM, updating it, or attaching a new disk to it.

If previously created disks are attached to the VM, they will be detached when the VM is deleted. The disk data is preserved and this disk can be attached to another VM in the future.

If you want a disk to be deleted with a VM, specify this during one of the following operations: when creating the VM, updating it, or attaching the disk to it. Such disks will be deleted when you delete the VM.

#### Do I need to stop a VM to create disk snapshots? Do I have to wait until disk snapshots are created before I start a VM? {#create-snapshot}

You don't have to stop the VM. However, keep in mind that a snapshot contains only the data written to disk when creating the snapshot. You need to take care of the data integrity yourself. For information about how to create disk snapshots, see [{#T}](../operations/disk-control/create-snapshot.md).

A snapshot is created asynchronously. You can resume writing data to disk immediately after running the create snapshot command, without waiting for the snapshot creation to be completed.

