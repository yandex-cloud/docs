---
subcategory: Application Load Balancer
---

# yandex_alb_virtual_host (Resource)

Creates a virtual host that belongs to specified HTTP router and adds the specified routes to it. For more information, see [the official documentation](https://yandex.cloud/docs/application-load-balancer/concepts/http-router).

## Example usage

```terraform
//
// Create a new ALB Virtual Host
//
resource "yandex_alb_virtual_host" "my-vhost" {
  name           = "my-virtual-host"
  http_router_id = yandex_alb_http_router.my-router.id
  route {
    name = "my-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.my-bg.id
        timeout          = "3s"
      }
    }
  }
}
```

## Arguments & Attributes Reference

- `authority` (Set Of String). A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '*.foo.com' or '*-bar.foo.com'. If not specified, all domains will be matched.
- `http_router_id` (**Required**)(String). The ID of the HTTP router to which the virtual host belongs.
- `id` (String). 
- `name` (**Required**)(String). The resource name.
- `modify_request_headers` [Block]. Apply the following modifications to the Request/Response header.

{% note warning %}

Only one type of actions `append` or `replace` or `remove` should be specified.

{% endnote %}


  - `append` (String). Append string to the header value.
  - `name` (**Required**)(String). Name of the header to modify.
  - `remove` (Bool). If set, remove the header.
  - `replace` (String). New value for a header. Header values support the following [formatters](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers).
- `modify_response_headers` [Block]. Apply the following modifications to the Request/Response header.

{% note warning %}

Only one type of actions `append` or `replace` or `remove` should be specified.

{% endnote %}


  - `append` (String). Append string to the header value.
  - `name` (**Required**)(String). Name of the header to modify.
  - `remove` (Bool). If set, remove the header.
  - `replace` (String). New value for a header. Header values support the following [formatters](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers).
- `rate_limit` [Block]. Rate limit configuration applied for a whole virtual host
  - `all_requests` [Block]. Rate limit configuration applied to all incoming requests
    - `per_minute` (Number). Limit value specified with per minute time unit
    - `per_second` (Number). Limit value specified with per second time unit
  - `requests_per_ip` [Block]. Rate limit configuration applied separately for each set of requests grouped by client IP address
    - `per_minute` (Number). Limit value specified with per minute time unit
    - `per_second` (Number). Limit value specified with per second time unit
- `route` [Block]. A Route resource. Routes are matched *in-order*. Be careful when adding them to the end. For instance, having http '/' match first makes all other routes unused.

{% note warning %}

Exactly one type of routes `http_route` or `grpc_route` should be specified.

{% endnote %}


  - `disable_security_profile` (Bool). Disables security profile for the route
  - `name` (String). Name of the route.
  - `grpc_route` [Block]. gRPC route resource.

{% note warning %}

Exactly one type of actions `grpc_route_action` or `grpc_status_response_action` should be specified.

{% endnote %}


    - `grpc_match` [Block]. Checks `/` prefix by default.
      - `fqmn` [Block]. The `path` and `fqmn` blocks.

{% note warning %}

Exactly one type of string matches `exact`, `prefix` or `regex` should be specified.

{% endnote %}


        - `exact` (String). Match exactly.
        - `prefix` (String). Match prefix.
        - `regex` (String). Match regex.
    - `grpc_route_action` [Block]. gRPC route action resource.

{% note warning %}

Only one type of host rewrite specifiers `host_rewrite` or `auto_host_rewrite` should be specified.

{% endnote %}


      - `auto_host_rewrite` (Bool). If set, will automatically rewrite host.
      - `backend_group_id` (**Required**)(String). Backend group to route requests.
      - `host_rewrite` (String). Host rewrite specifier.
      - `idle_timeout` (String). Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios - one should set idle_timeout to something meaningful and max_timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout.
      - `max_timeout` (String). Lower timeout may be specified by the client (using grpc-timeout header). If not set, default is 60 seconds.
      - `rate_limit` [Block]. Rate limit configuration applied for a whole virtual host
        - `all_requests` [Block]. Rate limit configuration applied to all incoming requests
          - `per_minute` (Number). Limit value specified with per minute time unit
          - `per_second` (Number). Limit value specified with per second time unit
        - `requests_per_ip` [Block]. Rate limit configuration applied separately for each set of requests grouped by client IP address
          - `per_minute` (Number). Limit value specified with per minute time unit
          - `per_second` (Number). Limit value specified with per second time unit
    - `grpc_status_response_action` [Block]. gRPC status response action resource.
      - `status` (String). The status of the response. Supported values are: ok, invalid_argumet, not_found, permission_denied, unauthenticated, unimplemented, internal, unavailable.
  - `http_route` [Block]. HTTP route resource.

{% note warning %}

Exactly one type of actions `http_route_action` or `redirect_action` or `direct_response_action` should be specified.

{% endnote %}


    - `direct_response_action` [Block]. Direct response action resource.
      - `body` (String). Response body text.
      - `status` (Number). HTTP response status. Should be between `100` and `599`.
    - `http_match` [Block]. Checks `/` prefix by default.
      - `http_method` (Set Of String). List of methods (strings).
      - `path` [Block]. The `path` and `fqmn` blocks.

{% note warning %}

Exactly one type of string matches `exact`, `prefix` or `regex` should be specified.

{% endnote %}


        - `exact` (String). Match exactly.
        - `prefix` (String). Match prefix.
        - `regex` (String). Match regex.
    - `http_route_action` [Block]. HTTP route action resource.

{% note warning %}

Only one type of host rewrite specifiers `host_rewrite` or `auto_host_rewrite` should be specified.

{% endnote %}


      - `auto_host_rewrite` (Bool). If set, will automatically rewrite host.
      - `backend_group_id` (**Required**)(String). Backend group to route requests.
      - `host_rewrite` (String). Host rewrite specifier.
      - `idle_timeout` (String). Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios (i.e. long-polling, server-sent events) - one should set idle_timeout to something meaningful and timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout.
      - `prefix_rewrite` (String). If not empty, matched path prefix will be replaced by this value.
      - `timeout` (String). Specifies the request timeout (overall time request processing is allowed to take) for the route. If not set, default is 60 seconds.
      - `upgrade_types` (Set Of String). List of upgrade types. Only specified upgrade types will be allowed. For example, `websocket`.
      - `rate_limit` [Block]. Rate limit configuration applied for a whole virtual host
        - `all_requests` [Block]. Rate limit configuration applied to all incoming requests
          - `per_minute` (Number). Limit value specified with per minute time unit
          - `per_second` (Number). Limit value specified with per second time unit
        - `requests_per_ip` [Block]. Rate limit configuration applied separately for each set of requests grouped by client IP address
          - `per_minute` (Number). Limit value specified with per minute time unit
          - `per_second` (Number). Limit value specified with per second time unit
      - `regex_rewrite` [Block]. Replacement for path substrings that match the pattern
        - `regex` (String). RE2 regular expression
        - `substitute` (String). The string which should be used to substitute matched substrings
    - `redirect_action` [Block]. Redirect action resource.

{% note warning %}

Only one type of paths `replace_path` or `replace_prefix` should be specified.

{% endnote %}


      - `remove_query` (Bool). If set, remove query part.
      - `replace_host` (String). Replaces hostname.
      - `replace_path` (String). Replace path.
      - `replace_port` (Number). Replaces port.
      - `replace_prefix` (String). Replace only matched prefix. Example:<br/> match:{ prefix_match: `/some` } <br/> redirect: { replace_prefix: `/other` } <br/> will redirect `/something` to `/otherthing`.
      - `replace_scheme` (String). Replaces scheme. If the original scheme is `http` or `https`, will also remove the 80 or 443 port, if present.
      - `response_code` (String). The HTTP status code to use in the redirect response. Supported values are: `moved_permanently`, `found`, `see_other`, `temporary_redirect`, `permanent_redirect`.
  - `route_options` [Block]. Route options for the virtual host.
    - `security_profile_id` (String). SWS profile ID.
    - `rbac` [Block]. RBAC configuration.
      - `action` (String). 
      - `principals` [Block]. 
        - `and_principals` [Block]. 
          - `any` (Bool). 
          - `remote_ip` (String). 
          - `header` [Block]. 
            - `name` (**Required**)(String). 
            - `value` [Block]. The `path` and `fqmn` blocks.

{% note warning %}

Exactly one type of string matches `exact`, `prefix` or `regex` should be specified.

{% endnote %}


              - `exact` (String). Match exactly.
              - `prefix` (String). Match prefix.
              - `regex` (String). Match regex.
- `route_options` [Block]. Route options for the virtual host.
  - `security_profile_id` (String). SWS profile ID.
  - `rbac` [Block]. RBAC configuration.
    - `action` (String). 
    - `principals` [Block]. 
      - `and_principals` [Block]. 
        - `any` (Bool). 
        - `remote_ip` (String). 
        - `header` [Block]. 
          - `name` (**Required**)(String). 
          - `value` [Block]. The `path` and `fqmn` blocks.

{% note warning %}

Exactly one type of string matches `exact`, `prefix` or `regex` should be specified.

{% endnote %}


            - `exact` (String). Match exactly.
            - `prefix` (String). Match prefix.
            - `regex` (String). Match regex.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_alb_virtual_host.<resource Name> <http_router_id>/<vhost_name>
terraform import yandex_alb_virtual_host.my_vhost ds7ph**********hm4in/route-7565bde...6ddd6-1
```
