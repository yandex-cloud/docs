---
title: Updating a function label
description: Follow this guide to update a function label.
---

# Updating a function label

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    To update a function label, run this command:
  
    {% include [labels-rewrite-warning](../../../_includes/labels-rewrite-warning.md) %}

    ```
    yc serverless function update <function_name> --labels <key>=<value>
    ```

    Result:

    ```
    id: b097d9ous3ge********
    folder_id: aoek49ghmknn********
    created_at: "2019-06-06T11:36:48.688Z"
    name: my-beta-function
    description: My beta function.
    labels:
      new_labels: my-beta-function
    log_group_id: eolv6578frac********
    http_invoke_url: https://{{ sf-url }}/b097d9ous3ge********
    ```

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    To update a function label:

    1. Open the {{ TF }} configuration file and edit the `labels` section.

        Example of a function description in the {{ TF }} configuration:
      
        ```
        resource "yandex_function" "test-function" {
            name               = "test-function"
            description        = "Test function"
            user_hash          = "first-function"
            runtime            = "python37"
            entrypoint         = "main"
            memory             = "128"
            execution_timeout  = "10"
            service_account_id = "<service_account_ID>"
            tags               = ["my_tag"]
            labels = {
              <key_1>:"<value_1>",
              <key_2>:"<value_2>"
            }
            content {
                zip_filename = "<path_to_ZIP_archive>"
            }
        }
        ``` 

        For more information about `yandex_function` resource properties, see [this provider guide]({{ tf-provider-resources-link }}/function).

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
      
    You can check the update of the function labels using this [CLI](../../../cli/quickstart.md) command:

    ```
    yc serverless function get <function_name_or_ID>
    ```

- API {#api}

    To update a function label, use the [update](../../functions/api-ref/Function/update.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/Update](../../functions/api-ref/grpc/Function/update.md) gRPC API call.

{% endlist %}