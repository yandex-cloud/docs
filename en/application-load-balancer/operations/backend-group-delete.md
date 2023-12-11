---
title: "How to delete a backend group"
description: "Follow this guide to delete a backend group."
---

# Deleting a backend group

{% note warning %}

{% include [backend-group-deletion-restriction](../../_includes/application-load-balancer/backend-group-deletion-restriction.md) %}

{% endnote %}

To delete a backend group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the backend group was created.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the backend group name and select **{{ ui-key.yacloud.common.delete }}**.

      To do this with multiple groups, select the groups to delete from the list and click **{{ ui-key.yacloud.common.delete }}** at the bottom of the screen.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for deleting a backend group:

      ```bash
      yc alb backend-group delete --help
      ```

   1. Run the command, specifying the name of the backend group you want to delete:

      ```bash
      yc alb backend-group delete --name <backend_group_name>
      ```

      To check the deletion, get a list of backend groups by running the command:

      ```bash
      yc alb backend-group list
      ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}
   1. Open the {{ TF }} configuration file and delete the fragment with the backend group description.

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

      For more information about the `yandex_alb_backend_group` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-alb-backendgroup }}).
   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      You can verify the changes to the backend group using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```bash
      yc alb backend-group list
      ```

- API

   Use the [delete](../api-ref/BackendGroup/delete.md) REST API method for the [BackendGroup](../api-ref/BackendGroup/index.md) resource or the [BackendGroupService/Delete](../api-ref/grpc/backend_group_service.md#Delete) gRPC API call.

{% endlist %}
