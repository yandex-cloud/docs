# Creating HTTP router for HTTP traffic

To create an HTTP router and add a route to it:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create an HTTP router in.
   1. In the list of services, select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/router.svg) **HTTP routers**.
   1. Click **Create HTTP router**.
   1. Enter the router name: `test-router`.
   1. Under **Virtual hosts**, click **Add virtual host**.
   1. Enter the host name: `test-host-1`.
   1. Click **Add route**.
   1. Enter **Name**: `test-route`.
   1. In the **Path** field, select `Matches` and specify the path `/`.

      To specify the path, you can use the following options:
      * `Starts with` to route all requests with a specific beginning.
      * `Regular expression` to route all requests that match a [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression).

   1. In the **HTTP methods** list, select `GET`.
   1. In the **Action** field, leave the `Routing` value.
   1. In the **Backend group**, select the backend group name from the same folder where you create the router.
   1. Leave all other settings as they are and click **Create**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create an HTTP router:

      ```bash
      yc alb http-router create --help
      ```

   1. Run the following command:

      ```bash
      yc alb http-router create <HTTP_router_name>
      ```

      Result:

      ```text
      id: a5dcsselagj4o2v4a6e7
      name: test-http-router
      folder_id: aoerb349v3h4bupphtaf
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
        --modify-request-header name=Accept-Language,append=ru-RU
      ```



      Where:

      * `--authority`: Domains for the `Host` and `authority` headers that will be associated with this virtual host. Wildcards are supported, for example, `*.foo.com` or `*-bar.foo.com`.
      * `--modify-request-header`: Settings for modifying request headers:
         * `name`: Name of the header to be modified.
         * `append`: String to be added to the header value.

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

   1. Add a route, indicating the router ID or name and the routing parameters:

      ```bash
      yc alb virtual-host append-http-route <route_name> \
        --virtual-host-name <virtual_host_name> \
        --http-router-name <HTTP_router_name> \
        --prefix-path-match / \
        --backend-group-name <backend group name> \
        --request-timeout <request_timeout>s \
        --request-idle-timeout <request_idle_timeout>s
      ```

      Where:

      * `--virtual-host-name`: Virtual host name.
      * `--http-router-name`: HTTP router name.
      * `--prefix-path-match`: Parameter for routing all requests with a given prefix. The parameter should be followed with `/`.

         To specify a condition for routing, you can also use the following parameters:
         * `--exact-path-match` to route all requests that match the specified path. The parameter should be followed with `/<path>/`.
         * `--regex-path-match` to route all requests that match a [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression). The parameter should be followed with `/<regular_expression>`.
      * `--backend-group-name`: Name of the backend group.
      * `--request-timeout`: Request timeout, seconds.
      * `--request-max-timeout`: Maximum request idle timeout, seconds.

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
            backend_group_id: a5d4db973944t2fh8gor
            timeout: 2s
            idle_timeout: 3s
      modify_request_headers:
      - name: Accept-Language
        append: ru-RU
      ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, specify the parameters of the HTTP router and virtual host:

      ```hcl
      resource "yandex_alb_http_router" "tf-router" {
        name   = "<HTTP_router_name>"
        labels = {
          tf-label    = "tf-label-value"
          empty-label = ""
        }
      }

      resource "yandex_alb_virtual_host" "my-virtual-host" {
        name           = "<virtual_host_name>"
        http_router_id = yandex_alb_http_router.tf-router.id
        route {
          name = "<route_name>"
          http_route {
            http_route_action {
              backend_group_id = "<backend_group_ID>"
              timeout          = "3s"
            }
          }
        }
      }    
      ```

      Where:

      * `yandex_alb_virtual_host`: HTTP router description:
         * `name`: HTTP router name. The name format is as follows:

            {% include [name-format](../../_includes/name-format.md) %}

         * `labels`: HTTP router [labels](../../resource-manager/concepts/labels.md). Set a key-value pair.
      * `yandex_alb_virtual_host`: Virtual host description:
         * `name`: Virtual host name. The name format is as follows:

            {% include [name-format](../../_includes/name-format.md) %}

         * `http_router_id`: HTTP router ID.
         * `route`: Description of the HTTP router's route. Specify the route name, backend group ID, and request processing time (defaults to 60 seconds).

      For more information about {{ TF }} resource parameters, see the provider documentation ([yandex_alb_http_router](https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs/resources/alb_http_router) and [yandex_alb_virtual_host](https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs/resources/alb_virtual_host)).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can verify that the resources are there and their configuration is correct using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

         ```bash
         yc alb http-router get <HTTP_router_name>
         ```

- API

   Use the [create](../api-ref/HttpRouter/create.md) REST API method for the [HttpRouter](../api-ref/HttpRouter/index.md) resource or the [HttpRouterService/Create](../api-ref/grpc/http_router_service.md#Create) gRPC API call.

{% endlist %}
