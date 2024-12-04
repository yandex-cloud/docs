---
title: Resource availability check
description: In this article, you will learn about the purpose of resource availability checks and the different states of the network load balancer and target group resources.
---

# Resource availability check


The load balancer uses *resource availability checks* to get information about the state of resources in attached target groups. Components of the health check module are hosted in each availability zone. In response to a state request, resources report that they either are ready to receive traffic or have failed. If a resource does not respond to a state request within the specified time frame, it is also considered failed. Checks are performed via TCP or HTTP at the time frames (intervals) specified in the configuration.

For example, with a two-second health check interval, a resource in a target group will receive three state check requests with a two-second interval.

The resource availability check traffic is also routed through the load balancer.

For each check, you need to specify:

* Check type: HTTP or TCP.
* Path: Path within the URL to send requests to (specified for HTTP checks only).
* Port: A value from 1 to 32767.
* Check response time: A value from 1 to 60 seconds. This is the time the resource is given to respond. If it fails to respond within this time, it fails the check and gets the `UNHEALTHY` status.
* Check interval: Value from 1 to 60 seconds.
* Healthy and unhealthy thresholds: Number of passed or failed checks in a row that will cause a resource to be considered available or unavailable when reached.

## Network load balancer status {#nlb-status}

A network load balancer you created can have one of the following statuses:

* `CREATING`: The load balancer is being created.
* `STARTING`: The load balancer is starting up.
* `ACTIVE`: The load balancer is active performing health checks and routing traffic to the target group resources.
* `STOPPING`: The load balancer is stopping.
* `STOPPED`: The load balancer is stopped; no health checks or traffic routing.
* `DELETING`: The load balancer is being deleted.
* `INACTIVE`: The load balancer has no listeners, or the target groups attached to it contain no targets. The load balancer is not performing any checks or distributing any traffic.

## Resource statuses in target groups {#target-statuses}

Resources in target groups can have one of the following statuses:

* `INITIAL`: Health check is being configured for the resource.
* `HEALTHY`: The resource is active and ready to receive traffic.
* `UNHEALTHY`: The resource is not ready to receive traffic.
* `DRAINING`: The resource is being deleted and traffic is being removed from it. The load balancer stops routing traffic to this resource.
* `INACTIVE`: The resource is connected to a stopped load balancer or a load balancer without any listeners.

There is a delay between when a resource gets the `UNHEALTHY` status and when the load balancer stops routing traffic to the resource. The load balancer needs this delay time to process the health check results.

Status checks for resources in target groups are transmitted from the `198.18.235.0/24` and `198.18.248.0/24` subnets. Traffic filtering rules configured for targets must allow incoming traffic from these subnets; otherwise, no checks will be performed: the targets will not get the `HEALTHY` status and will not be able to receive traffic.

To allow traffic from the status check module, you can bind to targets a [security group](../../vpc/concepts/security-groups.md) with the following ingress rule:
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: Use the port range specified in the health check settings.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`.

In an HTTP check, a resource gets the `HEALTHY` status only when responding with the `200` code.
