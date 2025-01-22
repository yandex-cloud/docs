---
title: How to update HTTP router parameters in {{ alb-full-name }}
description: Follow this guide to update parameters of an HTTP router.
---

# Updating HTTP router parameters

To update the HTTP router parameters:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the HTTP router was created.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Click the router name.
  1. Click **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the router, virtual host, or route settings.
  1. At the bottom of the page, click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to update a load balancer:

     ```bash
     yc alb http-router update --help
     ```

  1. Run the command, indicating the new router parameters:

     ```bash
     yc alb http-router update <HTTP_router_name> --new-name <new_name_for_HTTP_router>
     ```

     Result:
     
          
     ```text
     id: a5dld80l32ed********
     name: new-http-router
     folder_id: aoe197919j8e********
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
             backend_group_id: a5d4db973944********
             timeout: 2s
             idle_timeout: 3s
       modify_request_headers:
       - name: Accept-Language
         append: ru-RU
     created_at: "2021-02-11T21:31:01.676592016Z"
     ```

 

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

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

     For more information about the `yandex_alb_http_router` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/alb_http_router).

  1. To add, update, or delete HTTP router virtual hosts, use the `yandex_alb_virtual_host` resource indicating the router in the `http_router_id` field:

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

     For more information about the `yandex_alb_virtual_host` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/alb_virtual_host).

  1. Check the configuration using this command:

     ```bash
     terraform validate
     ```
     
     If the configuration is correct, you will get this message:
     
     ```bash
     Success! The configuration is valid.
     ```

  1. Run this command:

     ```bash
     terraform plan
     ```
  
     The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

  1. Apply the configuration changes:

     ```bash
     terraform apply
     ```
     
  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the HTTP router update using the [management console]({{ link-console-main }}) or this CLI](../../cli/quickstart.md) command:

     ```bash
     yc alb http-router get <HTTP_router_ID>
     ```

