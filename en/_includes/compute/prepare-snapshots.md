A disk snapshot only contains the data that was written to the disk at the time its snapshot was created. If the disk is attached to a running VM, the OS and app cache will not be included in the snapshot.

To ensure the snapshot data integrity:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. Stop all disk write operations in applications.

  1. Write the OS cache to the disk:

      ```bash
      sync
      ```

  1. Freeze the file system:

      ```bash
      sudo fsfreeze --freeze <mount_point>
      ```
      Where `--freeze` is the parameter to freeze the file system. Replace `<mount_point>` with the folder where the file system is mounted, e.g., `/mnt/vdc2`.

  1. Create a snapshot by following the steps [below](#create).

  1. Unfreeze the file system:

      ```bash
      sudo fsfreeze --unfreeze <mount_point>
      ```
      Where `--unfreeze` is the parameter to unfreeze the file system. Replace `<mount_point>` with the folder where the file system is mounted, e.g., `/mnt/vdc2`.

- Other operating systems {#other}

  1. Stop the VM (see [{#T}](../../compute/operations/vm-control/vm-stop-and-start.md#stop)).
  1. Wait until the VM status changes to `STOPPED`.

{% endlist %}