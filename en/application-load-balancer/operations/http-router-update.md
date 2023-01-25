# Change HTTP router parameters

To change the HTTP router parameters:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the HTTP router was created.
   1. Select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/router.svg) **HTTP routers**.
   1. Click on the name of the router you need.
   1. Click **Edit**.
   1. Edit the router settings.
   1. At the bottom of the page, click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to update a load balancer:
      ```
      yc alb http-router update --help
      ```

   1. Run the command, indicating the new router parameters:
      ```
      yc alb http-router update <HTTP router name> --new-name <new HTTP router name>
      ```

      Result:

      
      ```
      id: a5dld80l32edg407nsti
      name: new-http-router
      folder_id: aoe197919j8elpeg1lkp
      virtual_hosts:
      - name: test-virtual-host
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
      created_at: "2021-02-11T21:31:01.676592016Z"
      ```



- {{ TF }}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Open the {{ TF }} configuration file and edit the fragment with the HTTP router description.

      ```hcl
      ...
      resource "yandex_alb_http_router" "tf-router" {
        name   = "my-http-router"
        labels = {
          tf-label    = "tf-label-value"
          empty-label = ""
        }
      }
      ...
      ```

      For more information about the `yandex_alb_http_router` resource in {{ TF }}, see the [provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/alb_http_router).

   1. To add, update, or delete an HTTP router's virtual hosts, use the `yandex_alb_virtual_host` resource indicating the router in the `http_router_id` field:

      ```hcl
      resource "yandex_alb_virtual_host" "my-virtual-host" {
        name           = "my-virtual-host"
        http_router_id = "${yandex_alb_http_router.tf-router.id}"
        route {
          name = "my-route"
          http_route {
            http_route_action {
              backend_group_id = "${yandex_alb_backend_group.backend-group.id}"
              timeout          = "3s"
            }
          }
        }
      }
      ```

      For more information about the `yandex_alb_virtual_host` resource in {{ TF }}, see the [provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/alb_virtual_host).

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change to the HTTP router using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

      ```
      yc alb http-router get <HTTP router ID>
      ```

{% endlist %}

## Adding a route to a virtual host {#add-virtual-host}

