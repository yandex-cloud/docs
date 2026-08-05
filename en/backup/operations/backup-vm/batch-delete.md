---
title: How to delete all backups of a resource
description: Follow this guide to delete all backups of a resource.
---

# Deleting all backups of a resource


If you need to delete all backups of a [{{ compute-name }} VM](../../concepts/vm-connection/compute.md), [{{ baremetal-name }} server](../../concepts/vm-connection/baremetal.md), or [external resource](../../concepts/vm-connection/external-resources.md), a faster and more effective way is to delete them together as a single [archive](../../concepts/backup.md#archives) rather than separately. This way, you can save time and avoid possible errors.

To delete the backup archive for a [backed up resource](../../concepts/index.md#protected-resources):

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting a backup archive:

      ```bash
      yc backup backup batch-delete --help
      ```
  1. Get a list of all backup archives in the default folder:

      ```bash
      yc backup backup list-archives
      ```

      Result:

      ```
      +--------------------------------------+-------------+----------------------+--------------------------------------------------------------------------------------+--------+---------------------+---------------------+------------------------+
      |                  ID                  | RESOURCE ID |     INSTANCE ID      |                                         NAME                                         |  SIZE  |     CREATED AT      |     UPDATED AT      | LAST BACKUP CREATED AT |
      +--------------------------------------+-------------+----------------------+--------------------------------------------------------------------------------------+--------+---------------------+---------------------+------------------------+
      | d8322308-fc11-833a-6b52-ca63******** |             | epd73glhmkr0******** | second-vm-579CFEB6-A557-4922-AACD-697FADED0529-40DC750F-057C-41FD-8AAE-D485A******** | 6.0 GB | 2025-03-02 15:33:44 | 0001-01-01 00:00:00 | 2025-03-02 16:07:13    |
      | 4508faa1-3372-542e-f73a-cccf******** |             | epdolbm6ijmt******** | backup-vm-579CFEB6-A557-4922-AACD-697FADED0529-86A93494-96F7-4168-A44C-0A969******** | 9.3 GB | 2025-03-02 14:13:46 | 0001-01-01 00:00:00 | 2025-03-02 16:07:16    |
      +--------------------------------------+-------------+----------------------+--------------------------------------------------------------------------------------+--------+---------------------+---------------------+------------------------+
      ```

      {% note info %}

      You can request a list of backup archives for a specific backed up resource:

      ```bash
      yc backup backup list-archives \
        --instance-id <resource_ID>
      ```

      However, this command will only provide an output if the resource you specified has not been deleted, i.e., it is still there and connected to {{ backup-name }}.

      {% endnote %}

  1. Delete the backup archive:

      * You can delete the archive by specifying its ID:

          ```bash
          yc backup backup batch-delete \
            --archive-id <archive_ID>
          ```

          Where `--archive-id` is the ID of the [backup archive](../../concepts/backup.md#archives) you need to delete.

      * You can delete the archive by specifying the IDs of the backed up resource and its backup policy:

          ```bash
          yc backup backup batch-delete \
            --instance-id <resource_ID> \
            --policy-id <policy_ID>
          ```

          Where:
          * `--instance-id`: ID of the [{{ compute-name }} VM](../../concepts/vm-connection/compute.md), [{{ baremetal-name }} server](../../concepts/vm-connection/baremetal.md), or [external resource](../../concepts/vm-connection/external-resources.md) whose backups you need to delete. When using the `--instance-id` parameter, you must specify the `--policy-id` parameter as well.
          * `--policy-id`: ID of the [backup policy](../../concepts/policy.md) on which the backups you need to delete were based. When using the `--policy-id` parameter, you must specify the `--instance-id` parameter as well.

{% endlist %}

The archive deletion will remove all [resource](../../concepts/index.md#protected-resources) backups stored in that archive.

{% note info %}

If the resource backups were based on a variety of backup policies, you also need to delete other archives associated with that resource and created under such policies.

{% endnote %}

#### Useful links {#see-also}

[{#T}](./delete.md)
