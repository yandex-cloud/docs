---
subcategory: Application Load Balancer
---

# yandex_alb_load_balancer (DataSource)

Get information about a Yandex Application Load Balancer. For more information, see [Yandex Cloud Application Load Balancer](https://yandex.cloud/docs/application-load-balancer/quickstart).

This data source is used to define [Application Load Balancer](https://yandex.cloud/docs/application-load-balancer/concepts/application-load-balancer) that can be used by other resources.

{% note warning %}

One of `load_balancer_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Application Load Balancer (ALB).
//
data "yandex_alb_load_balancer" "tf-alb-data" {
  load_balancer_id = "my-alb-id"
}
```

## Arguments & Attributes Reference

- `allocation_policy` (*Read-Only*) (List Of Object). Allocation zones for the Load Balancer instance.
  - `location` . 
    - `disable_traffic` . 
    - `subnet_id` . 
    - `zone_id` . 
- `allow_zonal_shift` (*Read-Only*) (Bool). Specifies whether application load balancer is available to zonal shift
- `auto_scale_policy` (*Read-Only*) (List Of Object). Scaling settings of the application load balancer.
  - `max_size` . 
  - `min_zone_size` . 
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (*Read-Only*) (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `listener` (*Read-Only*) (List Of Object). List of listeners for the Load Balancer.
  - `endpoint` . 
    - `address` . 
      - `external_ipv4_address` . 
        - `address` . 
      - `external_ipv6_address` . 
        - `address` . 
      - `internal_ipv4_address` . 
        - `address` . 
        - `subnet_id` . 
    - `ports` . 
  - `http` . 
    - `handler` . 
      - `allow_http10` . 
      - `http2_options` . 
        - `max_concurrent_streams` . 
      - `http_router_id` . 
      - `preserve_http1_header_casing` . 
      - `rewrite_request_id` . 
    - `redirects` . 
      - `http_to_https` . 
  - `name` . 
  - `stream` . 
    - `handler` . 
      - `backend_group_id` . 
      - `idle_timeout` . 
  - `tls` . 
    - `default_handler` . 
      - `certificate_ids` . 
      - `client_certificates_verification` . 
        - `accept_untrusted` . 
        - `allow_expired` . 
        - `bytes` . 
        - `require_client_certificate` . 
      - `http_handler` . 
        - `allow_http10` . 
        - `http2_options` . 
          - `max_concurrent_streams` . 
        - `http_router_id` . 
        - `preserve_http1_header_casing` . 
        - `rewrite_request_id` . 
      - `stream_handler` . 
        - `backend_group_id` . 
        - `idle_timeout` . 
    - `sni_handler` . 
      - `handler` . 
        - `certificate_ids` . 
        - `client_certificates_verification` . 
          - `accept_untrusted` . 
          - `allow_expired` . 
          - `bytes` . 
          - `require_client_certificate` . 
        - `http_handler` . 
          - `allow_http10` . 
          - `http2_options` . 
            - `max_concurrent_streams` . 
          - `http_router_id` . 
          - `preserve_http1_header_casing` . 
          - `rewrite_request_id` . 
        - `stream_handler` . 
          - `backend_group_id` . 
          - `idle_timeout` . 
      - `name` . 
      - `server_names` . 
- `load_balancer_id` (String). The resource identifier.
- `log_group_id` (*Read-Only*) (String). Cloud Logging group ID to send logs to. Leave empty to use the balancer folder default log group.
- `log_options` (*Read-Only*) (List Of Object). Cloud Logging settings.
  - `disable` . 
  - `discard_rule` . 
    - `discard_percent` . 
    - `grpc_codes` . 
    - `http_code_intervals` . 
    - `http_codes` . 
  - `log_group_id` . 
- `name` (String). The resource name.
- `network_id` (*Read-Only*) (String). The `VPC Network ID` of subnets which resource attached to.
- `region_id` (*Read-Only*) (String). The region ID where Load Balancer is located at.
- `security_group_ids` (*Read-Only*) (Set Of String). The list of security groups applied to resource or their components.
- `status` (*Read-Only*) (String). Status of the Load Balancer.
- `timeouts` [Block]. 
  - `create` (String). 
  - `delete` (String). 
  - `update` (String).


