---
title: How to delete all backups of a resource
description: Follow this guide to delete all backups of a VM or {{ baremetal-name }} server.
---

# Deleting all backups of a VM or {{ baremetal-name }} server

If you need to delete all backups of a [VM](../../../compute/concepts/vm.md) or [{{ baremetal-name }} server](../../../baremetal/concepts/servers.md), the faster and more effective way to delete them as a whole [archive](../../concepts/backup.md#archives) rather than separately. This way, you can save time and avoid possible errors.

To delete the backup archive of a VM or {{ baremetal-name }} server:

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

      You can request a list of backup archives for a specific VM or {{ baremetal-name }} server:

      ```bash
      yc backup backup list-archives --instance-id <VM_or_{{ baremetal-name }}_server_ID>
      ```

      However, this command will provide an output in case the VM or server you specified has not been deleted, i.e., it is still there and connected to {{ backup-name }}.

      {% endnote %}

  1. Delete the backup archive:

      * You can delete the archive by specifying its ID:

          ```bash
          yc backup backup batch-delete \
            --archive-id <archive_ID>
          ```

          Where `--archive-id` is the ID of the [backup archive](../../concepts/backup.md#archives) you need to delete.

      * You can delete the archive by specifying the IDs of the VM or server and the backup policy:

          ```bash
          yc backup backup batch-delete \
            --instance-id <VM_or_{{ baremetal-name }}_server_ID> \
            --policy-id <policy_ID>
          ```

          Where:
          * `--instance-id`: ID of the VM or {{ baremetal-name }} server whose backups you need to delete. When using the `--instance-id` parameter, you must specify the `--policy-id` parameter as well.
          * `--policy-id`: ID of the [backup policy](../../concepts/policy.md) on which the backups you need to delete were based. When using the `--policy-id` parameter, you must specify the `--instance-id` parameter as well.

{% endlist %}

The archive deletion will remove all backups of the VM or {{ baremetal-name }} server stored in that archive.

{% note info %}

If backups for a VM or {{ baremetal-name }} server were based on a variety of backup policies, you also need to delete other VM or server archives created under such policies.

{% endnote %}

#### See also {#see-also}

* [{#T}](./delete.md)