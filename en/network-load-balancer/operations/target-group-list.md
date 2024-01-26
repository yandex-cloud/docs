# Information about existing target groups

You can request detailed information about each target group you created.

## Getting a list of target groups in a folder {#list}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
   1. In the left-hand panel, select ![trgroups.svg](../../_assets/trgroups.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of target groups in the default folder, run this command:

   ```bash
   yc load-balancer target-group list
   ```

   Result:

   
   ```text
   +----------------------+-------------+---------------------+-------------+--------------+
   |          ID          |    NAME     |       CREATED       |  REGION ID  | TARGET COUNT |
   +----------------------+-------------+---------------------+-------------+--------------+
   | enp1d7t5pdea******** | test-group1 | 2023-02-03 07:17:56 | {{ region-id }} |            1 |
   | ...                  |             |                     |             |              |
   +----------------------+-------------+---------------------+-------------+--------------+
   ```



- API {#api}

   Use the [list](../api-ref/TargetGroup/list.md) API method and provide the folder ID in the `folderId` request parameter.

{% endlist %}

## Getting detailed information about a target group {#get}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
   1. In the left-hand panel, select ![trgroups.svg](../../_assets/trgroups.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.
   1. Click the name of the target group you need.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a target group, run this command:

   ```bash
   yc load-balancer target-group get <target_group_name_or_ID>
   ```

   You can get the target group ID and name with a [list of target groups in the folder](#list).

- API {#api}

   Use the [get](../api-ref/TargetGroup/get.md) API method and provide the target group ID in the `targetGroupId` request parameter.

   You can get the target group ID with a [list of target groups in the folder](#list).

{% endlist %}

## Viewing a list of operations in a target group {#list-operations}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
   1. In the left-hand panel, select ![trgroups.svg](../../_assets/trgroups.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.
   1. Click the name of the target group and go to ![operations.svg](../../_assets/mdb/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of operations, run the following command:

   ```bash
   yc load-balancer target-group list-operations <target_group_name_or_ID>
   ```

   You can get the target group ID and name with a [list of target groups in the folder](#list).

- API {#api}

   Use the [listOperations](../api-ref/TargetGroup/listOperations.md) API method and provide the target group ID in the `networkLoadBalancerId` request parameter.

   You can get the target group ID with a [list of target groups in the folder](#list).

{% endlist %}
