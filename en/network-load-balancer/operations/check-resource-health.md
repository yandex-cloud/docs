---
title: "Checking target health statuses"
description: "Follow this guide to run health checks for target resources."
---

# Checking target health statuses

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
   1. Click the name of the required network load balancer.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Request the status of the target group resources:

   ```bash
   yc load-balancer network-load-balancer target-states <load_balancer_name_or_ID> \
     --target-group-id=<target_group_ID>
   ```

   You can get the load balancer ID and name, as well as the IDs of the attached target groups, with a [list of network load balancers in the folder](load-balancer-list.md#list).

- API {#api}

   Use the [getTargetStates](../api-ref/NetworkLoadBalancer/getTargetStates.md) API method and include the following in the request:

   * Load balancer ID in the `networkLoadBalancerId` parameter.
   * Target group ID in the `targetGroupId` parameter.

   You can get the IDs of the load balancer and attached target groups with a [list of network load balancers in the folder](load-balancer-list.md#list).

{% endlist %}
