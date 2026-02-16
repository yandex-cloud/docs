* `--http-router-name`: Name of the HTTPS router you are creating the route in.

    Instead of the HTTP router name, you can provide its ID in the `--http-router-id` parameter.
* `--virtual-host-name`: Name of the virtual host where the route is created.
* `--match-http-method`: List of HTTP [methods](https://en.wikipedia.org/wiki/HTTP#Request_methods) for which requests need to be routed, e.g., `--match-http-method GET,POST,OPTIONS`. This is an optional parameter. If not specified, requests with any methods will be routed.
* Parameters with path-based routing conditions:

    * `--exact-path-match`: Route requests with the same path as the specified one. For example, to route all requests, specify the `/` path.
    * `--prefix-path-match`: Route requests whose path starts with the specified prefix, e.g., `/myapp/`.
    * `--regex-path-match`: Route requests whose path matches the specified [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression), e.g., `\/[a-z]{10}[0-9]{3}\/`.

    {% note info %}

    The `--exact-path-match`, `--prefix-path-match`, and `--regex-path-match` parameters are mutually exclusive: you can use only one of them.

    {% endnote %}

* {% include [cli-grpc-route-creation-backend-group-name](./cli-grpc-route-creation-backend-group-name.md) %}
* `--request-timeout`: Maximum connection time in seconds for a connection on request.
* `--request-idle-timeout`: Maximum connection idle time in seconds.
* {% include [cli-route-creation-rate-limit](./cli-route-creation-rate-limit.md) %}
* {% include [cli-route-creation-disable-security-profile](./cli-route-creation-disable-security-profile.md) %}

