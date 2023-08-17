# Deleting a container

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ serverless-containers-name }}**.
   1. In the line with the container, click ![image](../../_assets/horizontal-ellipsis.svg).
   1. In the menu that opens, click **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   To delete a container, run this command:

   ```
   yc serverless container delete --name <container_name>
   ```

   Result:

   ```
   done (2s)
   ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a container created with {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the section with the container description.

      Example container description in the {{ TF }} configuration:

      ```hcl
      ...
      resource "yandex_serverless_container" "test-container" {
        name               = "my-container"
        memory             = 256
        service_account_id = "ajec........34ova"
        image {
            url = "{{ registry }}/yc/test-image:v1"
        }
      }
      ...
      ```

      For more information about the `yandex_serverless_container` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/serverless_container).

   1. Check the configuration using this command:
      ```
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify that you have deleted the container in the [management console]({{ link-console-main }}) or with the following [CLI](../../cli/) command:

   ```
   yc serverless container list
   ```

- API

   To delete a container, use the [delete](../containers/api-ref/Container/delete.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/Delete](../containers/api-ref/grpc/container_service.md#Delete) gRPC API call.

{% endlist %}