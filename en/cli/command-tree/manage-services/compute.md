# yc compute

Manage {{ compute-full-name }} resources.

#### Usage

Syntax:

`yc compute <group>`

#### Groups

- `yc compute instance` — manage [virtual machine instances](../../../compute/concepts/vm.md).
    - `get` — [show information about the specified virtual machine instance](../../../compute/operations/vm-info/get-info.md).
    - `list` — list virtual machine instances.
    - `create` — [create a virtual machine instance](../../../compute/operations/vm-create/create-linux-vm.md).
    - `update` — [update the specified virtual machine instance](../../../compute/operations/vm-control/vm-update.md).
    - `delete` — [delete the specified virtual machine instance](../../../compute/operations/vm-control/vm-delete.md).
    - `get-serial-port-output` — [return the serial port output of the specified virtual machine instance](../../../compute/operations/vm-info/get-serial-port-output.md).
    - `stop` — [stop the specified virtual machine instance](../../../compute/operations/vm-control/vm-stop-and-start.md#stop).
    - `start` — [start the specified virtual machine instance](../../../compute/operations/vm-control/vm-stop-and-start.md#start).
    - `restart` — [restart the specified virtual machine instance](../../../compute/operations/vm-control/vm-stop-and-start.md#restart).
    - `attach-disk` — [attach existing disk to the specified virtual machine instance](../../../compute/operations/vm-control/vm-attach-disk.md).
    - `attach-new-disk` — attach new disk to the the specified virtual machine instance.
    - `detach-disk` — [detach disk from the specified virtual machine instance](../../../compute/operations/vm-control/vm-detach-disk.md).
    - `list-operations` — list operations for the specified instance.
- `yc compute disk` — manage [disks](../../../compute/concepts/disk.md).
    - `get` — show information about the specified disk.
    - `list` — list disks.
    - `create` — [create a disk](../../../compute/operations/disk-create/empty.md).
    - `update` — update the specified disk.
    - `resize` — resize the specified disk.
    - `delete` — [delete the specified disk](../../../compute/operations/disk-control/delete.md).
    - `list-operations` — list operations for the specified disk.
- `yc compute disk-type` — show available disk types.
    - `get` — show information about the specified disk type.
    - `list` — list disk types.
- `yc compute image` — manage [images](../../../compute/concepts/image.md).
    - `get` — show information about the specified image.
    - `list` — [list images](../../../compute/operations/images-with-pre-installed-software/get-list.md).
    - `get-latest-from-family` — show information about the latest image that is part of an image family.
    - `create` — [create an image](../../../compute/operations/image-create/upload#2.-sozdajte-obraz-v-compute-cloud.md).
    - `update` — update the specified image.
    - `delete` — delete the specified image.
    - `list-operations` — list operations for the specified image.
- `yc compute snapshot` — manage [snapshots](../../../compute/concepts/snapshot.md).
    - `get` — show information about the specified snapshot.
    - `list` — list snapshots.
    - `create` — [create a snapshot of the specified disk](../../../compute/operations/disk-control/create-snapshot.md).
    - `update` — update the specified snapshot.
    - `delete` — [delete the specified snapshot](../../../compute/operations/snapshot-control/delete.md).
    - `list-operations` — list operations for the specified snapshot.
- `yc compute zone` — show [availability zones](../../../overview/concepts/geo-scope.md).
    - `get` — show information about the specified availability zone.
    - `list` — list availability zones.
