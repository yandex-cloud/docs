# Delete a network load balancer

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to delete a load balancer from.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. In the line of the load balancer to delete, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's delete network load balancer command:

      ```bash
      yc load-balancer network-load-balancer delete --help
      ```

   1. Delete the load balancer:

      ```bash
      yc load-balancer network-load-balancer delete <load balancer ID or name>
      ```

      You can get the load balancer ID and name with a [list of network load balancers in the folder](load-balancer-list.md#list).

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a network load balancer created with {{ TF }}:
   1. Open the {{ TF }} configuration file and delete the fragment with the network load balancer description.

      ```hcl
      ...
      resource "yandex_lb_network_load_balancer" "foo" {
        name = "<network load balancer name>"
        listener {
          name = "<listener name>"
          port = <port number>
          external_address_spec {
            ip_version = "<IP address version: ipv4 or ipv6>"
          }
        }
        attached_target_group {
          target_group_id = "<target group ID>"
          healthcheck {
            name = "<health check name>"
              http_options {
                port = <port number>
                path = "<URL for health checks>"
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

- API

   Use the [delete](../api-ref/NetworkLoadBalancer/delete.md) API method and provide the load balancer ID in the `networkLoadBalancerId` request parameter.

   You can get the load balancer ID with a [list of network load balancers in the folder](load-balancer-list.md#list).

{% endlist %}

## Examples {examples}

### Deleting a network load balancer from a specific folder {from-folder}

{% list tabs %}

- CLI

   To delete a network load balancer from another folder, use the `--folder-id` or `--folder-name` parameters:

   ```bash
   yc load-balancer network-load-balancer delete test-load-balancer \
      --folder-id=b1gnbfd11bq5g5vnjgr4
   ```

   ```bash
   yc load-balancer network-load-balancer delete test-load-balancer \
      --folder-name=test-folder
   ```

{% endlist %}
