# Health checks


The load balancer uses *health checks* to get information about the state of resources in attached target groups. Components of the health check module are hosted in each availability zone. In response to a state request, resources report that they either are ready to receive traffic or have failed. If a resource does not respond to a state request within the specified time frame, it is also considered failed. Checks are performed via TCP or HTTP at the time frames (intervals) specified in the configuration.

For example, with a two-second health check interval, a resource in a target group will receive three state check requests with a two-second interval.

Health check traffic is also routed through the load balancer.

For each check, you need to specify:

* Check type: HTTP or TCP.
* Path: Path within the URL to send requests to (specified for HTTP checks only).
* Port: Value from 1 to 32767.
* Check response time: Value from 1 to 60 seconds. This is the time allowed for the resource to respond to a check. If the resource does not respond in time, the check is considered failed and the resource is assigned the `UNHEALTHY` status.
* Check interval: Value from 1 to 60 seconds.
* Healthy and unhealthy thresholds: Number of passed or failed checks in a row that will cause a resource to be considered available or unavailable when reached.

## Network load balancer status {#nlb-status}

A network load balancer you create can have one of the following statuses:

* `CREATING`: Load balancer is being created.
* `STARTING`: Load balancer is being started.
* `ACTIVE`: Load balancer is running, performing health checks, and routing traffic to the target group resources.
* `STOPPING`: Load balancer is being stopped.
* `STOPPED`: Load balancer is stopped and is not performing health checks or distributing traffic.
* `DELETING`: Load balancer is being deleted.
* `INACTIVE`: Load balancer has no listeners or the target groups attached to it contain no targets. The load balancer is not performing any checks or distributing any traffic.

## Resource statuses in target groups {#target-statuses}

Resources in target groups can have one of the following statuses:

* `INITIAL`: Health check is being configured for the resource.
* `HEALTHY`: Resource is running and ready to receive traffic.
* `UNHEALTHY`: Resource is not ready to receive traffic.
* `DRAINING`: Resource is being deleted and traffic is being removed from it. The load balancer stops routing traffic to this resource.
* `INACTIVE`: Resource is attached to a stopped load balancer or a load balancer without any listeners.

There is a delay between changing a resource status to `UNHEALTHY` and the time when the load balancer stops routing traffic to the resource. This is the time the load balancer needs to process the health check results.

Status checks for resources in target groups are transmitted from the `198.18.235.0/24` and `198.18.248.0/24` IP address ranges. Traffic filtering rules configured for targets must allow incoming traffic from these subnets; otherwise, no checks will be performed. As a result, the targets will not be assigned the `HEALTHY` status and will not receive traffic.

To allow traffic from the status check module, you can bind to targets a [security group](../../vpc/concepts/security-groups.md) with the following ingress rule:
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: Use the port range specified in the health check settings.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`.

When performing HTTP verification, a resource gets the `HEALTHY` status only when responding with code `200`.
