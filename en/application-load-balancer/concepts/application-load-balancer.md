# Load balancers

A load balancer is used to receive incoming traffic and transmit it to the backend endpoints. Requests are routed based on the settings of load balancer [listeners](#listener). Settings for transmitting traffic to backends are configured in [backend groups](backend-group.md).

The load balancer stores a list of endpoints, which accept traffic, and disables TLS encryption before sending the traffic to backends. Load balancer supports modern TLS versions (TLSv1.2, TLSv1.3) and encryption methods. If the load balancer is going to serve multiple domains, you can configure individual certificates and [HTTP routers](http-router.md) for each domain by using the TLS SNI mechanism.

For convenience and security, you can use the load balancer in combination with {{ certificate-manager-full-name }} to store your TLS certificates. You can also use {{ monitoring-full-name }} services to monitor request processing.

## Security groups {#security-groups}

When creating a load balancer, you need to specify [security groups](../../vpc/concepts/security-groups.md) as they contain rules the load balancer uses to receive incoming traffic and send it to backend VMs. Each VM also has security groups assigned to it.

For the load balancer to work correctly:

* The load balancer security groups must allow:
  * Receiving external incoming traffic on the ports specified in the [listener](#listener), e.g., for HTTP(S) traffic: TCP connections on ports `80` and `443` from any address (CIDR: `0.0.0.0/0`).
  * Receiving incoming traffic to health check load balancer nodes in different [availability zones](../../overview/concepts/geo-scope.md): TCP connections on port `30080` with the `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` source.
  * Sending traffic to backend VMs, i.e., VMs whose IP addresses are included in [target groups](target-group.md). For example, any outgoing connections to internal VM addresses (any protocol, full port range, CIDR: `<VM_internal_IP_address>/32`).

  {% include [security-groups-note](../_includes_service/security-groups-note.md) %}

* Backend VM security groups must allow incoming traffic from the load balancer on the ports specified in the [backend groups](backend-group.md), e.g., any incoming connections from subnets [hosting the load balancer](#lb-location) or from at least one of its security groups.

For information on how to configure security groups for the ingress controller and Gateway API, see [{#T}](../tools/k8s-ingress-controller/security-groups.md).

## Load balancer location and its internal IP addresses {#lb-location}

When creating a load balancer, specify a [network](../../vpc/concepts/network.md) and [subnets](../../vpc/concepts/network.md#subnet) in the [availability zones](../../overview/concepts/geo-scope.md). Those are the subnets where the load balancer's nodes will be hosted. Application backends will receive traffic from the load balancer nodes in these subnets.

{% include [backend-healthcheck](../../_includes/application-load-balancer/backend-healthcheck.md) %}

See [below](#lcu-scaling-subnet-sizes) to learn what subnet sizes are recommended for load balancers.

You can disable the load balancer in the selected availability zones. In this case, external traffic will no longer be sent to the load balancer nodes in these availability zones. However, the load balancer nodes in other availability zones will continue supplying traffic to backends in the availability zones the load balancer was disabled in, if allowed by the [locality-aware routing](backend-group.md#locality) settings.

You can also [allow or disallow](../operations/manage-zone/allow-and-deny-shift.md) automatic traffic transfer from an availability zone. Such transfer is performed by {{ yandex-cloud }} technicians if one of the zones becomes unavailable. This keeps your services up and running. After the zone is recovered, traffic is routed back to the zones configured for the load balancer.

### Internal IP addresses {#internal-ips}

The load balancer reserves internal IP addresses in the specified networks and assigns addresses to its nodes. These addresses are used for communication between the load balancer nodes and backends. Node IP addresses are shown in the list of internal IP addresses.

To correctly distribute the load across backends, add a permission for incoming traffic from subnets where the load balancer nodes are located:

1. Get the CIDR of each network the load balancer nodes are using.
1. To enable nodes to freely communicate with backends, add these CIDRs to the list of allowed sources.

> For example, the load balancer uses subnets with CIDRs `10.0.1.0/24` and `10.0.2.0/24`, and backends receive traffic on port `8080`. In which case you will need two [rules](../../vpc/concepts/security-groups.md#security-groups-rules) to allow traffic from the load balancer nodes:
> 
> | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
> | --- | --- | --- | --- | --- |
> | Inbound | `8080` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.0.1.0/24` |
> | Inbound | `8080` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.0.2.0/24` |

## Autoscaling and resource units {#lcu-scaling}

An internal group of VM instances called _resource units_ is created in each availability zone of the load balancer. 

{% include [lcu-thresholds](../../_includes/application-load-balancer/lcu-thresholds.md) %}

{#lcu-scaling-example}
> As an example, let's take a look at the following load:
>
> {% include [lcu-example](../../_includes/application-load-balancer/lcu-example.md) %}
>
> This workload requires **eight resource units** to process:
>
> {% include [lcu-example-amounts](../../_includes/application-load-balancer/lcu-example-amounts.md) %}

By default, the minimum number of resource units per availability zone is 2. You can increase it in the autoscaling settings. For more information, see [below](#lcu-scaling-settings).

The number of resource units affects the cost of using the load balancer. For more information, see [{#T}](../pricing.md).


### Autoscaling settings {#lcu-scaling-settings}

In the load balancer settings, you can specify the following:

The minimum number of resource units per availability zone

: If you expect higher loads on the load balancer, you can increase the minimum number of resource units per zone in advance to avoid waiting for it to increase following the load.

  The default minimum is 2. You cannot set a limit lower than 2 resource units per zone.

Maximum total number of resource units

: The cost of using the load balancer depends on the number of its resource units (see the [relevant pricing policy](../pricing.md)). By default, it is unlimited. You can set a limit to control your expenses.

  If the specified minimum is too low for the actual load on the load balancer, it may run incorrectly.

  Make sure this value is no less than the number of load balancer availability zones multiplied by the minimum number of resource units per zone.

You can set autoscaling for a group of resource units of your load balancer when [creating](../operations/application-load-balancer-create.md) or [updating](../operations/application-load-balancer-update.md) it.


### Recommended subnet sizes {#lcu-scaling-subnet-sizes}

For {{ alb-name }} to provide load balancer availability as specified in the [service level agreement](https://yandex.com/legal/cloud_sla_apploadbalancer/), load balancer subnets must have a sufficient number of [internal IP addresses](../../vpc/concepts/address.md#internal-addresses) available. We recommend sizing the subnets to have at least two free IPs per each [resource unit](../pricing.md) at peak load.

> For example, if a load balancer uses eight resource units in each availability zone, as shown in this [example](#lcu-scaling-example), each subnet should have at least 8 × 2 = 16 free addresses. For the load balancer, we recommend specifying subnets at least /27 in size.

## Listener {#listener}

The listener determines the ports, addresses, and protocols the load balancer will accept traffic on.

Some incoming ports, such as port 22, are reserved for service purposes and you cannot use them.

Request routing to [backend groups](backend-group.md) depends on the _listener type_:

* **{{ ui-key.yacloud.alb.label_listener-type-http }}**: Load balancer accepts HTTP or HTTPS requests and distributes them across backend groups based on the rules set in [HTTP routers](http-router.md), or redirects HTTP requests to HTTPS. Backend groups receiving traffic must have the **{{ ui-key.yacloud.alb.label_proto-http }}** or **{{ ui-key.yacloud.alb.label_proto-grpc }}** [type](backend-group.md#group-type). For **{{ ui-key.yacloud.alb.label_listener-type-http }}** listeners, [{{ monitoring-full-name }}](../../monitoring/) calculates and displays the [request statistics](#stats).
* **{{ ui-key.yacloud.alb.label_listener-type-stream }}**: Load balancer accepts incoming traffic via unencrypted or encrypted TCP connections and routes it to **{{ ui-key.yacloud.alb.label_proto-stream }}** backend groups. For **{{ ui-key.yacloud.alb.label_listener-type-stream }}** listeners, the system does not collects statistics on individual HTTP requests, so {{ monitoring-name }} does not display their error or access metrics.

If encrypted traffic is accepted, the _main listener_ and optional _SNI listeners_ are set up for the load balancer. In each SNI listener, the domain name specified as [Server Name Indication](https://{{ lang }}.wikipedia.org/wiki/Server_Name_Indication) (SNI) when establishing a TLS connection is mapped to a TLS certificate and HTTP router (if the listener type is **{{ ui-key.yacloud.alb.label_listener-type-http }}**) or a backend group (if the listener type is **{{ ui-key.yacloud.alb.label_listener-type-stream }}**). The main listener is responsible for TLS connections with domain names that do not match any SNI listener.

{% note tip %}

Some browsers reuse TLS connections with the same IP address if a connection certificate contains the necessary domain name. In this case, no new SNI match is selected and traffic may be routed to an inappropriate HTTP router. Use different certificates in different SNI listeners and the main listener. To distribute traffic across the domain names of a single certificate, set up HTTP router virtual hosts.

{% endnote %}

One load balancer can serve both regular and encrypted traffic on different ports and have public and internal IP addresses on different listeners.

### Example {#listener-example}

The listener can accept HTTP traffic on port 80 and redirect traffic to HTTPS port 443. The listener gets an HTTP request from a client and returns a response with HTTP code 302. Further requests will be accepted at port 443 via HTTPS.

If an HTTPS listener is used, specify a [certificate](../../certificate-manager/concepts/imported-certificate.md) from {{ certificate-manager-name }} that will be used to terminate TLS connections.

## Statistics {#stats}

{% note info %}

For **{{ ui-key.yacloud.alb.label_listener-type-stream }}** listeners, the system does not collect statistics on individual HTTP requests.

{% endnote %}

Load balancer statistics are automatically logged in the [{{ monitoring-full-name }}](../../monitoring/) metrics. The following dashboards and measures are available:

* **HTTP statistics**:

  * **RPS**: Number of load balancer requests per second.
  * **4XX**, **5XX**: Number of load balancer responses containing HTTP codes 4XX and 5XX and the [corresponding gRPC codes](../../api-design-guide/concepts/errors.md#error-list) per second.
  * **Request size**: Total volume of load balancer requests per second.
  * **Response size**: Total volume of load balancer responses per second.
  * **Latency**: Response delay (the time between the balancer receiving the first byte of a request to sending the last byte of the response), 50th to 99th percentiles.

* **Capacity statistics**:

  * **Active connections**: Number of active connections.
  * **Connections per second**: Number of connections per second.
  * **Requests per second**: Number of requests per second.
  * **Bytes per second**: Amount of data handled per second.

For a full list of metrics delivered to {{ monitoring-full-name }}, see the [reference](../metrics.md).

{{ alb-name }} has aggregate load balancer statistics available. In {{ monitoring-name }}, you can view statistics itemized by the resources associated with the load balancer (HTTP routers, virtual hosts, routes, and the like) as well as [create alerts](../../monitoring/operations/alert/create-alert.md).

For instructions on viewing statistics, see [{#T}](../operations/application-load-balancer-get-stats.md).

## Logging {#logging}

You can [configure](../operations/application-load-balancer-manage-logs.md) the delivery of load balancer logs to a {{ cloud-logging-full-name }} [log group](../../logging/concepts/log-group.md).

For more information on how to view logs, see [{#T}](../operations/application-load-balancer-get-logs.md).

You can find the full list of logged parameters in the [log reference](../logs-ref.md).

You can also [send load balancer logs to a PostgreSQL DB](../tutorials/logging.md).

### Log discard rules {#discard-logs-rules}

Writing and storing logs in {{ cloud-logging-name }} is charged based on the service [pricing rules](../../logging/pricing.md#prices). To log less data, add log discard rules.

Possible rules:

#|
|| **Rule** | **Value** ||
||**HTTP codes**
|
* `100`: Continue
* `101`: Switching Protocol
* `102`: Processing
* `200`: OK
* `201`: Created
* `202`: Accepted
* `203`: Non Authoritative Information
* `204`: No Content
* `205`: Reset Content
* `206`: Partial Content
* `207`: Multi-Status
* `300`: Multiple Choices
* `301`: Moved Permanently
* `302`: Found
* `303`: See Other
* `304`: Not Modified
* `305`: Use Proxy
* `307`: Temporary Redirect
* `308`: Permanent Redirect
* `400`: Bad Request
* `401`: Unauthorized
* `402`: Payment Required
* `403`: Forbidden
* `404`: Not Found
* `405`: Method Not Allowed
* `406`: Not Acceptable
* `407`: Proxy Authentication Required
* `408`: Request Timeout
* `409`: Conflict
* `410`: Gone
* `411`: Length Required
* `412`: Precondition Failed
* `413`: Request Entity Too Large
* `414`: Request-URI Too Long
* `415`: Unsupported Media Type
* `416`: Requested Range Not Satisfiable
* `417`: Expectation Failed
* `418`: I'm a teapot
* `419`: Insufficient Space on Resource
* `420`: Method Failure
* `422`: Unprocessable Entity
* `423`: Locked
* `424`: Failed Dependency
* `428`: Precondition Required
* `429`: Too Many Requests
* `431`: Request Header Fields Too Large
* `451`: Unavailable For Legal Reasons
* `500`: Internal Server Error
* `501`: Not Implemented
* `502`: Bad Gateway
* `503`: Service Unavailable
* `504`: Gateway Timeout
* `505`: HTTP Version Not Supported
* `507`: Insufficient Storage
* `511`: Network Authentication Required||
||**HTTP code classes**
|
* `1XX`
* `2XX`
* `3XX`
* `4XX`
* `5XX`
* `ALL`||
||**gRPC codes**
|
* `GRPC_OK`
* `GRPC_CANCELLED`
* `GRPC_UNKNOWN`
* `GRPC_INVALID_ARGUMENT`
* `GRPC_DEADLINE_EXCEEDED`
* `GRPC_NOT_FOUND`
* `GRPC_ALREADY_EXISTS`
* `GRPC_PERMISSION_DENIED`
* `GRPC_UNAUTHENTICATED`
* `GRPC_RESOURCE_EXHAUSTED`
* `GRPC_FAILED_PRECONDITION`
* `GRPC_ABORTED`
* `GRPC_OUT_OF_RANGE`
* `GRPC_UNIMPLEMENTED`
* `GRPC_INTERNAL`
* `GRPC_UNAVAILABLE`||
|#

## Use cases {#examples}

* [{#T}](../tutorials/virtual-hosting.md)
* [{#T}](../tutorials/alb-with-ddos-protection/index.md)
* [{#T}](../tutorials/balancer-with-sws-profile/index.md)
* [{#T}](../tutorials/migration-from-nlb-to-alb/index.md)
* [{#T}](../tutorials/alb-ingress-controller.md)
* [{#T}](../tutorials/application-load-balancer-website/console.md)
* [{#T}](../tutorials/custom-health-checks.md)
* [{#T}](../tutorials/logging.md)
* [{#T}](../tutorials/alb-ingress-controller-log-options.md)