# Detach a target group from a network load balancer

{% list tabs %}

- Management console

   To detach a [target group](../concepts/target-resources.md) from a network load balancer:
   1. In the [management console]({{ link-console-main }}), select the folder where you wish to detach a target group from a load balancer.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. Select the load balancer that you wish to detach the target group from.
   1. Under **Target groups**, click ![image](../../_assets/horizontal-ellipsis.svg) in the line of the appropriate target group.
   1. In the menu that opens, click **Detach**.
   1. In the window that opens, click **Detach**.

- CLI

   If you don't have the {{ yandex-cloud }} command line interface, [install it](../../cli/quickstart.md#install).

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to detach a target group from a network load balancer:

      ```bash
      yc load-balancer network-load-balancer detach-target-group --help
      ```

   1. Get the list of load balancers:

      ```bash
      load-balancer network-load-balancer list
      ```

      Result:

      
      ```bash
      +----------------------+--------------------+-----------------+----------+----------------+------------------------+----------+
      |          ID          |        NAME        |    REGION ID    |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
      +----------------------+--------------------+-----------------+----------+----------------+------------------------+----------+
      ...
      | b7r97ah2jn5rmo6k1dsk | test-load-balancer | {{ region-id }} | EXTERNAL |              1 | b7roi767je4c574iivrk   | INACTIVE |
      ...
      +----------------------+--------------------+-----------------+----------+----------------+------------------------+----------+
      ```



   1. Choose the `ID` of the load balancer and the target group that is attached to it.
   1. Detach the selected group from the load balancer:

      ```bash
      yc load-balancer network-load-balancer detach-target-group b7r97ah2jn5rmo6k1dsk \
        --target-group-id=b7roi767je4c574iivrk
      ```

- API

   You can detach a target group from a network load balancer using the [detachTargetGroup](../api-ref/NetworkLoadBalancer/detachTargetGroup.md) API method.

{% endlist %}