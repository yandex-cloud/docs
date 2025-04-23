* Backend **{{ ui-key.yacloud.common.name }}**.
* **{{ ui-key.yacloud.alb.label_backend-weight }}**: Backend weight in traffic distribution. If this option is disabled, the backend weight will be 0 and its endpoints will not be receiving traffic.
* Backend **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.alb.label_target-group }}` for {{ alb-name }} [target groups](../../application-load-balancer/concepts/target-group.md) or `{{ ui-key.yacloud.alb.label_bucket }}` for {{ objstorage-name }} [buckets](../../storage/concepts/bucket.md). This option works for `{{ ui-key.yacloud.alb.label_proto-http-plain }}` backend groups only. `{{ ui-key.yacloud.alb.label_proto-grpc }}` and Stream group backends have the `{{ ui-key.yacloud.alb.label_target-group }}` backend type. For more information about backend types, see [{#T}](../../application-load-balancer/concepts/backend-group.md#types).

* The settings described below only work for **{{ ui-key.yacloud.alb.label_target-group }}** backends:

  * Under **{{ ui-key.yacloud.alb.label_lb-settings }}**:
    
    * **{{ ui-key.yacloud.alb.label_load-balancing-mode }}**: [Load balancing mode](../../application-load-balancer/concepts/backend-group.md#balancing-mode).
    * **{{ ui-key.yacloud.alb.label_panic-threshold }}**: Healthy endpoint threshold triggering [panic mode](../../application-load-balancer/concepts/backend-group.md#panic-mode) when the load balancer distributes requests across all endpoints, regardless of their health status.
    * **{{ ui-key.yacloud.alb.label_locality-aware-routing }}**: Share of incoming traffic the load balancer node will route to its availability zone backends. The remaining traffic will be evenly distributed across other availability zones. To learn more, see [{#T}](../../application-load-balancer/concepts/backend-group.md#locality).
    * **{{ ui-key.yacloud.alb.label_strict-locality }}**: If this option is enabled, the load balancer will return `503 Service Unavailable` if no application backends are operational in the request’s originating availability zone.
 
  * Under **{{ ui-key.yacloud.alb.label_protocol-settings }}**:
    
    * For a `{{ ui-key.yacloud.alb.label_proto-http }}` backend group:
      
      * **{{ ui-key.yacloud.alb.label_use-http2 }}**: With this option enabled, the load balancer will use the HTTP/2 protocol when routing requests to `{{ ui-key.yacloud.alb.label_proto-http }}` group backends. By default, the load balancer uses the HTTP/1.1 protocol. `{{ ui-key.yacloud.alb.label_proto-grpc }}` backend groups only support the HTTP/2 protocol.
      * **{{ ui-key.yacloud.alb.label_protocol }}**: Backend connection protocol, e.g., `{{ ui-key.yacloud.alb.label_proto-http-plain }}` without encryption or `{{ ui-key.yacloud.alb.label_proto-http-tls }}` with TLS encryption. For `{{ ui-key.yacloud.alb.label_proto-http-tls }}`, specify:
        
        * **{{ ui-key.yacloud.alb.label_sni }}**. SNI domain name for TLS connections.
        * **{{ ui-key.yacloud.alb.label_trusted-ca }}**. Specify the [root CA](https://en.wikipedia.org/wiki/Root_certificate) for the certificate chain installed on backend endpoints. You can use [X.509](https://en.wikipedia.org/wiki/X.509) certificates in [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail) format.
    
    * For a `{{ ui-key.yacloud.alb.label_proto-grpc }}` backend group:

      * **{{ ui-key.yacloud.alb.label_protocol }}**: Backend connection protocol, e.g., `{{ ui-key.yacloud.alb.label_proto-grpc-plain }}` or `{{ ui-key.yacloud.alb.label_proto-grpc-tls }}`. For the encrypted protocol, specify **{{ ui-key.yacloud.alb.label_sni }}** and **{{ ui-key.yacloud.alb.label_trusted-ca }}** as shown above.
    
    * For a `{{ ui-key.yacloud.alb.label_proto-stream }}` backend group:
      
      * **{{ ui-key.yacloud.alb.label_enable-proxy-protocol }}**: With this option enabled, the load balancer will send its client connection metadata, e.g. its IP address, to the backend via [HAProxy](https://www.haproxy.org/download/1.9/doc/proxy-protocol.txt) protocol.
        
      * **{{ ui-key.yacloud.alb.label_protocol }}**: Backend connection protocol, e.g., `{{ ui-key.yacloud.alb.label_proto-grpc-plain }}` or `{{ ui-key.yacloud.alb.label_proto-grpc-tls }}`. For the encrypted protocol, specify **{{ ui-key.yacloud.alb.label_sni }}** and **{{ ui-key.yacloud.alb.label_trusted-ca }}** as shown above.

* The following settings only work for **{{ ui-key.yacloud.alb.label_bucket }}** backends in **{{ ui-key.yacloud.alb.label_proto-http }}** backend groups:

  * **{{ ui-key.yacloud.mdb.forms.config_field_form-bucket-type }}**: `{{ ui-key.yacloud.forms.label_form-list }}` or `{{ ui-key.yacloud.forms.label_form-id }}`.
  * **{{ ui-key.yacloud.alb.label_bucket }}**: Select a bucket from the list or specify its ID.

* Under **HTTP health check**, **gRPC health check**, or **Stream health check** specify:
  
  * **{{ ui-key.yacloud.alb.label_timeout }}**: Response timeout. Maximum connection time.
  * **{{ ui-key.yacloud.alb.label_interval }}**: Health check request interval.
  * **{{ ui-key.yacloud.alb.label_healthy }}**: Number of consecutive successful checks required before considering the endpoint healthy. The load balancer ignores this setting at start, conducting one health check to identify the endpoint as healthy.
  * **{{ ui-key.yacloud.alb.label_unhealthy }}**: Number of consecutive failed checks required before considering the endpoint unhealthy. The load balancer ignores this setting when receiving `503 Service Unavailable` from a backend, following which it is considered unhealthy right away.
  * **{{ ui-key.yacloud.alb.label_port }}**.
  * **{{ ui-key.yacloud.common.type }}**: Health check protocol, e.g., `{{ ui-key.yacloud.alb.label_hc-type-http }}`, `{{ ui-key.yacloud.alb.label_hc-type-grpc }}`, or `{{ ui-key.yacloud.alb.label_hc-type-stream }}`. The health check protocol does not need to match the backend group type. Depending on the selected protocol, specify:
    
    * For the `{{ ui-key.yacloud.alb.label_hc-type-http }}` type:
      
      * **{{ ui-key.yacloud.alb.label_path }}**: Endpoint request URI path.
      * **{{ ui-key.yacloud.alb.label_hc_host }}**: HTTP/1.1 `Host` or HTTP/2 `:authority` header of the backend endpoint health check requests.
      * **{{ ui-key.yacloud.alb.label_use-http2 }}**: Use HTTP v2 protocol.
      * **{{ ui-key.yacloud.alb.label_expected-statuses }}**: HTTP status codes deemed valid during a backend health check.
     
    * For the `{{ ui-key.yacloud.alb.label_hc-type-grpc }}` type:
      
      * **{{ ui-key.yacloud.alb.label_service-name }}**: Name of the gRPC service you want to check. If no service is specified, the system will check the backend overall health.
     
    * For the `{{ ui-key.yacloud.alb.label_hc-type-stream }}` type:
      
      * **{{ ui-key.yacloud.alb.label_send }}**: Data sent to the endpoint for a health check.
      * **{{ ui-key.yacloud.alb.label_receive }}**: Data the endpoint must return to pass the health check.
      
  {% include [backend-healthcheck](backend-healthcheck.md) %}

  To add a health check, at the bottom of the backend section, click **{{ ui-key.yacloud.alb.button_add-healthcheck }}** and specify the check settings.

  To remove a health check, click ![image](../../_assets/console-icons/ellipsis.svg) next to the **HTTP health check**, **gRPC health check**, or **Stream health check** title, and select **{{ ui-key.yacloud.common.delete }}**.
