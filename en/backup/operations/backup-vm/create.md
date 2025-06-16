---
title: How to create a VM or {{ baremetal-full-name }} server backup in {{ backup-full-name }}
description: Follow this guide to create a VM or {{ baremetal-name }} server backup.
---

# Creating a VM or {{ baremetal-full-name }} server backup

To create a backup of a VM or {{ baremetal-name }} server, [connect](../../concepts/vm-connection.md) it to {{ backup-name }} and [link](../policy-vm/attach-and-detach-vm.md#attach-vm) it to at least one [backup policy](../../concepts/policy.md). Any backup can only be created within policies.

{{ backup-name }} automatically creates backups based on the schedule detailed in the policy.

To create an out-of-schedule backup:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the backup policy.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Depending on the resource you want to create a backup for, select ![vm](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.backup.label_instances }}** or ![bms](../../../_assets/console-icons/objects-align-justify-horizontal.svg) **{{ ui-key.yacloud.backup.label_baremetal-instances }}** in the left-hand panel.
  1. In the row with the required VM or {{ baremetal-name }} server, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.backup.action_start_backup }}**.
  1. In the window that opens, select the backup policy for creating the backup and click **{{ ui-key.yacloud.common.create }}**.

  {{ backup-name }} will start creating a backup of your VM or {{ baremetal-name }} server. You can follow the progress in the VM or {{ baremetal-name }} server row in the **{{ ui-key.yacloud.backup.column_baremetal-instance-status }}** field.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to create a backup:

      ```bash
      yc backup policy execute --help
      ```

  1. Get the ID of the backup policy the backup will be based on:

      {% include [get-backup-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Get the ID of the VM you need to back up:

      {% include [get-vm-id](../../../_includes/backup/operations/get-vm-id.md) %}

      {% include [get-bms-ids](../../../_includes/backup/operations/get-bms-ids.md) %}

  1. Create a backup:

      ```bash
      yc backup policy execute \
        --id <policy_ID> \
        --instance-id <VM_or_{{ baremetal-name }}_server_ID>
      ```

      Where:

      * `--id`: ID of the backup policy the backup will be based on.
      * `--instance-id`: ID of the VM or {{ baremetal-name }} server you need to back up.

      Result:

      ```bash
      id: abcsdngawmqv********
      description: execute policy
      created_at: "2024-08-19T09:38:06.015732Z"
      created_by: def9k8luj4qf********
      modified_at: "2024-08-19T09:38:06.015732Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.backup.v1.ExecuteMetadata
        policy_id: hij86k3tu3pu********
        compute_instance_id: klmc87d7q49r********
      ```

  For more information about the command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/policy/execute.md).

{% endlist %}