- API {#api}

  Use the [update](../api-ref/HttpRouter/update.md) REST API method for the [HttpRouter](../api-ref/HttpRouter/index.md) resource or the [HttpRouterService/Update](../api-ref/grpc/HttpRouter/update.md) gRPC API call.

{% endlist %}

## Adding a route to a virtual host {#add-virtual-host}

To add a new route to an HTTP router's virtual host:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the HTTP router was created.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Click the router name.
  1. Click **{{ ui-key.yacloud.common.edit }}**.
  1. Click **{{ ui-key.yacloud.alb.button_add-route }}**.
  1. Set the route parameters and click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}
 
   See the description of the CLI command for managing virtual hosts:
 
   ```bash
   yc alb virtual-host --help
   ```

   * **HTTP**

    
      You can add a new route to the beginning, end, or specific position in the host's route list.
    
      **Add a route to the end of a host's route list**
    
      1. View a description of the CLI command for adding a route to the end of a host's route list:

         ```bash
         yc alb virtual-host append-http-route --help
         ```
    
      1. Run this command:

         ```bash
         yc alb virtual-host append-http-route <route_name> \
           --virtual-host-name <virtual_host_name> \
           --http-router-name <HTTP_router_name> \
           --match-http-method <HTTP_method> \
           --exact-path-match / \
           --backend-group-name <backend_group_name> \
           --request-timeout <request_timeout>s \
           --request-idle-timeout <request_idle_timeout>s
         ```

         For more information about the `yc alb virtual-host append-http-route` command parameters, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/append-http-route.md).

         Result:

         ```text
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
               backend_group_id: a5d3e9ko2qf0********
               timeout: 2s
               idle_timeout: 3s
         ```
    
      **Add a route to the beginning of a host's route list**
    
      1. View a description of the CLI command for adding a route to the beginning of a host's route list:

         ```bash
         yc alb virtual-host prepend-http-route --help
         ```
    
      1. Run this command:

         ```bash
         yc alb virtual-host prepend-http-route <route_name> \
           --virtual-host-name <virtual_host_name> \
           --http-router-name <HTTP_router_name> \
           --match-http-method <HTTP_method> \
           --exact-path-match / \
           --backend-group-name <backend_group_name> \
           --request-timeout <request_timeout>s \
           --request-idle-timeout <request_idle_timeout>s
         ```

         For more information about the `yc alb virtual-host prepend-http-route` command parameters, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/prepend-http-route.md).

         Result:

         ```text
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
               backend_group_id: a5d3e9ko2qf0********
               timeout: 2s
               idle_timeout: 3s
         - name: test-route
         ...
         ```
    
      **Add a route before a specific route**
    
      1. View a description of the CLI command for adding a route before a specific route:

         ```bash
         yc alb virtual-host insert-http-route --help
         ```
    
      1. Run this command:

         ```bash
         yc alb virtual-host insert-http-route <route_name> \
           --virtual-host-name <virtual_host_name> \
           --before <route_name_to_be_preceded_by_new_route> \
           --http-router-name <HTTP_router_name> \
           --match-http-method <HTTP_method> \
           --exact-path-match / \
           --backend-group-name <backend_group_name> \
           --request-timeout <request_timeout>s \
           --request-idle-timeout <request_idle_timeout>s
         ```

         For more information about the `yc alb virtual-host insert-http-route` command parameters, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/insert-http-route.md).

         Result:

         ```text
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
               backend_group_id: a5d3e9ko2qf0********
               timeout: 2s
               idle_timeout: 3s
         - name: test-route
         ...
         ```
    
      **Add a route after a specific route**
    
       1. View a description of the CLI command for adding a new route after a specific route:

          ```bash
          yc alb virtual-host insert-http-route --help
          ```
    
       1. Run this command:

           ```bash
           yc alb virtual-host insert-http-route <route_name> \
             --virtual-host-name <virtual_host_name> \
             --after <route_name_to_be_followed_by_new_route> \
             --http-router-name <HTTP_router_name> \
             --match-http-method <HTTP_method> \
             --exact-path-match / \
             --backend-group-name <backend_group_name> \
             --request-timeout <request_timeout>s \
             --request-idle-timeout <request_idle_timeout>s
           ```

           For more information about the `yc alb virtual-host insert-http-route` command parameters, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/insert-http-route.md).
    
           Result:
    
           ```text
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
                 backend_group_id: a5d3e9ko2qf0********
                 timeout: 2s
                 idle_timeout: 3s
           ...
           ```

   * **gRPC**

      You can add a new route to the beginning, end, or specific position in the host's route list.
      
      **Add a route to the end of a host's route list**
      
      1. View a description of the CLI command for adding a route to the end of a host's route list:

         ```bash
         yc alb virtual-host append-grpc-route --help
         ```
      
      1. Run this command:

         ```bash
         yc alb virtual-host append-grpc-route <route_name> \
           --virtual-host-name <virtual_host_name> \
           --http-router-name <HTTP_router_name> \
           --prefix-fqmn-match /<first_word_of_service_name> \
           --backend-group-name <backend_group_name> \
           --request-max-timeout <timeout>s 
         ```

         For more information about the `yc alb virtual-host append-grpc-route` command parameters, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/append-grpc-route.md).

         Result:

         ```text
         name: <virtual_host_name>
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
               backend_group_id: ds7snban2dvn********
               max_timeout: 60s
               auto_host_rewrite: false
         ```
      
      **Add a route to the beginning of a host's route list**
      
      1. View a description of the CLI command for adding a route to the beginning of a host's route list:

         ```bash
         yc alb virtual-host prepend-grpc-route --help
         ```
      
      1. Run this command:

         ```bash
         yc alb virtual-host prepend-grpc-route <route_name> \
           --virtual-host-name <virtual_host_name> \
           --http-router-name <HTTP_router_name> \
           --prefix-fqmn-match /<first_word_of_service_name> \
           --backend-group-name <backend_group_name> \
           --request-max-timeout <timeout>s  
         ```

         For more information about the `yc alb virtual-host prepend-grpc-route` command parameters, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/prepend-grpc-route.md).

         Result:

         ```text
         name: <virtual_host_name>
         authority:
         - *
         routes:
         - name: grpc-route-tostart
           grpc:
             match:
               fqmn:
                prefix_match: /helloworld
             route:
               backend_group_id: ds7snban2dvn********
               max_timeout: 60s
               auto_host_rewrite: false
         - name: grpc-route
         ...
         ```
      
      **Add a route before a specific route**
      
      1. View a description of the CLI command for adding a route before a specific route:

         ```bash
         yc alb virtual-host insert-grpc-route --help
         ```
      
      1. Run this command:

         ```bash
         yc alb virtual-host insert-grpc-route <route_name> \
           --virtual-host-name <virtual_host_name> \
           --before <route_name> \
           --http-router-name <HTTP_router_name> \
           --prefix-fqmn-match /<first_word> \
           --backend-group-name <backend_group_name> \
           --request-max-timeout <timeout>s  
         ```

          Where:

          * `--virtual-host-name`: Name of the virtual host to add a route to.
          * `--before`: Route name to be preceded by the new route.
          * `--http-router-name`: HTTP router name.
          * `--prefix-fqmn-match`: First word in the service name.
          * `--backend-group-name`: Backend group name.
          * `--request-max-timeout`: Timeout in seconds.

         For more information about the `yc alb virtual-host insert-grpc-route` command parameters, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/insert-grpc-route.md).

         Result:

         ```text
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
               backend_group_id: ds7snban2dvn********
               max_timeout: 60s
               auto_host_rewrite: false
         - name: grpc-route
         ...
         ```
      
      **Add a route after a specific route**
      
      1. View a description of the CLI command for adding a new route after a specific route:

          ```bash
          yc alb virtual-host insert-grpc-route --help
          ```
      
      1. Run this command:

          ```bash
          yc alb virtual-host insert-grpc-route <route_name> \
            --virtual-host-name <virtual_host_name> \
            --after <route_name> \
            --http-router-name <HTTP_router_name> \
            --prefix-fqmn-match /<first_word> \
            --backend-group-name <backend_group_name> \
            --request-max-timeout <timeout>s  
          ```

          Where:

          * `--virtual-host-name`: Name of the virtual host to add a route to.
          * `--after`: Route name to be followed by the new route.
          * `--http-router-name`: HTTP router name.
          * `--prefix-fqmn-match`: First word in the service name.
          * `--backend-group-name`: Backend group name.
          * `--request-max-timeout`: Timeout in seconds.

          For more information about the `yc alb virtual-host insert-grpc-route` command parameters, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/insert-grpc-route.md).

          Result:
      
          ```text
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
               backend_group_id: ds7snban2dvn********
               max_timeout: 60s
               auto_host_rewrite: false
          ...
          ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and edit the virtual host description fragment by adding the `route` section:

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

     For more information about the `yandex_alb_virtual_host` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/alb_virtual_host).

     The sequence of routes inside a virtual host description matters. For more information, see the [concept](../../application-load-balancer/concepts/http-router.md#virtual-host).

  1. Check the configuration using this command:

     ```bash
     terraform validate
     ```
     
     If the configuration is correct, you will get this message:
     
     ```text
     Success! The configuration is valid.
     ```

  1. Run this command:

     ```bash
     terraform plan
     ```
  
     The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

  1. Apply the configuration changes:

     ```bash
     terraform apply
     ```
     
  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the virtual host update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc alb virtual-host get <virtual_host_ID>
     ```

