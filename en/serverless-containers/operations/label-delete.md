---
title: Deleting a container label
description: Follow this guide to delete a container label.
---

# Deleting a container label

{% list tabs group=instructions %}

- CLI {#cli}
    
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
    url: https://flh7r96juaqq********.{{ serverless-containers-host }}/
    status: ACTIVE
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete a label of a container created with {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the label from the `labels` section in the `yandex_serverless_container` resource:
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

	 For more information about the `yandex_serverless_container` properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/serverless_container).

  1. Validate your configuration using this command:
     ```
     terraform validate
     ```
     
     If the configuration is valid, you will get this message:
     
     ```
     Success! The configuration is valid.
     ```

  1. Run this command:
     ```
     terraform plan
     ```
  
     You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors in the configuration.

  1. Apply the configuration changes:
     ```
     terraform apply
     ```
     
  1. Type `yes` and press **Enter** to confirm the changes.

  You can verify that the container label has been deleted using the [CLI](../../cli/):

  ```
  yc serverless container get <container_name_or_ID>
  ```

- API {#api}

  To delete a container label, use the [update](../containers/api-ref/Container/update.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/Update](../containers/api-ref/grpc/Container/update.md) gRPC API call.

{% endlist %}