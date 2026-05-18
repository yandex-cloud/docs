---
title: Deleting function scaling settings
description: Follow this guide to delete function scaling settings.
---

# Deleting function scaling settings

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder containing the function.
    1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select the function.
    1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-history }}**, hover over the tag of the function version (e.g., ![image](../../../_assets/console-icons/gear.svg) `$latest`) you want to delete scaling settings for.
    1. In the pop-up window, click **{{ ui-key.yacloud.serverless-functions.item.overview.button_edit-scale-settings }}**.
    1. To delete a scaling setting, set it to zero.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    To remove scaling settings, run this command:

    ```
    yc serverless function remove-scaling-policy \
      --id=<function_ID> \
      --tag=\$latest
    ```

    Where:

    * `--id`: Function ID. To find out the ID, [get](./function-list.md) the list of functions.
    * `--tag`: Function version [tag](../../concepts/function.md#tag).

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}  

    To delete scaling settings:

    1. In the configuration file, describe the resources you want to create:

       * `yandex_function_scaling_policy`: Description of function scaling settings.
         * `function_id`: Function ID.
         * `policy`: Scaling settings:
           * `policy.0.tag`: Function version [tag](../../concepts/function.md#tag).
           * `policy.0.zone_instances_limit`: Number of function instances. Set it to `0`.
           * `policy.0.zone_requests_limit`: Number of calls in progress. Set it to `0`.

        Here is an example of the configuration file structure:

        ```
        resource "yandex_function_scaling_policy" "my_scaling_policy" {
            function_id = "are1samplefu********"
            policy {
                tag                  = "$latest"
                zone_instances_limit = 0
                zone_requests_limit  = 0
            }
        }
        ```
      
        For more information about `yandex_function_scaling_policy` properties, see [this provider guide]({{ tf-provider-resources-link }}/function_scaling_policy).
      
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

    You can check that the scaling settings are deleted using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:
    
    ```
    yc serverless function list-scaling-policies <function_name_or_ID>
    ```

- API {#api}

    To remove scaling settings, use the [removeScalingPolicy](../../functions/api-ref/Function/removeScalingPolicy.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/RemoveScalingPolicy](../../functions/api-ref/grpc/Function/removeScalingPolicy.md) gRPC API call.


{% endlist %}

{% include [see-also-scaling](../../../_includes/functions/see-also-scaling.md) %}