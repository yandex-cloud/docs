{% note info %}

[Disks](../../compute/concepts/disk.md), [snapshots](../../compute/concepts/snapshot.md), and [images](../../compute/concepts/image.md) are separate resources that work independently from each other in {{ compute-name }}. You can create, delete, and manage them separately. Any changes you make to the disk do not affect the snapshot of that disk or the image it was created from. Even if you delete the disk or the VM with the disk, its snapshot and image will remain unaffected.

{% endnote %}