---
title: How to manage virtual hosts in {{ alb-full-name }}
description: Follow this guide to create, update, or delete HTTP router's virtual hosts in {{ alb-full-name }}.
---

# Managing virtual hosts

[Virtual hosts](../concepts/http-router.md#virtual-host) within [HTTP routers](../concepts/http-router.md) consolidate [routes](../concepts/http-router.md#routes) belonging to the same set of domains, i.e., the `Host` (`:authority`) header values of an HTTP request. On an incoming request, the [load balancer](../concepts/application-load-balancer.md) checks route predicates one by one and selects the first one matching the request.

## Creating a virtual host {#create-vh}

To create a virtual host:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you are going to create a virtual host.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, click ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** and select the [HTTP router](../concepts/http-router.md) you are going to create a virtual host in.
  
      [Create](./http-router-create.md) a new HTTP router if needed.
  1. In the top panel, click ![cube](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.alb.button_virtual-host-create }}** and in the window that opens:

      1. {% include [console-name-vh](../../_includes/application-load-balancer/instruction-steps/console-name-vh.md) %}
      1. In the **{{ ui-key.yacloud.alb.label_authority }}** field, specify:

          * For HTTP traffic, the value of the `Host` header for HTTP/1.1 or the `:authority` pseudo-header for HTTP/2 that will be used to select this virtual host.
          * For gRPC traffic, `*` or the [IP address](../../vpc/concepts/address.md) of the load balancer.

          If needed, use the **{{ ui-key.yacloud.alb.button_add-host-id }}** button to assign additional **{{ ui-key.yacloud.alb.label_authority }}** values to the virtual host.

          {% include [console-no-authority-notice](../../_includes/application-load-balancer/instruction-steps/console-no-authority-notice.md) %}

      1. {% include [console-vh-form-sws-step](../../_includes/application-load-balancer/instruction-steps/console-vh-form-sws-step.md) %}
      1. {% include [console-vh-form-albnative-rl-step](../../_includes/application-load-balancer/instruction-steps/console-vh-form-albnative-rl-step.md) %}
      1. {% include [console-vh-form-header-mods-step](../../_includes/application-load-balancer/instruction-steps/console-vh-form-header-mods-step.md) %}
      1. Optionally, [create](./manage-routes.md#create-route) the necessary routes for your new virtual host's traffic.
      1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. {% include [cli-vh-create-help](../../_includes/application-load-balancer/instruction-steps/cli-vh-create-help.md) %}
  1. {% include [cli-vh-list-http-routers](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-create](../../_includes/application-load-balancer/instruction-steps/cli-vh-create.md) %}

  For more information about the `alb virtual-host create` command, see this [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Describe the virtual host parameters in the configuration file. With {{ TF }}, you can create virtual hosts with different route [types](../concepts/http-router.md#routes-types):

      {% list tabs group=alb_route_type%}

      - HTTP {#http}

        {% include [tf-vh-http-create-manifest](../../_includes/application-load-balancer/instruction-steps/tf-vh-http-create-manifest.md) %}

        Where:

        * `yandex_alb_virtual_host`: Virtual host description:

            {% include [tf-vh-create-legend-part1](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-part1.md) %}

            * `route`: Virtual host route description:

                {% include [tf-vh-create-legend-route-general](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-general.md) %}

                {% include [tf-vh-create-legend-route-http](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-http.md) %}

            {% include [tf-vh-create-legend-last-part](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-last-part.md) %}

      - gRPC {#grpc}

        {% include [tf-vh-grpc-create-manifest](../../_includes/application-load-balancer/instruction-steps/tf-vh-grpc-create-manifest.md) %}

        Where:

        * `yandex_alb_virtual_host`: Virtual host description:

            {% include [tf-vh-create-legend-part1](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-part1.md) %}

            * `route`: Virtual host route description:

                {% include [tf-vh-create-legend-route-general](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-general.md) %}

                {% include [tf-vh-create-legend-route-grpc](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-grpc.md) %}

            {% include [tf-vh-create-legend-last-part](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-last-part.md) %}

      {% endlist %}

      Learn more about the properties of {{ TF }} resources in the relevant provider guide: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

      ```bash
      yc alb virtual-host get <virtual_host_name> \
        --http-router-name <HTTP_router_name>
      ```

      {% include [Terraform timeouts](../../_includes/application-load-balancer/terraform-timeout-router-and-host.md) %}

- API {#api}

  Use the [create](../api-ref/VirtualHost/create.md) REST API method for the [VirtualHost](../api-ref/VirtualHost/index.md) resource or the [VirtualHostService/Create](../api-ref/grpc/VirtualHost/create.md) gRPC API call.

{% endlist %}

## Updating a virtual host {#update-vh}

To update a virtual host:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing your virtual host.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, click ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** and select the [HTTP router](../concepts/http-router.md) that contains the virtual host.
  1. On the page that opens, under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to the virtual host and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**. In the window that opens, do the following:

      1. Optionally, in the **{{ ui-key.yacloud.alb.label_authority }}** field, update the settings and specify:

          * For HTTP traffic, the value of the `Host` header for HTTP/1.1 or the `:authority` pseudo-header for HTTP/2 that will be used to select this virtual host.
          * For gRPC traffic, `*` or the [IP address](../../vpc/concepts/address.md) of the load balancer.

          If needed, use the **{{ ui-key.yacloud.alb.button_add-host-id }}** button to assign additional **{{ ui-key.yacloud.alb.label_authority }}** values to the virtual host.

          {% include [console-no-authority-notice](../../_includes/application-load-balancer/instruction-steps/console-no-authority-notice.md) %}
      1. {% include [console-vh-form-sws-step](../../_includes/application-load-balancer/instruction-steps/console-vh-form-sws-step.md) %}
      1. {% include [console-vh-form-albnative-rl-step](../../_includes/application-load-balancer/instruction-steps/console-vh-form-albnative-rl-step.md) %}
      1. Optionally, expand the **{{ ui-key.yacloud.alb.label_modifications }}** section and configure a [HTTP header](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields) modification. If there are none yet, click **{{ ui-key.yacloud.alb.button_add-modification }}** to add a new header modification:

          {% include [console-vh-form-header-mods-step-part2](../../_includes/application-load-balancer/instruction-steps/console-vh-form-header-mods-step-part2.md) %}
      1. Optionally, [create](./manage-routes.md#create-route) the necessary routes for your new virtual host's traffic.
      1. {% include [console-reorder-routes](../../_includes/application-load-balancer/instruction-steps/console-reorder-routes.md) %}
      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for updating a virtual host:

      ```bash
      yc alb virtual-host update --help
      ```
  1. {% include [cli-vh-list-http-routers](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-list-vhs](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-vhs.md) %}
  1. To update a virtual host, put in its name and run this command:

      ```bash
      yc alb virtual-host update <virtual_host_name> \
        --http-router-name <HTTP_router_name> \
        --authority <domain_1>,<domain_2>,...,<domain_n> \
        --modify-request-header name=Accept-Language,append=ru-RU \
        --modify-response-header name=Accept-Charset,replace=utf-8 \
        --rate-limit rps=100,all-requests \
        --security-profile-id <security_profile_ID> \
        --clear-routes
      ```

      Where:
      * `--http-router-name`: HTTP router name.

          Instead of the HTTP router name, you can provide its ID in the `--http-router-id` parameter.
      * `--authority`: List of domains for the `Host` header (HTTP/1.1) or the `authority` pseudo-header (HTTP/2) associated with this virtual host, comma-separated. You can use wildcards, e.g., `*.foo.com` or `*-bar.foo.com`. For gRPC traffic, you may specify the load balancer's IP address.

          This is an optional parameter. If not specified, all traffic will be routed to this virtual host.

          To remove the current list of domains assigned to the virtual host, provide the `--clear-authorities` parameter in the command.
      * `--modify-request-header`: Request HTTP header modification settings in `<property>=<value>` format. Available properties:

          {% include [cli-vh-modify-header-options](../../_includes/application-load-balancer/instruction-steps/cli-vh-modify-header-options.md) %}

          To modify multiple HTTP headers in a request, include `--modify-request-header` as many times as needed.

          This is an optional parameter; if omitted, request headers are provided to the backend unchanged.

          To clear all request header modification settings for the virtual host, provide the `--clear-request-header-modifications` parameter in the command.
      * `--modify-response-header`: Response HTTP header modification settings in `<property>=<value>` format. Available properties: 

          {% include [cli-vh-modify-header-options](../../_includes/application-load-balancer/instruction-steps/cli-vh-modify-header-options.md) %}

          To modify multiple HTTP headers in a response, include `--modify-response-header` as many times as needed.

          This is an optional parameter; if omitted, response headers are provided to the client unchanged.

          To clear all response HTTP header modification settings for the virtual host, provide the `--clear-response-header-modifications` parameter in the command.
      * `--rate-limit`: Request rate limit. Available properties:
          * `rps` or `rpm`: Number of incoming requests per second or per minute.
          * `all-requests`: Limits all incoming requests.
          * `requests-per-ip` Applies the limit per client IP address.

          You can configure only one type of rate limit per virtual host, either `all-requests` or `requests-per-ip`.

          This is an optional parameter; if not specified, no rate limiting is applied.

          To clear all rate-limiting settings from the virtual host, provide the `--clear-rate-limit` parameter in the command.
      * `--security-profile-id`: [{{ sws-full-name }}](../../smartwebsecurity/index.yaml) [security profile](../../smartwebsecurity/concepts/profiles.md) ID. A security profile allows you to filter incoming requests, enable [WAF](../../smartwebsecurity/concepts/waf.md), and set limits on the number of requests for protection against malicious activities. For more information, see [{#T}](../../smartwebsecurity/concepts/profiles.md). This is an optional parameter.

          To detach a security profile from the virtual host, provide an empty value in the flag: `--security-profile-id ""`.

      * `--clear-routes`: Clears all routes from the virtual host. This is an optional parameter.

      Result:

      ```text
      name: test-virtual-host
      authority:
        - example.com
      modify_request_headers:
        - name: Accept-Language
          replace: ru-RU
      modify_response_headers:
        - name: Accept-Charset
          append: utf-8
      route_options:
        security_profile_id: fevu5fnuk6vf********
      rate_limit:
        all_requests:
          per_second: "80"
      ```

  For more information about the `yc alb virtual-host update` command, see this [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/update.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Describe the updated virtual host parameters in the configuration file. With {{ TF }}, you can create virtual hosts with different route [types](../concepts/http-router.md#routes-types):

      {% list tabs group=alb_route_type%}

      - HTTP {#http}

        {% include [tf-vh-http-create-manifest](../../_includes/application-load-balancer/instruction-steps/tf-vh-http-create-manifest.md) %}

        Where:

        * `yandex_alb_virtual_host`: Virtual host description:

            {% include [tf-vh-create-legend-part1](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-part1.md) %}

            * `route`: Virtual host route description:

                {% include [tf-vh-create-legend-route-general](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-general.md) %}

                {% include [tf-vh-create-legend-route-http](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-http.md) %}

            {% include [tf-vh-create-legend-last-part](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-last-part.md) %}

      - gRPC {#grpc}

        {% include [tf-vh-grpc-create-manifest](../../_includes/application-load-balancer/instruction-steps/tf-vh-grpc-create-manifest.md) %}

        Where:

        * `yandex_alb_virtual_host`: Virtual host description:

            {% include [tf-vh-create-legend-part1](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-part1.md) %}

            * `route`: Virtual host route description:

                {% include [tf-vh-create-legend-route-general](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-general.md) %}

                {% include [tf-vh-create-legend-route-grpc](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-route-grpc.md) %}

            {% include [tf-vh-create-legend-last-part](../../_includes/application-load-balancer/instruction-steps/tf-vh-create-legend-last-part.md) %}

      {% endlist %}

      Learn more about the properties of {{ TF }} resources in the relevant provider guide: [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Update the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
      {{ TF }} will update the required resources. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

      ```bash
      yc alb virtual-host get <virtual_host_name> \
        --http-router-name <HTTP_router_name>
      ```

      {% include [Terraform timeouts](../../_includes/application-load-balancer/terraform-timeout-router-and-host.md) %}

- API {#api}

  Use the [update](../api-ref/VirtualHost/update.md) REST API method for the [VirtualHost](../api-ref/VirtualHost/index.md) resource or the [VirtualHostService/Update](../api-ref/grpc/VirtualHost/update.md) gRPC API call.

{% endlist %}

## Deleting a virtual host {#delete-vh}

To delete a virtual host:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing your virtual host.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, click ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}** and select the [HTTP router](../concepts/http-router.md) that contains the virtual host.
  1. On the page that opens, under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to the virtual host and select ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting a virtual host:

      ```bash
      yc alb virtual-host delete --help
      ```
  1. {% include [cli-vh-list-http-routers](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-http-routers.md) %}
  1. {% include [cli-vh-list-vhs](../../_includes/application-load-balancer/instruction-steps/cli-vh-list-vhs.md) %}
  1. To delete a virtual host, put in its name and run this command:

      ```bash
      yc alb virtual-host delete <virtual_host_name> \
        --http-router-name <HTTP_router_name>
      ```

      Where `--http-router-name` is the HTTP router name. Instead of the HTTP router name, you can provide its ID in the `--http-router-id` parameter.

  For more information about the `yc alb virtual-host delete` command, see this [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/delete.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete a virtual host created with {{ TF }}:

  1. Open the {{ TF }} configuration file and remove the fragment describing the virtual host (the `yandex_alb_virtual_host` resource).

      {% cut "Example of a virtual host description in a {{ TF }} configuration" %}

      {% include [tf-vh-http-create-manifest](../../_includes/application-load-balancer/instruction-steps/tf-vh-http-create-manifest.md) %}

      {% endcut %}

  1. Update the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will update the required resources. You can check for your resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

      ```bash
      yc alb virtual-host list \
        --http-router-name <HTTP_router_name>
      ```

      {% include [Terraform timeouts](../../_includes/application-load-balancer/terraform-timeout-router-and-host.md) %}

- API {#api}

  Use the [delete](../api-ref/VirtualHost/delete.md) REST API method for the [VirtualHost](../api-ref/VirtualHost/index.md) resource or the [VirtualHostService/Delete](../api-ref/grpc/VirtualHost/delete.md) gRPC API call.

{% endlist %}
