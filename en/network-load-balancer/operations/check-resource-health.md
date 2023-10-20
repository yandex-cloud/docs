---
title: "Checking target health statuses"
description: "Follow this guide to run health checks for target resources."
---

# Checking target health statuses

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
   1. Click the name of the required network load balancer.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Request the status of the target group resources:

   ```bash
   yc load-balancer network-load-balancer target-states <load balancer ID or name> \
     --target-group-id=<target group ID>
   ```

   You can get the load balancer ID and name, as well as the IDs of the attached target groups, with a [list of network load balancers in the folder](load-balancer-list.md#list).

- API

   Use the [getTargetStates](../api-ref/NetworkLoadBalancer/getTargetStates.md) API method and include the following in the request:

   * Load balancer ID in the `networkLoadBalancerId` parameter.
   * Target group ID in the `targetGroupId` parameter.

   You can get the IDs of the load balancer and attached target groups with a [list of network load balancers in the folder](load-balancer-list.md#list).

{% endlist %}
