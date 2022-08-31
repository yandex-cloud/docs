# Scaling a function

Incoming requests are processed by the function one at a time. If the function is called faster than one instance can process the request, {{ sf-name }} scales the function by running additional function instances. You can set the following:

* `zone_instances_limit`: Number of function instances in an [availability zone](../../../overview/concepts/geo-scope.md).
* `zone_requests_limit`: Number of concurrent function calls in an availability zone.

{% note info %}

Function calls are distributed across availability zones randomly. Cloud Functions does not guarantee their even distribution across zones. For example, all calls, regardless of their number, might end up in the same zone.

{% endnote %}

When the number of function instances reaches the `zone_instances_limit`, {{ sf-name }} stops scaling it. If there are more function calls than instances available, the call is queued and treated as a call-in-progress. When the number of calls-in-progress reaches the `zone_requests_limit`, the service stops queuing calls and returns the `429 TooManyRequests` error.

You can configure different scaling settings for different function [versions](../../concepts/function.md#version) using [tags](../../concepts/function.md#tag). Scaling settings will be valid for the function version that the specified tag is assigned to. Function versions are scaled independently of each other.

The scaling settings must be within the [quotas](../../concepts/limits.md#functions-quotas). If the setting value is zero, the function is scaled within the quotas.

## Viewing scaling settings {#list}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Open **{{ sf-name }}**.
   1. Select a function.
   1. Under **Version history**, mouse over the version tag of the function (such as, ![image](../../../_assets/settings.svg) `$latest`) whose scaling settings you wish to view.
   1. Information on these scaling settings will be displayed in a pop-up window:
      * **zone_instances_limit**: Number of function instances in an availability zone.
      * **zone_requests_limit**: Number of concurrent function calls in an availability zone.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To view a function's scaling settings, run the command:

   ```
   yc serverless function list-scaling-policies --id=d4eokpuol55h********
   ```

   Where `--id`: Function ID. To find out the ID, [request](./version-manage.md#function-list) a list of functions.

   Result:

   ```
   +----------------------+---------+----------------------+---------------------+
   |     FUNCTION ID      |   TAG   | ZONE INSTANCES LIMIT | ZONE REQUESTS LIMIT |
   +----------------------+---------+----------------------+---------------------+
   | d4eokpuol55hmj15k7g1 | $latest |                    1 |                   2 |
   +----------------------+---------+----------------------+---------------------+
   ```

- API

   You can view a function's scaling settings using the [listScalingPolicies](../../functions/api-ref/Function/listScalingPolicies.md).

- Yandex Cloud Toolkit

   You can view function scaling settings using the [Yandex Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Adding scaling settings {#add}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Open **{{ sf-name }}**.
   1. Select a function.
   1. Under **Version history**, mouse over the version tag of the function (such as, ![image](../../../_assets/settings.svg) `$latest`) you wish to add scaling settings for.
   1. In the pop-up window, click **Add**.
   1. In the window that opens, specify:
      * **zone_instances_limit**: Number of function instances in an availability zone.
      * **zone_requests_limit**: Number of concurrent function calls in an availability zone.
   1. Click **Save**.

- CLI

   To add scaling settings for a function, run the command:

   ```
   yc serverless function set-scaling-policy \
     --id=d4eokpuol55h******** \
     --tag=\$latest \
     --zone-instances-limit=1 \
     --zone-requests-limit=2
   ```

   Where:

   * `--id`: Function ID. To find out the ID, [request](./version-manage.md#function-list) a list of functions.
   * `--tag`: Function version [tag](../../concepts/function.md#tag).
   * `--zone-instances-limit`: Number of function instances.
   * `--zone-requests-limit`: Number of calls-in-progress.

   Result:

   ```
   function_id: d4eokpuol55h********
   tag: $latest
   zone_instances_limit: "1"
   zone_requests_limit: "2"
   ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To add scaling settings:

   1. In the configuration file, describe the parameters of resources that you want to create:

      * `yandex_function_scaling_policy`: Description of function scaling settings.
         * `function_id`: Function ID.
         * `policy`: Scaling settings:
            * `policy.0.tag`: Function version [tag](../../concepts/function.md#tag).
            * `policy.0.zone_instances_limit`: Number of function instances.
            * `policy.0.zone_requests_limit`: Number of calls in progress.

      Example configuration file structure:

      

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




      For more information about the parameters of the `yandex_function_scaling_policy` resource, see the [provider documentation]({{ tf-provider-link }}/yandex_function_scaling_policy).

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contain errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```
   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify that you have deleted the scaling settings in the [management console]({{ link-console-main }}) or using the [CLI](../../../cli/quickstart.md) command:

   ```
   yc serverless function list-scaling-policies <function_name>|<function_ID>
   ```

- API

   You can add scaling settings for a function using the [setScalingPolicy](../../functions/api-ref/Function/setScalingPolicy.md).

- Yandex Cloud Toolkit

   You can add function scaling settings using the [Yandex Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Deleting scaling settings {#delete}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Open **{{ sf-name }}**.
   1. Select a function.
   1. Under **Version history**, mouse over the version tag of the function (such as, ![image](../../../_assets/settings.svg) `$latest`) which you wish to delete scaling settings for.
   1. In the pop-up window, click **Change**.
   1. To delete a scaling setting, set it equal to zero.
   1. Click **Save**.

- CLI

   To delete a function's scaling settings, run the command:

   ```
   yc serverless function remove-scaling-policy \
     --id=d4eokpuol55h******** \
     --tag=\$latest
   ```

   Where:

   * `--id`: Function ID. To find out the ID, [request](./version-manage.md#function-list) a list of functions.
   * `--tag`: Function version [tag](../../concepts/function.md#tag).

- API

   You can delete scaling settings for a function using the [removeScalingPolicy](../../functions/api-ref/Function/removeScalingPolicy.md).

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete scaling settings:

   1. In the configuration file, describe the parameters of resources that you want to create:

      * `yandex_function_scaling_policy`: Description of function scaling settings.
         * `function_id`: Function ID.
         * `policy`: Scaling settings:
            * `policy.0.tag`: Function version [tag](../../concepts/function.md#tag).
            * `policy.0.zone_instances_limit`: Number of function instances. Set the `0` value.
            * `policy.0.zone_requests_limit`: Number of calls in progress. Set the `0` value.

      Example configuration file structure:

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

      For more information about the parameters of the `yandex_function_scaling_policy` resource, see the [provider documentation]({{ tf-provider-link }}/yandex_function_scaling_policy).

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contain errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```
   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify that you have deleted the scaling settings in the [management console]({{ link-console-main }}) or using the [CLI](../../../cli/) command:

   ```
   yc serverless function list-scaling-policies <function_name>|<function_ID>
   ```

- Yandex Cloud Toolkit

   You can delete function scaling settings using the [Yandex Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}
