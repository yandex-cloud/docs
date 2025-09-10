---
title: Deleting a function
description: Follow this guide to delete a function.
---

# Deleting a function

{% list tabs group=instructions %}

- Management console {#console}
  
    1. In the [management console]({{ link-console-main }}), select the folder to delete the function from.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. In the function row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.serverless-functions.list.button_action-delete }}**.
    1. In the window that opens, click **{{ ui-key.yacloud.serverless-functions.list.popup-confirm_button_delete }}**.
  
- CLI {#cli}
  
    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    {% include [function-list-note](../../../_includes/functions/function-list-note.md) %}
    
    To delete a function, run the command:
    
    ```
    yc serverless function delete <function_name>
    ```
    Result:
    ```
    done (1s)
    id: b09kk2ujb8js********
    folder_id: aoek49ghmknn********
    created_at: "2019-06-13T13:21:40.022Z"
    name: my-functions
    log_group_id: eolq9ac97486********
    http_invoke_url: https://{{ sf-url }}/b09kk2ujb8js********
    status: DELETING
    ```

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    To delete a function created using {{ TF }}:

    1. Open the {{ TF }} configuration file and delete the fragment with the function description.
       
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

        For more information about `yandex_function` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/function).

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
        
       You will see a detailed list of resources. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will show them.
         
    1. Apply the changes:

       ```
       terraform apply
       ```
    1. Type `yes` and press **Enter** to confirm the changes.
      
    You can check the deletion of the function using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

    ```
    yc serverless function list
    ```

- API {#api}

    To delete a function, use the [delete](../../functions/api-ref/Function/delete.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/Delete](../../functions/api-ref/grpc/Function/delete.md) gRPC API call.


{% endlist %}
