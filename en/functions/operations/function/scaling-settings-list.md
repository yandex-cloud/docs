# Viewing function scaling settings

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ sf-name }}**.
   1. Select a function.
   1. Under **Version history**, mouse over the version tag of the function (such as, ![image](../../../_assets/settings.svg) `$latest`) whose scaling settings you wish to view.
   1. Information on these scaling settings will be displayed in a pop-up window:
      * **zone_instances_limit**: Number of function instances in an availability zone.
      * **zone_requests_limit**: Number of concurrent function calls in an availability zone.
      * **provisioned_instances_count**: Number of provisioned instances.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To view a function's scaling settings, run the command:

   ```
   yc serverless function list-scaling-policies --id=d4eokpuol55h********
   ```

   Where `--id`: Function ID. To find out the ID, [request](./function-list.md) a list of functions.

   Result:

   ```
   +----------------------+---------+----------------------+---------------------+-----------------------------+
   |     FUNCTION ID      |   TAG   | ZONE INSTANCES LIMIT | ZONE REQUESTS LIMIT | PROVISIONED INSTANCES COUNT |
   +----------------------+---------+----------------------+---------------------+-----------------------------+
   | d4eokpuol55h******** | $latest |                    1 |                   2 |                           3 |
   +----------------------+---------+----------------------+---------------------+-----------------------------+
   ```

- API

   You can view a function's scaling settings using the [listScalingPolicies](../../functions/api-ref/Function/listScalingPolicies.md).

- {{ yandex-cloud }} Toolkit

   You can view function scaling settings using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

{% include [see-also-scaling](../../../_includes/functions/see-also-scaling.md) %}