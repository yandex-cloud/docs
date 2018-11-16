# Creating an empty disk

You can create an empty disk of the specified size.

---

**[!TAB Management console]**

1. In the management console, select the folder where you want to create a disk.
1. Click on the **Yandex Compute Cloud** tile.
1. On the **Virtual machines** page, go to the **Disks** tab.
1. Click **Create disk**.
1. Enter the disk name.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

1. If necessary, add an arbitrary description of the disk.
1. Specify the necessary disk size.
1. Click **Save disk**.

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. See the description of the CLI's create disk commands:

    ```
    $ yc compute disk create --help
    ```

1. Create a disk in the default folder:

    ```
    $ yc compute disk create \
        --name my-yc-disk \
        --size 10 \
        --description "my first disk via yc"
    ```

    This command creates a 10 GB disk with the name `my-yc-disk` and description `my first disk via yc`.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

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

    Get the same list with a large number of details in YAML format:

    ```
    $ yc compute disk list --format yaml

    - id: fhm53hnjmvplsn5r0633
        folder_id: b1gm3og7ei7aegv8i73m
        created_at: "2018-10-01T08:14:58Z"
        type_id: network-nvme
        zone_id: ru-central1-a
        size: "13958643712"
        product_ids:
        - f2ecl5vhsftdean0sr6s
        status: READY
        source_image_id: fd853eldm2bpgu1ii7v6
        instance_ids:
        - fhm9gk85nj7gcoji2f8s
    - id: fhmc3pdo4l7uqf8hq0ad
        folder_id: b1gm3og7ei7aegv8i73m
        created_at: "2018-10-01T08:49:38Z"
        type_id: network-nvme
        zone_id: ru-central1-a
        size: "42949672960"
        product_ids:
        - f2ermbgrfmdb7jp9js5o
        status: READY
        source_image_id: fd8d7vd1imm1hlng6qci
        instance_ids:
        - fhmq76jqs5i59fdi7d7g
    - id: fhmj8jjlicm6g3poe32g
        folder_id: b1gm3og7ei7aegv8i73m
        created_at: "2018-10-03T09:32:06Z"
        name: my-yc-disk
        description: my first disk via yc
        type_id: network-hdd
        zone_id: ru-central1-a
        size: "10737418240"
        status: READY
    ```

---
