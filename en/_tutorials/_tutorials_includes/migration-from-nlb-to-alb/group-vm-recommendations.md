1. Optionally, enable L3-L4 DDoS protection (the [OSI model](https://en.wikipedia.org/wiki/OSI_model)). It will enhance the L7 protection provided by [{{ sws-full-name }}](../../../smartwebsecurity/) after migration.

    To enable L3-L4 protection:

    1. Before the migration, [reserve a public static IP address with DDoS protection](../../../vpc/operations/enable-ddos-protection.md#enable-on-reservation) and use this address for the L7 load balancer's listener. If you already have a protected public IP address for the load balancer, you can keep this address during migration. Otherwise, you will have to change the IP address to a protected one.

    1. Configure a trigger threshold for the protection mechanisms, consistent with the amount of legitimate traffic to the protected resource. To set up this threshold, contact [support]({{ link-console-support }}).

    1. [Set](../../../vpc/operations/adjust-mtu-ddos-protection.md) the MTU value to `1450` for the targets downstream of the load balancer. For more information, see [MTU and TCP MSS](../../../vpc/concepts/mtu-mss.md).

1. Perform migration during the hours when the user load is at its lowest. Your service will be unavailable during the migration while updating the instance group’s integration with the target group and moving the network load balancer’s public IP address to the L7 load balancer. The downtime depends on the number of VMs in the group, [deployment policy](../../../compute/concepts/instance-groups/policies/deploy-policy.md) settings and usually takes from several minutes to tens of minutes.

1. When using an L7 load balancer, requests to backends come with the source IP address from the range of internal IP addresses of the subnets specified when creating the L7 load balancer. The original IP address of the request source (user) is specified in the `X-Forwarded-For` header. If you want to log public IP addresses of users on the web server, reconfigure it.

1. Before the migration, define the minimum number of resource units for the [autoscaling](../../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) settings in the L7 load balancer:

    Select the number of resource units based on the analysis of your service load expressed in:

    * Number of requests per second (RPS).
    * Number of concurrent active connections.
    * Number of new connections per second.
    * Traffic processed per second.
