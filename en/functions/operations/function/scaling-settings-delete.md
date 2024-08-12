---
title: "Deleting function scaling settings"
description: "Follow this guide to delete function scaling settings."
---

# Deleting function scaling settings

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Select a function.
   1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-history }}**, hover over the tag (e.g., ![image](../../../_assets/console-icons/gear.svg) `$latest`) of the function version you want to delete scaling settings for.
   1. In the pop-up window, click **{{ ui-key.yacloud.serverless-functions.item.overview.button_edit-tag }}**.
   1. To delete a scaling setting, set it equal to zero.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   To delete a function's scaling settings, run the command:

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

   To delete scaling settings:

   1. In the configuration file, describe the parameters of the resources you want to create:

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

      For more information about parameters of the `yandex_function_scaling_policy` resource, see the [provider documentation]({{ tf-provider-resources-link }}/function_scaling_policy).

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

   You can check the deletion of the scaling settings using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

   ```
   yc serverless function list-scaling-policies <function_name_or_ID>
   ```

- API {#api}

   To remove function scaling settings, use the [removeScalingPolicy](../../functions/api-ref/Function/removeScalingPolicy.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/RemoveScalingPolicy](../../functions/api-ref/grpc/function_service.md#RemoveScalingPolicy) gRPC API call.


- {{ yandex-cloud }} Toolkit {#yc-toolkit}

   You can delete scaling settings of a function using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).


{% endlist %}

{% include [see-also-scaling](../../../_includes/functions/see-also-scaling.md) %}