To add a new route to an HTTP router's virtual host:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the HTTP router was created.
   1. Select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/router.svg) **HTTP routers**.
   1. Click on the name of the router you need.
   1. Click **Edit**.
   1. Click **Add route**.
   1. Set the route parameters and click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   See the description of the CLI command for managing virtual hosts:

   ```
   yc alb virtual-host --help
   ```

   * **HTTP**


      You can add a new route to the beginning, end, or specific position in the host's route list.

      **Add a route to the end of a host's route list**

      1. View a description of the CLI command for adding a route to the end of a host's route list:
         ```
         yc alb virtual-host append-http-route --help
         ```

      1. Run the command:
         ```
         yc alb virtual-host append-http-route <route name> \
           --virtual-host-name <virtual host name> \
           --http-router-name <HTTP router name> \
           --match-http-method GET \
           --exact-path-match / \
           --backend-group-name <backend group name> \
           --request-timeout <request timeout>s \
           --request-idle-timeout <request idle timeout>s
         ```

         Result:
         ```
         name: test-virtual-host
         authority:
         - your-domain.foo.com
         routes:
         - name: test-route
         ...
         - name: test-route-toend
           http:
             match:
               path:
                 prefix_match: /
             route:
               backend_group_id: a5d3e9ko2qf0tbk0s27b
               timeout: 2s
               idle_timeout: 3s
         ```

      **Add a route to the beginning of a host's route list**

      1. View a description of the CLI command for adding a route to the beginning of a host's route list:
         ```
         yc alb virtual-host prepend-http-route --help
         ```

      1. Run the command:
         ```
         yc alb virtual-host prepend-http-route <route name> \
           --virtual-host-name <virtual host name> \
           --http-router-name <HTTP router name> \
           --match-http-method GET \
           --exact-path-match / \
           --backend-group-name <backend group name> \
           --request-timeout <request timeout>s \
           --request-idle-timeout <request idle timeout>s
         ```

         Result:
         ```
         name: test-virtual-host
         authority:
         - your-domain.foo.com
         routes:
         - name: test-route-tostart
           http:
             match:
               http_method:
               - GET
               path:
                 exact_match: /
             route:
               backend_group_id: a5d3e9ko2qf0tbk0s27b
               timeout: 2s
               idle_timeout: 3s
         - name: test-route
         ...
         ```

      **Add a route before a specific route**

      1. View a description of the CLI command for adding a route before a specific route:
         ```
         yc alb virtual-host insert-http-route --help
         ```

      1. Run the command:
         ```
         yc alb virtual-host insert-http-route <route name> \
           --virtual-host-name <virtual host name> \
           --before <name of the route to add a new route before> \
           --http-router-name <HTTP router name> \
           --match-http-method GET \
           --exact-path-match / \
           --backend-group-name <backend group name> \
           --request-timeout <request timeout>s \
           --request-idle-timeout <request idle timeout>s
         ```

         Result:
         ```
         done (2s)
         name: test-virtual-host
         authority:
         - your-domain.foo.com
         routes:
         ...
         - name: test-route-insbefore
           http:
             match:
               http_method:
               - GET
               path:
                 exact_match: /
             route:
               backend_group_id: a5d3e9ko2qf0tbk0s27b
               timeout: 2s
               idle_timeout: 3s
         - name: test-route
         ...
         ```

      **Add a route after a specific route**

      1. View a description of the CLI command for adding a new route after a specific route:
         ```
         yc alb virtual-host insert-http-route --help
         ```

      1. Run the command:
         ```
         yc alb virtual-host insert-http-route <route name> \
           --virtual-host-name <virtual host name> \
           --after <name of the route to add a new route after> \
           --http-router-name <HTTP router name> \
           --match-http-method GET \
           --exact-path-match / \
           --backend-group-name <backend group name> \
           --request-timeout <request timeout>s \
           --request-idle-timeout <request idle timeout>s
         ```

         Result:

         ```
         done (2s)
         name: test-virtual-host
         authority:
         - your-domain.foo.com
         routes:
         - name: test-route
         ...
         - name: test-route-insafter
           http:
             match:
               path:
                 prefix_match: /
             route:
               backend_group_id: a5d3e9ko2qf0tbk0s27b
               timeout: 2s
               idle_timeout: 3s
         ...
         ```

   * **gRPC**

      You can add a new route to the beginning, end, or specific position in the host's route list.

      **Add a route to the end of a host's route list**

      1. View a description of the CLI command for adding a route to the end of a host's route list:
         ```
         yc alb virtual-host append-grpc-route --help
         ```

      1. Run the command:
         ```
         yc alb virtual-host append-grpc-route <route name> \
           --virtual-host-name <virtual host name> \
           --http-router-name <HTTP router name> \
           --prefix-fqmn-match /<first word in service name> \
           --backend-group-name <backend group name> \
           --request-max-timeout <timeout>s 
         ```

         Result:
         ```
         name: <virtual host name>
         authority:
         - *
         routes:
         - name: grpc-route
         ...
         - name: grpc-route-toend
           grpc:
             match:
               fqmn:
                prefix_match: /helloworld
             route:
               backend_group_id: ds7snban2dvnedokp6kc
               max_timeout: 60s
               auto_host_rewrite: false
         ```

      **Add a route to the beginning of a host's route list**

      1. View a description of the CLI command for adding a route to the beginning of a host's route list:
         ```
         yc alb virtual-host prepend-grpc-route --help
         ```

      1. Run the command:
         ```
         yc alb virtual-host prepend-grpc-route <route name> \
           --virtual-host-name <virtual host name> \
           --http-router-name <HTTP router name> \
           --prefix-fqmn-match /<first word in service name> \
           --backend-group-name <backend group name> \
           --request-max-timeout <timeout>s  
         ```

         Result:
         ```
         name: <virtual host name>
         authority:
         - *
         routes:
         - name: grpc-route-tostart
           grpc:
             match:
               fqmn:
                prefix_match: /helloworld
             route:
               backend_group_id: ds7snban2dvnedokp6kc
               max_timeout: 60s
               auto_host_rewrite: false
         - name: grpc-route
         ...
         ```

      **Add a route before a specific route**

      1. View a description of the CLI command for adding a route before a specific route:
         ```
         yc alb virtual-host insert-grpc-route --help
         ```

      1. Run the command:
         ```
         yc alb virtual-host insert-grpc-route <route name> \
           --virtual-host-name <virtual host name> \
           --before <name of route that new route should precede> \
           --http-router-name <HTTP router name> \
           --prefix-fqmn-match /<first word in service name> \
           --backend-group-name <backend group name> \
           --request-max-timeout <timeout>s  
         ```

         Result:
         ```
         name: grpc-host
         authority:
         - *
         routes:       
         ...
         - name: grpc-route-before
           grpc:
             match:
               fqmn:
                prefix_match: /helloworld
             route:
               backend_group_id: ds7snban2dvnedokp6kc
               max_timeout: 60s
               auto_host_rewrite: false
         - name: grpc-route
         ...
         ```

      **Add a route after a specific route**

      1. View a description of the CLI command for adding a new route after a specific route:
         ```
         yc alb virtual-host insert-grpc-route --help
         ```

      1. Run the command:
         ```
         yc alb virtual-host insert-grpc-route <route name> \
           --virtual-host-name <virtual host name> \
           --after <name of route that new route should precede> \
           --http-router-name <HTTP router name> \
           --prefix-fqmn-match /<first word in service name> \
           --backend-group-name <backend group name> \
           --request-max-timeout <timeout>s  
         ```

         Result:

         ```
         name: grpc-host
         authority:
         - *
         routes:       
         ...
         - name: grpc-route
         ...
         - name: grpc-route-after
            grpc:
           match:
              fqmn:
              prefix_match: /helloworld
           route:
              backend_group_id: ds7snban2dvnedokp6kc
              max_timeout: 60s
              auto_host_rewrite: false
         ...
         ```


