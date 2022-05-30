# Deleting a container

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Open **{{ serverless-containers-name }}**.
   1. In the line with the container, click ![image](../../_assets/horizontal-ellipsis.svg).
   1. In the resulting menu, click **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   To delete a container, run the command:

   ```
   yc serverless container delete --name <container_name>
   ```

   Result:

   ```
   done (2s)
   ```
- Terraform

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about Terraform, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a container created with Terraform:

   1. Open the Terraform configuration file and delete the section with the container description.

      Example container description in the Terraform configuration:

      ```hcl
      ...
      resource "yandex_serverless_container" "test-container" {
        name               = "my-container"
        memory             = 256
        service_account_id = "ajec........34ova"
        image {
            url = "cr.yandex/yc/test-image:v1"
        }
      }
      ...
      ```

      For more information about the `yandex_serverless_container` resource in Terraform, see the [provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/serverless_container).

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, Terraform points them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify that you have deleted the container in the [management console]({{ link-console-main }}) or with the following [CLI](../../cli/) command:

   ```
   yc serverless container list
   ```

{% endlist %}