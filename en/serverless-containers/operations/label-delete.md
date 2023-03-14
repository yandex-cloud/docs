# Deleting a container label

{% list tabs %}

- CLI

   To delete a container label, run this command:

   ```
   yc serverless container remove-labels <container_name> --labels <key>
   ```

   Result:

   ```
   id: flh7r96juaqq********
   folder_id: aoek6qrs8tjh********
   created_at: "2021-08-17T07:53:10.219Z"
   name: my-beta-container
   description: my beta container description
   url: https://flh7r96juaqq********.containers.cloud-preprod.yandex.net/
   status: ACTIVE
   ```

- API

   You can delete a container label using the [update](../containers/api-ref/Container/update.md) API method.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete the label of a container created using {{ TF }}:

   1. Open the {{ TF }} configuration file and, under the `yandex_serverless_container` resource, delete the label in the `labels` section:
      ```hcl
      ...
      resource "yandex_serverless_container" "test-container" {
        name   = "my first container with description"
        memory = 256
        image {
           url = "{{ registry }}/yc/test-image:v1"
        }
        labels = {
           label1 = "new-label"
        }
      }
      ...
      ```

      For more information about the `yandex_serverless_container` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/serverless_container).

   1. Check the configuration using this command:
      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

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

   You can verify that you have deleted a container label using the [CLI](../../cli/):

   ```
   yc serverless container get <container_ID>|<container_name>
   ```

{% endlist %}