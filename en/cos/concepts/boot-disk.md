# Specifics of working with a boot disk

When [creating a VM from a {{ coi }}](../tutorials/vm-create.md), take into account the following specifics:
* You can't create a boot disk from a [disk snapshot](../../compute/concepts/snapshot.md).
* By default, you create a disk that is the same size as the image. However, since the purpose of a VM created from a {{ coi }} is to run a Docker container, there may not be enough free space to deploy the Docker container. To avoid this, explicitly specify the required size of the boot disk using the `--create-boot-disk size=<disk size in GB>` flag. The disk size must be at least 30 GB.