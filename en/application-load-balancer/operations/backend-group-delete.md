---
title: How to delete a backend group
description: In this tutorial, you will learn how to delete a backend group.
---

# Deleting a backend group

{% note warning %}

{% include [backend-group-deletion-restriction](../../_includes/application-load-balancer/backend-group-deletion-restriction.md) %}

{% endnote %}

To delete a [backend group](../concepts/backend-group.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with your backend group.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the backend group name and select **{{ ui-key.yacloud.common.delete }}**.

     To delete multiple backend groups at once, select them in the list and click **{{ ui-key.yacloud.common.delete }}** at the bottom of the screen.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../cli/) command for deleting a backend group:

     ```bash
     yc alb backend-group delete --help
     ```

  1. Run this command and specify the name of the backend group you want to delete:

     ```bash
     yc alb backend-group delete --name <backend_group_name>
     ```

     To check whether the group has been deleted, get a backend group list by running the command:

     ```bash
     yc alb backend-group list
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and delete the fragment describing your backend group.

     Sample backend group description in the {{ TF }} configuration:

     ```hcl
     resource "yandex_alb_backend_group" "test-backend-group" {
       name                     = "<backend_group_name>"

       http_backend {
         name                   = "<backend_name>"
         weight                 = 1
         port                   = 80
         target_group_ids       = ["<target_group_ID>"]
         load_balancing_config {
           panic_threshold      = 90
         }    
         healthcheck {
           timeout              = "10s"
           interval             = "2s"
           healthy_threshold    = 10
           unhealthy_threshold  = 15 
           http_healthcheck {
             path               = "/"
           }
         }
       }
     }
     ```

     For more information about `yandex_alb_backend_group` properties, see the relevant [{{ TF }} article]({{ tf-provider-alb-backendgroup }}).
  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the backend group updates in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/) command:

     ```bash
     yc alb backend-group list
     ```

- API {#api}

  Use the [delete](../api-ref/BackendGroup/delete.md) REST API method for the [BackendGroup](../api-ref/BackendGroup/index.md) resource or the [BackendGroupService/Delete](../api-ref/grpc/BackendGroup/delete.md) gRPC API call.

{% endlist %}