- API {#api}

  Use the [update](../api-ref/VirtualHost/update.md) REST API method for the [VirtualHost](../api-ref/VirtualHost/index.md) resource or the [VirtualHostService/Update](../api-ref/grpc/VirtualHost/update.md) gRPC API call.

{% endlist %}

## Change route order in the virtual host {#change-route-order}

To change the order of HTTP router routes:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the HTTP router was created.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Click the router name.
  1. Click **{{ ui-key.yacloud.common.edit }}**.
  1. Click **{{ ui-key.yacloud.alb.button_routes-sort }}**.
  1. In the window that opens, drag the route to a new position in the list.
  1. Click **{{ ui-key.yacloud.common.save }}**.
  1. Finish editing the router and click **{{ ui-key.yacloud.common.save }}**.
  
- CLI {#cli}

   * **HTTP**
   
      1. View a description of the CLI route delete command:

          ```bash
          yc application-load-balancer virtual-host remove-http-route --help
          ```
       
      1. Delete the route:   

          ```bash
          yc alb virtual-host remove-http-route <route_name> \
            --virtual-host-name <virtual_host_name> \
            --http-router-name <router_name>
          ```
      
      1. Add the route to a desired position using one of the ways described above.   

   * **gRPC**
   
      1. View a description of the CLI route delete command:

          ```bash
          yc application-load-balancer virtual-host remove-gRPC-route --help
          ```
       
      1. Delete the route:   

          ```bash
          yc alb virtual-host remove-grpc-route <route_name> \
            --virtual-host-name <virtual_host_name> \
            --http-router-name  <router_name>
          ```
      
      1. Add the route to a desired position using one of the ways described above.

- API {#api}

  Use the [update](../api-ref/VirtualHost/update.md) REST API method for the [VirtualHost](../api-ref/VirtualHost/index.md) resource or the [VirtualHostService/Update](../api-ref/grpc/VirtualHost/update.md) gRPC API call.

{% endlist %}
