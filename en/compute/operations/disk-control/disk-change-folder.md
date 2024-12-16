# Moving a disk to another folder

When a disk is being created, it's placed in the current folder.

In {{ yandex-cloud }}, you can move a disk to another folder within one cloud.

You can learn more about the resource hierarchy in {{ yandex-cloud }} [here](../../../resource-manager/concepts/resources-hierarchy.md).

## Limitations {#limits}

Limitations when moving a disk:

* In [{{ monitoring-full-name }}](../../../monitoring/), metrics are not movable. The metrics in the previous folder stay there and new metrics will already be created in the new folder.
* You can move VMs only within a single cloud.

## Moving a disk {#change-folder}

To change a disk's folder:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get a list of all the disks in the default folder:

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

  1. View the description of the CLI disk move command:

      ```bash
      yc compute disk move --help
      ```

  1. Move the disk to another folder with the following parameters:

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
