---
title: "Deleting a network load balancer"
description: "Follow this guide to delete a network load balancer."
---

# Deleting a network load balancer

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to delete a load balancer from.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
   1. In the line of the load balancer to delete, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's delete network load balancer command:

      ```bash
      yc load-balancer network-load-balancer delete --help
      ```

   1. Delete the load balancer:

      ```bash
      yc load-balancer network-load-balancer delete <load_balancer_name_or_ID>
      ```

      You can get the load balancer ID and name with a [list of network load balancers in the folder](load-balancer-list.md#list).

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To delete a network load balancer created with {{ TF }}:
   1. Open the {{ TF }} configuration file and delete the fragment with the network load balancer description.

      ```hcl
      ...
      resource "yandex_lb_network_load_balancer" "foo" {
        name = "<load_balancer_name>"
        listener {
          name = "<listener_name>"
          port = <port_number>
          external_address_spec {
            ip_version = "<IP_version>"
          }
        }
        attached_target_group {
          target_group_id = "<target_group_ID>"
          healthcheck {
            name = "<health_check_name>"
              http_options {
                port = <port_number>
                path = "<URL>"
              }
          }
        }
      }
      ...
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Delete the network load balancer.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   To delete a network load balancer, use the [delete](../api-ref/NetworkLoadBalancer/delete.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/Delete](../api-ref/grpc/network_load_balancer_service.md#Delete) gRPC API call.

{% endlist %}

## Examples {examples}

### Deleting a network load balancer from a specific folder {from-folder}

{% list tabs group=instructions %}

- CLI {#cli}

   To delete a network load balancer from another folder, use the `--folder-id` or `--folder-name` parameters:

   ```bash
   yc load-balancer network-load-balancer delete test-load-balancer \
      --folder-id=b1gnbfd11bq5********
   ```

   ```bash
   yc load-balancer network-load-balancer delete test-load-balancer \
      --folder-name=test-folder
   ```

{% endlist %}
