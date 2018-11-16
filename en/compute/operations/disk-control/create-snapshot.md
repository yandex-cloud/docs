# Creating a disk snapshot

_A disk snapshot_ is a copy of the disk file system at a certain point in time.

## Preparation {#prepare}

A disk snapshot contains only the data written to disk when creating the snapshot. If the disk is attached to a running VM, the cache of the apps and OS will not be included in the snapshot.

To ensure the integrity of the snapshot data:

**For Linux systems:**

1. Stop all disk write operations in the apps.
1. Run one of the following commands:
    - `sync` to write the OS cache to disk
    - `fsfreeze -f` to freeze the file system. To unfreeze it, run the `fsfreeze --unfreeze` command.

**For any other systems:**

1. Stop the VM (see [[!TITLE]](../vm-control/vm-stop-and-start.md#stop)).
1. Wait until the VM's status changes to `STOPPED`.

## Creating a snapshot {#create}

To create a disk snapshot:

---

**[!TAB Management console]**

1. In the management console, select the folder where the disk is located.
1. Click on the **Yandex Compute Cloud** tile.
1. On the **Virtual machines** page, go to the **Disks** tab.
1. In the line with the disk name, click ![](../../../_assets/dots.png) and select the **Create snapshot** command.
1. Enter the snapshot name.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

1. If necessary, enter an arbitrary text description of the snapshot.
1. Click **Create snapshot**.

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. See the description of the CLI's create snapshot commands:

    ```
    $ yc compute snapshot create --help
    ```

1. Select the disk to take a snapshot of. To get a list of all the disks in the folder specified in your CLI profile, run the command:

    ```
    $ yc compute disk list
    +----------------------+------------+-------------+---------------+--------+----------------------+
    |          ID          |    NAME    |    SIZE     |     ZONE      | STATUS |     DESCRIPTION      |
    +----------------------+------------+-------------+---------------+--------+----------------------+
    | fhm53hnjmvplsn5r0633 |            | 13958643712 | ru-central1-a | READY  |                      |
    | fhmc3pdo4l7uqf8hq0ad |            | 42949672960 | ru-central1-a | READY  |                      |
    +----------------------+------------+-------------+---------------+--------+----------------------+
    ```

1. Create a snapshot in the default folder:

    ```
    $ yc compute snapshot create \
        --name my-yc-snapshot-fhm53 \
        --description "my first snapshot via yc" \
        --disk-id fhm53hnjmvplsn5r0633
    ```

    This command creates a disk snapshot with the name `my-yc-snapshot-fhm53` and description `my first snapshot via yc`.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

---

A snapshot is created asynchronously. The snapshot is created immediately after the create command is run. It gets the `CREATING` status. From this point on, you can resume writing data to disk, and disk operations will not affect the data in the snapshot.

Once the snapshot has been created, its status changes to `READY`. From this point on, you can use the snapshot for creating images, filling disks, and so on.
