---
subcategory: Application Load Balancer
---

# yandex_alb_load_balancer (Resource)

Creates an Application Load Balancer in the specified folder. For more information, see [the official documentation](https://yandex.cloud/docs/application-load-balancer/concepts/application-load-balancer).

## Example usage

```terraform
//
// Create a new Application Load Balancer (ALB)
//
resource "yandex_alb_load_balancer" "my_alb" {
  name = "my-load-balancer"

  network_id = yandex_vpc_network.test-network.id

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.test-subnet.id
    }
  }

  listener {
    name = "my-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [8080]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.test-router.id
      }
    }
  }

  log_options {
    discard_rule {
      http_code_intervals = ["2XX"]
      discard_percent     = 75
    }
  }
}
```

## Arguments & Attributes Reference

- `allow_zonal_shift` (Bool). Specifies whether application load balancer is available to zonal shift
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `log_group_id` (*Read-Only*) (String). Cloud Logging group ID to send logs to. Leave empty to use the balancer folder default log group.
- `name` (String). The resource name.
- `network_id` (**Required**)(String). The `VPC Network ID` of subnets which resource attached to.
- `region_id` (String). The region ID where Load Balancer is located at.
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
- `status` (*Read-Only*) (String). Status of the Load Balancer.
- `allocation_policy` [Block]. Allocation zones for the Load Balancer instance.
  - `location` [Block]. Unique set of locations.
    - `disable_traffic` (Bool). If set, will disable all L7 instances in the zone for request handling.
    - `subnet_id` (**Required**)(String). ID of the subnet that location is located at.
    - `zone_id` (**Required**)(String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.
- `auto_scale_policy` [Block]. Scaling settings of the application load balancer.
  - `max_size` (Number). Upper limit for total instance count (across all zones)
  - `min_zone_size` (Number). Lower limit for instance count in each zone.
- `listener` [Block]. List of listeners for the Load Balancer.
  - `name` (**Required**)(String). Name of the listener.
  - `endpoint` [Block]. Network endpoint (addresses and ports) of the listener.
    - `ports` (**Required**)(List Of Number). One or more ports to listen on.
    - `address` [Block]. One or more addresses to listen on.
      - `external_ipv4_address` [Block]. External IPv4 address.
        - `address` (String). Provided by the client or computed automatically.
      - `external_ipv6_address` [Block]. External IPv6 address.
        - `address` (String). Provided by the client or computed automatically.
      - `internal_ipv4_address` [Block]. Internal IPv4 address.
        - `address` (String). Provided by the client or computed automatically.
        - `subnet_id` (String). ID of the subnet that the address belongs to.
  - `http` [Block]. HTTP handler that sets plain text HTTP router.
    - `handler` [Block]. HTTP handler.
      - `allow_http10` (Bool). If set, will enable only HTTP1 protocol with HTTP1.0 support.
      - `http_router_id` (String). HTTP router id.
      - `rewrite_request_id` (Bool). When unset, will preserve the incoming `x-request-id` header, otherwise would rewrite it with a new value.
      - `http2_options` [Block]. If set, will enable HTTP2 protocol for the handler.
        - `max_concurrent_streams` (Number). Maximum number of concurrent streams.
    - `redirects` [Block]. Shortcut for adding http -> https redirects.
      - `http_to_https` (Bool). If set redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`.
  - `stream` [Block]. Stream configuration
    - `handler` [Block]. Stream handler resource.
      - `backend_group_id` (String). Backend Group ID.
      - `idle_timeout` (String). The idle timeout is the interval after which the connection will be forcibly closed if no data has been transmitted or received on either the upstream or downstream connection. If not configured, the default idle timeout is 1 hour. Setting it to 0 disables the timeout.
  - `tls` [Block]. TLS configuration
    - `default_handler` [Block]. TLS handler resource.
      - `certificate_ids` (**Required**)(Set Of String). Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used.
      - `http_handler` [Block]. HTTP handler.
        - `allow_http10` (Bool). If set, will enable only HTTP1 protocol with HTTP1.0 support.
        - `http_router_id` (String). HTTP router id.
        - `rewrite_request_id` (Bool). When unset, will preserve the incoming `x-request-id` header, otherwise would rewrite it with a new value.
        - `http2_options` [Block]. If set, will enable HTTP2 protocol for the handler.
          - `max_concurrent_streams` (Number). Maximum number of concurrent streams.
      - `stream_handler` [Block]. Stream handler resource.
        - `backend_group_id` (String). Backend Group ID.
        - `idle_timeout` (String). The idle timeout is the interval after which the connection will be forcibly closed if no data has been transmitted or received on either the upstream or downstream connection. If not configured, the default idle timeout is 1 hour. Setting it to 0 disables the timeout.
    - `sni_handler` [Block]. Settings for handling requests with Server Name Indication (SNI)
      - `name` (**Required**)(String). Name of the SNI handler
      - `server_names` (**Required**)(Set Of String). Server names that are matched by the SNI handler
      - `handler` [Block]. TLS handler resource.
        - `certificate_ids` (**Required**)(Set Of String). Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used.
        - `http_handler` [Block]. HTTP handler.
          - `allow_http10` (Bool). If set, will enable only HTTP1 protocol with HTTP1.0 support.
          - `http_router_id` (String). HTTP router id.
          - `rewrite_request_id` (Bool). When unset, will preserve the incoming `x-request-id` header, otherwise would rewrite it with a new value.
          - `http2_options` [Block]. If set, will enable HTTP2 protocol for the handler.
            - `max_concurrent_streams` (Number). Maximum number of concurrent streams.
        - `stream_handler` [Block]. Stream handler resource.
          - `backend_group_id` (String). Backend Group ID.
          - `idle_timeout` (String). The idle timeout is the interval after which the connection will be forcibly closed if no data has been transmitted or received on either the upstream or downstream connection. If not configured, the default idle timeout is 1 hour. Setting it to 0 disables the timeout.
- `log_options` [Block]. Cloud Logging settings.
  - `disable` (Bool). Set to `true` to disable Cloud Logging for the balancer.
  - `log_group_id` (String). Cloud Logging group ID to send logs to. Leave empty to use the balancer folder default log group.
  - `discard_rule` [Block]. List of rules to discard a fraction of logs.
    - `discard_percent` (Number). The percent of logs which will be discarded.
    - `grpc_codes` (List Of String). list of grpc codes by name, e.g, [**NOT_FOUND**, **RESOURCE_EXHAUSTED**].
    - `http_code_intervals` (List Of String). List of http code intervals *1XX*-*5XX* or *ALL*
    - `http_codes` (List Of Number). List of http codes *100*-*599*.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_alb_load_balancer.<resource Name> <resource Id>
terraform import yandex_alb_load_balancer.my_alb ds705**********q7qvl
```
