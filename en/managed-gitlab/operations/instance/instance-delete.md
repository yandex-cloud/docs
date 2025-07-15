---
title: Deleting an instance
description: Follow this guide to delete an instance.
---

# Deleting an instance

If the instance has deletion protection enabled, [disable](instance-update.md) it first, and then delete the instance.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to delete a [{{ GL }} instance](../../concepts/index.md#instance) from.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) for the instance and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To delete a {{ GL }} instance, run this command:

  ```bash
  {{ yc-mdb-gl }} instance delete <instance_name_or_ID>
  ```

  You can [request](instance-list.md#list) the instance ID or name with the list of instances in the folder.

  Result:

  ```text
  done (3m14s)
  ```

  For more information about this command, see the [CLI reference](../../cli-ref/instance/delete.md).

- API {#api}

  Use the [Delete](../../api-ref/Instance/delete.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Delete](../../api-ref/grpc/Instance/delete.md) gRPC API call.

{% endlist %}

If you have deleted the instance but want to restore it, contact [support]({{ link-console-support }}). When you delete an instance, the system automatically creates its [backup](../../concepts/backup.md) which is stored for two weeks.
