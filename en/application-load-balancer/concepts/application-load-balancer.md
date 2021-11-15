# Load balancers

A load balancer is used for receiving incoming traffic and transmitting it to the backend endpoints. Request routing follows the rules defined in the [HTTP routers](http-router.md) connected to the load balancer's [listeners](#listener). Settings for transmitting traffic to backends are configured in [backend groups](backend-group.md).

The load balancer stores a list of endpoints, which accept traffic and disables TLS encryption before sending the traffic to backends. Load balancer supports modern TLS versions (TLSv1.2, TLSv1.3) and encryption methods. If the load balancer is going to serve multiple domains, you can configure individual certificates and [HTTP routers](http-router.md) for each domain by using the TLS SNI mechanism.

For convenience and security, you can use the load balancer together with {{ certificate-manager-full-name }} to store your TLS certificates. You can also use {{ monitoring-full-name }} services to monitor request processing.

## Security groups {#security-groups}

{% include [security-groups-note](../_includes_service/security-groups-note.md) %}

When you create a load balancer, specify [security groups](../../vpc/concepts/security-groups.md) as they contain a set of rules for the load balancer to receive incoming traffic and send it to backend VMs. Security groups are also assigned to each VM.

For the load balancer to work correctly:

* The load balancer's security groups must allow:
  * Receiving external incoming traffic on the ports specified in [the listener](#listener). For example, for HTTP(S) traffic: TCP connections on ports `80` and `443` from any address (CIDR — `0.0.0.0/0`).
  * Receiving incoming traffic to check the status of the load balancer's nodes in different [availability zones](../../overview/concepts/geo-scope.md): TCP connections on port `30080` from IP addresses in ranges `198.18.235.0/24` and `198.18.248.0/24`.
  * Sending traffic to backend VMs. For example, any outgoing connections to internal addresses of virtual machines (CIDR — `<internal IP of VM>/32`), to [subnets](../../vpc/concepts/network.md#subnet), or security groups containing VMs.
* Backend VM security groups must allow incoming traffic from the load balancer on the ports specified in the [backend groups](backend-group.md). For example, any incoming connections from subnets that host [the load balancer](#lb-location) or from one of its security groups.

## Host load balancer {#lb-location}

When you create a load balancer, specify a [network](../../vpc/concepts/network.md) and [subnets](../../vpc/concepts/network.md#subnet) in three [availability zones](../../overview/concepts/geo-scope.md). Those are the subnets where the load balancer's nodes will be hosted. Application backends will receive traffic from the load balancer nodes in these subnets.

You can disable the load balancer in the selected availability zones. In this case, external traffic will no longer be sent to the load balancer nodes in these availability zones. However, the load balancer's nodes in other availability zones will continue delivering traffic to backends in the availability zones where the load balancer was disabled if permitted by the [locality aware routing](backend-group.md#locality) settings.

## Listener {#listener}

The listener determines the ports, addresses, and protocols the load balancer will accept traffic on. The listener passes traffic to the application's backends based on the routing rules set in the [HTTP router](http-router.md). One load balancer can serve both regular and encrypted traffic on different ports and have public and internal IP addresses on different listeners.

### Example {#listener-example}

The listener can accept HTTP traffic on port 80 and redirect traffic to HTTPS port 443. The listener gets an HTTP request from a client and returns a response with HTTP code 302. Further requests will be accepted at port 443 via HTTPS.

If an HTTPS listener is used, make sure to specify a [certificate](../../certificate-manager/concepts/imported-certificate.md) from {{ certificate-manager-name }} to be used for TLS termination.

## Logging {#logging}

When creating a load balancer, a log group is created for it in {{ cloud-logs-full-name }}. This log group is used to write messages about incoming requests. You can view the logs in the management console. A complete list of parameters is shown in the [log reference](../logs-ref.md).

You can set up log processing using {{ sf-full-name }}. To do this, create a [trigger for {{ cloud-logs-name }}](../../functions/concepts/trigger/cloudlogs-trigger.md) with the log group ID and the [function](../../functions/concepts/function.md) to be called by the trigger and including the message processing logic.

{% note warning %}

Currently, to get the load balancer's log group ID and [create a trigger](../../functions/operations/trigger/cloudlogs-trigger-create.md) with this ID, you can only use the [CLI](../../cli/index.yaml) or the API from {{ yandex-cloud }}.

{% endnote %}

For an example of log processing, see the use case [{#T}](../solutions/logging.md).

