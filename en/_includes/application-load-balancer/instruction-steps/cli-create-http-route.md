{{ yandex-cloud }} CLI allows using three different commands to add HTTP routes to a virtual host:

* `yc alb virtual-host append-http-route`: Adds a route to the end of the list of virtual host routes.
* `yc alb virtual-host append-http-route`: Adds a route to the beginning of the list of virtual host routes.
* `yc alb virtual-host append-http-route`: Adds a route to a specified place in the list of virtual host routes.

{% list tabs %}

- append-http-route

  1. {% include [cli-vh-append-http-route-help](./cli-vh-append-http-route-help.md) %}
  1. {% include [cli-vh-list-http-routers](./cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-list-vhs](./cli-vh-list-vhs.md) %}
  1. {% include [cli-vh-append-http-route-code](./cli-vh-append-http-route-code.md) %}

      Where:

      {% include [cli-http-route-creation-legend](./cli-http-route-creation-legend.md) %}

      {% include [cli-vh-append-http-route-output](./cli-vh-append-http-route-output.md) %}

- prepend-http-route

  1. See the description of the CLI command for adding a route to the beginning of the route list:

      ```bash
      yc alb virtual-host prepend-http-route --help
      ```
  1. {% include [cli-vh-list-http-routers](./cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-list-vhs](./cli-vh-list-vhs.md) %}
  1. Add the route by specifying its name and additional parameters:

      ```bash
      yc alb virtual-host prepend-http-route <route_name> \
        --http-router-name <HTTP_router_name> \
        --virtual-host-name <virtual_host_name> \
        --match-http-method <method_1>,<method_2>,...<method_n> \
        --exact-path-match <full_path> \
        --prefix-path-match <path_prefix> \
        --regex-path-match <regular_expression> \
        --backend-group-name <backend_group_name> \
        --request-timeout <request_timeout>s \
        --request-idle-timeout <request_idle_timeout>s \
        --rate-limit rps=<request_limit>,requests-per-ip \
        --disable-security-profile
      ```

      Where:

      {% include [cli-http-route-creation-legend](./cli-http-route-creation-legend.md) %}

      {% cut "Result:" %}

      ```text
      name: test-virtual-host
      authority:
        - example.com
      routes:
        - name: my-second-route
          http:
            match:
              http_method:
                - GET
                - POST
                - OPTIONS
              path:
                exact_match: /
            route:
              backend_group_id: ds7dnf2s5dco********
              timeout: 2s
              idle_timeout: 5s
              rate_limit:
                requests_per_ip:
                  per_second: "10"
          disable_security_profile: true
        - name: my-first-route
          http:
            match:
              path:
                prefix_match: /
            route:
              backend_group_id: ds7dnf2s5dco********
              timeout: 60s
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

      For more details about the `yc alb virtual-host prepend-http-route` command, see the [CLI reference](../../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/prepend-http-route.md).

- insert-http-route

  1. See the description of the CLI command for adding a route to a specified place in the route list:

      ```bash
      yc alb virtual-host insert-http-route --help
      ```
  1. {% include [cli-vh-list-http-routers](./cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-list-vhs](./cli-vh-list-vhs.md) %}
  1. {% include [cli-vh-get-vh](./cli-vh-get-vh.md) %}

      {% include [cli-vh-get-vh-output](./cli-vh-get-vh-output.md) %}

  1. Add the route by specifying its name and additional parameters:

      ```bash
      yc alb virtual-host insert-http-route <route_name> \
        --http-router-name <HTTP_router_name> \
        --virtual-host-name <virtual_host_name> \
        --match-http-method <method_1>,<method_2>,...<method_n> \
        --exact-path-match <full_path> \
        --prefix-path-match <path_prefix> \
        --regex-path-match <regular_expression> \
        --backend-group-name <backend_group_name> \
        --request-timeout <request_timeout>s \
        --request-idle-timeout <request_idle_timeout>s \
        --rate-limit rps=<request_limit>,requests-per-ip \
        --disable-security-profile \
        --before <name_of_next_route> \
        --after <name_of_previous_route>
      ```

      Where:

      {% include [cli-http-route-creation-legend](./cli-http-route-creation-legend.md) %}

      {% include [cli-grpc-route-creation-legend-before-after](./cli-grpc-route-creation-legend-before-after.md) %}

      {% cut "Result:" %}

      ```text
      name: test-virtual-host
      authority:
        - example.com
      routes:
        - name: my-first-route
          http:
            match:
              path:
                prefix_match: /
            route:
              backend_group_id: ds7dnf2s5dco********
              timeout: 60s
              auto_host_rewrite: false
        - name: my-third-route
          http:
            match:
              http_method:
                - PATCH
                - PUT
              path:
                exact_match: /
            route:
              backend_group_id: ds7dnf2s5dco********
              timeout: 2s
              idle_timeout: 5s
              rate_limit:
                requests_per_ip:
                  per_second: "10"
          disable_security_profile: true
        - name: my-second-route
          http:
            match:
              http_method:
                - GET
                - POST
                - OPTIONS
              path:
                exact_match: /
            route:
              backend_group_id: ds7dnf2s5dco********
              timeout: 2s
              idle_timeout: 5s
              rate_limit:
                requests_per_ip:
                  per_second: "10"
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

      For more details about the `yc alb virtual-host insert-http-route` command, see the [CLI reference](../../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/insert-http-route.md).

{% endlist %}