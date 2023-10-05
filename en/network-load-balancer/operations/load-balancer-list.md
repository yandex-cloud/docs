# Information about existing network load balancers

You can request detailed information about each network load balancer you created.

## Getting a list of network load balancers in a folder {#list}

{% list tabs %}

- Management console

   In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of network load balancers in the default folder, run this command:

   ```bash
   yc load-balancer network-load-balancer list
   ```

   Result:

   
   ```text
   +----------------------+-----------------------+-------------+----------+----------------+------------------------+--------+
   |          ID          |         NAME          |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS | STATUS |
   +----------------------+-----------------------+-------------+----------+----------------+------------------------+--------+
   | enp9svq2ajbsckpd4f2m | network-load-balancer | {{ region-id }} | EXTERNAL |              1 | enp1d7t5pdeaan2rk8c9   | ACTIVE |
   | ...                  |                       |             |          |                |                        |        |
   +----------------------+-----------------------+-------------+----------+----------------+------------------------+--------+
   ```



- API

   Use the [list](../api-ref/NetworkLoadBalancer/list.md) API method and provide the folder ID in the `folderId` request parameter.

{% endlist %}

## Get detailed information about a network load balancer {#get}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
   1. Click the name of the required network load balancer.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a network load balancer, run this command:

   ```bash
   yc load-balancer network-load-balancer get <load balancer ID or name>
   ```

   You can get the load balancer ID and name with a [list of network load balancers in the folder](#list).

- API

   Use the [get](../api-ref/NetworkLoadBalancer/get.md) API method and provide the network load balancer ID in the `networkLoadBalancerId` request parameter.

   You can get the network load balancer ID with a [list of network load balancers in the folder](#list).

{% endlist %}

## Viewing a list of operations in a network load balancer {#list-operations}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
   1. Click the name of the load balancer and go to ![operations.svg](../../_assets/mdb/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of operations, run the following command:

   ```bash
   yc load-balancer network-load-balancer list-operations <load balancer ID or name>
   ```

   You can get the load balancer ID and name with a [list of network load balancers in the folder](#list).

- API

   Use the [listOperations](../api-ref/NetworkLoadBalancer/listOperations.md) API method and provide the network load balancer ID in the `networkLoadBalancerId` request parameter.

   You can get the network load balancer ID with a [list of network load balancers in the folder](#list).

{% endlist %}
