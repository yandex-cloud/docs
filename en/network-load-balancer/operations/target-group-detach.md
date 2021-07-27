---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Detach a target group from a network load balancer

{% list tabs %}

- Management console
  
  To detach a [target group](../concepts/target-resources.md) from a network load balancer:
  
  1. Open the **Load Balancer** section in the folder where you want to detach the target group from the load balancer.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) in the row of that load balancer.
  1. In the menu that opens, click **Detach target group**.
  
- CLI
  
  If you don't have the Yandex.Cloud command line interface yet, [install it](https://cloud.yandex.com/docs/cli/quickstart#install).
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. See the description of the CLI's detach target group command from a network load balancer:
  
     ```
     $ yc load-balancer network-load-balancer detach-target-group --help
     ```
  
  1. Get a list of load balancers:
  
     ```
     $ load-balancer network-load-balancer list
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     |          ID          |        NAME        |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ...
     | b7r97ah2jn5rmo6k1dsk | test-load-balancer | ru-central1 | EXTERNAL |              1 | b7roi767je4c574iivrk   | INACTIVE |
     ...
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ```
  
  1. Choose the `ID` of the load balancer and the target group that is attached to it.
  
  1. Detach the selected group from the load balancer:
  
     ```
     $ yc load-balancer network-load-balancer detach-target-group b7r97ah2jn5rmo6k1dsk \
       --target-group-id=b7roi767je4c574iivrk
     ```
  
- API
  
  You can detach a target group from a network load balancer using the [detachTargetGroup](../api-ref/NetworkLoadBalancer/detachTargetGroup.md) API method.
  
{% endlist %}

