# Specifics of working with a boot disk

When [creating a VM from {{ coi }}](../solutions/vm-create.md), you must consider the specifics:
* You can't create a boot disk from a [disk snapshot](../../compute/concepts/snapshot.md).
* By default, a disk is created that is the same size as the image. However, since the purpose of a VM with a {{ coi }} is to run a Docker container, there may not be enough free space when deploying the Docker container. To avoid this, explicitly specify the required size of the boot disk using the `--create-boot-disk size=<disk size in GB>` flag.