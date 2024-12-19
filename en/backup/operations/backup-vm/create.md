---
title: How to create a VM or {{ baremetal-full-name }} server backup in {{ backup-full-name }}
description: Follow this guide to create a VM or {{ baremetal-name }} server backup.
---

# Creating a VM or {{ baremetal-full-name }} server backup

To create a backup of a VM or {{ baremetal-name }} server, [connect](../../concepts/vm-connection.md) it to {{ backup-name }} and [link](../policy-vm/attach-and-detach-vm.md#attach-vm) it to at least one [backup policy](../../concepts/policy.md). Any backup can only be created within policies.

{% include [baremetal-note](../../../_includes/backup/baremetal-note.md) %}

To learn how to create a [{{ baremetal-name }} server](../../../baremetal/concepts/servers.md) backup, see [Starting creating a backup](../backup-baremetal/backup-baremetal.md#execute-policy).

{{ backup-name }} automatically creates backups based on the schedule detailed in the policy.

To create an out-of-schedule backup:

{% list tabs group=instructions %}

- Management console {#console}

  {% note info %}

  Currently, the management console supports creating backups only for {{ compute-full-name }} VMs. To create an out-of-schedule {{ baremetal-name }} server backup, use the {{ yandex-cloud }} CLI.

  {% endnote %}

  1. In the [management console]({{ link-console-main }}), select a folder to create a backup in.
  1. In the list of services, select **{{ compute-name }}**.
  1. Select the VM with the `Running` [status](../../../compute/concepts/vm-statuses.md#list-of-statuses) that you want to back up.
  1. Go to the **Backups** tab.
  1. Click **Create backup**.
  1. In the window that opens, select the backup policy to create the VM backup under and click **Create**.

  The VM backup creation will start.

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

      To get the {{ baremetal-name }} server ID, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}** from the list of services of the relevant [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) in the [management console]({{ link-console-main }}). The ID is specified in the **{{ ui-key.yacloud.common.id }}** field in the line with the relevant server.

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