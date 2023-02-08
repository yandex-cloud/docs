# Stop a network load balancer

{% list tabs %}

- Management console

   To stop a [network load balancer](../concepts/index.md):
   1. In the [management console]({{ link-console-main }}), select the folder where you need to stop a load balancer.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. In the line of the load balancer to stop, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Stop**.
   1. In the window that opens, click **Stop**.

- CLI

   If you don't have the {{ yandex-cloud }} command line interface, [install it](../../cli/quickstart.md#install).

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's stop network load balancer command:

      ```bash
      yc load-balancer network-load-balancer stop --help
      ```

   1. Get a list of all load balancers:

      ```bash
      yc load-balancer network-load-balancer list
      ```

      Result:

      
      ```text
      +----------------------+--------------------+-----------------+----------+----------------+------------------------+----------+
      |          ID          |        NAME        |    REGION ID    |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
      +----------------------+--------------------+-----------------+----------+----------------+------------------------+----------+
      ...
      | b7r97ah2jn5rmo6k1dsk | test-load-balancer | {{ region-id }} | EXTERNAL |              1 | c58n3vh8saud47rj1cuk   |  ACTIVE  |
      ...
      +----------------------+--------------------+-----------------+----------+----------------+------------------------+----------+
      ```



   1. Choose the `ID` or `NAME` of the required load balancer in the `ACTIVE` state.
   1. Stop the load balancer:

      ```bash
      yc load-balancer network-load-balancer stop b7r97ah2jn5rmo6k1dsk
      ```

- API

   You can stop network load balancers using the [stop](../api-ref/NetworkLoadBalancer/stop.md) API method.

{% endlist %}