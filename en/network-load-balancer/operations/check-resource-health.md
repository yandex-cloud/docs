---
title: Checking target health statuses
description: Follow this guide to check the health status of your targets.
---

# Checking target health statuses

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder page.
  1. [Navigate]({{ link-console-main }}/link/network-load-balancer/) to **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. Click the name of the load balancer in question.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Request a health check for targets in the target group:
  
  ```bash
  yc load-balancer network-load-balancer target-states <load_balancer_name_or_ID> \
    --target-group-id=<target_group_ID>
  ```

  You can get the load balancer ID and name, as well as the IDs of the attached target groups with the [list of network load balancers in the folder](load-balancer-list.md#list).

- API {#api}

  Use the [getTargetStates](../api-ref/NetworkLoadBalancer/getTargetStates.md) REST API method for the [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) resource or the [NetworkLoadBalancerService/GetTargetStates](../api-ref/grpc/NetworkLoadBalancer/getTargetStates.md) gRPC API call and provide the following in the request:

  * Load balancer ID in the `networkLoadBalancerId` parameter (REST API), or `network_load_balancer_id` (gRPC API).
  * Target group ID in the `targetGroupId` parameter (REST API), or `target_group_id` (gRPC API).

  You can get the IDs of the load balancer and attached target groups with the [list of network load balancers in the folder](load-balancer-list.md#list).

{% endlist %}
