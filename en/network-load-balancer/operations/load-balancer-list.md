# Information about current network load balancers

You can request detailed information about each network load balancer you created.

## Getting a list of network load balancers in a folder {#list}

{% list tabs group=instructions %}

- Management console {#console}

    In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.

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

    1. In the [management console]({{ link-console-main }}), go to the folder housing the [network load balancer](../concepts/index.md).
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
    1. Click the name of the load balancer in question.
    1. The **Overview** page shows the load balancer details.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To find out the name or unique ID of a [network load balancer](../concepts/index.md), [get a list](#list) of load balancers in the folder.

    1. View the description of the CLI command to get information about a network load balancer:
  
        ```bash
        yc load-balancer network-load-balancer --help
        ```

    1. To get your load balancer details, run this command with its name or ID specified:

        ```bash
        yc load-balancer network-load-balancer get <load_balancer_name_or_ID>
        ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To get information about a [network load balancer](../concepts/index.md) with the help of {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_lb_network_load_balancer" "my_balancer" {
        network_load_balancer_id = "<load_balancer_ID>"
      }

      output "network_load_balancer" {
        value = data.yandex_lb_network_load_balancer.my_balancer.created_at
      }
      ```

      Where:

      * `data "yandex_lb_network_load_balancer"`: Description of the load balancer as a data source.
         * `network_load_balancer_id`: Load balancer ID.
      * `output "network_load_balancer"`: Output variable containing information about the load balancer creation date:
         * `value`: Return value.

      You can replace `created_at` with any other parameter to get the information you need. For more information about the `yandex_lb_network_load_balancer` data source properties, see [this {{ TF }} provider article]({{ tf-provider-datasources-link }}/datasource_lb_network_load_balancer).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display their output variables. To check the results, run this command:

      ```bash
      terraform output
      ```

      Result:

      ```bash
      network_load_balancer = "2024-03-20T23:43:56Z"
      ```

- API {#api}

    Use the [get](../api-ref/NetworkLoadBalancer/get.md) API method, providing the network load balancer ID in the `networkLoadBalancerId` parameter of your request.

    You can get the network load balancer ID with the [list of network load balancers in the folder](#list).

{% endlist %}
