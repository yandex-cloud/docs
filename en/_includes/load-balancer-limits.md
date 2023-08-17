#### Quotas {#load-balancer-quotas}
| Type of limit | Value |
----- | -----
| Number of load balancers per cloud | 2 |
| Number of target groups per cloud | 100 |

#### Limits {#load-balancer-limits}
| Type of limit | Value |
----- | -----
| Number of resources per target group | 254 |
| Number of listening ports | 10 |
| Number of health checks per attached target group | 1 |
| Status check protocol | TCP, HTTP |

#### Other restrictions {#load-balancer-other-restrictions}
A single target group may only contain target resources from a single cloud network.

A target group can include resources that are connected to the same subnet within a single availability zone.

A resource will not be directly available on the target port if you add it to the internal load balancer's target group.

You can create a load balancer without a listener.

Health checks are transmitted from the `198.18.235.0/24` and `198.18.248.0/24` IP address ranges.

When connecting resources to the load balancer, keep in mind the [limit](../vpc/concepts/limits.md#limits) on the maximum number of concurrent TCP/UDP connections per VM.
