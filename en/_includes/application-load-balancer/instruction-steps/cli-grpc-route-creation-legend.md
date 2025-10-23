 * `--http-router-name`: Name of the HTTPS router you are creating the route in.

    Instead of the HTTP router name, you can provide its ID in the `--http-router-id` parameter.
* `--virtual-host-name`: Name of the virtual host you are creating the route in.
* FQMN-based routing condition parameters:

    * `--exact-fqmn-match`: Route requests with the same FQMN as the specified one.
    * `--prefix-fqmn-match`: Route requests whose FQMN starts with the specified prefix. For example, you can specify the first word of the service name: `/helloworld`.
    * `--regex-fqmn-match`: Route requests whose FQMN matches the specified [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression). For example: `\/[a-z]{10}[0-9]{3}`.

    {% include [fqmn-slash-warning](./fqmn-slash-warning.md) %}

    {% note info %}

    The `--exact-fqmn-match`, `--prefix-fqmn-match`, and `--regex-fqmn-match` parameters are mutually exclusive: you can use only one of them.

    {% endnote %}

* {% include [cli-grpc-route-creation-backend-group-name](./cli-grpc-route-creation-backend-group-name.md) %}
* `--request-max-timeout`: Maximum connection time. You can specify a shorter timeout in the `grpc-timeout` request HTTP header.
* `--request-idle-timeout`: Maximum connection idle time in seconds.
* {% include [cli-route-creation-rate-limit](./cli-route-creation-rate-limit.md) %}
* {% include [cli-route-creation-disable-security-profile](./cli-route-creation-disable-security-profile.md) %}

