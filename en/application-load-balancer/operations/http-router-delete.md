---
title: "How to delete an HTTP router"
description: "Follow this guide to delete an HTTP router."
---

# Deleting an HTTP router

{% note warning %}

{% include [http-router-deletion-restriction](../../_includes/application-load-balancer/http-router-deletion-restriction.md) %}

{% endnote %}

To delete an HTTP router:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the HTTP router was created.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
   1. Select the router and click ![image](../../_assets/console-icons/ellipsis.svg).
   1. In the menu that opens, select **{{ ui-key.yacloud.common.delete }}**.

      To do this with multiple HTTP routers, select the routers to delete from the list and click **{{ ui-key.yacloud.common.delete }}** at the bottom of the screen.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for deleting an HTTP router:

      ```bash
      yc alb http-router delete --help
      ```

   1. Run the command, specifying the name of the HTTP router:

      ```bash
      yc alb http-router delete --name <HTTP_router_name>
      ```

      To check the deletion, get a list of HTTP routers by running the command:

      ```bash
      yc alb http-router list
      ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To delete an HTTP router or virtual host created with {{ TF }}:
   1. Open the {{ TF }} configuration file and delete the fragment with the HTTP router or virtual host description (the `yandex_alb_http_router` and `yandex_alb_virtual_host` resources, respectively).

      {% cut "Sample HTTP router and virtual host description in the {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_alb_http_router" "tf-router" {
        name   = "my-http-router"
        labels = {
          tf-label    = "tf-label-value"
          empty-label = ""
        }
      }

      resource "yandex_alb_virtual_host" "my-virtual-host" {
        name           = "my-virtual-host"
        http_router_id = "${yandex_alb_http_router.tf-router.id}"
        route {
          name = "my-route"
          http_route {
            http_route_action {
              backend_group_id = "${yandex_alb_backend_group.backend-group.id}"
              timeout          = "3s"
            }
          }
        }
      }
      ...
      ```

      {% endcut %}

   1. In the command line, go to the directory with the {{ TF }} configuration file.
   1. Check the configuration using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```text
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```bash
      yc alb http-router list
      ```

- API {#api}

   Use the [delete](../api-ref/HttpRouter/delete.md) REST API method for the [HttpRouter](../api-ref/HttpRouter/index.md) resource or the [HttpRouter/Delete](../api-ref/grpc/http_router_service.md#Delete) gRPC API call.

{% endlist %}