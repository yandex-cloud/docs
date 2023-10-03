# Adding function scaling settings

You can set the following:

{% include [scaling](../../../_includes/functions/scaling.md) %}


{% include [provisioned-instances-price](../../../_includes/functions/provisioned-instances-price.md) %}


You can configure different scaling settings for different function [versions](../../concepts/function.md#version) using [tags](../../concepts/function.md#tag). Scaling settings will be valid for the function version that the specified tag is assigned to. Function versions are scaled independently of each other.

The scaling settings must be within the [quotas](../../concepts/limits.md#functions-quotas).


{% include [provisioned-instances-time](../../../_includes/functions/provisioned-instances-time.md)%}


{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Select a function.
   1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-history }}**, mouse over the version tag of the function (such as, ![image](../../../_assets/settings.svg) `$latest`) you wish to add scaling settings for.
   1. In the pop-up window, click **{{ ui-key.yacloud.common.add }}**.
   1. In the window that opens, specify:
      * **zone_instances_limit**: Number of function instances in an availability zone.
      * **zone_requests_limit**: Number of concurrent function calls in an availability zone.
      * **provisioned_instances_count**: Number of provisioned instances.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

   To add scaling settings for a function, run the command:

   
   ```
   yc serverless function set-scaling-policy \
     --id=d4eokpuol55h******** \
     --tag=\$latest \
     --zone-instances-limit=1 \
     --zone-requests-limit=2 \
     --provisioned-instances-count=3
   ```
  

   Where:

   * `--id`: Function ID. To find out the ID, [request](./function-list.md) a list of functions.
   * `--tag`: Function version [tag](../../concepts/function.md#tag).
   * `--zone-instances-limit`: Number of function instances.
   * `--zone-requests-limit`: Number of calls-in-progress.
   * `--provisioned-instances-count`: Number of provisioned instances.

   Result:

   
   ```
   function_id: d4eokpuol55h********
   tag: $latest
   zone_instances_limit: "1"
   zone_requests_limit: "2"
   provisioned_instances_count: "3"
   ```
  

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To add scaling settings:

   1. In the configuration file, describe the parameters of the resources you want to create:

      * `yandex_function_scaling_policy`: Description of function scaling settings.
         * `function_id`: Function ID.
         * `policy`: Scaling settings:
            * `policy.0.tag`: Function version [tag](../../concepts/function.md#tag).
            * `policy.0.zone_instances_limit`: Number of function instances.
            * `policy.0.zone_requests_limit`: Number of calls in progress.

      Example of the configuration file structure:

      
      ```
      provider "yandex" {
          token     = "<service account OAuth or static key>"
          folder_id = "<folder ID>"
          zone      = "{{ region-id }}-a"
      }

      resource "yandex_function_scaling_policy" "my_scaling_policy" {
          function_id = "are1samplefu********"
          policy {
              tag = "$latest"
              zone_instances_limit = 2
              zone_requests_limit  = 1
          }
      }
      ```


      For more information about the parameters of the `yandex_function_scaling_policy` resource, see the [provider documentation]({{ tf-provider-resources-link }}/yandex_function_scaling_policy).

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

   You can check the scaling settings' deletion using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

   ```
   yc serverless function list-scaling-policies <function_name>|<function_ID>
   ```

- API

   To add function scaling settings, use the [setScalingPolicy](../../functions/api-ref/Function/setScalingPolicy.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/SetScalingPolicy](../../functions/api-ref/grpc/function_service.md#SetScalingPolicy) gRPC API call.


- {{ yandex-cloud }} Toolkit

   You can add scaling settings for a function using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).


{% endlist %}

{% include [see-also-scaling](../../../_includes/functions/see-also-scaling.md) %}