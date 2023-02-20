# Attach a target group to a network load balancer

{% list tabs %}

- Management console

   To attach a [target group](../concepts/target-resources.md) to a network load balancer:

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to attach a target group to a load balancer.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. In the line of the load balancer to attach a target group to, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Attach target group**.
   1. Select a target group or [create a new one](target-group-create.md).
   1. Configure health check settings.
   1. Click **Attach target group**.

- CLI

   If you don't have the {{ yandex-cloud }} command line interface, [install it](../../cli/quickstart.md#install).

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the CLI command to attach a target group to a network load balancer:

      ```
      yc load-balancer network-load-balancer attach-target-group --help
      ```

   1. Get the list of load balancers:

      ```
      yc load-balancer network-load-balancer list
      ```

      Result:

      {% if product == "yandex-cloud" %}

      ```
      +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
      |          ID          |        NAME        |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
      +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
      ...
      | b7r97ah2jn5rmo6k1dsk | test-load-balancer | {{ region-id }} | EXTERNAL |              1 |                        | INACTIVE |
      ...
      +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
      ```

      {% endif %}

      {% if product == "cloud-il" %}

      ```
      +----------------------+--------------------+-----------+----------+----------------+------------------------+----------+
      |          ID          |        NAME        | REGION ID |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
      +----------------------+--------------------+-----------+----------+----------------+------------------------+----------+
      ...
      | b7r97ah2jn5rmo6k1dsk | test-load-balancer | {{ region-id }}       | EXTERNAL |              1 |                        | INACTIVE |
      ...
      +----------------------+--------------------+-----------+----------+----------------+------------------------+----------+
      ```

      {% endif %}

   1. Get a list of target groups:

      ```
      yc load-balancer target-group list
      ```

      Result:

      {% if product == "yandex-cloud" %}

      ```
      +----------------------+-------------------+---------------------+-------------+--------------+
      |          ID          |       NAME        |       CREATED       |  REGION ID  | TARGET COUNT |
      +----------------------+-------------------+---------------------+-------------+--------------+
      ...
      | b7roi767je4c574iivrk | test-target-group | 2018-12-03 14:41:04 | {{ region-id }} |            1 |
      ...
      +----------------------+-------------------+---------------------+-------------+--------------+
      ```

      {% endif %}

      {% if product == "cloud-il" %}

      ```
      +----------------------+-------------------+---------------------+-----------+--------------+
      |          ID          |       NAME        |       CREATED       | REGION ID | TARGET COUNT |
      +----------------------+-------------------+---------------------+-----------+--------------+
      ...
      | b7roi767je4c574iivrk | test-target-group | 2018-12-03 14:41:04 | {{ region-id }}       |            1 |
      ...
      +----------------------+-------------------+---------------------+-----------+--------------+
      ```

      {% endif %}

   1. Select the `ID` or `NAME` of the required load balancer and target group.
   1. Attach the appropriate group to the selected load balancer by specifying the health check settings in the corresponding command parameters:

      ```
      yc load-balancer network-load-balancer attach-target-group b7r97ah2jn5rmo6k1dsk \
        --target-group target-group-id=b7roi767je4c574iivrk,healthcheck-name=test-health-check,healthcheck-interval=2s,healthcheck-timeout=1s,healthcheck-unhealthythreshold=2,healthcheck-healthythreshold=2,healthcheck-http-port=80
      ```

      Mind the `healthcheck-interval` and `healthcheck-timeout` parameter format: the values must be in `Ns` format.

      For more information about check parameters, see [Resource health check](../concepts/health-check).

- API

   You can attach a target group to a network load balancer using the [attachTargetGroup](../api-ref/NetworkLoadBalancer/attachTargetGroup.md) API method.

{% endlist %}