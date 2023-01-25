# Create HTTP router for gRPC traffic 

To create an HTTP router and add a route to it:

{% list tabs %}

- Management console

   1. In the menu on the left, select **HTTP routers**.
   1. Click **Create HTTP router**.
   1. Enter the router name: `test-grpc-router`.
   1. Under **Virtual hosts**, click **Add virtual host**.
   1. Enter the **Name**: `test-virtual-host`.
   1. In the **Authority** field, specify the `*` or IP address of the load balancer
   1. Click **Add route** and select `gRPC` as a **Type**.
      1. Enter the **Name**: `grpc-route`.
      1. Under **FQMN**, select `Starts with` and in the input field, specify `/<first word in service name>`, for example: `/helloworld`.

      {% note warning %}

      The FQMN must start with a slash `/` and contain part of the name of the service that the procedure call is redirected to.

      {% endnote %}

      1. In the **Action** field, leave the `Routing` value.
      1. In the **Backend group**, select the backend group name from the same folder where you create the router.
      1. Leave the other settings as they are and click **Create**.


- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create an HTTP router:
      ```
      yc alb http-router create --help
      ```

   1. Run the command:
      ```
      yc alb http-router create <HTTP router name>
      ```

      Result:
      ```
      id: a5dcsselagj4o2v4a6e7
      name: <HTTP router name>
      folder_id: aoerb349v3h4bupphtaf
      created_at: "2022-06-16T21:04:59.438292069Z"
      ```

   1. View a description of the CLI command for creating a virtual host:
      ```
      yc alb virtual-host create --help
      ```

   1. Create a virtual host, specifying the name of the HTTP router and the virtual host settings:
      ```
      yc alb virtual-host create <virtual host name> \
        --http-router-name <HTTP router name> \
        --authority *
      ```

      Where `--authority`: Domains for the Host and `:authority` headers that will be associated with this virtual host. Wildcards are supported, for example, `*.foo.com` or `*-bar.foo.com`.

      Result:
      ```
      done (1s)
      name: <virtual host name>
      authority:
      - *
      ```

   1. View a description of the CLI command for adding a host:
      ```
      yc alb virtual-host append-grpc-route --help
      ```

   1. Add a route, indicating the router ID or name and the routing parameters:
      ```
      yc alb virtual-host append-grpc-route <route name> \
        --virtual-host-name <virtual host name> \
        --http-router-name <HTTP router name> \
        --prefix-fqmn-match "/helloworld" \
        --backend-group-name <backend group name> \
        --request-max-timeout 60s \
      ```

      Result:
      ```
      done (1s)
      name: <virtual host name>
      authority:
      - *
      routes:
      - name: <route name>
        grpc:
         match:
           fqmn:
            prefix_match: /helloworld
         route:
           backend_group_id: ds7snban2dvnedokp6kc
           max_timeout: 60s
      
      ```

{% endlist %}
