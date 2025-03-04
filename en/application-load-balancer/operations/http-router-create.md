---
title: How to create an HTTP router for HTTP traffic in {{ alb-full-name }}
description: Follow this guide to create an HTTP router for HTTP traffic.
---

# Creating an HTTP router for HTTP traffic

To create an [HTTP router](../concepts/http-router.md) and add a [route](../concepts/http-router.md#routes) to it:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create an HTTP router.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Click **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. Enter the HTTP router name.
  1. Under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, click **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
  1. Enter the host name.
  1. (Optional) In the **{{ ui-key.yacloud.alb.label_authority }}** field, specify the value of the `Host` header for HTTP/1.1 or the `:authority` pseudo-header for HTTP/2 that will be used to select a virtual host.
  1. (Optional) In the **{{ ui-key.yacloud.alb.label_security-profile-id }}** field, select the [{{ sws-full-name }}](../../smartwebsecurity/) [security profile](../../smartwebsecurity/concepts/profiles.md). A security profile allows you to set up filtering of incoming requests, enable WAF, and limit the number of requests for protection against malicious activities. For more information, see [{#T}](../../smartwebsecurity/concepts/profiles.md).


  1. Click **{{ ui-key.yacloud.alb.button_add-route }}**.
  1. Enter the route **{{ ui-key.yacloud.common.name }}**.
  1. In the **{{ ui-key.yacloud.alb.label_path }}** field, select one of the options:
     * `{{ ui-key.yacloud.alb.label_match-exact }}` and specify the `/` path to route all requests that match the specified path.
     * `{{ ui-key.yacloud.alb.label_match-prefix }}` to route all requests with a specific prefix.
     * `{{ ui-key.yacloud.alb.label_match-regex }}` to route all requests that satisfy the [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression).
  1. In the **{{ ui-key.yacloud.alb.label_http-methods }}** list, select the required methods.
  1. In the **{{ ui-key.yacloud.alb.label_route-action }}** field, select one of the options: `{{ ui-key.yacloud.alb.label_route-action-route }}`, `{{ ui-key.yacloud.alb.label_route-action-redirect }}`, or `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`. Depending on the selected option:
     * `{{ ui-key.yacloud.alb.label_route-action-route }}`:
       * In the **{{ ui-key.yacloud.alb.label_backend-group }}** field, select the name of the [backend group](../concepts/backend-group.md) from the same folder where you are creating the HTTP router.
       * (Optional) In the **{{ ui-key.yacloud.alb.label_prefix-rewrite }}** field, specify where the HTTP router should redirect traffic. If you select `{{ ui-key.yacloud.alb.label_match-exact }}` in the **{{ ui-key.yacloud.alb.label_path }}** field, the path will be completely rewritten. If you select `{{ ui-key.yacloud.alb.label_match-prefix }}`, only the prefix will be rewritten.
       * Optionally, in the **{{ ui-key.yacloud.alb.label_host-rewrite }}** field, select one of these options:
         * `none`: No rewriting.
         * `rewrite`: Rewriting to the specified value.
         * `auto`: Automatic rewriting to the target VM address.
       * (Optional) In the **{{ ui-key.yacloud.alb.label_timeout }}** field, specify the maximum connection time.
       * (Optional) In the **{{ ui-key.yacloud.alb.label_idle-timeout }}** field, specify the maximum connection keep-alive time with zero data transmission.
       * (Optional) In the **{{ ui-key.yacloud.alb.label_upgrade-types }}** field, list the protocols the backend group can switch to within a TCP connection upon the client's request.
       * (Optional) Select **{{ ui-key.yacloud.alb.label_web-socket }}** if you want to use the WebSocket protocol.
     * `{{ ui-key.yacloud.alb.label_route-action-redirect }}`:
       * In the **{{ ui-key.yacloud.alb.label_http-status-code }}** field, select the code to be used for forwarding.
       * (Optional) In the **{{ ui-key.yacloud.alb.label_replace }}** field, specify where the HTTP router should redirect traffic. If you select `{{ ui-key.yacloud.alb.label_match-exact }}` in the **{{ ui-key.yacloud.alb.label_path }}** field, the path will be completely replaced, even if `{{ ui-key.yacloud.alb.label_replace-prefix }}` is selected in the **{{ ui-key.yacloud.alb.label_replace }}** field.
       * (Optional) Select the **{{ ui-key.yacloud.alb.label_strict-query }}** option. 
       * (Optional) Select the **{{ ui-key.yacloud.alb.label_replace-scheme }}** option. If the original URI uses the `http` (`https`) schema and specifies port `80`(`443`), the change of schema will delete the port.
       * (Optional) Select **{{ ui-key.yacloud.alb.label_replace-host }}** and specify a new host.
       * (Optional) Select **{{ ui-key.yacloud.alb.label_replace-port }}** and specify a new port.
     * `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`:
       * In the **{{ ui-key.yacloud.alb.label_http-status-code }}** field, select the code to be used for response.
       * In the **{{ ui-key.yacloud.alb.label_body }}** field, click **{{ ui-key.yacloud.alb.button_select }}** and do the following in the window that opens:
         * Select a response **{{ ui-key.yacloud.component.file-content-dialog.field_method }}**: **{{ ui-key.yacloud.component.file-content-dialog.value_manual }}** or **{{ ui-key.yacloud.component.file-content-dialog.value_upload }}**.
         * Depending on the selected method, attach a file or specify the text of the load balancer's response to the request received via this route.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../cli/) command to create an HTTP router:

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

  1. View a description of the CLI command for creating a virtual host:

     ```bash
     yc alb virtual-host create --help
     ```

  1. Create a virtual host, specifying the name of the HTTP router and the virtual host settings:

     ```bash
     yc alb virtual-host create <virtual_host_name> \
       --http-router-name <HTTP_router_name> \
       --authority your-domain.foo.com \
       --modify-request-header name=Accept-Language,append=ru-RU \
       --security-profile-id <security_profile_ID>
     ```

     Where:
     * `--http-router-name`: HTTP router name.
     * `--authority`: Domains for the `Host` headers for HTTP/1.1 or `authority` for HTTP/2 that will be associated with this virtual host. This parameter supports wildcards, e.g., `*.foo.com` or `*-bar.foo.com`. This is an optional parameter.
     * `--modify-request-header`: Request header modification settings:
       * `name`: Name of the header being modified.
       * `append`: String to add to the header value.
     * `--security-profile-id` (optional): ID of the [{{ sws-full-name }}](../../smartwebsecurity/) [security profile](../../smartwebsecurity/concepts/profiles.md). A security profile allows you to set up filtering of incoming requests, enable WAF, and limit the number of requests for protection against malicious activities. For more information, see [{#T}](../../smartwebsecurity/concepts/profiles.md).


     Result:

     ```text
     name: test-virtual-host
     authority:
     - your-domain.foo.com
     modify_request_headers:
     - name: Accept-Language
       append: ru-RU
     ```

  1. View a description of the CLI command for adding a host:

     ```bash
     yc alb virtual-host append-http-route --help
     ```

  1. Add a route, specifying the HTTP router ID or name and the routing parameters:

     ```bash
     yc alb virtual-host append-http-route <route_name> \
       --virtual-host-name <virtual_host_name> \
       --http-router-name <HTTP_router_name> \
       --prefix-path-match / \
       --backend-group-name <backend_group_name> \
       --request-timeout <request_timeout>s \
       --request-idle-timeout <request_idle_timeout>s
     ```

     Where:
     * `--virtual-host-name`: Virtual host name.
     * `--http-router-name`: HTTP router name.
     * `--prefix-path-match`: Parameter to route all requests with a specific prefix. The parameter should be followed by path `/`.

       To specify a routing condition, you can also use the following parameters:
       * `--exact-path-match` to route all requests matching the specified path. The parameter should be followed by `/<path>/`. 
       * `--regex-path-match` to route all requests that satisfy the [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression). The parameter should be followed by `/<regular_expression>`.
     * `--backend-group-name`: [Backend group](../concepts/backend-group.md) name.
     * `--request-timeout`: Request timeout in seconds.
     * `--request-max-timeout`: Maximum request idle timeout in seconds.

     For more information about the `yc alb virtual-host append-http-route` command parameters, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/append-http-route.md).

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

  1. In the configuration file, specify the parameters of the HTTP router and virtual host:

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
       * `name`: HTTP router name. The name should match the following format:

         {% include [name-format](../../_includes/name-format.md) %}

       * `labels`: HTTP router [labels](../../resource-manager/concepts/labels.md). Specify a key-value pair.
     * `yandex_alb_virtual_host`: Virtual host description:
       * `name`: Virtual host name. The name should match the following format:

         {% include [name-format](../../_includes/name-format.md) %}

       * `http_router_id`: HTTP router ID.
       * `route`: HTTP router route description:
         * `name`: Route name.
         * `http_route_action`: Parameter to specify an action with HTTP traffic.
           * `backend_group_id`: [Backend group](../concepts/backend-group.md) ID.
           * `timeout`: Maximum request idle timeout in seconds.
       * `authority`: Domains for the `Host` headers for HTTP/1.1 or `authority` for HTTP/2 that will be associated with this virtual host. This parameter supports wildcards, e.g., `*.foo.com` or `*-bar.foo.com`. This is an optional parameter.
       * `route_options` (optional): Additional parameters of the virtual host:
           * `security_profile_id`: ID of the [{{ sws-full-name }}](../../smartwebsecurity/) [security profile](../../smartwebsecurity/concepts/profiles.md). A security profile allows you to set up filtering of incoming requests, enable WAF, and limit the number of requests for protection against malicious activities. For more information, see [{#T}](../../smartwebsecurity/concepts/profiles.md).
  

     For more information about the properties of {{ TF }} resources, see these {{ TF }} guides:
     * [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router).
     * [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
     {{ TF }} will create all the required resources. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

     ```bash
     yc alb http-router get <HTTP_router_name>
     ```

- API {#api}

  Use the [create](../api-ref/HttpRouter/create.md) REST API method for the [HttpRouter](../api-ref/HttpRouter/index.md) resource or the [HttpRouterService/Create](../api-ref/grpc/HttpRouter/create.md) gRPC API call.

{% endlist %}