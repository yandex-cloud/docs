#### Quotas {#load-balancer-quotas}
Type of limitation | Value
----- | -----
Number of load balancers per cloud | 2
Number of target groups per cloud | 100

#### Limits {#load-balancer-limits}
Type of limitation | Value
----- | -----
Number of targets per target group | 254
Number of ports per listener | 10
Number of health checks per attached target group | 1
Health check protocol | TCP, HTTP

#### Other restrictions {#load-balancer-other-restrictions}
A single target group can only contain targets from a single cloud network. 

Within a single availability zone, a target group can only include targets on the same subnet.

If you add a target to the internal load balancer's target group, it will not be directly accessible on the target port.

You can create a load balancer without a listener.

Health check traffic comes from the `198.18.235.0/24` and `198.18.248.0/24` ranges.

When adding targets for a load balancer, keep in mind the [limit](../vpc/concepts/limits.md#limits) on the maximum number of concurrent TCP/UDP connections per VM.
