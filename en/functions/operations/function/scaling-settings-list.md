---
title: "Viewing function scaling settings"
description: "Follow this guide to view function scaling settings."
---

# Viewing function scaling settings

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing your function.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Select a function.
   1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-history }}**, hover over the tag (e.g., ![image](../../../_assets/console-icons/gear.svg) `$latest`) of the function version whose scaling settings you want to view.
   1. Information on these scaling settings will be displayed in a pop-up window:
      * **zone_instances_limit**: Number of function instances in an availability zone.
      * **zone_requests_limit**: Number of concurrent function calls in an availability zone.
      * **provisioned_instances_count**: Number of provisioned instances.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To view the function scaling settings, run this command:

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


- API {#api}

   To view function scaling settings, use the [listScalingPolicies](../../functions/api-ref/Function/listScalingPolicies.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/ListScalingPolicies](../../functions/api-ref/grpc/function_service.md#ListScalingPolicies) gRPC API call.


- {{ yandex-cloud }} Toolkit {#yc-toolkit}

   You can view scaling settings of a function using the [{{ yandex-cloud }} Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the IDE family on the [JetBrains](https://www.jetbrains.com/) [IntelliJ platform](https://www.jetbrains.com/opensource/idea/).


{% endlist %}

{% include [see-also-scaling](../../../_includes/functions/see-also-scaling.md) %}