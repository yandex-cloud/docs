# Start a network load balancer

{% list tabs %}

- Management console

   To start a [network load balancer](../concepts/index.md):
   1. In the [management console]({{ link-console-main }}), select the folder where you need to start a load balancer.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. In the line of the load balancer to start, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Start**.
   1. In the window that opens, click **Start**.

- CLI

   If you don't have the {{ yandex-cloud }} command line interface, [install it](../../cli/quickstart.md#install).

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's start network load balancer command:

      ```bash
      yc load-balancer network-load-balancer start --help
      ```

   1. Get a list of all load balancers:

      ```bash
      yc load-balancer network-load-balancer list
      ```

      Result:

      {% if product == "yandex-cloud" %}

      ```text
      +----------------------+--------------------+-----------------+----------+----------------+------------------------+----------+
      |          ID          |        NAME        |    REGION ID    |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
      +----------------------+--------------------+-----------------+----------+----------------+------------------------+----------+
      ...
      | b7r97ah2jn5rmo6k1dsk | test-load-balancer | {{ region-id }} | EXTERNAL |              1 | b7r97ah2jn5rmo6k1dsk   | INACTIVE |
      ...
      +----------------------+--------------------+-----------------+----------+----------------+------------------------+----------+
      ```

      {% endif %}

      {% if product == "cloud-il" %}

      ```text
      +----------------------+--------------------+-----------+----------+----------------+------------------------+----------+
      |          ID          |        NAME        | REGION ID |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
      +----------------------+--------------------+-----------+----------+----------------+------------------------+----------+
      ...
      | b7r97ah2jn5rmo6k1dsk | test-load-balancer | {{ region-id }}       | EXTERNAL |              1 | b7r97ah2jn5rmo6k1dsk   | INACTIVE |
      ...
      +----------------------+--------------------+----- -----+----------+----------------+------------------------+----------+
      ```

      {% endif %}

   1. Choose the `ID` or `NAME` of the required load balancer in the `INACTIVE` state.
   1. Start the load balancer:

      ```bash
      yc load-balancer network-load-balancer start b7r97ah2jn5rmo6k1dsk
      ```

- API

   You can start load balancers using the [start](../api-ref/NetworkLoadBalancer/start.md) API method.

{% endlist %}