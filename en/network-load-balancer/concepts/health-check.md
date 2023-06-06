# Resource health checks

*Health checks* are used by the load balancer to get information about the health of resources in an attached target group. In response to a health request, resources report that they either are ready to receive traffic or have failed. Checks are performed via TCP or HTTP at the intervals specified in the configuration.

The following parameters should be specified for each check:

* Check type: HTTP or TCP.
* Path to send requests to (specified for HTTP checks only).
* Port: 1 to 32767.
* Check response time: 1 to 60 seconds. This is the time allowed for the resource to respond to a check. If the resource does not respond in time, the check is considered failed and the resource is assigned the `UNHEALTHY` status.
* Check interval: 1 to 60 seconds.
* Healthy and unhealthy thresholds: Number of passed or failed checks in a row that will cause a resource to be considered available or unavailable when reached.

## Target resource health statuses {#target-statuses}

A target can have one of the following health statuses:

* `INITIAL`: Health check is being configured for the resource.
* `HEALTHY`: Resource is running and ready to receive traffic.
* `UNHEALTHY`: Resource is not ready to receive traffic.
* `DRAINING`: Resource is being deleted and traffic is being removed from it. The load balancer stops routing traffic to this resource.
* `INACTIVE`: Resource is attached to a stopped load balancer or a load balancer without any listeners.

There is a delay between changing a resource status to `UNHEALTHY` and the time when the load balancer stops routing traffic to the resource. This is the time the load balancer needs to process the health check results.

Health checks are transmitted to target resources from IP addresses in the following ranges: `198.18.235.0/24` and `198.18.248.0/24`. Traffic filtering rules configured for targets must support incoming traffic from addresses in this range. Otherwise, no checks will be performed. As a result, the targets will not be assigned the `HEALTHY` status and will not be able to receive traffic. You can bind a [security group](../../vpc/concepts/security-groups.md) to targets with the following rule for incoming traffic:
* **Port range**: Use the port range specified in the health check settings.
* **Protocol**: `TCP`.
* **Source**: `Load balancer health checks`.

When performing HTTP verification, a resource gets the `HEALTHY` status only when responding with code `200`.
