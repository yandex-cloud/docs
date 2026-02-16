* `grpc_route`: Route description for gRPC traffic:

    * `grpc_match.fqmn`: Parameter for filtering incoming gRPC requests by FQMN (optional):

        * `exact`: Route requests with the same FQMN as the specified one.
        * `prefix`: Route requests whose FQMN starts with the specified prefix. For example, you can specify the first word of the service name: `/helloworld`.
        * `regex`: Route requests whose FQMN matches the specified [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression). For example: `\/[a-z]{10}[0-9]{3}`.

        The `exact`, `prefix`, and `regex` parameters are mutually exclusive: you can use only one of them.
        
    * `grpc_route_action`: Action applied to gRPC traffic.

        * `backend_group_id`: ID of the [backend group](../../../application-load-balancer/concepts/backend-group.md) located in the same folder as the new route's [HTTP router](../../../application-load-balancer/concepts/http-router.md) and virtual host.
        * `host_rewrite`: Replacing the Host header in the request with the specified value (optional). You can specify `auto_host_rewrite` instead of `host_rewrite`, in which case the Host header in the request will be automatically replaced with the target [VM](../../../compute/concepts/vm.md) address.
        * `--request-max-timeout`: Maximum request timeout in seconds (optional). You can specify a shorter timeout in the `grpc-timeout` request HTTP header. The default value is 60 seconds.
        * `idle_timeout`: Maximum connection idle timeout (keep-alive time) (optional). If not specified, the idle connection will be terminated immediately.
        * {% include [tf-vh-create-legend-route-rate-limit](./tf-vh-create-legend-route-rate-limit.md) %}