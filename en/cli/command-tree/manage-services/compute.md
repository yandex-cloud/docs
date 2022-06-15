# yc compute

Managing {{ compute-full-name }} resources.

#### Command usage

Syntax:

`yc compute <group>`

#### Groups

- `yc compute instance`: Manage [VM instances](../../../compute/concepts/vm.md).
   - `get`: [Get information about the specified VM instance](../../../compute/operations/vm-info/get-info.md).
   - `list`: Get a list of VM instances.
   - `create`: [Create a VM instance](../../../compute/operations/vm-create/create-linux-vm.md).
   - `update`: [Update the specified VM instance](../../../compute/operations/vm-control/vm-update.md).
   - `delete`: [Delete the specified VM instance](../../../compute/operations/vm-control/vm-delete.md).
   - `get-serial-port-output`: [Return the serial port output of the specified VM instance](../../../compute/operations/vm-info/get-serial-port-output.md).
   - `stop`: [Stop the specified VM instance](../../../compute/operations/vm-control/vm-stop-and-start.md#stop).
   - `start`: [Start the specified VM instance](../../../compute/operations/vm-control/vm-stop-and-start.md#start).
   - `restart`: [Restart the specified VM instance](../../../compute/operations/vm-control/vm-stop-and-start.md#restart).
   - `attach-disk`: [Attach an existing disk to the specified VM instance](../../../compute/operations/vm-control/vm-attach-disk.md).
   - `attach-new-disk`: Attach a new disk to the specified VM instance.
   - `detach-disk`: [Detach an existing disk from the specified VM instance](../../../compute/operations/vm-control/vm-detach-disk.md).
   - `list-operations`: Get a list of operations for the specified VM instance.
- `yc compute disk`: Manage [disks](../../../compute/concepts/disk.md).
   - `get`: Get information about the specified disk.
   - `list`: Get a list of disks.
   - `create`: [Create a disk](../../../compute/operations/disk-create/empty.md).
   - `update`: Update a disk.
   - `resize`: Resize the specified disk.
   - `delete`: [Delete the specified disk](../../../compute/operations/disk-control/delete.md).
   - `list-operations`: Get a list of operations for the specified disk.
- `yc compute disk-type`: Get information about the available disk types.
   - `get`: Get information about the specified disk type.
   - `list`: Get a list of disk types.
- `yc compute image`: Manage [images](../../../compute/concepts/image.md).
   - `get`: Get information about the specified image.
   - `list`: [Get a list of images](../../../compute/operations/images-with-pre-installed-software/get-list.md).
   - `get-latest-from-family`: Get information about the latest image from the image family.
   - `create`: [Create an image](../../../compute/operations/image-create/upload.md#2.-sozdajte-obraz-v-compute-cloud).
   - `update`: Update the specified image.
   - `delete`: Delete the specified image.
   - `list-operations`: Get a list of operations for the specified image.
- `yc compute snapshot`: Manage [disk snapshots](../../../compute/concepts/snapshot.md).
   - `get`: Get information about the specified disk snapshot.
   - `list`: Get a list of disk snapshots.
   - `create`: [Create a snapshot of the specified disk](../../../compute/operations/disk-control/create-snapshot.md).
   - `update`: Update the specified disk snapshot.
   - `delete`: [Delete the specified disk snapshot](../../../compute/operations/snapshot-control/delete.md).
   - `list-operations`: Get a list of operations for the specified disk snapshot.
- `yc compute zone`: Get information about [availability zones](../../../overview/concepts/geo-scope.md).
   - `get`: Get information about the specified availability zone.
   - `list`: Get a list of availability zones.

