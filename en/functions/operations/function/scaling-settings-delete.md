# Deleting function scaling settings

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ sf-name }}**.
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

   * `--id`: Function ID. To find out the ID, [request](./function-list.md) a list of functions.
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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```
   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify that you have deleted the scaling settings in the [management console]({{ link-console-main }}) or using the [CLI](../../../cli/) command:

   ```
   yc serverless function list-scaling-policies <function_name>|<function_ID>
   ```

- {{ yandex-cloud }} Toolkit

   You can delete function scaling settings using the [{{ yandex-cloud }} Toolkit plugin]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} for the IDE family on the [IntelliJ platform]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

{% include [see-also-scaling](../../../_includes/functions/see-also-scaling.md) %}