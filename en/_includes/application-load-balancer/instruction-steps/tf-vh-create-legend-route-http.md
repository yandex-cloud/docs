* `http_route`: Route description for HTTP traffic:

    * `http_match`: Parameter for filtering incoming HTTP requests (optional):

        * `http_method`: List of HTTP [methods](https://en.wikipedia.org/wiki/HTTP#Request_methods) for which requests will be routed (optional). By default, requests with any methods are routed.
        * `path`: Optionally, parameters for filtering the path of an incoming request:

            * `exact`: Route requests with the same path as the specified one. For example, to route all requests, specify the `/` path.
            * `prefix`: Route requests whose path starts with the specified prefix.
            * `regex`: Route requests whose path matches the specified [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression). For example: `[a-z]{10}[0-9]{3}\/`.

            The `exact`, `prefix`, and `regex` parameters are mutually exclusive: you can use only one of them.

    * `http_route_action`: Action applied to HTTP traffic.

        * `backend_group_id`: ID of the [backend group](../../../application-load-balancer/concepts/backend-group.md) located in the same folder as the new route's [HTTP router](../../../application-load-balancer/concepts/http-router.md) and virtual host.
        * `host_rewrite`: Replacing the Host header in the request with the specified value (optional). You can specify `auto_host_rewrite` instead of `host_rewrite`, in which case the Host header in the request will be automatically replaced with the target [VM](../../../compute/concepts/vm.md) address.
        * `timeout`: Maximum connection time, in seconds (optional). The default value is 60 seconds.
        * `idle_timeout`: Maximum connection idle timeout (keep-alive time) (optional). If not specified, the idle connection will be terminated immediately.
        * `prefix_rewrite`: Value to replace the path or part of the path specified in the `path` parameter (optional).
        * {% include [tf-vh-create-legend-route-rate-limit](./tf-vh-create-legend-route-rate-limit.md) %}