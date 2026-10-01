---
subcategory: Application Load Balancer
---

# yandex_alb_virtual_host (DataSource)

Get information about a Yandex ALB Virtual Host. For more information, see [Yandex Cloud Application Load Balancer](https://yandex.cloud/docs/application-load-balancer/quickstart).

This data source is used to define [Application Load Balancer Virtual Host](https://yandex.cloud/docs/application-load-balancer/concepts/http-router) that can be used by other resources.

{% note warning %}

One of `virtual_host_id` or `name` with `http_router_id` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing ALB Virtual Host
//
data "yandex_alb_virtual_host" "my-vhost" {
  name           = yandex_alb_virtual_host.my-vh.name
  http_router_id = yandex_alb_virtual_host.my-router.id
}
```

## Arguments & Attributes Reference

- `authority` (*Read-Only*) (Set Of String). A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '*.foo.com' or '*-bar.foo.com'. If not specified, all domains will be matched.
- `http_router_id` (String). The ID of the HTTP router to which the virtual host belongs.
- `id` (String). 
- `modify_request_headers` (*Read-Only*) (List Of Object). Apply the following modifications to the Request/Response header.

{% note warning %}

Only one type of actions `append` or `replace` or `remove` should be specified.

{% endnote %}


  - `append` . 
  - `name` . 
  - `remove` . 
  - `replace` . 
- `modify_response_headers` (*Read-Only*) (List Of Object). Apply the following modifications to the Request/Response header.

{% note warning %}

Only one type of actions `append` or `replace` or `remove` should be specified.

{% endnote %}


  - `append` . 
  - `name` . 
  - `remove` . 
  - `replace` . 
- `name` (String). The resource name.
- `rate_limit` (*Read-Only*) (List Of Object). Rate limit configuration applied for a whole virtual host
  - `all_requests` . 
    - `per_minute` . 
    - `per_second` . 
  - `requests_per_ip` . 
    - `per_minute` . 
    - `per_second` . 
- `route` (*Read-Only*) (List Of Object). A Route resource. Routes are matched *in-order*. Be careful when adding them to the end. For instance, having http '/' match first makes all other routes unused.

{% note warning %}

Exactly one type of routes `http_route` or `grpc_route` should be specified.

{% endnote %}


  - `client_certificate_forward` . 
    - `http_header` . 
    - `issuer_header_name` . 
    - `subject_header_name` . 
  - `disable_security_profile` . 
  - `grpc_route` . 
    - `grpc_match` . 
      - `fqmn` . 
        - `exact` . 
        - `prefix` . 
        - `regex` . 
    - `grpc_route_action` . 
      - `auto_host_rewrite` . 
      - `backend_group_id` . 
      - `host_rewrite` . 
      - `idle_timeout` . 
      - `max_timeout` . 
      - `rate_limit` . 
        - `all_requests` . 
          - `per_minute` . 
          - `per_second` . 
        - `requests_per_ip` . 
          - `per_minute` . 
          - `per_second` . 
    - `grpc_status_response_action` . 
      - `status` . 
  - `http_route` . 
    - `direct_response_action` . 
      - `body` . 
      - `status` . 
    - `http_match` . 
      - `http_method` . 
      - `path` . 
        - `exact` . 
        - `prefix` . 
        - `regex` . 
    - `http_route_action` . 
      - `auto_host_rewrite` . 
      - `backend_group_id` . 
      - `host_rewrite` . 
      - `idle_timeout` . 
      - `prefix_rewrite` . 
      - `rate_limit` . 
        - `all_requests` . 
          - `per_minute` . 
          - `per_second` . 
        - `requests_per_ip` . 
          - `per_minute` . 
          - `per_second` . 
      - `regex_rewrite` . 
        - `regex` . 
        - `substitute` . 
      - `timeout` . 
      - `upgrade_types` . 
    - `redirect_action` . 
      - `remove_query` . 
      - `replace_host` . 
      - `replace_path` . 
      - `replace_port` . 
      - `replace_prefix` . 
      - `replace_scheme` . 
      - `response_code` . 
  - `name` . 
  - `route_options` . 
    - `rbac` . 
      - `action` . 
      - `principals` . 
        - `and_principals` . 
          - `any` . 
          - `header` . 
            - `name` . 
            - `value` . 
              - `exact` . 
              - `prefix` . 
              - `regex` . 
          - `remote_ip` . 
    - `security_profile_id` . 
- `route_options` (*Read-Only*) (List Of Object). 
  - `rbac` . 
    - `action` . 
    - `principals` . 
      - `and_principals` . 
        - `any` . 
        - `header` . 
          - `name` . 
          - `value` . 
            - `exact` . 
            - `prefix` . 
            - `regex` . 
        - `remote_ip` . 
  - `security_profile_id` . 
- `virtual_host_id` (String). The ID of a specific Virtual Host. Virtual Host ID is concatenation of HTTP Router ID and Virtual Host name with `/` symbol between them. For Example, `http_router_id/vhost_name`.


