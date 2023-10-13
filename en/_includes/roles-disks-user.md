#### compute.disks.user {#compute-disks-user}

The `compute.disks.user` role includes the following permissions:

- Get a list of [disks](../compute/concepts/disk.md).
- Get information about a disk.
- Use a disk to create new resources (images, snapshots, new disks, and VMs).

{% include [roles-editor-includes-permissions](iam/roles-editor-includes-permissions.md) %}

{% note info %}

This role is not sufficient to mark the disk as automatically deletable when creating a VM. To do this, use the `editor` role.

{% endnote %}

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}