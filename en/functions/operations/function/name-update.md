---
title: Updating a function name
description: Follow this guide to update a function name.
---

# Updating a function name

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder where you want to update a [function](../../concepts/function.md) name.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select the function.
    1. In the top-right corner, click **{{ ui-key.yacloud.serverless-functions.list.button_action-edit }}**.
    1. In the window that opens, enter a new function name.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}
  
    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    To update a function name, run this command:

    ```
    yc serverless function update <function_name> --new-name <new_function_name>
    ```

    Result:
    ```    
    id: b097d9ous3ge********
    folder_id: aoek49ghmknn********
    created_at: "2019-06-06T11:36:48.688Z"
    name: my-beta-function
    labels:
     test: test
    log_group_id: eolv6578frac********
    http_invoke_url: https://{{ sf-url }}/b097d9ous3ge********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    To update a function name:

    1. Open the {{ TF }} configuration file and edit the `name` field in the function description.

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
            content {
                zip_filename = "<path_to_ZIP_archive>"
            }
        }
        ```

        For more information about `yandex_function` properties, see [this provider guide]({{ tf-provider-resources-link }}/function).

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
      
    You can check the function name update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

    ```
    yc serverless function list
    ```

- API {#api}

    To update a function name, use the [update](../../functions/api-ref/Function/update.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/Update](../../functions/api-ref/grpc/Function/update.md) gRPC API call.


{% endlist %}
