---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Start a network load balancer

{% list tabs %}

- Management console
  
  To start a [network load balancer](../concepts/index.md):
  
  1. Open the **Load Balancer** section in the folder where you want to start the load balancer.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) in the row of that load balancer or open the page of the load balancer you need.
  1. Click **Start**.
  1. In the window that opens, click **Start**.
  
- CLI
  
  If you don't have the Yandex.Cloud command line interface yet, [install it](https://cloud.yandex.com/docs/cli/quickstart#install).
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. See the description of the CLI's start network load balancer command:
  
     ```
     $ yc load-balancer network-load-balancer start --help
     ```
  
  1. Get a list of all load balancers:
  
     ```
     $ yc load-balancer network-load-balancer list
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     |          ID          |        NAME        |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ...
     | b7r97ah2jn5rmo6k1dsk | test-load-balancer | ru-central1 | EXTERNAL |              1 | c58n3vh8saud47rj1cuk   | INACTIVE |
     ...
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ```
  
  1. Choose the `ID` or `NAME` of the required load balancer in the `INACTIVE` state.
  
  1. Start the load balancer:
  
     ```
     $ yc load-balancer network-load-balancer start b7r97ah2jn5rmo6k1dsk
     ```
  
- API
  
  You can start network load balancers using the [start](../api-ref/NetworkLoadBalancer/start.md) API method.
  
{% endlist %}

