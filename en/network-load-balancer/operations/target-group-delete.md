---
title: Deleting a target group in the load balancer
description: Before deleting a target group, detach it from the network load balancer. You cannot restore a target group after it is deleted. Open the Load Balancer section in the folder you want to delete the target group from. In the menu that opens, click Delete.
---

# Deleting a {{ network-load-balancer-name }} target group

{% note alert %}

Before deleting a target group, detach it from the network load balancer. You cannot restore a target group after it is deleted.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   To delete a [target group](../concepts/target-resources.md):
   1. In the [management console]({{ link-console-main }}), select the folder to delete a target group from.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the line of the target group to delete.
   1. In the menu that opens, select **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI delete target group command:

      ```bash
      yc load-balancer target-group delete --help
      ```

   1. Delete the target group from the default folder:

      ```bash
      yc load-balancer target-group delete <target_group_name_or_ID>
      ```

      You can get the target group ID and name with a [list of target groups in the folder](target-group-list.md#list).

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To delete a target group created with {{ TF }}:
   1. Open the {{ TF }} configuration file and delete the fragment with the target group description.

      ```hcl
      resource "yandex_lb_target_group" "foo" {
        name      = "<target_group_name>"
        target {
          subnet_id = "<subnet_ID>"
          address   = "<resource_internal_IP_address>"
        }
        target {
          subnet_id = "<subnet_ID>"
          address   = "<resource_2_internal_IP_address>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Delete the network load balancer.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   To delete a target group, use the [delete](../api-ref/TargetGroup/delete.md) REST API method for the [TargetGroup](../api-ref/TargetGroup/index.md) resource or the [TargetGroupService/Delete](../api-ref/grpc/TargetGroup/delete.md) gRPC API call.

   You can get the target group ID with a [list of target groups in the folder](target-group-list.md#list).

{% endlist %}