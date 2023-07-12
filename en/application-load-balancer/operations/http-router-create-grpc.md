# Creating HTTP router for gRPC traffic 

To create an HTTP router and add a route to it:

{% list tabs %}

- Management console

   1. In the left menu, select **HTTP routers**.
   1. Click **Create HTTP router**.
   1. Enter the router name: `test-grpc-router`.
   1. Under **Virtual hosts**, click **Add virtual host**.
   1. Enter the **Name**: `test-virtual-host`.
   1. In the **Authority** field, specify the `*` or IP address of the load balancer
   1. Click **Add route** and select `gRPC` as a **Type**.
      1. Enter the **Name**: `grpc-route`.
      1. Under **FQMN**, select `Starts with` and, in the input field, specify the `/<first_word_in_service_name>`, e.g., `/helloworld`.

         To specify the FQMN, you can use the following options:
         * `Matches` to route all requests that match the specified FQMN.
         * `Regular expression` to route all requests that match a [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression).

      {% note warning %}

      The FQMN must start with a slash `/` and contain part of the name of the service that the procedure call is redirected to.

      {% endnote %}

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
      name: <HTTP_router_name>
      folder_id: aoerb349v3h4bupphtaf
      created_at: "2022-06-16T21:04:59.438292069Z"
      ```

   1. View a description of the CLI command for creating a virtual host:

      ```bash
      yc alb virtual-host create --help
      ```

   1. Create a virtual host, specifying the name of the HTTP router and the virtual host settings:

      ```bash
      yc alb virtual-host create <virtual_host_name> \
        --http-router-name <HTTP_router_name> \
        --authority *
      ```

      Where `--authority`: Domains for the Host and `:authority` headers that will be associated with this virtual host. Wildcards are supported, for example, `*.foo.com` or `*-bar.foo.com`.

      Result:

      ```text
      done (1s)
      name: <virtual_host_name>
      authority:
      - *
      ```

   1. View a description of the CLI command for adding a host:

      ```bash
      yc alb virtual-host append-grpc-route --help
      ```

   1. Add a route, indicating the router ID or name and the routing parameters:

      ```bash
      yc alb virtual-host append-grpc-route <route_name> \
        --virtual-host-name <virtual_host_name> \
        --http-router-name <HTTP_router_name> \
        --prefix-fqmn-match / \
        --backend-group-name <backend_group_name> \
        --request-max-timeout 60s
      ```

      Where:

      * `--virtual-host-name`: Virtual host name.
      * `--http-router-name`: HTTP router name.
      * `--prefix-fqmn-match`: Parameter for routing all requests with a given prefix. The parameter should be followed with FQMN `/`.

         To specify a condition for routing, you can also use the following options:
         * `--exact-fqmn-match` to route all requests that match the specified FQMN. The parameter should be followed with `/<FQMN>/`.
         * `--regex-fqmn-match` to route all requests that match a [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression). The parameter should be followed with `/<regular_expression>`.
      * `--backend-group-name`: Name of the backend group.
      * `--request-max-timeout`: Maximum request idle timeout, seconds.

      Result:

      ```text
      done (1s)
      name: <virtual_host_name>
      authority:
      - *
      routes:
      - name: <route_name>
        grpc:
         match:
           fqmn:
            prefix_match: /helloworld
         route:
           backend_group_id: ds7snban2dvnedokp6kc
           max_timeout: 60s
      ```

- API

   Use the [create](../api-ref/HttpRouter/create.md) REST API method for the [HttpRouter](../api-ref/HttpRouter/index.md) resource or the [HttpRouterService/Create](../api-ref/grpc/http_router_service.md#Create) gRPC API call.

{% endlist %}
