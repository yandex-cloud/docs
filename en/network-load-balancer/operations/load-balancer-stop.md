# Stop a network load balancer

{% list tabs %}

- Management console
  
  To stop a [network load balancer](../concepts/index.md):
  
  1. Open the **Load Balancer** section in the folder where you want to stop the load balancer.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) in the row of that load balancer or open the page of the load balancer you need.
  1. Click **Stop**.
  1. In the window that opens, click **Stop**.
  
- CLI
  
  If you don't have the Yandex.Cloud command line interface yet, [install it](https://cloud.yandex.com/docs/cli/quickstart#install).
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. See the description of the CLI's stop network load balancer command:
  
     ```
     $ yc load-balancer network-load-balancer stop --help
     ```
  
  1. Get a list of all load balancers:
  
     ```
     $ yc load-balancer network-load-balancer list
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     |          ID          |        NAME        |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ...
     | b7r97ah2jn5rmo6k1dsk | test-load-balancer | ru-central1 | EXTERNAL |              1 | c58n3vh8saud47rj1cuk   |  ACTIVE  |
     ...
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ```
  
  1. Choose the `ID` or `NAME` of the required load balancer in the `ACTIVE` state.
  
  1. Stop the load balancer:
  
     ```
     $ yc load-balancer network-load-balancer stop b7r97ah2jn5rmo6k1dsk
     ```
  
- API
  
  You can stop network load balancers using the [stop](../api-ref/NetworkLoadBalancer/stop.md) API method.
  
{% endlist %}

