1. In addition to DDoS protection at OSI L7 using [{{ sws-full-name }}](../../../smartwebsecurity/), we recommend enabling DDoS protection at L3-L4. To do this, [reserve a public static IP address with DDoS protection](../../../vpc/operations/enable-ddos-protection.md#enable-on-reservation) in advance and use this address for the L7 load balancer's listener.

    If the network load balancer's listener already uses a public IP address with DDoS protection, you can save it and use it for the L7 load balancer.

    If the network load balancer's listener uses a public IP address without DDoS protection, DDoS protection at L3-L4 when migrating to an L7 load balancer can only be achieved by changing the public IP for your service.

    When using L3-L4 DDoS protection, configure a trigger threshold for the L3-L4 protection mechanisms aligned with the amount of legitimate traffic to the protected resource. To set up this threshold, contact [support]({{ link-console-support }}).

    Also, set the MTU value to `1450` for the targets downstream of the load balancer. For more information, see [Setting up MTU when enabling DDoS protection](../../../vpc/operations/adjust-mtu-ddos-protection.md).

1. We recommend performing migration during the hours when the user load is at its lowest. If you plan to keep your public IP address, bear in mind that migration involves moving this IP address from the load balancer to the L7 load balancer. Your service will be unavailable during this period. Under normal conditions, this may last for several minutes.

1. When using an L7 load balancer, requests to backends come with the source IP address from the range of internal IP addresses of the subnets specified when creating the L7 load balancer. The original IP address of the request source (user) is specified in the `X-Forwarded-For` header. If you want to log public IP addresses of users on the web server, reconfigure it.

1. See the [autoscaling and resource units](../../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) in the L7 load balancer.
