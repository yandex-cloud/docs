# Information about existing target groups

You can request detailed information about each target group you created.

## Getting a list of target groups in a folder {#list}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ network-load-balancer-name }}**.
   1. On the left-hand panel, select ![trgroups.svg](../../_assets/trgroups.svg) **Target groups**.

- CLI

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
   | enp1d7t5pdeaan2rk8c9 | test-group1 | 2023-02-03 07:17:56 | {{ region-id }} |            1 |
   | ...                  |             |                     |             |              |
   +----------------------+-------------+---------------------+-------------+--------------+
   ```



- API

   Use the [list](../api-ref/TargetGroup/list.md) API method and provide the folder ID in the `folderId` request parameter.

{% endlist %}

## Getting detailed information about a target group {#get}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ network-load-balancer-name }}**.
   1. On the left-hand panel, select ![trgroups.svg](../../_assets/trgroups.svg) **Target groups**.
   1. Click the name of the target group you need.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a target group, run this command:

   ```bash
   yc load-balancer target-group get <target group ID or name>
   ```

   You can get the target group ID and name with a [list of target groups in the folder](#list).

- API

   Use the [get](../api-ref/TargetGroup/get.md) API method and provide the target group ID in the `targetGroupId` request parameter.

   You can get the target group ID with a [list of target groups in the folder](#list).

{% endlist %}

## Viewing a list of operations in a target group {#list-operations}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ network-load-balancer-name }}**.
   1. On the left-hand panel, select ![trgroups.svg](../../_assets/trgroups.svg) **Target groups**.
   1. Click the name of the target group and go to ![operations.svg](../../_assets/mdb/operations.svg) **Operations**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of operations, run the following command:

   ```bash
   yc load-balancer target-group list-operations <target group ID or name>
   ```

   You can get the target group ID and name with a [list of target groups in the folder](#list).

- API

   Use the [listOperations](../api-ref/TargetGroup/listOperations.md) API method and provide the target group ID in the `networkLoadBalancerId` request parameter.

   You can get the target group ID with a [list of target groups in the folder](#list).

{% endlist %}
