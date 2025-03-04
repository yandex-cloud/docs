* Backend **{{ ui-key.yacloud.common.name }}**.
* **{{ ui-key.yacloud.alb.label_backend-weight }}**: Backend relative weight when distributing traffic. If the option is disabled in the field, the backend endpoints will not receive any traffic (weight will be equal to 0).
* Backend **{{ ui-key.yacloud.common.type }}** (for an `{{ ui-key.yacloud.alb.label_proto-http-plain }}` backend group): `{{ ui-key.yacloud.alb.label_target-group }}` ({{ alb-name }} [target groups](../../application-load-balancer/concepts/target-group.md)) or `{{ ui-key.yacloud.alb.label_bucket }}` ({{ objstorage-name }} [bucket](../../storage/concepts/bucket.md)). For a `{{ ui-key.yacloud.alb.label_proto-grpc }}` or Stream backend group, the type of any backend is `{{ ui-key.yacloud.alb.label_target-group }}`. For more information about backend types, see [{#T}](../../application-load-balancer/concepts/backend-group.md#types).

* The settings described below are only applicable to backends of the **{{ ui-key.yacloud.alb.label_target-group }}** type:

  * Under **{{ ui-key.yacloud.alb.label_lb-settings }}**:
    
    * **{{ ui-key.yacloud.alb.label_load-balancing-mode }}**: [Mode for distributing traffic](../../application-load-balancer/concepts/backend-group.md#balancing-mode) across backend endpoints.
    * **{{ ui-key.yacloud.alb.label_panic-threshold }}**: Percentage of healthy endpoints for enabling [panic mode](../../application-load-balancer/concepts/backend-group.md#panic-mode): the load balancer will distribute requests across all endpoints, regardless of health check results.
    * **{{ ui-key.yacloud.alb.label_locality-aware-routing }}**: Percentage of incoming traffic that a load balancer node routes to the backends from its availability zone. The remaining traffic is evenly distributed between other availability zones. For more information, see [{#T}](../../application-load-balancer/concepts/backend-group.md#locality).
    * **{{ ui-key.yacloud.alb.label_strict-locality }}**: If this option is enabled, the load balancer will respond with an error (`503 Service Unavailable`) if there are no operating application backends in the availability zone the request was accepted in.
 
  * Under **{{ ui-key.yacloud.alb.label_protocol-settings }}**:
    
    * For a `{{ ui-key.yacloud.alb.label_proto-http }}` backend group:
      
      * **{{ ui-key.yacloud.alb.label_use-http2 }}**: Option to use HTTP/2 when routing requests to the backend of an `{{ ui-key.yacloud.alb.label_proto-http }}` backend group. By default, the protocol version is 1.1. Backend groups of the `{{ ui-key.yacloud.alb.label_proto-grpc }}` type only support HTTP/2 connections.
      * **{{ ui-key.yacloud.alb.label_protocol }}**: Backend connection protocol: `{{ ui-key.yacloud.alb.label_proto-http-plain }}` (without encryption) or `{{ ui-key.yacloud.alb.label_proto-http-tls }}` (with TLS encryption). For `{{ ui-key.yacloud.alb.label_proto-http-tls }}`, specify:
        
        * **{{ ui-key.yacloud.alb.label_sni }}**: Host domain name for Server Name Indication, an extension to the TLS protocol.
        * **{{ ui-key.yacloud.alb.label_trusted-ca }}**: Specify a [root CA](https://en.wikipedia.org/wiki/Root_certificate) for a certificate chain installed on backend endpoints. [X.509](https://en.wikipedia.org/wiki/X.509) certificates in [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail) format are supported.
    
    * For a `{{ ui-key.yacloud.alb.label_proto-grpc }}` backend group:

      * **{{ ui-key.yacloud.alb.label_protocol }}**: Backend connection protocol: `{{ ui-key.yacloud.alb.label_proto-grpc-plain }}` or `{{ ui-key.yacloud.alb.label_proto-grpc-tls }}`. For the encrypted protocol, set **{{ ui-key.yacloud.alb.label_sni }}** and **{{ ui-key.yacloud.alb.label_trusted-ca }}** (see above).
    
    * For a `{{ ui-key.yacloud.alb.label_proto-stream }}` backend group:
      
      * **{{ ui-key.yacloud.alb.label_enable-proxy-protocol }}**: With this option enabled, the load balancer will send metadata about its connection to the client, including its IP, to the backend over the [PROXY protocol from HAProxy](https://www.haproxy.org/download/1.9/doc/proxy-protocol.txt).
        
      * **{{ ui-key.yacloud.alb.label_protocol }}**: Backend connection protocol: `{{ ui-key.yacloud.alb.label_proto-grpc-plain }}` or `{{ ui-key.yacloud.alb.label_proto-grpc-tls }}`. For the encrypted protocol, set **{{ ui-key.yacloud.alb.label_sni }}** and **{{ ui-key.yacloud.alb.label_trusted-ca }}** (see above).

* The settings described below are only applicable to backends of the **{{ ui-key.yacloud.alb.label_bucket }}** type in backend groups of the **{{ ui-key.yacloud.alb.label_proto-http }}** type:

  * **{{ ui-key.yacloud.mdb.forms.config_field_form-bucket-type }}**: Select `{{ ui-key.yacloud.forms.label_form-list }}` or `{{ ui-key.yacloud.forms.label_form-id }}`.
  * **{{ ui-key.yacloud.alb.label_bucket }}**: Select a bucket from the list or specify its ID.

* Under **HTTP health check**, **gRPC health check**, or **Stream health check**:
  
  * **{{ ui-key.yacloud.alb.label_timeout }}**: Response timeout. The maximum period for which a connection can be established.
  * **{{ ui-key.yacloud.alb.label_interval }}**: Interval for sending check requests.
  * **{{ ui-key.yacloud.alb.label_healthy }}**: Number of consecutive successful checks at which the endpoint is considered healthy. It is ignored when the load balancer has just started: one health check is enough.
  * **{{ ui-key.yacloud.alb.label_unhealthy }}**: Number of consecutive failed checks after which the endpoint is considered unhealthy. It is ignored if the backend has responded with the `503 Service Unavailable` HTTP status code once, in which case it is considered unhealthy right away.
  * **{{ ui-key.yacloud.alb.label_port }}**.
  * **{{ ui-key.yacloud.common.type }}**: Protocol to use for health checks: `{{ ui-key.yacloud.alb.label_hc-type-http }}`, `{{ ui-key.yacloud.alb.label_hc-type-grpc }}`, or `{{ ui-key.yacloud.alb.label_hc-type-stream }}`. The check type may be the same as the backend group type. Also specify:
    
    * For the `{{ ui-key.yacloud.alb.label_hc-type-http }}` type:
      
      * **{{ ui-key.yacloud.alb.label_path }}**: Path in the URI of a request to the endpoint.
      * **{{ ui-key.yacloud.alb.label_hc_host }}**: Value of the `Host` header for HTTP/1.1 or the `:authority` pseudo-header for HTTP/2 that will go to the backend endpoints during health checks.
      * **{{ ui-key.yacloud.alb.label_use-http2 }}**: Option to use HTTP v.2.
      * **{{ ui-key.yacloud.alb.label_expected-statuses }}**: List of HTTP status codes that will be considered correct when running the backend health check.
     
    * For the `{{ ui-key.yacloud.alb.label_hc-type-grpc }}` type:
      
      * **{{ ui-key.yacloud.alb.label_service-name }}**: Name of the gRPC service to check. If no service is specified, the backend general health is checked.
     
    * For the `{{ ui-key.yacloud.alb.label_hc-type-stream }}` type:
      
      * **{{ ui-key.yacloud.alb.label_send }}**: Data to send to the endpoint for a health check.
      * **{{ ui-key.yacloud.alb.label_receive }}**: Data to receive from the endpoint for it to pass the health check.
      
  {% include [backend-healthcheck](backend-healthcheck.md) %}

  To add a health check, click **{{ ui-key.yacloud.alb.button_add-healthcheck }}** at the bottom of the backend section and specify the check settings.

  To remove a health check, click ![image](../../_assets/console-icons/ellipsis.svg) next to the **HTTP health check**, **gRPC health check**, or **Stream health check** title, and select **{{ ui-key.yacloud.common.delete }}**.
