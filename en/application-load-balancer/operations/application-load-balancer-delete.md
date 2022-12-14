# Delete an L7 load balancer

To delete an L7 load balancer:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the load balancer was created.
   1. Select **{{ alb-name }}**.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) next to the load balancer name and select **Delete**.

      To do this with multiple load balancers, select the load balancers to delete from the list and click **Delete** at the bottom of the screen.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for removing a load balancer:

      ```bash
      yc alb load-balancer delete --help
      ```

   1. Run the command:

      ```bash
      yc alb load-balancer delete <ID or name of the load balancer>
      ```

      Result:

      ```bash
      done (1m10s)
      ```

- {{ TF }}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete an L7 load balancer created with {{ TF }}:
   1. Open the {{ TF }} configuration file and delete the fragment with the L7 load balancer description.

      {% cut "Sample L7 load balancer description in the {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_alb_load_balancer" "test-balancer" {
        name        = "my-load-balancer"
        network_id  = yandex_vpc_network.test-network.id

        allocation_policy {
          location {
            zone_id   = "{{ region-id }}-a"
            subnet_id = yandex_vpc_subnet.test-subnet.id
          }
        }

        listener {
          name = "my-listener"
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
   1. Check the configuration using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contain errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```bash
      yc alb load-balancer list
      ```

{% endlist %}