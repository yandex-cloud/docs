---
title: "Updating a container name"
description: "Follow this guide to update a container name."
---

# Updating a container name

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
   1. Select the container.
   1. Click **{{ ui-key.yacloud.common.edit }}**.
   1. Rename the container. The name format is as follows:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   {% include [note](../../_includes/serverless-containers/sc-list-note.md) %}

   To rename the container, run this command:

   ```
   yc serverless container \
     --name <container_name> \
     --new-name <new_container_name>
   ```

   Result:

   ```
   id: flh7r96juaqq********
   folder_id: aoek6qrs8tjh********
   created_at: "2021-08-17T07:53:10.219Z"
   name: my-beta-container
   description: my beta container description
   url: https://flh7r96juaqq********.{{ serverless-containers-host }}/
   status: ACTIVE
   ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To update the name of a container created using {{ TF }}:

   1. Open the {{ TF }} configuration file and edit the `name` field value in the `yandex_serverless_container` resource description:

      ```hcl
      ...
      resource "yandex_serverless_container" "test-container" {
        name               = "my-conrainer"
        description        = "my first container with description"
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

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can check the container update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

   ```
   yc serverless container get <container_ID>|<container_name>
   ```

- API

   To rename a container, use the [update](../containers/api-ref/Container/update.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/Update](../containers/api-ref/grpc/container_service.md#Update) gRPC API call.

{% endlist %}
