---
title: How to create a VM or server backup in {{ backup-full-name }}
description: Follow this guide to create a VM or server backup in {{ backup-full-name }}.
---

# Creating a backup of a resource


To create a backup of a [resource](../../concepts/index.md#protected-resources), [connect](../../concepts/vm-connection/index.md) it to {{ backup-name }} and [link](../policy-vm/attach-and-detach-vm.md#attach-vm) it to at least one [backup policy](../../concepts/policy.md). All backups are created only as part of policies.

{{ backup-name }} automatically creates backups based on the schedule detailed in a policy.

To create an out-of-schedule backup:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your backup policy.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. In the left-hand panel, select ![resources](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.backup.label_connected-resources }}**.
  1. Depending on the type of resource you want to back up, open the following tab:

      * **{{ ui-key.yacloud.backup.label_instances }}**: For {{ compute-name }} VMs.
      * **{{ ui-key.yacloud.backup.label_baremetal-instances }}**: For {{ baremetal-name }} servers.
      * **{{ ui-key.yacloud.backup.label_external-vm-instances }}**: For external VMs.
      * **{{ ui-key.yacloud.backup.label_external-server-instances }}**: For external servers.

  1. In the row with the resource, click ![options](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.backup.action_start_backup }}**.
  1. In the window that opens, select the backup policy for creating the backup and click **{{ ui-key.yacloud.common.create }}**.

  This will start the backup creation process. You can see the progress in the **{{ ui-key.yacloud.backup.column_baremetal-instance-status }}** field of the resource row.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to create a backup:

      ```bash
      yc backup policy execute --help
      ```

  1. Get the ID of the backup policy the backup will be based on:

      {% include [get-backup-id](../../../_includes/backup/operations/get-policy-id.md) %}

  1. Get the ID of the [resource](../../concepts/index.md#protected-resources) you want to back up:

      {% include [get-resource-ids](../../../_includes/backup/operations/get-resource-ids.md) %}

  1. Create a backup:

      ```bash
      yc backup policy execute \
        --id <policy_ID> \
        --instance-id <resource_ID>
      ```

      Where:

      * `--id`: ID of the backup policy the backup will be based on.
      * `--instance-id`: ID of the [{{ compute-name }} VM](../../concepts/vm-connection/compute.md), [{{ baremetal-name }}](../../concepts/vm-connection/baremetal.md) server, or [external resource](../../concepts/vm-connection/external-resources.md) to back up.

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

  For more information about this command, see the [CLI reference](../../../cli/cli-ref/backup/cli-ref/policy/execute.md).

- API {#api}

  Use the [execute](../../backup/api-ref/Policy/execute.md) REST API method for the [Policy](../../backup/api-ref/Policy/index.md) resource or the [PolicyService/Execute](../../backup/api-ref/grpc/Policy/execute.md) gRPC API call.

{% endlist %}
