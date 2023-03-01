# Updating the description of a container

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ serverless-containers-name }}**.
   1. Select the container.
   1. Click **Edit**.
   1. Edit the container description.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   {% include [note](../../_includes/serverless-containers/sc-list-note.md) %}

   To edit the container description, run this command:

   ```
   yc serverless container \
     --name <container_name> \
     --description <new_container_description>
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

   You can update the container description using the [update](../containers/api-ref/Container/update.md) API method.


- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To update the description of a container created using {{ TF }}:

   1. Open the {{ TF }} configuration file and edit the `description` field value in the `yandex_serverless_container` resource description:

      ```hcl
      ...
      resource "yandex_serverless_container" "test-container" {
        name               = "my-conrainer"
        description        = "my first container with description"
        memory             = 256
        service_account_id = "ajec........34ova"
        image {
            url = "cr.yandex/yc/test-image:v1"
        }
      }
      ...
      ```

   For more information about the `yandex_serverless_container` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/serverless_container).

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify the change to the container using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/) command:

   ```
   yc serverless container get <container_ID>|<container_name>
   ```

{% endlist %}
