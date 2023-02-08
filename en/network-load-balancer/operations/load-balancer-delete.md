# Delete a network load balancer

{% list tabs %}

- Management console

   To delete a network [load balancer](../concepts/index.md):
   1. In the [management console]({{ link-console-main }}), select the folder to delete a load balancer from.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. In the line of the load balancer to delete, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   If you don't have the {{ yandex-cloud }} command line interface, [install it](../../cli/quickstart.md#install).

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's delete network load balancer command:

      ```bash
      yc load-balancer network-load-balancer delete --help
      ```

   1. Get a list of all load balancers:

      ```bash
      yc load-balancer network-load-balancer list
      ```

      Result:

      ```text
      +----------------------+--------------------+-------+
      |          ID          | NAME               |  ...  |
      +----------------------+------+-------------+-------+
      ...
      | b7r97ah2jn5rmo6k1dsk | test-load-balancer |  ...  |
      ...
      +----------------------+------+-------------+-------+
      ```

   1. Select the identifier (`ID`) or name (`NAME`) of the load balancer you need.
   1. Delete the load balancer:

      ```bash
      yc load-balancer network-load-balancer delete b7r97ah2jn5rmo6k1dsk
      ```

- API

   You can delete load balancers using the [delete](../api-ref/NetworkLoadBalancer/delete.md) API method.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a network load balancer created with {{ TF }}:
   1. Open the {{ TF }} configuration file and delete the fragment with the network load balancer description.

      {% cut "Sample network load balancer description in the {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_lb_network_load_balancer" "foo" {
        name = "my-network-load-balancer"
        listener {
          name = "my-listener"
      	 port = 9000
          external_address_spec {
            ip_version = "ipv4"
          }
        }
        attached_target_group {
          target_group_id = "${yandex_lb_target_group.my-target-group.id}"
          healthcheck {
            name = "http"
              http_options {
                port = 9000
                path = "/ping"
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

      ```text
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```bash
      yc load-balancer network-load-balancer list
      ```

{% endlist %}

## Examples {examples}

### Deleting a network load balancer from a specific folder {from-folder}

{% list tabs %}

- CLI

   To delete a network load balancer from another folder, use the `--folder-id` or `--folder-name` flags.

   ```bash
   yc load-balancer network-load-balancer delete test-load-balancer --folder-id b1gnbfd11bq5g5vnjgr4
   ```

   ```bash
   yc load-balancer network-load-balancer delete test-load-balancer --folder-name test-folder
   ```

{% endlist %}