- {{ TF }}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Open the {{ TF }} configuration file and edit the fragment with the virtual host description by adding the `route` section:

      ```hcl
      resource "yandex_alb_virtual_host" "my-virtual-host" {
        name           = "my-virtual-host"
        http_router_id = "${yandex_alb_http_router.tf-router.id}"
        route {
          name = "my-route"
          http_route {
            http_route_action {
              backend_group_id = "${yandex_alb_backend_group.backend-group.id}"
              timeout          = "3s"
            }
          }
        }
      }
      ```

      For more information about the `yandex_alb_virtual_host` resource in {{ TF }}, see the [provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/alb_virtual_host).

      The sequence of routes inside a virtual host description matters. For more information, see the [concept](../../application-load-balancer/concepts/http-router.md#virtual-host).

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change to the virtual host using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

      ```
      yc alb virtual-host get <virtual host ID>
      ```

{% endlist %}

## Change route order in the virtual host {#change-route-order}

To change the order of HTTP router routes:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the HTTP router was created.
   1. Select **{{ alb-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/router.svg) **HTTP routers**.
   1. Click on the name of the router you need.
   1. Click **Edit**.
   1. Click **Sort**.
   1. In the window that opens, drag the route to a new position in the list.
   1. Click **Save**.
   1. Finish editing the router and click **Save**.

- CLI

   * **HTTP**

      1. View a description of the CLI route delete command:
         ```
         yc application-load-balancer virtual-host remove-http-route --help
         ```

      1. Delete the route:
         ```
         yc alb virtual-host remove-http-route <route name> \
           --virtual-host-name <virtual host name> \
           --http-router-name <router name>
         ```

      1. Add the route to a desired position using one of the ways described above.

   * **gRPC**

      1. View a description of the CLI route delete command:
         ```
         yc application-load-balancer virtual-host remove-gRPC-route --help
         ```

      1. Delete the route:
         ```
         yc alb virtual-host remove-grpc-route <route name> \
           --virtual-host-name <virtual host name> \
           --http-router-name <router name>
         ```

      1. Add the route to a desired position using one of the ways described above.

{% endlist %}