---
title: "Tips for configuring {{ alb-full-name }} health checks"
description: "This page provides recommendations for configuring {{ alb-name }} health checks."
---

# Tips for configuring {{ alb-full-name }} health checks

For [backends](backend-group.md) consisting of [target groups](target-group.md), we recommend configuring [health checks](backend-group.md#health-checks). The L7 balancer will send check requests to endpoints at certain intervals and wait for a response for a certain period of time. Traffic routing to a specific endpoint will be managed based on its health check results.

## Benefits {#health-checks-advantages}

### High app availability {#hight-availability}

High application availability and reliability require properly configured health checks. Health checks enable prompt removal of faulty application instances, ensuring only stable ones remain available. This means the users will encounter fewer service failures. This improves user experience and reduces financial and reputational risks.

The health check works as follows: the L7 load balancer periodically sends check requests to the backends where application instances are deployed and running. If the backend does not respond within the specified time period, the load balancer marks it as unhealthy and reroutes traffic to alternative backends. The load balancer keeps sending periodic check requests to all backends. If the unhealthy backend recovers and starts responding to requests, it will be brought back into use.

Thus, health checks help the load balancer to effectively distribute load, identify available and recovered backends, and promptly remove those that have failed.

### Seamless service maintenance {#service-maintenance}

Health checks allow the application to continue running while undergoing rolling updates on the backends. During updates, the VM may automatically restart making the application temporarily unavailable. With health checks, the load balancer will promptly spot the unavailable backend to reroute traffic to alternative backends. Once the update is complete, traffic will be distributed across all backends.

This way, the update will be seamless for users.

### Resource saving {#resource-saving}

Health checks help to promptly troubleshoot application failures. Thus, you can avoid downtime costs for the resources that are actually unavailable, provide no services to users, and generate no profit.

## Configuration rules {#health-checks-rules}

### Dedicated endpoint for health checks {#health-checks-endpoint}

Include a dedicated endpoint in the backend application logic to handle health check requests.
This is to prevent overloading endpoints that handle user requests with extra check requests. Health check requests must not affect app performance. For example, frequent check requests must not overload databases or other critical components.

The check endpoint must be integrated with the application rather than operate independently. The check endpoint health must mirror app performance. The check endpoint encryption and protocol must match those of working endpoints. This will allow you to assume that if the check endpoint is unresponsive, the entire backend is unavailable.

### Integration with Instance Groups {#instance-groups-integrations}

[Integrating an instance group with the L7 load balancer](../../compute/concepts/instance-groups/balancers.md) enables automatic app recovery without involving the administrator. This is possible because a group can automatically recreate a VM that has received no traffic from the load balancer for a long time.

When configuring, specify the `max_opening_traffic_duration` parameter. It stands for the time required for a new VM in the instance group to pass the load balancer’s health check.

### Panic mode {#panic-mode}

In some cases, health checks can be automatically disabled to maintain application performance when data load increases drastically. To handle this, use [panic mode](backend-group.md#panic-mode). In this mode, the load balancer will distribute requests across all endpoints, ignoring health check results. Some users will find the service unavailable, while others will still be able to use it.

If you do not use panic mode, failure of some backends will further increase the load on backends that are still running. If an application is running at its maximum capacity, all backends will fail, which will render your service completely unavailable for all its users.

## Recommended practices {#health-checks-recommendations}

You set up health checks when [creating a backend group](../operations/backend-group-create.md). You can add one or more health checks for each backend.

{% include [backend-healthcheck](../../_includes/application-load-balancer/backend-healthcheck.md) %}

When configuring a health check, you can either keep the default parameters or specify your own. Health checks must consider backend's capacity to avoid overloading it. For example, if the backend response time is more than one second, the timeout must be greater than that.

See below for the optimal parameters to use when configuring {{ alb-name }} for the first time. You can adjust these values later to align with performance of your backends and the L7 load balancer.

* **{{ ui-key.yacloud.alb.label_timeout }}**: `1`
* **{{ ui-key.yacloud.alb.label_interval }}**: `1`
* **{{ ui-key.yacloud.alb.label_healthy }}**: `2`
* **{{ ui-key.yacloud.alb.label_unhealthy }}**: `3`


