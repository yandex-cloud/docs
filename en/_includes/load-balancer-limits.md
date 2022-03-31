#### Quotas {#load-balancer-quotas}
| Type of limit | Value |
----- | -----
| Number of load balancers per cloud | 2 |
| Number of target groups per cloud | 2 |

#### Limits {#load-balancer-limits}
| Type of limit | Value |
----- | -----
| Number of resources per target group | 254 |
| Number of listening ports | 10 |
| Number of health checks per attached target group | 1 |
| Status check protocol | TCP, HTTP |

#### Other restrictions {#load-balancer-other-restrictions}
A particular target group can only contain target resources from a single cloud network.

A target group can include resources that are connected to the same subnet within a single availability zone.

You can create a load balancer without a listener.

Health checks are transmitted from the IP address range `198.18.235.0/24`.

When connecting resources to the load balancer, keep in mind the [limit](../vpc/concepts/limits.md#limits) on the maximum number of simultaneous TCP/UDP connections per VM.