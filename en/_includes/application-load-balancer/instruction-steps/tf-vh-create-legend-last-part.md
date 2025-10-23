* `authority`: HTTP/1.1 `Host` (HTTP/2 `authority`) header domains associated with this virtual host. You can use wildcards, e.g., `*.foo.com` or `*-bar.foo.com`. For gRPC traffic, you may specify `*` or the the load balancer's IP address.

    This is an optional parameter. If not specified, all traffic will be routed to this virtual host.
* `modify_request_headers`: HTTP request header modification settings. Possible parameters:

    {% include [tf-vh-modify-header-options](./tf-vh-modify-header-options.md) %}

    This is an optional parameter; if omitted, request headers go to the backend unchanged.

* `modify_response_headers`: HTTP response header modification settings. Possible parameters:

    {% include [tf-vh-modify-header-options](./tf-vh-modify-header-options.md) %}

    This is an optional parameter; if omitted, response headers go to the client unchanged.
* `route_options`: Additional virtual host parameters (optional):
    * `security_profile_id`: Security profile ID. A security profile allows you to filter incoming requests, enable [WAF](../../../smartwebsecurity/concepts/waf.md), and set limits on the number of requests for protection against malicious activity. For more information, see [{#T}](../../../smartwebsecurity/concepts/profiles.md).

