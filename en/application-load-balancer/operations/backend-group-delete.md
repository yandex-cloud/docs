# Delete a backend group

To delete a backend group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the backend group was created.
   1. Select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/backgrs.svg) **Backend groups**.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) next to the backend group name and select **Delete**.

      To do this with multiple groups, select the groups to delete from the list and click **Delete** at the bottom of the screen.

   1. Confirm the deletion.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for deleting a backend group:
      ```
      yc alb backend-group delete --help
      ```

   1. Run the command, specifying the name of the backend group you want to delete:
      ```
      yc alb backend-group delete --name <backend group name>
      ```

      To check the deletion, get a list of backend groups by running the command:
      ```
      yc alb backend-group list
      ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Open the {{ TF }} configuration file and delete the fragment with the backend group description.

      Sample backend group description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_alb_backend_group" "test-backend-group" {
        name                     = "<backend group name>"
      
        http_backend {
          name                   = "<backend name>"
          weight                 = 1
          port                   = 80
          target_group_ids       = ["<target group ID>"]
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

{% endlist %}
