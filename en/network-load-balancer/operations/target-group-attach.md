# Attach a target group to a network load balancer

{% list tabs %}

- Management console
  
  To attach a [target group](../concepts/target-resources.md) to a network load balancer:
  
  1. Open the **Load Balancer** section in the folder where you want to attach the target group to the load balancer.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) in the row of that load balancer. If you already have a target group created, select it. If not, [create one](target-group-create.md).
  1. Configure health check settings.
  1. Click **Attach**
  
- CLI
  
  If you don't have the Yandex.Cloud command line interface yet, [install it](https://cloud.yandex.com/docs/cli/quickstart#install).
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. See the description of the CLI's attach target group command to a network load balancer:
  
     ```
     $ yc load-balancer network-load-balancer attach-target-group --help
     ```
  
  1. Get a list of load balancers:
  
     ```
     $ yc load-balancer network-load-balancer list
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     |          ID          |        NAME        |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ...
     | b7r97ah2jn5rmo6k1dsk | test-load-balancer | ru-central1 | EXTERNAL |              1 |                        | INACTIVE |
     ...
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ```
  
  1. Get a list of target groups:
  
     ```
     $ yc load-balancer target-group list
     +----------------------+-------------------+---------------------+-------------+--------------+
     |          ID          |       NAME        |       CREATED       |  REGION ID  | TARGET COUNT |
     +----------------------+-------------------+---------------------+-------------+--------------+
     ...
     | b7roi767je4c574iivrk | test-target-group | 2018-12-03 14:41:04 | ru-central1 |            1 |
     ...
     +----------------------+-------------------+---------------------+-------------+--------------+
     ```
  
  1. Choose the `ID` or `NAME` of the required load balancer and target group.
  
  1. Attach the appropriate group to the selected load balancer by specifying the health check settings in the corresponding command parameters:
  
     ```
     $ yc load-balancer network-load-balancer attach-target-group b7r97ah2jn5rmo6k1dsk \
       --target-group target-group-id=b7roi767je4c574iivrk,healthcheck-name=test-health-check,healthcheck-interval=2s,healthcheck-timeout=1s,healthcheck-unhealthythreshold=2,healthcheck-healthythreshold=2,healthcheck-http-port=80
     ```
  
     Pay attention to the format of the `healthcheck-interval` and `healthcheck-timeout` parameters: their values must be specified in `Ns` format.
  
     For more information about check parameters, see the section [Resource health check](../concepts/health-check).
  
- API
  
  You can attach a target group to a network load balancer using the [attachTargetGroup](../api-ref/NetworkLoadBalancer/attachTargetGroup.md) API method.
  
{% endlist %}

