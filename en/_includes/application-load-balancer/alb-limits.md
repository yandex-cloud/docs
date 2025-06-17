#### Quotas {#quotas}

#|
|| Type of limitation | Value ||
|| Maximum number of load balancers per cloud
`apploadbalancer.loadBalancers.count` | 4 ||
|| Maximum number of HTTP routers per cloud
`apploadbalancer.httpRouters.count` | 16 ||
|| Maximum number of backend groups per cloud
`apploadbalancer.backendGroups.count` | 32 ||
|| Maximum number of target groups per cloud
`apploadbalancer.targetGroups.count` | 32 ||
|#

#### Limits {#limits}

Type of limit | Value
----- | -----
Maximum number of resources per target group | 256
Maximum number of backends per backend group | 8
Maximum number of virtual hosts per HTTP router | 64
Maximum number of routes per HTTP router | 128
Maximum number of listeners per L7 load balancer | 8
Maximum number of SNI listeners per L7 load balancer | 32
Maximum number of authority headers you can specify for a virtual host | 32