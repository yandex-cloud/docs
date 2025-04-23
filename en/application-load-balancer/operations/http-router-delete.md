---
title: How to delete an HTTP router
description: In this tutorial, you will learn how to delete an HTTP router.
---

# Deleting an HTTP router

{% note warning %}

{% include [http-router-deletion-restriction](../../_includes/application-load-balancer/http-router-deletion-restriction.md) %}

{% endnote %}

To delete an HTTP router:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your HTTP router.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Select your router and click ![image](../../_assets/console-icons/ellipsis.svg).
  1. In the menu that opens, select **{{ ui-key.yacloud.common.delete }}**.

     To delete multiple routers at once, select them in the list and click **{{ ui-key.yacloud.common.delete }}** at the bottom of the screen.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting an HTTP router:

     ```bash
     yc alb http-router delete --help
     ```

  1. Run this command with your HTTP router name specified:

     ```bash
     yc alb http-router delete --name <HTTP_router_name>
     ```

     To check whether your router has been deleted, get a list of HTTP routers by running the command:

     ```bash
     yc alb http-router list
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete an HTTP router or virtual host created with {{ TF }}:
  1. Open the {{ TF }} configuration file and delete the fragment describing the HTTP router or virtual host, i.e., `yandex_alb_http_router` or `yandex_alb_virtual_host` resource, respectively.

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

  1. In the command line, navigate to the directory with the {{ TF }} configuration file.
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

     You will see a detailed list of resources. No changes will be made at this step. If your configuration contains errors, {{ TF }} will show them.
  1. Apply the changes:

     ```bash
     terraform apply
     ```

  1. Type `yes` and press **Enter** to confirm changes.

     You can check updates in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc alb http-router list
     ```

- API {#api}

  Use the [delete](../api-ref/HttpRouter/delete.md) REST API method for the [HttpRouter](../api-ref/HttpRouter/index.md) resource or the [HttpRouter/Delete](../api-ref/grpc/HttpRouter/delete.md) gRPC API call.

{% endlist %}