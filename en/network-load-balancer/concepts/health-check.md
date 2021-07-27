---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Resource health checks

*A network load balancer uses health checks* to get information about the health of resources in an attached target group. In response to a status request, a resource reports that it is ready to receive traffic, is in an intermediate state, or has failed. Checks are performed via TCP or HTTP at the intervals specified in the configuration.

The following should be specified for each check:

* Check interval, from 1 to 300 seconds.
* Check timeout, from 1 to 60 seconds. The timeout is the time allowed for the resource to respond to a check. If the resource doesn't respond in time, the check is considered failed and the resource is assigned the `UNHEALTHY` status.
* Resource health indicators: the threshold amount of successful or failed results. If a threshold is exceeded, it indicates that the check passed or failed, respectively.

## Target health statuses {#target-statuses}

A target can have one of the following health statuses:

* `INITIAL`: a health check is being configured for the resource.
* `HEALTHY`: the resource is running and ready to receive traffic.
* `UNHEALTHY`: the resource is not ready to receive traffic.
* `DRAINING`: the resource is being deleted and traffic is being removed from it. The load balancer stops routing traffic to this resource.
* `INACTIVE`: the resource is attached to a stopped load balancer or a load balancer without any listeners.

There is a delay between changing the resource status to `UNHEALTHY` and the time when the network load balancer stops routing traffic to the resource. This is the time that the load balancer spends on processing the check results.

Health check results are passed to targets with IPs in the `198.18.235.0/24` and `198.18.248.0/24` ranges. Traffic filtering rules configured for targets must allow receiving traffic from the addresses in this range. Otherwise, no checks will be performed. As a result, the targets will not be assigned the `HEALTHY` status and will not be able to receive traffic.

When using an HTTP health check, a resource will get a `HEALTHY` status only if the response code `200` is returned.