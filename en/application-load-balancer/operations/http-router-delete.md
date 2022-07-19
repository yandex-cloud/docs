# Delete an HTTP router

To delete an HTTP router:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the HTTP router was created.
   1. Select **{{ alb-name }}**.
   1. Select the router and click ![image](../../_assets/horizontal-ellipsis.svg).
   1. In the menu that opens, select **Delete**.

      To do this with multiple HTTP routers, select the routers to delete from the list and click **Delete** at the bottom of the screen.

   1. Confirm the deletion.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for deleting an HTTP router:
      ```
      yc alb http-router delete --help
      ```

   1. Run the command, specifying the name of the HTTP router:
      ```
      yc alb http-router delete --name <HTTP router name>
      ```

      To check the deletion, get a list of HTTP routers by running the command:
      ```
      yc alb http-router list
      ```

- {{ TF }}

   For more information about {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```
      yc alb http-router list
      ```

{% endlist %}
