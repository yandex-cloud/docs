{% note info %}

[Disks](../../compute/concepts/disk.md), [snapshots](../../compute/concepts/snapshot.md), and [images](../../compute/concepts/image.md) are separate resources that work independently from each other in {{ compute-name }}. You can create, delete, and manage them separately. Your actions with a disk do not affect that disk's snapshot or the image the disk was created out of. Even if you delete the disk or the VM with the disk, its snapshot and image will remain intact.

{% endnote %}