---
title: Updating a container label
description: Follow this guide to update a container label.
---

# Updating a container label

{% list tabs group=instructions %}

- CLI {#cli}

   To update a container label, run this command:

   {% note warning %}

   The existing set of `labels` is completely overwritten by the one transmitted in the request.

   {% endnote %}

   ```
   yc serverless container update <container_name> --labels <key>=<value>
   ```

   Result:

   ```
   id: flh7r96juaqq********
   folder_id: aoek6qrs8tjh********
   created_at: "2021-08-17T07:53:10.219Z"
   name: my-beta-container
   description: my beta container description
   labels:
     new_label: new_test
   url: https://flh7r96juaqq********.{{ serverless-containers-host }}/
   status: ACTIVE
   ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To modify the label of a container created with {{ TF }}:

   1. Open the {{ TF }} configuration file, and under the `yandex_serverless_container` resource, edit the `labels` section:

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

   You can verify that you have modified a container label using the [CLI](../../cli/):

   ```
   yc serverless container get <container_name_or_ID>
   ```

- API {#api}

   To update a container label, use the [update](../containers/api-ref/Container/update.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/Update](../containers/api-ref/grpc/Container/update.md) gRPC API call.

{% endlist %}
