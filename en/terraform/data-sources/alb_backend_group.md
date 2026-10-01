---
subcategory: Application Load Balancer
---

# yandex_alb_backend_group (DataSource)

Get information about a Yandex Application Load Balancer Backend Group. For more information, see [official documentation](https://yandex.cloud/docs/application-load-balancer/quickstart).

This data source is used to define [Application Load Balancer Backend Groups](https://yandex.cloud/docs/application-load-balancer/concepts/backend-group) that can be used by other resources.

{% note warning %}

One of `backend_group_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing ALB Backend Group
//
data "yandex_alb_backend_group" "my_alb_bg" {
  backend_group_id = yandex_alb_backend_group.my_backend_group.id
}
```

## Arguments & Attributes Reference

- `backend_group_id` (String). Backend Group ID.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `grpc_backend` [Block]. 
  - `name` (*Read-Only*) (String). 
  - `port` (Number). 
  - `target_group_ids` (*Read-Only*) (List Of String). 
  - `weight` (Number). 
  - `healthcheck` [Block]. 
    - `healthcheck_port` (Number). 
    - `healthy_threshold` (Number). 
    - `interval` (*Read-Only*) (String). 
    - `interval_jitter_percent` (Number). 
    - `timeout` (*Read-Only*) (String). 
    - `unhealthy_threshold` (Number). 
    - `grpc_healthcheck` [Block]. 
      - `service_name` (String). 
    - `http_healthcheck` [Block]. 
      - `expected_statuses` (*Read-Only*) (List Of Number). 
      - `host` (String). 
      - `http2` (Bool). 
      - `path` (*Read-Only*) (String). 
    - `stream_healthcheck` [Block]. 
      - `receive` (String). 
      - `send` (String). 
    - `tls` [Block]. TLS settings for the health check.
      - `sni` (String). Server name indication (SNI) to be sent to the backend.
      - `client_certificate` [Block]. Client certificate to present during TLS handshake.
        - `certificate_id` (String). ID of the client certificate.
      - `validation_context` [Block]. Validation context for the TLS connection.
        - `trusted_ca_bytes` (String). PEM-encoded trusted CA certificate bytes.
        - `trusted_ca_id` (String). ID of the trusted CA certificate.
  - `load_balancing_config` [Block]. 
    - `locality_aware_routing_percent` (Number). 
    - `mode` (String). 
    - `panic_threshold` (Number). 
    - `strict_locality` (Bool). 
  - `tls` [Block]. TLS settings for the backend connection.
    - `sni` (String). Server name indication (SNI) to be sent to the backend.
    - `client_certificate` [Block]. Client certificate to present during TLS handshake.
      - `certificate_id` (String). ID of the client certificate.
    - `validation_context` [Block]. Validation context for the TLS connection.
      - `trusted_ca_bytes` (String). PEM-encoded trusted CA certificate bytes.
      - `trusted_ca_id` (String). ID of the trusted CA certificate.
- `http_backend` [Block]. HTTP backend specification that will be used by the ALB Backend Group
  - `http2` (Bool). Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default.
  - `name` (*Read-Only*) (String). Name of the backend.
  - `port` (Number). Port for incoming traffic.
  - `storage_bucket` (String). Name of bucket which should be used as a backend.
  - `target_group_ids` (List Of String). References target groups for the backend.
  - `weight` (Number). Weight of the backend.
  - `healthcheck` [Block]. 
    - `healthcheck_port` (Number). 
    - `healthy_threshold` (Number). 
    - `interval` (*Read-Only*) (String). 
    - `interval_jitter_percent` (Number). 
    - `timeout` (*Read-Only*) (String). 
    - `unhealthy_threshold` (Number). 
    - `grpc_healthcheck` [Block]. 
      - `service_name` (String). 
    - `http_healthcheck` [Block]. 
      - `expected_statuses` (*Read-Only*) (List Of Number). 
      - `host` (String). 
      - `http2` (Bool). 
      - `path` (*Read-Only*) (String). 
    - `stream_healthcheck` [Block]. 
      - `receive` (String). 
      - `send` (String). 
    - `tls` [Block]. TLS settings for the health check.
      - `sni` (String). Server name indication (SNI) to be sent to the backend.
      - `client_certificate` [Block]. Client certificate to present during TLS handshake.
        - `certificate_id` (String). ID of the client certificate.
      - `validation_context` [Block]. Validation context for the TLS connection.
        - `trusted_ca_bytes` (String). PEM-encoded trusted CA certificate bytes.
        - `trusted_ca_id` (String). ID of the trusted CA certificate.
  - `load_balancing_config` [Block]. 
    - `locality_aware_routing_percent` (Number). 
    - `mode` (String). 
    - `panic_threshold` (Number). 
    - `strict_locality` (Bool). 
  - `tls` [Block]. TLS settings for the backend connection.
    - `sni` (String). Server name indication (SNI) to be sent to the backend.
    - `client_certificate` [Block]. Client certificate to present during TLS handshake.
      - `certificate_id` (String). ID of the client certificate.
    - `validation_context` [Block]. Validation context for the TLS connection.
      - `trusted_ca_bytes` (String). PEM-encoded trusted CA certificate bytes.
      - `trusted_ca_id` (String). ID of the trusted CA certificate.
- `session_affinity` [Block]. 
  - `connection` [Block]. IP address affinity
    - `source_ip` (Bool). Use source IP address
  - `cookie` [Block]. Cookie affinity
    - `name` (*Read-Only*) (String). Name of the HTTP cookie
    - `path` (String). Path of the HTTP cookie
    - `ttl` (String). TTL for the cookie (if not set, session cookie will be used)
  - `header` [Block]. Request header affinity
    - `header_name` (String). The name of the request header that will be used
- `stream_backend` [Block]. 
  - `enable_proxy_protocol` (Bool). 
  - `keep_connections_on_host_health_failure` (Bool). 
  - `name` (*Read-Only*) (String). 
  - `port` (Number). 
  - `target_group_ids` (*Read-Only*) (List Of String). 
  - `weight` (Number). 
  - `healthcheck` [Block]. 
    - `healthcheck_port` (Number). 
    - `healthy_threshold` (Number). 
    - `interval` (*Read-Only*) (String). 
    - `interval_jitter_percent` (Number). 
    - `timeout` (*Read-Only*) (String). 
    - `unhealthy_threshold` (Number). 
    - `grpc_healthcheck` [Block]. 
      - `service_name` (String). 
    - `http_healthcheck` [Block]. 
      - `expected_statuses` (*Read-Only*) (List Of Number). 
      - `host` (String). 
      - `http2` (Bool). 
      - `path` (*Read-Only*) (String). 
    - `stream_healthcheck` [Block]. 
      - `receive` (String). 
      - `send` (String). 
    - `tls` [Block]. TLS settings for the health check.
      - `sni` (String). Server name indication (SNI) to be sent to the backend.
      - `client_certificate` [Block]. Client certificate to present during TLS handshake.
        - `certificate_id` (String). ID of the client certificate.
      - `validation_context` [Block]. Validation context for the TLS connection.
        - `trusted_ca_bytes` (String). PEM-encoded trusted CA certificate bytes.
        - `trusted_ca_id` (String). ID of the trusted CA certificate.
  - `load_balancing_config` [Block]. 
    - `locality_aware_routing_percent` (Number). 
    - `mode` (String). 
    - `panic_threshold` (Number). 
    - `strict_locality` (Bool). 
  - `tls` [Block]. TLS settings for the backend connection.
    - `sni` (String). Server name indication (SNI) to be sent to the backend.
    - `client_certificate` [Block]. Client certificate to present during TLS handshake.
      - `certificate_id` (String). ID of the client certificate.
    - `validation_context` [Block]. Validation context for the TLS connection.
      - `trusted_ca_bytes` (String). PEM-encoded trusted CA certificate bytes.
      - `trusted_ca_id` (String). ID of the trusted CA certificate.


