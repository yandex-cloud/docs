* **Name** of the backend.
* **Weight**: The relative weight of the backend when distributing traffic. If the option is disabled in the field, the backend endpoints won't receive any traffic (the weight will be equal to 0).
* **Type** of the backend (for an HTTP backend group): `Target group` ( {{ alb-name }} [target groups](../../application-load-balancer/concepts/target-group.md)) or `Bucket` ({{ objstorage-name }} [bucket](../../storage/concepts/bucket.md)). For a gRPC or Stream backend group, the type of any backend is `Target group`. For more information about backend types, see [{#T}](../../application-load-balancer/concepts/backend-group.md#types).

The settings described below are only applicable to backends of the **Target group** type.

* Under **Load balancing settings**:

   * **Balancing mode**: [Mode for distributing traffic](../../application-load-balancer/concepts/backend-group.md#balancing-mode) across backend endpoints.
   * **Panic mode threshold**: Percentage of healthy endpoints for enabling [panic mode](../../application-load-balancer/concepts/backend-group.md#panic-mode): the load balancer will distribute requests across all endpoints, regardless of health check results.
   * **Locality aware routing**: Percentage of incoming traffic that a load balancer node routes to the backends from its availability zone. The rest traffic is evenly distributed between other availability zones. For more information, see [{#T}](../../application-load-balancer/concepts/backend-group.md#locality).
   * **Strict locality**: If this option is enabled, the load balancer will respond with an error (`503 Service Unavailable`) if no application backends are running in the availability zone that accepted the request.

* Under **Protocol settings**:

   * For an `HTTP` backend group:

      * **HTTP/2**: Option to use HTTP/2 when routing requests to the backend of an `HTTP` backend group. By default, the protocol version is 1.1. Backend groups of the `gRPC` type only support HTTP/2 connections.
      * **Protocol**: Backend connection protocol: `HTTP` (without encryption) or `HTTPS` (with TLS encryption). For `HTTPS`, specify:

         * **SNI**. Host domain name for Server Name Indication, an extension to the TLS protocol.
         * **Trusted CA certificate**. Specify a certificate from the certificate authority that the load balancer will trust when establishing a secure connection with backend endpoints. X.509 certificates in PEM format are supported.

   * For a `gRPC` backend group:

      * **Protocol**: The backend connection protocol: `Open` or `Encrypted`. For the encrypted protocol, set the **SNI** and **Trusted CA certificate** (see above).

   * For a `Stream` backend group:

      * **PROXY protocol**: If this option is enabled, the load balancer will pass metadata about its connection with the client, including the IP address, to the backend over [PROXY protocol from HAProxy](https://www.haproxy.org/download/1.9/doc/proxy-protocol.txt).

      * **Protocol**: The backend connection protocol: `Open` or `Encrypted`. For the encrypted protocol, set the **SNI** and **Trusted CA certificate** (see above).

* Under **HTTP health check**, **gRPC health check**, or **Stream health check**:

   * **Timeout**: Response waiting time.
   * **Interval**: Interval for sending check requests.
   * **Healthy threshold**: The number of consecutive successful checks at which the endpoint is considered healthy. Ignored when the load balancer has just started: one health check is enough.
   * **Unhealthy threshold**: The number of consecutive failed checks at which the endpoint is considered unhealthy. Ignored if the backend has responded with the `503 Service Unavailable` HTTP status code once: it's considered unhealthy immediately.
   * **Port**.
   * **Type**: The protocol to use for health checks: `HTTP`, `gRPC`, or `Stream`. The check type may be the same as the backend group type. Also specify:

      * For the `HTTP` type:

         * **Path**: Path in the URI of a request to the endpoint.
         * **Authority**: The value of the `Host` header for HTTP/1.1 or the `:authority` pseudo-header for HTTP/2 to be passed to the backend endpoints during health checks.
         * **HTTP/2**: The option to use HTTP v.2.

      * For the `gRPC` type:

         * **Service name**: The name of the gRPC service to check. If no service is specified, the backend's general health is checked.

      * For the `Stream` type:

         * **Send**: Data to be sent to the endpoint for a health check.
         * **Receive**: Data to be received from the endpoint for it to pass the health check.

   For more information, see [{#T}](../../application-load-balancer/concepts/backend-group.md#health-checks).

   To add a health check, click **Add health check** at the bottom of the backend section and specify the check settings.

   To remove a health check, click ![image](../../_assets/horizontal-ellipsis.svg) next to the **HTTP health check**, **gRPC health check**, or **Stream health check** title and select **Delete**.