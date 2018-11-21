# Deleting a disk

You can only delete a disk that is not attached to any VM.

> [!IMPORTANT]
>
> Deleting a disk is an operation that cannot be canceled or reversed. You cannot restore a deleted disk.

If you delete a disk, its snapshots are not deleted with it. Snapshots need to be [deleted](../snapshot-control/delete.md) separately.

To delete a disk:

---

**[!TAB Management console]**

1. In the management console, select the folder the disk belongs to.
1. Click on the **Yandex Compute Cloud** tile.
1. On the **Virtual machines** page, go to the **Disks** tab.
1. In the line with the appropriate disk, click ![](../../../_assets/dots.png) and select the **Delete** command.
1. Confirm the deletion.

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. See the description of the CLI's delete disk commands:

    ```
    $ yc compute disk delete --help
    ```

1. Get a list of disks in the default folder:

    ```
    $ yc compute disk list
    +----------------------+------------+-------------+---------------+--------+----------------------+
    |          ID          |    NAME    |    SIZE     |     ZONE      | STATUS |     DESCRIPTION      |
    +----------------------+------------+-------------+---------------+--------+----------------------+
    | fhm53hnjmvplsn5r0633 |            | 13958643712 | ru-central1-a | READY  |                      |
    | fhmc3pdo4l7uqf8hq0ad |            | 42949672960 | ru-central1-a | READY  |                      |
    | fhmj8jjlicm6g3poe32g | my-yc-disk | 10737418240 | ru-central1-a | READY  | my first disk via yc |
    +----------------------+------------+-------------+---------------+--------+----------------------+
    ```

1. Select the `ID` or `NAME` of the necessary disk.

1. Delete the disk:

    ```
    $ yc compute disk delete \
        --name my-yc-disk
    ```

---

