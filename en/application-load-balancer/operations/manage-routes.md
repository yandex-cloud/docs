---
title: How to manage HTTP router routes in {{ alb-full-name }}
description: Follow this guide to create, update, and delete routes in an HTTP router's virtual host in {{ alb-full-name }}.
---

# Managing routes

[Routes](../concepts/http-router.md) are sets of conditions (predicates) that are used by the [load balancer](../concepts/application-load-balancer.md) to select the request's next forwarding direction and actions to perform with it. Possible conditions and actions depend on the [route type](../concepts/http-router.md#routes-types).

## Creating a route {#create-route}

To create a route in a [virtual host](../concepts/http-router.md#virtual-host) of an HTTP router:

{% include [console-update-http-route-naming-step](../../_includes/application-load-balancer/instruction-steps/route-create-complete-section.md) %}

## Updating a route {#update-route}

To update a route in a [virtual host](../concepts/http-router.md#virtual-host) of an HTTP router:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you are going to update a virtual host route in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, click ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** and select the [HTTP router](../concepts/http-router.md) that contains the route you need.
  1. On the page that opens, under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, locate the route in the virtual host section, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to its name, and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. In the window that opens, depending on the [type](../concepts/http-router.md#routes-types) of your route:

      {% list tabs group=alb_route_type%}

      - HTTP {#http}

        1. {% include [console-update-http-route-ss1](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-ss1.md) %}
        1. {% include [console-update-http-route-ss2](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-ss2.md) %}
        1. {% include [console-update-http-route-ss3](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-ss3.md) %}
        1. {% include [console-update-http-route-ss4](../../_includes/application-load-balancer/instruction-steps/console-update-http-route-ss4.md) %}

      - gRPC {#grpc}

        1. {% include [console-update-grpc-route-ss1](../../_includes/application-load-balancer/instruction-steps/console-update-grpc-route-ss1.md) %}
        1. {% include [console-update-grpc-route-ss2](../../_includes/application-load-balancer/instruction-steps/console-update-grpc-route-ss2.md) %}
        1. {% include [console-update-grpc-route-ss3](../../_includes/application-load-balancer/instruction-steps/console-update-grpc-route-ss3.md) %}

      {% endlist %}

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  With the {{ yandex-cloud }} CLI, you can update different [types](../concepts/http-router.md#routes-types) of routes in the virtual host:

  {% list tabs group=alb_route_type%}

  - HTTP {#http}

    1. See the description of the CLI command for updating a virtual host route:

        ```bash
        yc alb virtual-host update-http-route --help
        ```
    1. {% include [cli-vh-list-http-routers](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-http-routers.md) %}
    1. {% include [cli-vh-list-vhs](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-vhs.md) %}
    1. To get a list of a virtual host's routes, run this command by substituting the virtual host name and the HTTP router name or ID in the `--http-router-name` or `--http-router-id` parameter, respectively:

        ```bash
        yc alb virtual-host get <virtual_host_name> \
          --http-router-name <HTTP_router_name> \
          --http-router-id <HTTP_router_ID>
        ```

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
        modify_request_headers:
          - name: Accept-Language
            append: ru-RU
        modify_response_headers:
          - name: Accept-Language
            append: ru-RU
        route_options:
          security_profile_id: fevu5fnuk6vf********
        rate_limit:
          all_requests:
            per_second: "5"
          requests_per_ip:
            per_second: "3"
        ```

        {% endcut %}

    1. Update the route by specifying its name and additional parameters:

        ```bash
        yc alb virtual-host update-http-route <route_name> \
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

        * `--http-router-name`: Name of the HTTP router the route is in.

            Instead of the HTTP router name, you can provide its ID in the `--http-router-id` parameter.
        * `--virtual-host-name`: Name of the virtual host the route is in.
        * `--match-http-method`: List of HTTP [methods](https://en.wikipedia.org/wiki/HTTP#Request_methods) for which to route the requests. For example: `--match-http-method GET,POST,OPTIONS`.

            To clear the list of HTTP methods set for the route, provide the `--clear-method-match` parameter in the command.
        * Path-based routing condition parameters:

            * `--exact-path-match`: Route requests with the same path as the specified one. For example, to route all requests, specify the `/` path.
            * `--prefix-path-match`: Route requests whose path starts with the specified prefix. For example: `myapp/`.
            * `--regex-path-match`: Route requests whose path matches the specified [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression). For example: `[a-z]{10}[0-9]{3}\/`.

            {% note info %}

            The `--exact-path-match`, `--prefix-path-match`, and `--regex-path-match` parameters are mutually exclusive: you can use only one of them.

            {% endnote %}

            To clear the path-based routing conditions set for the route, provide the `--clear-path-match` parameter in the command.

        * `--backend-group-name`: Name of the [backend group](../concepts/backend-group.md) located in the same folder as the [HTTP router](../concepts/http-router.md), virtual host, and route.
        
            Instead of the backend group name, you can provide its ID in the `--backend-group-id` parameter.
        * `--request-timeout`: Maximum connection time in seconds for a connection on request.

            To clear the request timeout set for the route, provide the `--clear-request-timeout` parameter in the command.
        * `--request-idle-timeout`: Maximum connection idle time in seconds.

            To clear the idle timeout set for the route, provide the `--clear-idle-timeout` parameter in the command.
        * {% include [cli-route-creation-rate-limit](../../_includes/application-load-balancer/instruction-steps/cli-route-creation-rate-limit.md) %}

            To clear the route's request rate limits settings, provide the `--clear-rate-limit` parameter in the command.
        * {% include [cli-route-creation-disable-security-profile](../../_includes/application-load-balancer/instruction-steps/cli-route-creation-disable-security-profile.md) %}

            To re-enable the security profile previously disabled for the route, provide the `--disable-security-profile=false` parameter in the command.


        {% cut "Result:" %}

        ```text
        name: test-virtual-host
        authority:
          - example.com
        routes:
          - name: my-first-route
            http:
              match:
                http_method:
                  - POST
                  - PATCH
                path:
                  exact_match: /
              route:
                backend_group_id: ds7dnf2s5dco********
                timeout: 12s
                idle_timeout: 6s
                host_rewrite: myapp
                prefix_rewrite: yourapp/
                rate_limit:
                  requests_per_ip:
                    per_second: "5"
          modify_request_headers:
            - name: Accept-Language
              append: ru-RU
          modify_response_headers:
            - name: Accept-Language
              append: ru-RU
          route_options:
            security_profile_id: fevu5fnuk6vf********
          rate_limit:
            all_requests:
              per_second: "5"
            requests_per_ip:
              per_second: "3"
        ```

        {% endcut %}

        For more details about the `yc alb virtual-host update-http-route` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/update-http-route.md).

  - gRPC {#grpc}

    1. See the description of the CLI command for updating a virtual host route:

        ```bash
        yc alb virtual-host update-grpc-route --help
        ```
    1. {% include [cli-vh-list-http-routers](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-http-routers.md) %}
    1. {% include [cli-vh-list-vhs](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-vhs.md) %}
    1. To get a list of a virtual host's routes, run this command by substituting the virtual host name and the HTTP router name or ID in the `--http-router-name` or `--http-router-id` parameter, respectively:

        ```bash
        yc alb virtual-host get <virtual_host_name> \
          --http-router-name <HTTP_router_name> \
          --http-router-id <HTTP_router_ID>
        ```

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
                max_timeout: 10s
                idle_timeout: 5s
                host_rewrite: myapp
                rate_limit:
                  all_requests:
                    per_second: "12"
                  requests_per_ip:
                    per_second: "6"
        modify_request_headers:
          - name: Accept-Language
            append: ru-RU
        modify_response_headers:
          - name: Accept-Language
            append: ru-RU
        route_options:
          security_profile_id: fevu5fnuk6vf********
        rate_limit:
          all_requests:
            per_second: "5"
          requests_per_ip:
            per_second: "3"
        ```

        {% endcut %}

    1. Update the route by specifying its name and additional parameters:

        ```bash
        yc alb virtual-host update-grpc-route <route_name> \
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

        * `--http-router-name`: Name of the HTTP router the route is in.

            Instead of the HTTP router name, you can provide its ID in the `--http-router-id` parameter.
        * `--virtual-host-name`: Name of the virtual host the route is in.
        * FQMN-based routing condition parameters:

            * `--exact-fqmn-match`: Route requests with the same FQMN as the specified one.
            * `--prefix-fqmn-match`: Route requests whose FQMN starts with the specified prefix. For example, you can specify the first word of the service name: `/helloworld`.
            * `--regex-fqmn-match`: Route requests whose FQMN matches the specified [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression). For example: `\/[a-z]{10}[0-9]{3}`.

            {% include [fqmn-slash-warning](../../_includes/application-load-balancer/instruction-steps/fqmn-slash-warning.md) %}

            {% note info %}

            The `--exact-fqmn-match`, `--prefix-fqmn-match`, and `--regex-fqmn-match` parameters are mutually exclusive: you can use only one of them.

            {% endnote %}

            To clear the FQMN-based routing conditions set for the route, provide the `--clear-fqmn-match` parameter in the command.
        * `--backend-group-name`: Name of the [backend group](../concepts/backend-group.md) located in the same folder as the [HTTP router](../concepts/http-router.md), virtual host, and route.
        
            Instead of the backend group name, you can provide its ID in the `--backend-group-id` parameter.
        * `--request-max-timeout`: Maximum connection time. You can specify a shorter timeout in the `grpc-timeout` request HTTP header.

            To clear the connection timeout set for the route, provide the `--clear-max-timeout` parameter in the command.
        * `--request-idle-timeout`: Maximum connection idle time in seconds.

            To clear the idle timeout set for the route, provide the `--clear-idle-timeout` parameter in the command.
        * {% include [cli-route-creation-rate-limit](../../_includes/application-load-balancer/instruction-steps/cli-route-creation-rate-limit.md) %}

            To clear the route's request rate limits settings, provide the `--clear-rate-limit` parameter in the command.
        * {% include [cli-route-creation-disable-security-profile](../../_includes/application-load-balancer/instruction-steps/cli-route-creation-disable-security-profile.md) %}

            To re-enable the security profile previously disabled for the route, provide the `--disable-security-profile=false` parameter in the command.


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
                  exact_match: /myapp
              route:
                backend_group_id: ds7dq9nsrgpc********
                max_timeout: 12s
                idle_timeout: 6s
                host_rewrite: myapp
                rate_limit:
                  all_requests:
                    per_second: "12"
                  requests_per_ip:
                    per_second: "6"
            disable_security_profile: true
        modify_request_headers:
          - name: Accept-Language
            append: ru-RU
        modify_response_headers:
          - name: Accept-Language
            append: ru-RU
        route_options:
          security_profile_id: fevu5fnuk6vf********
        rate_limit:
          all_requests:
            per_second: "5"
          requests_per_ip:
            per_second: "3"
        ```

        {% endcut %}

        For more details about the `yc alb virtual-host update-grpc-route` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/update-grpc-route.md).

  {% endlist %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, update the parameters of the route as a resource nested in a [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host) resource. With {{ TF }}, you can update different [types](../concepts/http-router.md#routes-types) of routes in the virtual host:

      {% list tabs group=alb_route_type%}

      - HTTP {#http}

        {% include [tf-route-http-hcl-code](../../_includes/application-load-balancer/instruction-steps/tf-route-http-hcl-code.md) %}

        Where:

        * `route`: Virtual host route description:

            {% include [tf-vh-create-legend-route-general](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-general.md) %}

            {% include [tf-vh-create-legend-route-http](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-http.md) %}

      - gRPC {#grpc}

        {% include [tf-route-grpc-hcl-code](../../_includes/application-load-balancer/instruction-steps/tf-route-grpc-hcl-code.md) %}

        Where:

        * `route`: Virtual host route description:

            {% include [tf-vh-create-legend-route-general](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-general.md) %}

            {% include [tf-vh-create-legend-route-grpc](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-grpc.md) %}

      {% endlist %}

      Learn more about the properties of {{ TF }} resources in the relevant provider guide: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Update the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
      {{ TF }} will create all the required resources. You can check the new resources, their updates, and settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

      ```bash
      yc alb virtual-host get <virtual_host_name> \
        --http-router-name <HTTP_router_name>
      ```

- API {#api}

  Use the [updateRoute](../api-ref/VirtualHost/updateRoute.md) REST API method for the [VirtualHost](../api-ref/VirtualHost/index.md) resource or the [VirtualHostService/UpdateRoute](../api-ref/grpc/VirtualHost/updateRoute.md) gRPC API call.

{% endlist %}

## Changing route order {#sort-routes}

To reorder routes in a [virtual host](../concepts/http-router.md#virtual-host) of an HTTP router:

{% include [reorder-routes-complete-section](../../_includes/application-load-balancer/instruction-steps/reorder-routes-complete-section.md) %}

## Deleting a route {#delete-route}

To delete a route from a [virtual host](../concepts/http-router.md#virtual-host) of an HTTP router:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to delete a virtual host route from.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, click ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** and select the [HTTP router](../concepts/http-router.md) that contains the route you need.
  1. On the page that opens, under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, locate the route in the virtual host section, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to its name, and select ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  With the {{ yandex-cloud }} CLI, you can delete different [types](../concepts/http-router.md#routes-types) of routes from a virtual host:

  {% list tabs group=alb_route_type%}

  - HTTP {#http}

    1. See the description of the CLI command for deleting a virtual host route:

        ```bash
        yc alb virtual-host remove-http-route --help
        ```
    1. {% include [cli-vh-list-http-routers](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-http-routers.md) %}
    1. {% include [cli-vh-list-vhs](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-vhs.md) %}
    1. To get a list of a virtual host's routes, run this command by substituting the virtual host name and the HTTP router name or ID in the `--http-router-name` or `--http-router-id` parameter, respectively:

        ```bash
        yc alb virtual-host get <virtual_host_name> \
          --http-router-name <HTTP_router_name> \
          --http-router-id <HTTP_router_ID>
        ```

        {% include [cli-route-delete-route](../../_includes/application-load-balancer/instruction-steps/cli-route-delete-route.md) %}

    1. Delete a route by specifying its name, virtual host details, and HTTP router details:

        ```bash
        yc alb virtual-host remove-http-route <route_name> \
          --http-router-name <HTTP_router_name> \
          --virtual-host-name <virtual_host_name>
        ```

        Where:

        * `--http-router-name`: Name of the HTTP router the route is in.

            Instead of the HTTP router name, you can provide its ID in the `--http-router-id` parameter.
        * `--virtual-host-name`: Name of the virtual host the route is in.

        {% cut "Result:" %}

        ```text
        name: test-virtual-host
        authority:
          - example.com
        routes:
          - name: my-first-grpc-route
            grpc:
              match:
                fqmn:
                  prefix_match: /
              route:
                backend_group_id: ds7dq9nsrgpc********
                max_timeout: 10s
                idle_timeout: 5s
                host_rewrite: myapp
                rate_limit:
                  all_requests:
                    per_second: "12"
                  requests_per_ip:
                    per_second: "6"
        modify_request_headers:
          - name: Accept-Language
            append: ru-RU
        modify_response_headers:
          - name: Accept-Language
            append: ru-RU
        route_options:
          security_profile_id: fevu5fnuk6vf********
        rate_limit:
          all_requests:
            per_second: "5"
          requests_per_ip:
            per_second: "3"
        ```

        {% endcut %}

        For more details about the `yc alb virtual-host remove-http-route` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/remove-http-route.md).

  - gRPC {#grpc}

    1. See the description of the CLI command for deleting a virtual host route:

        ```bash
        yc alb virtual-host remove-grpc-route --help
        ```
    1. {% include [cli-vh-list-http-routers](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-http-routers.md) %}
    1. {% include [cli-vh-list-vhs](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-vhs.md) %}
    1. To get a list of a virtual host's routes, run this command by substituting the virtual host name and the HTTP router name or ID in the `--http-router-name` or `--http-router-id` parameter, respectively:

        ```bash
        yc alb virtual-host get <virtual_host_name> \
          --http-router-name <HTTP_router_name> \
          --http-router-id <HTTP_router_ID>
        ```

        {% include [cli-route-delete-route](../../_includes/application-load-balancer/instruction-steps/cli-route-delete-route.md) %}

    1. Delete a route by specifying its name, virtual host details, and HTTP router details:

        ```bash
        yc alb virtual-host remove-grpc-route <route_name> \
          --http-router-name <HTTP_router_name> \
          --virtual-host-name <virtual_host_name>
        ```

        Where:

        * `--http-router-name`: Name of the HTTP router the route is in.

            Instead of the HTTP router name, you can provide its ID in the `--http-router-id` parameter.
        * `--virtual-host-name`: Name of the virtual host the route is in.

        {% cut "Result:" %}

        ```text
        name: test-virtual-host
        authority:
          - example.com
        routes:
          - name: my-first-http-route
            http:
              match:
                http_method:
                  - GET
                  - POST
                path:
                  prefix_match: myapp/
              route:
                backend_group_id: ds7dnf2s5dco********
                timeout: 10s
                idle_timeout: 3s
                host_rewrite: myapp
                prefix_rewrite: yourapp/
                rate_limit:
                  all_requests:
                    per_second: "12"
                  requests_per_ip:
                    per_minute: "120"
        modify_request_headers:
          - name: Accept-Language
            append: ru-RU
        modify_response_headers:
          - name: Accept-Language
            append: ru-RU
        route_options:
          security_profile_id: fevu5fnuk6vf********
        rate_limit:
          all_requests:
            per_second: "5"
          requests_per_ip:
            per_second: "3"
        ```

        {% endcut %}

        For more details about the `yc alb virtual-host remove-grpc-route` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/remove-grpc-route.md).

  {% endlist %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Delete from the configuration file the description of the route as a resource nested in a [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host) resource.

      {% include [tf-route-reorder-delete-route](../../_includes/application-load-balancer/instruction-steps/tf-route-reorder-delete-route.md) %}

      Learn more about the properties of {{ TF }} resources in the relevant provider guide: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Update the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
      {{ TF }} will create all the required resources. You can check the new resources, their deletion status, and settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

      ```bash
      yc alb virtual-host get <virtual_host_name> \
        --http-router-name <HTTP_router_name>
      ```

- API {#api}

  Use the [removeRoute](../api-ref/VirtualHost/removeRoute.md) REST API method for the [VirtualHost](../api-ref/VirtualHost/index.md) resource or the [VirtualHostService/RemoveRoute](../api-ref/grpc/VirtualHost/removeRoute.md) gRPC API call.

{% endlist %}