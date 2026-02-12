---
subcategory: Application Load Balancer
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/alb_backend_group.md
---

# yandex_alb_backend_group (Resource)

Creates a backend group in the specified folder and adds the specified backends to it. For more information, see [the official documentation](https://yandex.cloud/docs/application-load-balancer/concepts/backend-group).

{% note warning %}

Only one type of backends `http_backend` or `grpc_backend` or `stream_backend` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Create a new ALB Backend Group.
//
resource "yandex_alb_backend_group" "my_alb_bg" {
  name = "my-backend-group"

  session_affinity {
    connection {
      source_ip = "127.0.0.1"
    }
  }

  http_backend {
    name             = "test-http-backend"
    weight           = 1
    port             = 8080
    target_group_ids = ["${yandex_alb_target_group.test-target-group.id}"]
    tls {
      sni = "backend-domain.internal"
    }
    load_balancing_config {
      panic_threshold = 50
    }
    healthcheck {
      timeout  = "1s"
      interval = "1s"
      http_healthcheck {
        path = "/"
      }
    }
    http2 = "true"
  }
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `grpc_backend` [Block]. gRPC backend specification that will be used by the ALB Backend Group.
  - `name` (**Required**)(String). Name of the backend.
  - `port` (Number). Port for incoming traffic.
  - `target_group_ids` (**Required**)(List Of String). References target groups for the backend.
  - `weight` (Number). Weight of the backend. Traffic will be split between backends of the same BackendGroup according to their weights.
  - `healthcheck` [Block]. Healthcheck specification that will be used by this backend.

{% note warning %}

Only one of `stream_healthcheck` or `http_healthcheck` or `grpc_healthcheck` should be specified.

{% endnote %}


    - `healthcheck_port` (Number). Optional alternative port for health checking.
    - `healthy_threshold` (Number). Number of consecutive successful health checks required to promote endpoint into the healthy state. 0 means 1. Note that during startup, only a single successful health check is required to mark a host healthy.
    - `interval` (**Required**)(String). Interval between health checks.
    - `interval_jitter_percent` (Number). An optional jitter amount as a percentage of interval. If specified, during every interval value of (interval_ms * interval_jitter_percent / 100) will be added to the wait time.
    - `timeout` (**Required**)(String). Time to wait for a health check response.
    - `unhealthy_threshold` (Number). Number of consecutive failed health checks required to demote endpoint into the unhealthy state. 0 means 1. Note that for HTTP health checks, a single 503 immediately makes endpoint unhealthy.
    - `grpc_healthcheck` [Block]. gRPC Healthcheck specification that will be used by this healthcheck.
      - `service_name` (String). Service name for `grpc.health.v1.HealthCheckRequest` message.
    - `http_healthcheck` [Block]. HTTP Healthcheck specification that will be used by this healthcheck.
      - `expected_statuses` (List Of Number). A list of HTTP response statuses considered healthy.
      - `host` (String). `Host` HTTP header value.
      - `http2` (Bool). If set, health checks will use HTTP2.
      - `path` (**Required**)(String). HTTP path.
    - `stream_healthcheck` [Block]. Stream Healthcheck specification that will be used by this healthcheck.
      - `receive` (String). Data that must be contained in the messages received from targets for a successful health check. If not specified, no messages are expected from targets, and those that are received are not checked.
      - `send` (String). Message sent to targets during TCP data transfer. If not specified, no data is sent to the target.
  - `load_balancing_config` [Block]. Load Balancing Config specification that will be used by this backend.
    - `locality_aware_routing_percent` (Number). Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones.
    - `mode` (String). Load balancing mode for the backend. Possible values: `ROUND_ROBIN`, `RANDOM`, `LEAST_REQUEST`, `MAGLEV_HASH`.
    - `panic_threshold` (Number). If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading when everything is bad. Zero means no panic threshold.
    - `strict_locality` (Bool). If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones.
  - `tls` [Block]. TLS specification that will be used by this backend.

{% note warning %}

Only one of `validation_context.0.trusted_ca_id` or `validation_context.0.trusted_ca_bytes` should be specified.

{% endnote %}


    - `sni` (String). [SNI](https://en.wikipedia.org/wiki/Server_Name_Indication) string for TLS connections.
    - `validation_context` [Block]. Validation context
      - `trusted_ca_bytes` (String). PEM-encoded trusted CA certificate chain.
      - `trusted_ca_id` (String). Trusted CA certificate ID in the Certificate Manager.
- `http_backend` [Block]. HTTP backend specification that will be used by the ALB Backend Group.

{% note warning %}

Only one of `target_group_ids` or `storage_bucket` should be specified.

{% endnote %}


  - `http2` (Bool). Enables HTTP2 for upstream requests. If not set, HTTP 1.1 will be used by default.
  - `name` (**Required**)(String). Name of the backend.
  - `port` (Number). Port for incoming traffic.
  - `storage_bucket` (String). Name of bucket which should be used as a backend.
  - `target_group_ids` (List Of String). References target groups for the backend.
  - `weight` (Number). Weight of the backend. Traffic will be split between backends of the same BackendGroup according to their weights.
  - `healthcheck` [Block]. Healthcheck specification that will be used by this backend.

{% note warning %}

Only one of `stream_healthcheck` or `http_healthcheck` or `grpc_healthcheck` should be specified.

{% endnote %}


    - `healthcheck_port` (Number). Optional alternative port for health checking.
    - `healthy_threshold` (Number). Number of consecutive successful health checks required to promote endpoint into the healthy state. 0 means 1. Note that during startup, only a single successful health check is required to mark a host healthy.
    - `interval` (**Required**)(String). Interval between health checks.
    - `interval_jitter_percent` (Number). An optional jitter amount as a percentage of interval. If specified, during every interval value of (interval_ms * interval_jitter_percent / 100) will be added to the wait time.
    - `timeout` (**Required**)(String). Time to wait for a health check response.
    - `unhealthy_threshold` (Number). Number of consecutive failed health checks required to demote endpoint into the unhealthy state. 0 means 1. Note that for HTTP health checks, a single 503 immediately makes endpoint unhealthy.
    - `grpc_healthcheck` [Block]. gRPC Healthcheck specification that will be used by this healthcheck.
      - `service_name` (String). Service name for `grpc.health.v1.HealthCheckRequest` message.
    - `http_healthcheck` [Block]. HTTP Healthcheck specification that will be used by this healthcheck.
      - `expected_statuses` (List Of Number). A list of HTTP response statuses considered healthy.
      - `host` (String). `Host` HTTP header value.
      - `http2` (Bool). If set, health checks will use HTTP2.
      - `path` (**Required**)(String). HTTP path.
    - `stream_healthcheck` [Block]. Stream Healthcheck specification that will be used by this healthcheck.
      - `receive` (String). Data that must be contained in the messages received from targets for a successful health check. If not specified, no messages are expected from targets, and those that are received are not checked.
      - `send` (String). Message sent to targets during TCP data transfer. If not specified, no data is sent to the target.
  - `load_balancing_config` [Block]. Load Balancing Config specification that will be used by this backend.
    - `locality_aware_routing_percent` (Number). Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones.
    - `mode` (String). Load balancing mode for the backend. Possible values: `ROUND_ROBIN`, `RANDOM`, `LEAST_REQUEST`, `MAGLEV_HASH`.
    - `panic_threshold` (Number). If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading when everything is bad. Zero means no panic threshold.
    - `strict_locality` (Bool). If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones.
  - `tls` [Block]. TLS specification that will be used by this backend.

{% note warning %}

Only one of `validation_context.0.trusted_ca_id` or `validation_context.0.trusted_ca_bytes` should be specified.

{% endnote %}


    - `sni` (String). [SNI](https://en.wikipedia.org/wiki/Server_Name_Indication) string for TLS connections.
    - `validation_context` [Block]. Validation context
      - `trusted_ca_bytes` (String). PEM-encoded trusted CA certificate chain.
      - `trusted_ca_id` (String). Trusted CA certificate ID in the Certificate Manager.
- `session_affinity` [Block]. Session affinity mode determines how incoming requests are grouped into one session.

{% note warning %}

Only one type(`connection` or `cookie` or `header`) of session affinity should be specified.

{% endnote %}


  - `connection` [Block]. Requests received from the same IP are combined into a session. Stream backend groups only support session affinity by client IP address.
    - `source_ip` (Bool). Source IP address to use with affinity.
  - `cookie` [Block]. Requests with the same cookie value and the specified file name are combined into a session. Allowed only for `HTTP` and `gRPC` backend groups.
    - `name` (**Required**)(String). Name of the HTTP cookie to use with affinity.
    - `path` (String). Path of the HTTP cookie to use with affinity.
    - `ttl` (String). TTL for the cookie (if not set, session cookie will be used).
  - `header` [Block]. Requests with the same value of the specified HTTP header, such as with user authentication data, are combined into a session. Allowed only for `HTTP` and `gRPC` backend groups.
    - `header_name` (**Required**)(String). The name of the request header that will be used with affinity.
- `stream_backend` [Block]. Stream backend specification that will be used by the ALB Backend Group.
  - `enable_proxy_protocol` (Bool). Enables TCP proxy protocol support for upstream backend
  - `keep_connections_on_host_health_failure` (Bool). If set, when a backend host becomes unhealthy (as determined by the configured health checks), keep connections to the failed host.
  - `name` (**Required**)(String). Name of the backend.
  - `port` (Number). Port for incoming traffic.
  - `target_group_ids` (**Required**)(List Of String). References target groups for the backend.
  - `weight` (Number). Weight of the backend. Traffic will be split between backends of the same BackendGroup according to their weights.
  - `healthcheck` [Block]. Healthcheck specification that will be used by this backend.

{% note warning %}

Only one of `stream_healthcheck` or `http_healthcheck` or `grpc_healthcheck` should be specified.

{% endnote %}


    - `healthcheck_port` (Number). Optional alternative port for health checking.
    - `healthy_threshold` (Number). Number of consecutive successful health checks required to promote endpoint into the healthy state. 0 means 1. Note that during startup, only a single successful health check is required to mark a host healthy.
    - `interval` (**Required**)(String). Interval between health checks.
    - `interval_jitter_percent` (Number). An optional jitter amount as a percentage of interval. If specified, during every interval value of (interval_ms * interval_jitter_percent / 100) will be added to the wait time.
    - `timeout` (**Required**)(String). Time to wait for a health check response.
    - `unhealthy_threshold` (Number). Number of consecutive failed health checks required to demote endpoint into the unhealthy state. 0 means 1. Note that for HTTP health checks, a single 503 immediately makes endpoint unhealthy.
    - `grpc_healthcheck` [Block]. gRPC Healthcheck specification that will be used by this healthcheck.
      - `service_name` (String). Service name for `grpc.health.v1.HealthCheckRequest` message.
    - `http_healthcheck` [Block]. HTTP Healthcheck specification that will be used by this healthcheck.
      - `expected_statuses` (List Of Number). A list of HTTP response statuses considered healthy.
      - `host` (String). `Host` HTTP header value.
      - `http2` (Bool). If set, health checks will use HTTP2.
      - `path` (**Required**)(String). HTTP path.
    - `stream_healthcheck` [Block]. Stream Healthcheck specification that will be used by this healthcheck.
      - `receive` (String). Data that must be contained in the messages received from targets for a successful health check. If not specified, no messages are expected from targets, and those that are received are not checked.
      - `send` (String). Message sent to targets during TCP data transfer. If not specified, no data is sent to the target.
  - `load_balancing_config` [Block]. Load Balancing Config specification that will be used by this backend.
    - `locality_aware_routing_percent` (Number). Percent of traffic to be sent to the same availability zone. The rest will be equally divided between other zones.
    - `mode` (String). Load balancing mode for the backend. Possible values: `ROUND_ROBIN`, `RANDOM`, `LEAST_REQUEST`, `MAGLEV_HASH`.
    - `panic_threshold` (Number). If percentage of healthy hosts in the backend is lower than panic_threshold, traffic will be routed to all backends no matter what the health status is. This helps to avoid healthy backends overloading when everything is bad. Zero means no panic threshold.
    - `strict_locality` (Bool). If set, will route requests only to the same availability zone. Balancer won't know about endpoints in other zones.
  - `tls` [Block]. TLS specification that will be used by this backend.

{% note warning %}

Only one of `validation_context.0.trusted_ca_id` or `validation_context.0.trusted_ca_bytes` should be specified.

{% endnote %}


    - `sni` (String). [SNI](https://en.wikipedia.org/wiki/Server_Name_Indication) string for TLS connections.
    - `validation_context` [Block]. Validation context
      - `trusted_ca_bytes` (String). PEM-encoded trusted CA certificate chain.
      - `trusted_ca_id` (String). Trusted CA certificate ID in the Certificate Manager.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_alb_backend_group.<resource Name> <resource ID>
terraform import yandex_alb_backend_group.my_alb_bg ds7io**********9bike
```
