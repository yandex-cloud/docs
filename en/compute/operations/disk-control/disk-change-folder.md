# Moving a disk to a different folder

When you create a disk, it is placed in the current folder.

In {{ yandex-cloud }}, you can move a disk to a different folder within a single cloud.

Learn more about the {{ yandex-cloud }} resource hierarchy [here](../../../resource-manager/concepts/resources-hierarchy.md).

## Limitations {#limits}

When moving a disk, keep in mind the following limitations:

* [{{ monitoring-full-name }}](../../../monitoring/) does not support metric relocation: existing metrics remain in the source folder, and new ones will be created in the destination folder.
* You can only move disks within a single cloud.

## Moving a disk {#change-folder}

To change the disk folder:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get a list of all disks in the default folder:

      ```bash
      yc compute disk list
      ```

      Result:

      ```bash
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      |          ID          |     NAME     |    SIZE     |     ZONE      | STATUS |     INSTANCE IDS     |       DESCRIPTION       |
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      | a7lqgbt0bb9s******** | first-disk   | 20401094656 | {{ region-id }}-a | READY  | a7lcvu28njbh******** |                         |
      | a7lv5j5hm1p1******** | second-disk  | 21474836480 | {{ region-id }}-a | READY  |                      |                         |
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      ```

  1. Get a list of all folders in the default cloud:

      ```bash
      yc resource-manager folder list
      ```

      Result:

      ```bash
      +----------------------+--------------------+------------------+--------+
      |          ID          |        NAME        |      LABELS      | STATUS |
      +----------------------+--------------------+------------------+--------+
      | b1gd129pp9ha******** | my-folder          |                  | ACTIVE |
      | b1g66mft1vop******** | default            |                  | ACTIVE |
      +----------------------+--------------------+------------------+--------+
      ```

  1. See the description of the CLI command for moving a disk:

      ```bash
      yc compute disk move --help
      ```

  1. Move the disk to a different folder with the following parameters:

      ```bash
      yc compute disk move \
        --id a7lqgbt0bb9s******** \
        --destination-folder-id b1gd129pp9ha********
      ```

      Where:

      * `--id`: Disk ID, e.g., `a7lqgbt0bb9s********`.
      * `--destination-folder-id`: Destination folder ID, e.g., `b1gd129pp9ha********`.

      For more information about the `yc compute disk move` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/disk/move.md).

- API {#api}

  Use the [move](../../api-ref/Disk/move.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Move](../../api-ref/grpc/Disk/move.md) gRPC API call.

{% endlist %}
