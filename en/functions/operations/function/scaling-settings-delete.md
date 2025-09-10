---
title: Deleting function scaling settings
description: Follow this guide to delete function scaling settings.
---

# Deleting function scaling settings

{% list tabs group=instructions %}

- Management console {#console}

    To delete any scaling setting other than the number of calls processed concurrently by a single function instance (`concurrency`):

    1. In the [management console]({{ link-console-main }}), select the folder containing the function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select a function.
    1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-history }}**, hover over the tag of the function version (e.g., ![image](../../../_assets/console-icons/gear.svg) `$latest`) you want to delete scaling settings for.
    1. In the pop-up window, click **{{ ui-key.yacloud.serverless-functions.item.overview.button_edit-scale-settings }}**.
    1. To delete a scaling setting, set it equal to zero.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    To delete any scaling setting other than the number of calls processed concurrently by a single function instance (`concurrency`), run this command:

    ```
    yc serverless function remove-scaling-policy \
      --id=<function_ID> \
      --tag=\$latest
    ```

    Where:

    * `--id`: Function ID. To find out the ID, [request](./function-list.md) a list of functions.
    * `--tag`: Function version [tag](../../concepts/function.md#tag).

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    To delete any scaling setting other than the number of calls processed concurrently by a single function instance (`concurrency`):

    1. In the configuration file, describe the parameters of resources you want to create:

       * `yandex_function_scaling_policy`: Description of function scaling settings.
         * `function_id`: Function ID.
         * `policy`: Scaling settings:
           * `policy.0.tag`: Function version [tag](../../concepts/function.md#tag).
           * `policy.0.zone_instances_limit`: Number of function instances. Set the `0` value.
           * `policy.0.zone_requests_limit`: Number of calls in progress. Set the `0` value.

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
      
        For more information about `yandex_function_scaling_policy` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/function_scaling_policy).
      
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

    You can check the deletion of the scaling settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:
    
    ```
    yc serverless function list-scaling-policies <function_name_or_ID>
    ```

- API {#api}

    To delete any function scaling setting other than the number of calls processed concurrently by a single function instance (`concurrency`), use the [removeScalingPolicy](../../functions/api-ref/Function/removeScalingPolicy.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/RemoveScalingPolicy](../../functions/api-ref/grpc/Function/removeScalingPolicy.md) gRPC API call.


{% endlist %}

To delete the [number of calls processed concurrently by a single function instance](../../concepts/function.md#concurrency) (`concurrency`), [create a function version](../../operations/function/version-manage.md#version-create) without specifying this parameter.

{% include [see-also-scaling](../../../_includes/functions/see-also-scaling.md) %}