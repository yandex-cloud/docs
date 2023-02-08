# Check target health statuses

{% list tabs %}

- CLI

   If you don't have the {{ yandex-cloud }} command line interface, [install it](../../cli/quickstart.md#install).

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's get attached resource status command:

      ```
      yc load-balancer network-load-balancer target-states --help
      ```

   1. Get a list of all network load balancers:

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
      | b7r97ah2jn5rmo6k1dsk | test-load-balancer | {{ region-id }} | EXTERNAL |              1 | b7roi767je4c574iivrk   |  ACTIVE  |
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
      | b7r97ah2jn5rmo6k1dsk | test-load-balancer | il1       | EXTERNAL |              1 | b7roi767je4c574iivrk   |  ACTIVE  |
      ...
      +----------------------+--------------------+-----------+----------+----------------+------------------------+----------+
      ```

      {% endif %}

   1. Choose the `ID` of the load balancer and the `ID` of the target group that is attached to it.
   1. Request the status of the target group resources:

      ```
      yc load-balancer network-load-balancer target-states b7r97ah2jn5rmo6k1dsk --target-group-id b7roi767je4c574iivrk
      ```

      Result:

      ```
      +----------------------+-----------+-----------+
      |      SUBNET ID       |  ADDRESS  |  STATUS   |
      +----------------------+-----------+-----------+
      | e9bc0iisdf7b00b7d4v0 | 10.10.0.4 | UNHEALTHY |
      | e9bc0iisdf7b00b7d4v0 | 10.10.0.7 | UNHEALTHY |
      +----------------------+-----------+-----------+
      ```

{% endlist %}