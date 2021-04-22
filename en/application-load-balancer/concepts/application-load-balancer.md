# Load balancer

A load balancer is used for receiving incoming traffic and transmitting it to the backend endpoints specified in the [target groups](target-group.md). Request routing follows the rules defined in the [HTTP routers](http-router.md) connected to the load balancer's [listeners](#listener.md). Settings for transmitting traffic to backends are configured in [backend groups](backend-group.md) created on top of target groups.

The load balancer stores a list of endpoints, which accept traffic and disables TLS encryption before sending the traffic to backends. Load balancer supports modern TLS versions (TLSv1.2, TLSv1.3) and encryption methods. If the load balancer is going to serve multiple domains, you can configure individual certificates and [HTTP routers](http-router.md) for each domain by using the TLS SNI mechanism.

For convenience and security, you can use the load balancer together with {{ certificate-manager-full-name }} to store your TLS certificates. You can also use {{ monitoring-full-name }} services to monitor request processing.

## Load balancer locality {#lb-location}

When you create a load balancer, specify a [network](../../vpc/concepts/network.md) and [subnets](../../vpc/concepts/network.md#subnet) in three [availability zones](../../overview/concepts/geo-scope.md). Those are the subnets where the load balancer's nodes will be hosted. Application backends will receive traffic from the load balancer nodes in these subnets. If the backend VMs belong to [security groups](../../vpc/concepts/security-groups.md), allow traffic from these subnets on the VM ports used by the application to handle traffic.

You can disable the load balancer in the selected availability zones. In this case, external traffic will no longer be sent to the load balancer nodes in these availability zones. However, the load balancer's nodes in other availability zones will continue delivering traffic to backends in the availability zones where the load balancer was disabled if permitted by the [locality aware routing](backend-group.md#locality) settings.

## Listener {#listener}

The listener determines the ports, addresses, and protocols the load balancer will accept traffic on. The listener passes traffic to the application's backends based on the routing rules set in the [HTTP router](http-router.md). One load balancer can serve both regular and encrypted traffic on different ports and have public and internal IP addresses on different listeners.

### Example {#listener-example}

The listener can accept HTTP traffic on port 80 and redirect traffic to HTTPS port 443. The listener gets an HTTP request from a client and returns a response with HTTP code 302. Further requests will be accepted at port 443 via HTTPS.

If an HTTPS listener is used, make sure to specify a [certificate](../../certificate-manager/concepts/imported-certificate.md) from {{ certificate-manager-name }} to be used for TLS termination.

