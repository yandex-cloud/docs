# {{ alb-full-name }} log reference

This section describes L7 load balancer log fields. 

The load balancer provides logs in JSON format. Each log entry corresponds to one client request processed by the load balancer. 

For more information, see [Logging](./concepts/application-load-balancer.md#logging).

Field | Description
---- | ----
`type` | Request type. The possible values are: <ul><li>`http`: HTTP/1.0 or HTTP/1.1 without encryption.</li><li>`https`: HTTP/1.0 or HTTP/1.1 with TLS encryption, i.e., HTTPS or HTTP over TLS.</li><li>`h2`: HTTP/2.</li><li>`h3`: HTTP/3.</li><li>`grpc`: gRPC without encryption.</li><li>`grpcs`: gRPC with TLS encryption.</li></ul>
`time` | Date and time when the load balancer received the first byte of the client request in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format, i.e., `<YYYY>-<MM>-<DD>T<hh>:<mm>:<ss>Z`, where `Z` is the universal coordinated time (UTC).
`http_method` | HTTP request method.
`authority` | For HTTP/1.0 and HTTP/1.1: `Host` header value. For other supported protocols: `:authority` pseudo-header value.
`request_uri` | Request path. For example, `/api/v1/foo`.
`http_status` | HTTP status code
`http_version` | HTTP version, e.g., `HTTP/2`
`rewritten_request_uri` | Request path after HTTP router's [route](./concepts/http-router.md#routes) substitution, e.g., `/api/backend/v1/foo`
`request_content_type` | HTTP request `Content-Type` header value
`request_id` | HTTP request `X-Request-ID` header value
`user_agent` | HTTP request `User-Agent` header value identifying the client’s software
`referer` | HTTP request `Referer` header value identifying the URL from which the request originates 
`response_content_type` | Load balancer HTTP response `Content-Type` header value
`client_ip` | Client IP address
`client_port` | The source TCP port of the client-side connection to the load balancer
`backend_ip` | Internal [backend](./concepts/backend-group.md) endpoint, e.g., a [target group](./concepts/target-group.md) VM or [{{ objstorage-name }}](../storage/concepts/bucket.md) bucket, IP address
`backend_port` | Backend port used by the load balancer for establishing connections
`load_balancer_id` | Load balancer ID
`http_router_id` | [HTTP router](./concepts/http-router.md) ID
`virtual_host_name` | [Virtual host](./concepts/http-router.md#virtual-host) name
`route_name` | [Route](./concepts/http-router.md#routes) name
`backend_group_id` | [Backend group](./concepts/backend-group.md) ID
`backend_name` | Backend name
`request_headers_bytes` | Request header total size in bytes
`request_body_bytes` | Request body size in bytes
`response_headers_bytes` | Response header total size in bytes
`response_body_bytes` | Response body size in bytes
`error_details` | Load balancer error during request processing. The possible values are: <ul><li>`no_healthy_backend`: No healthy backends. For more information, see [Health checks](./concepts/backend-group.md#health-checks).</li><li>`backend_request_timeout`: Backend request timeout specified in the route settings was triggered.</li><li>`balancer_reset`: Connection between client and load balancer was reset.</li><li>`backend_connection_closed_before_data_sent_to_client`: Load balancer backend connection was reset.</li><li>`failed_to_connect_to_backend`: Load balancer failed to connect to the backend.</li><li>`backend_connection_terminated`: Backend terminated the connection with the load balancer.</li><li>`no_route`: Client's request matches no configured routes in load balancer HTTP routers.</li><li>`client_disconnected`: Client terminated the connection with the load balancer.</li><li>`backend_stream_idle_timeout`: No data transmitted over the load balancer backend connection for longer than the route’s configured inactivity timeout period.</li><li>`backend_retry_limit_exceeded`: Load balancer exceeded maximum backend connection attempts.</li><li>`client_protocol_error`: Client protocol error.</li></ul>
`tls_version` | TLS version, e.g., `TLSv1.3`
`cipher_suite` | TLS encryption ciphers for load balancer client connections
`sni_hostname` | SNI (Server Name Indication) domain name sent to the load balancer by the client during the TLS handshake
`server_certificate_subject` | Domain name specified in the Subject field of the TLS certificate presented by the load balancer to the client
`grpc` | gRPC request information. This field appears in the response for gRPC requests, e.g., `"type": "grpc"` or `"type": "grpcs"`, only.
&ensp; `method` | gRPC request method
&ensp; `service` | gRPC service name
&ensp; `status` | gRPC request status
&emsp;&emsp; `code` | gRPC error code. For more information on gRPC to HTTP status code mapping, see the [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto) article.
&emsp;&emsp; `message` | gRPC error description
`upstream_transport_failure_reason` | Message describing the transport layer error that occured during the load balancer backend connection, e.g., TLS connection
`request_processing_times` | Request processing times. All values are specified in seconds.
&ensp; `request_time` | Total request time
&ensp; `response_start_time` | Latency between the load balancer receiving the first request byte from the client and sending the first response byte back
&ensp; `request_processing_time` | Latency between the load balancer receiving the first request byte from the client and sending the first byte to the backend
&ensp; `backend_processing_time` | Latency between the load balancer sending the first byte to the backend and receiving the first response byte
&ensp; `response_processing_time` | Latency between the load balancer receiving the first byte from the backend and sending the first byte to the client
&ensp; `request_rx_time` | Latency between the load balancer receiving the first and last bytes of the client’s request
&ensp; `request_tx_time` | Latency between the backend receiving the first and last bytes of the load balancer’s request
&ensp; `backend_response_time` | Latency between the load balancer sending the last request byte to the backend and receiving the first response byte
&ensp; `response_rx_time` | Latency between the load balancer receiving the first and last bytes of the backend response
&ensp; `response_tx_time` | Latency between the load balancer sending the first and last bytes of the response
`x_forwarded_for` | [X-Forwarded-For](https://en.wikipedia.org/wiki/X-Forwarded-For) (XFF) request header containing the originating `client_ip` followed by all intermediate proxy/LB IP addresses the request traversed. For example:<ul><li>`x_forwarded_for: 50.0.0.1` shows that the request came from the client directly, with its `client_ip` added to the header by {{ alb-name }}.</li><li>Conversely, `x_forwarded_for: 50.0.0.1,40.0.0.1` shows that the request passed through a proxy server, with its IP address added after `client_ip` by {{ alb-name }}.</li></ul>