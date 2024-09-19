---
title: "How to delete an L7 load balancer in {{ alb-full-name }}"
description: "Follow this guide to delete an L7 load balancer."
---

# Deleting an L7 load balancer

To delete an L7 load balancer:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the load balancer was created.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Next to the load balancer name, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.

     To do this with multiple load balancers, select the load balancers to delete in the list and click **{{ ui-key.yacloud.common.delete }}** at the bottom of the screen.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command for removing a load balancer:

     ```bash
     yc alb load-balancer delete --help
     ```

  1. Run this command:

     ```bash
     yc alb load-balancer delete <load_balancer_name_or_ID>
     ```

     Result:

     ```text
     done (1m10s)
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete an L7 load balancer created with {{ TF }}:
  1. Open the {{ TF }} configuration file and delete the fragment with the L7 load balancer description.

     {% cut "Sample L7 load balancer description in the {{ TF }} configuration" %}

     ```hcl
     ...
     resource "yandex_alb_load_balancer" "test-balancer" {
       name        = "<load_balancer_name>"
       network_id  = yandex_vpc_network.test-network.id

       allocation_policy {
         location {
           zone_id   = "{{ region-id }}-a"
           subnet_id = yandex_vpc_subnet.test-subnet.id
         }
       }

       listener {
         name = "<listener_name>"
         endpoint {
           address {
             external_ipv4_address {
             }
           }
           ports = [ 9000 ]
         }
         http {
           handler {
             http_router_id = yandex_alb_http_router.test-router.id
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

     ```bash
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

     You can check the update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc alb load-balancer list
     ```

- API {#api}

  Use the [delete](../api-ref/LoadBalancer/delete.md) REST API method for the [LoadBalancer](../api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/Delete](../api-ref/grpc/load_balancer_service.md#Delete) gRPC API call.

{% endlist %}