# Information about current network load balancers

You can request detailed information about each network load balancer you created.

## Getting a list of network load balancers in a folder {#list}

{% list tabs group=instructions %}

- Management console {#console}

    In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.

- CLI {#cli}

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
    | enp9svq2ajbs******** | network-load-balancer | {{ region-id }} | EXTERNAL |              1 | enp1d7t5pdea********   | ACTIVE |
    | ...                  |                       |             |          |                |                        |        |
    +----------------------+-----------------------+-------------+----------+----------------+------------------------+--------+
    ```

- API {#api}

    Use the [list](../api-ref/NetworkLoadBalancer/list.md) API method, providing the folder ID in the `folderId` parameter of your request.

{% endlist %}

## Getting detailed information about a network load balancer {#get}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. Click the name of the load balancer in question.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get information about a network load balancer, run this command:

    ```bash
    yc load-balancer network-load-balancer get <load_balancer_name_or_ID>
    ```

    You can get the load balancer ID and name with the [list of network load balancers in the folder](#list).

- API {#api}

    Use the [get](../api-ref/NetworkLoadBalancer/get.md) API method, providing the network load balancer ID in the `networkLoadBalancerId` parameter of your request.

    You can get the network load balancer ID with the [list of network load balancers in the folder](#list).

{% endlist %}
