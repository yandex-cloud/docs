---
title: Deleting a {{ mgl-full-name }} instance
description: Follow this guide to delete a {{ mgl-name }} instance.
---

# Deleting a {{ GL }} instance

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

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To delete a {{ GL }} instance created using {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the fragment with the `yandex_gitlab_instance` resource description:

     Example of a {{ GL }} instance description in the {{ TF }} configuration:

     ```hcl
     resource "yandex_gitlab_instance" "my_gitlab_instance" {
       name                      = "gl-instance"
       resource_preset_id        = "s2.micro"
       disk_size                 = 100
       admin_login               = "gitlab-user"
       admin_email               = "gitlab-user@example.com"
       domain                    = "gitlab-terraform.gitlab.yandexcloud.net"
       subnet_id                 = "e9bsdv4iunrv********"
       approval_rules_id         = "BASIC"
       backup_retain_period_days = 7
       deletion_protection       = true
     }
     ```

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the updates in the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/quickstart.md) command:

  ```bash
  {{ yc-mdb-gl }} instance list
  ```

- API {#api}

  Use the [Delete](../../api-ref/Instance/delete.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Delete](../../api-ref/grpc/Instance/delete.md) gRPC API call.

{% endlist %}

If you have deleted a {{ GL }} instance but want to restore it, contact [support]({{ link-console-support }}). When you delete an instance, the system automatically creates its [backup](../../concepts/backup.md) which is stored for two weeks.
