---
title: How to create an HTTP router for HTTP traffic in {{ alb-full-name }}
description: In this tutorial, you will learn how to create an HTTP router for HTTP traffic.
---

# Creating an HTTP router for HTTP traffic

To create an [HTTP router](../concepts/http-router.md) and add a [route](../concepts/http-router.md#routes) to it:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your HTTP router.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Click **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. Specify your HTTP router name.
  1. Under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, click **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
  1. Specify the host name.
  1. Optionally, in the **{{ ui-key.yacloud.alb.label_authority }}** field, specify the HTTP/1.1 `Host` (HTTP/2 `:authority`) header value for virtual host selection.
  1. Optionally, in the **{{ ui-key.yacloud.alb.label_security-profile-id }}** field, select the [{{ sws-full-name }}](../../smartwebsecurity/) [security profile](../../smartwebsecurity/concepts/profiles.md). A security profile allows you to enable WAF and filter incoming requests, limiting their number for protection against malicious attacks. For more information, see [{#T}](../../smartwebsecurity/concepts/profiles.md).


  1. Optionally, under **{{ ui-key.yacloud.alb.label_modifications }}**, click **{{ ui-key.yacloud.alb.button_add-modification }}** and configure the [HTTP header](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields).
     * In the **{{ ui-key.yacloud.alb.label_modification-type }}** field, select:
       * `{{ ui-key.yacloud.alb.label_header-request }}`: To modify the incoming request header, from client to load balancer.
       * `{{ ui-key.yacloud.alb.label_header-response }}`: To modify outgoing response header, from backend to external client.
     * In the **{{ ui-key.yacloud.alb.label_modification-header }}** field, give the header a name, e.g., `Host`, `User-Agent`, `X-Forwarded-For`, or `Strict-Transport-Security`.
     * In the **{{ ui-key.yacloud.alb.label_modification-operation }}** field, select:
       * `append`: To add a specified string to the header value.
       * `replace`: To replace the header value with a specified string.
       * `remove`: To remove the header. Both the header value and the header will be removed.
       * `rename`: To rename the header. The header value will not change.
     * Enter a string to modify the header value or a new header name.
  1. Click **{{ ui-key.yacloud.alb.button_add-route }}**.
  1. Specify the route **{{ ui-key.yacloud.common.name }}**.
  1. In the **{{ ui-key.yacloud.alb.label_path }}** field, select one of the options:
     * `{{ ui-key.yacloud.alb.label_match-exact }}`: Route all requests matching the specified path, e.g., `/`.
     * `{{ ui-key.yacloud.alb.label_match-prefix }}`: Route all requests with a specific prefix.
     * `{{ ui-key.yacloud.alb.label_match-regex }}`: Route all requests matching the [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression).
  1. In the **{{ ui-key.yacloud.alb.label_http-methods }}** list, select the required methods.
  1. In the **{{ ui-key.yacloud.alb.label_route-action }}** field, select one of the options: `{{ ui-key.yacloud.alb.label_route-action-route }}`, `{{ ui-key.yacloud.alb.label_route-action-redirect }}`, or `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`. Depending on the selected option:
     * `{{ ui-key.yacloud.alb.label_route-action-route }}`:
       * In the **{{ ui-key.yacloud.alb.label_backend-group }}** field, select a [backend group](../concepts/backend-group.md) from your HTTP router folder.
       * Optionally, in the **{{ ui-key.yacloud.alb.label_prefix-rewrite }}** field, specify where the HTTP router should redirect traffic. If you select `{{ ui-key.yacloud.alb.label_match-exact }}` in the **{{ ui-key.yacloud.alb.label_path }}** field, the path will be completely rewritten. If you select `{{ ui-key.yacloud.alb.label_match-prefix }}`, only the prefix will be rewritten.
       * Optionally, in the **{{ ui-key.yacloud.alb.label_host-rewrite }}** field, select one of these options:
         * `none`: No rewriting.
         * `rewrite`: Rewrite to the specified value.
         * `auto`: Rewrite to the target VM address.
       * Optionally, in the **{{ ui-key.yacloud.alb.label_timeout }}** field, specify the maximum connection time.
       * Optionally, in the **{{ ui-key.yacloud.alb.label_idle-timeout }}** field, specify the maximum keep-alive time during which the connection can remain idle without transmitting data.
       * Optionally, in the **{{ ui-key.yacloud.alb.label_upgrade-types }}** field, specify the protocols the backend group can use within a single TCP connection based on the client's request.
       * Optionally, select **{{ ui-key.yacloud.alb.label_web-socket }}** if you want to use the WebSocket protocol.
     * `{{ ui-key.yacloud.alb.label_route-action-redirect }}`:
       * In the **{{ ui-key.yacloud.alb.label_http-status-code }}** field, select the HTTP forwarding status code.
       * Optionally, in the **{{ ui-key.yacloud.alb.label_replace }}** field, specify where the HTTP router should redirect traffic. If you select `{{ ui-key.yacloud.alb.label_match-exact }}` in the **{{ ui-key.yacloud.alb.label_path }}** field, the path will be completely overwritten, even with `{{ ui-key.yacloud.alb.label_replace-prefix }}` selected in the **{{ ui-key.yacloud.alb.label_replace }}** field.
       * Optionally, select **{{ ui-key.yacloud.alb.label_strict-query }}**. 
       * Optionally, select **{{ ui-key.yacloud.alb.label_replace-scheme }}**. If the original URI has the `http` or `https` scheme, the specified port, `80` or `443`, will be deleted upon changing the scheme.
       * Optionally, select **{{ ui-key.yacloud.alb.label_replace-host }}** and specify the new host.
       * Optionally, select **{{ ui-key.yacloud.alb.label_replace-port }}** and specify the new port.
     * `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`:
       * In the **{{ ui-key.yacloud.alb.label_http-status-code }}** field, select the HTTP response status code.
       * In the **{{ ui-key.yacloud.alb.label_body }}** field, click **{{ ui-key.yacloud.alb.button_select }}** and do the following in the window that opens:
         * Select a response **{{ ui-key.yacloud.component.file-content-dialog.field_method }}**: **{{ ui-key.yacloud.component.file-content-dialog.value_manual }}** or **{{ ui-key.yacloud.component.file-content-dialog.value_upload }}**.
         * Depending on the selected method, attach a file or specify the text the load balancer will send in response to requests received via this route.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../cli/) command for creating an HTTP router:

     ```bash
     yc alb http-router create --help
     ```

  1. Run this command:

     ```bash
     yc alb http-router create <HTTP_router_name>
     ```

     Result:

     ```text
     id: a5dcsselagj4********
     name: test-http-router
     folder_id: aoerb349v3h4********
     created_at: "2021-02-11T21:04:59.438292069Z"
     ```

  1. See the description of the CLI command for creating a virtual host:

     ```bash
     yc alb virtual-host create --help
     ```

  1. To create a virtual host, run this command with the HTTP router name and virtual host settings specified:

     ```bash
     yc alb virtual-host create <virtual_host_name> \
       --http-router-name <HTTP_router_name> \
       --authority your-domain.foo.com \
       --modify-request-header name=Accept-Language,append=ru-RU \
       --rate-limit rps=100,all-requests \
       --security-profile-id <security_profile_ID>
     ```

     Where:
     * `--http-router-name`: HTTP router name.
     * `--authority`: HTTP/1.1 `Host` (HTTP/2 `authority`) header domains associated with this virtual host. You can use wildcards, e.g., `*.foo.com` or `*-bar.foo.com`. This is an optional argument.
     * `--modify-request-header`: Request header modification settings:
       * `name`: Modified header name.
       * `append`: String appended to the header.
     * `--rate-limit`: Request rate limit. This is an optional setting.
       * `rps` or `rpm`: Number of allowed incoming requests per second or per minute.
       * `all-requests`: Limits all incoming requests.
       * `requests-per-ip` Limits the total number of requests per IP address. That is, for each IP address, only the specified number of requests is allowed per unit of time.
     * `--security-profile-id`: [{{ sws-full-name }}](../../smartwebsecurity/) [security profile](../../smartwebsecurity/concepts/profiles.md) ID. This is an optional setting. A security profile allows you to enable WAF and filter incoming requests, limiting their number for protection against malicious attacks. For more information, see [{#T}](../../smartwebsecurity/concepts/profiles.md).


     Result:

     ```text
     name: test-virtual-host
     authority:
       - your-domain.foo.com
     modify_request_headers:
       - name: Accept-Language
         append: ru-RU
     route_options:
       security_profile_id: fevcifh6tr**********
     rate_limit:
       all_requests:
         per_second: "100"
     ```

  1. See the description of the CLI command for adding a route:

     ```bash
     yc alb virtual-host append-http-route --help
     ```

  1. To add a route, run this command with the HTTP router ID / name and routing settings specified:

     ```bash
     yc alb virtual-host append-http-route <route_name> \
       --virtual-host-name <virtual_host_name> \
       --http-router-name <HTTP_router_name> \
       --prefix-path-match / \
       --backend-group-name <backend_group_name> \
       --request-timeout <request_timeout>s \
       --request-idle-timeout <request_idle_timeout>s
       --rate-limit rps=<request_limit>,requests-per-ip
     ```

     Where:
     * `--virtual-host-name`: Virtual host name.
     * `--http-router-name`: HTTP router name.
     * `--prefix-path-match`: Route all requests with a specific prefix. Add path `/` after this option.

       To specify routing conditions, you can also use the following options:
       * `--exact-path-match`: Route all requests matching the specified path. Add `/<path>/` after this option. 
       * `--regex-path-match`: Route all requests matching the [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression). Add `/<regular_expression>` after this option.
     * `--backend-group-name`: [Backend group](../concepts/backend-group.md) name.
     * `--request-timeout`: Request timeout in seconds.
     * `--request-max-timeout`: Maximum request timeout in seconds.
     * `--rate-limit`: Request rate limit.

     For more information about `yc alb virtual-host append-http-route` options, see this [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/append-http-route.md).

     Result:

     ```text
     done (1s)
     name: test-virtual-host
     authority:
     - your-domain.foo.com
     routes:
     - name: test-route
       http:
         match:
           path:
             prefix_match: /
         route:
           backend_group_id: a5d4db973944********
           timeout: 2s
           idle_timeout: 3s
     modify_request_headers:
     - name: Accept-Language
       append: ru-RU
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, specify your HTTP router and virtual host settings:

     ```hcl
     resource "yandex_alb_http_router" "tf-router" {
       name          = "<HTTP_router_name>"
       labels        = {
         tf-label    = "tf-label-value"
         empty-label = ""
       }
     }

     resource "yandex_alb_virtual_host" "my-virtual-host" {
       name                    = "<virtual_host_name>"
       http_router_id          = yandex_alb_http_router.tf-router.id
       route {
         name                  = "<route_name>"
         http_route {
           http_route_action {
             backend_group_id  = "<backend_group_ID>"
             timeout           = "60s"
           }
         }
       }
       authority               = "<domains>"
       route_options {
         security_profile_id   = "<security_profile_ID>"
       }
     }
     ```

     Where:
     * `yandex_alb_http_router`: HTTP router description.
       * `name`: HTTP router name. Follow these naming requirements:

         {% include [name-format](../../_includes/name-format.md) %}

       * `labels`: HTTP router [labels](../../resource-manager/concepts/labels.md). Specify a key-value pair.
     * `yandex_alb_virtual_host`: Virtual host description:
       * `name`: Virtual host name. Follow these naming requirements:

         {% include [name-format](../../_includes/name-format.md) %}

       * `http_router_id`: HTTP router ID.
       * `route`: Route description:
         * `name`: Route name.
         * `http_route_action`: Action applied to HTTP traffic.
           * `backend_group_id`: [Backend group](../concepts/backend-group.md) ID.
           * `timeout`: Maximum request timeout in seconds.
       * `authority`: HTTP/1.1 `Host` (HTTP/2 `authority`) header domains associated with this virtual host. You can use wildcards, e.g., `*.foo.com` or `*-bar.foo.com`. This is an optional parameter.
       * `route_options`: Additional virtual host parameters (optional):
           * `security_profile_id`: [{{ sws-full-name }}](../../smartwebsecurity/) [security profile](../../smartwebsecurity/concepts/profiles.md) ID. A security profile allows you to enable WAF and filter incoming requests, limiting their number for protection against malicious attacks. For more information, see [{#T}](../../smartwebsecurity/concepts/profiles.md).
  

     Learn more about the properties of {{ TF }} resources in the relevant {{ TF }} guides:
     * [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router).
     * [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
     {{ TF }} will create all the required resources. You can check your new resources and their settings in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/) command:

     ```bash
     yc alb http-router get <HTTP_router_name>
     ```

- API {#api}

  Use the [create](../api-ref/HttpRouter/create.md) REST API method for the [HttpRouter](../api-ref/HttpRouter/index.md) resource or the [HttpRouterService/Create](../api-ref/grpc/HttpRouter/create.md) gRPC API call.

{% endlist %}
