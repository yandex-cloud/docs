{{ yandex-cloud }} CLI allows using three different commands to add gRPC routes to a virtual host:

* `yc alb virtual-host append-grpc-route`: Adds a route to the end of the list of virtual host routes.
* `yc alb virtual-host append-http-route`: Adds a route to the beginning of the list of virtual host routes.
* `yc alb virtual-host append-http-route`: Adds a route to a specified place in the list of virtual host routes.

{% list tabs %}

- append-grpc-route

  1. {% include [cli-vh-append-grpc-route-help](./cli-vh-append-grpc-route-help.md) %}
  1. {% include [cli-vh-list-http-routers](./cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-list-vhs](./cli-vh-list-vhs.md) %}
  1. {% include [cli-vh-append-grpc-route-code](./cli-vh-append-grpc-route-code.md) %}

      Where:

      {% include [cli-grpc-route-creation-legend](./cli-grpc-route-creation-legend.md) %}

      {% include [cli-vh-append-grpc-route-output](./cli-vh-append-grpc-route-output.md) %}

- prepend-grpc-route

  1. See the description of the CLI command for adding a route to the beginning of the route list:

      ```bash
      yc alb virtual-host prepend-grpc-route --help
      ```
  1. {% include [cli-vh-list-http-routers](./cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-list-vhs](./cli-vh-list-vhs.md) %}
  1. Add the route by specifying its name and additional parameters:

      ```bash
      yc alb virtual-host prepend-grpc-route <route_name> \
        --http-router-name <HTTP_router_name> \
        --virtual-host-name <virtual_host_name> \
        --exact-fqmn-match <full_FQMN> \
        --prefix-fqmn-match <FQMN_prefix> \
        --regex-fqmn-match <regular_expression> \
        --backend-group-name <backend_group_name> \
        --request-max-timeout <request_timeout>s \
        --request-idle-timeout <request_idle_timeout>s \
        --rate-limit rps=<request_limit>,requests-per-ip \
        --disable-security-profile
      ```

      Where:

      {% include [cli-grpc-route-creation-legend](./cli-grpc-route-creation-legend.md) %}

      {% cut "Result:" %}

      ```text
      name: test-virtual-host
      authority:
        - example.com
      routes:
        - name: my-second-route
          grpc:
            match:
              fqmn:
                prefix_match: helloworld/
            route:
              backend_group_id: ds7dq9nsrgpc********
              max_timeout: 10s
              idle_timeout: 5s
              rate_limit:
                requests_per_ip:
                  per_second: "4"
          disable_security_profile: true
        - name: my-first-route
          grpc:
            match:
              fqmn:
                prefix_match: /
            route:
              backend_group_id: ds7dq9nsrgpc********
              max_timeout: 60s
              idle_timeout: 5s
              auto_host_rewrite: false
      modify_request_headers:
        - name: Accept-Language
          append: ru-RU
      route_options:
        security_profile_id: fevu5fnuk6vf********
      rate_limit:
        all_requests:
          per_second: "100"
      ```

      {% endcut %}

      For more details about the `yc alb virtual-host prepend-grpc-route` command, see the [CLI reference](../../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/prepend-grpc-route.md).


- insert-grpc-route

  1. See the description of the CLI command for adding a route to a specified place in the route list:

      ```bash
      yc alb virtual-host insert-grpc-route --help
      ```
  1. {% include [cli-vh-list-http-routers](./cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-list-vhs](./cli-vh-list-vhs.md) %}
  1. {% include [cli-vh-get-vh](./cli-vh-get-vh.md) %}

      {% cut "Result:" %}

      ```text
      name: test-virtual-host
      authority:
        - example.com
      routes:
        - name: my-first-route
          grpc:
            match:
              fqmn:
                prefix_match: /
            route:
              backend_group_id: ds7dq9nsrgpc********
              max_timeout: 60s
              idle_timeout: 5s
              auto_host_rewrite: false
        - name: my-second-route
          grpc:
            match:
              fqmn:
                prefix_match: helloworld/
            route:
              backend_group_id: ds7dq9nsrgpc********
              max_timeout: 10s
              idle_timeout: 5s
              rate_limit:
                requests_per_ip:
                  per_second: "4"
          disable_security_profile: true
      modify_request_headers:
        - name: Accept-Language
          append: ru-RU
      route_options:
        security_profile_id: fevu5fnuk6vf********
      rate_limit:
        all_requests:
          per_second: "100"
      ```

      {% endcut %}

  1. Add the route by specifying its name and additional parameters:

      ```bash
      yc alb virtual-host insert-grpc-route <route_name> \
        --http-router-name <HTTP_router_name> \
        --virtual-host-name <virtual_host_name> \
        --exact-fqmn-match <full_FQMN> \
        --prefix-fqmn-match <FQMN_prefix> \
        --regex-fqmn-match <regular_expression> \
        --backend-group-name <backend_group_name> \
        --request-max-timeout <request_timeout>s \
        --request-idle-timeout <request_idle_timeout>s \
        --rate-limit rps=<request_limit>,requests-per-ip \
        --disable-security-profile \
        --before <name_of_next_route> \
        --after <name_of_previous_route>
      ```

      Where:

      {% include [cli-grpc-route-creation-legend](./cli-grpc-route-creation-legend.md) %}

      {% include [cli-grpc-route-creation-legend-before-after](./cli-grpc-route-creation-legend-before-after.md) %}

      {% cut "Result:" %}

      ```text
      name: test-virtual-host
      authority:
        - example.com
      routes:
        - name: my-first-route
          grpc:
            match:
              fqmn:
                prefix_match: /
            route:
              backend_group_id: ds7dq9nsrgpc********
              max_timeout: 60s
              idle_timeout: 5s
              auto_host_rewrite: false
        - name: my-third-route
          grpc:
            match:
              fqmn:
                prefix_match: myapp/
            route:
              backend_group_id: ds7dq9nsrgpc********
              max_timeout: 10s
              idle_timeout: 5s
              rate_limit:
                requests_per_ip:
                  per_second: "4"
          disable_security_profile: true
        - name: my-second-route
          grpc:
            match:
              fqmn:
                prefix_match: helloworld/
            route:
              backend_group_id: ds7dq9nsrgpc********
              max_timeout: 10s
              idle_timeout: 5s
              rate_limit:
                requests_per_ip:
                  per_second: "4"
          disable_security_profile: true
      modify_request_headers:
        - name: Accept-Language
          append: ru-RU
      route_options:
        security_profile_id: fevu5fnuk6vf********
      rate_limit:
        all_requests:
          per_second: "100"
      ```

      {% endcut %}

      For more details about the `yc alb virtual-host insert-grpc-route` command, see the [CLI reference](../../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/insert-grpc-route.md).

{% endlist %}