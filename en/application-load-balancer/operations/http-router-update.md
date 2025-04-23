---
title: How to update HTTP router settings in {{ alb-full-name }}
description: In this tutorial, you will learn how to update HTTP router settings.
---

# Updating HTTP router settings

To update HTTP router settings:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your HTTP router.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Click your router name.
  1. Click **{{ ui-key.yacloud.common.edit }}**.
  1. Edit your router (virtual host, route) settings.
  1. Click **{{ ui-key.yacloud.common.save }}** at the bottom of the page.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating an HTTP router:

     ```bash
     yc alb http-router update --help
     ```

  1. Run this command with new router settings specified:

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

  1. Open the {{ TF }} configuration file and edit the fragment describing your HTTP router.

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

     For more information about `yandex_alb_http_router` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/alb_http_router).

  1. To add, update, or delete HTTP router virtual hosts, use the `yandex_alb_virtual_host` resource with your router ID specified in its `http_router_id` field:

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

     For more information about `yandex_alb_virtual_host` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/alb_virtual_host).

  1. Check the configuration using this command:

     ```bash
     terraform validate
     ```
     
     If your configuration is correct, you will get this message:
     
     ```bash
     Success! The configuration is valid.
     ```

  1. Run this command:

     ```bash
     terraform plan
     ```
  
     You will see a detailed list of resources. No changes will be made at this step. If your configuration contains errors, {{ TF }} will show them.

  1. Apply the changes:

     ```bash
     terraform apply
     ```
     
  1. Type `yes` and press **Enter** to confirm changes.

     You can check your HTTP router updates in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc alb http-router get <HTTP_router_ID>
     ```

- API {#api}

  Use the [update](../api-ref/HttpRouter/update.md) REST API method for the [HttpRouter](../api-ref/HttpRouter/index.md) resource or the [HttpRouterService/Update](../api-ref/grpc/HttpRouter/update.md) gRPC API call.

{% endlist %}

## Adding a route to a virtual host {#add-virtual-host}

To add a new route to your HTTP router's virtual host:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your HTTP router.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Click your router name.
  1. Click **{{ ui-key.yacloud.common.edit }}**.
  1. Click **{{ ui-key.yacloud.alb.button_add-route }}**.
  1. Specify your route settings and click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}
 
   See the description of the CLI command for managing virtual hosts:
 
   ```bash
   yc alb virtual-host --help
   ```

   * **HTTP**

    
      You can add a new route at the beginning, end, or any position within the route list.
    
      **Add a route at the end of the list**
    
      1. See the description of the CLI command for adding a route at the end of the route list:

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
           --request-idle-timeout <request_idle_timeout>s \
           --rate-limit rps=<request_limit>,requests-per-ip
         ```

         For more information about `yc alb virtual-host append-http-route` options, see this [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/append-http-route.md).

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
    
      **Add a route at the beginning of the list**
    
      1. See the description of the CLI command for adding a route at the beginning of the route list:

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
           --request-idle-timeout <request_idle_timeout>s \
           --rate-limit rps=<request_limit>,requests-per-ip
         ```

         For more information about `yc alb virtual-host prepend-http-route` options, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/prepend-http-route.md).

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
    
      **Add a route before another route**
    
      1. See the description of the CLI command for adding a route before another route:

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
           --request-idle-timeout <request_idle_timeout>s \
           --rate-limit rps=<request_limit>,requests-per-ip
         ```

         For more information about `yc alb virtual-host insert-http-route` options, see this [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/insert-http-route.md).

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
    
      **Add a route after another route**
    
       1. See the description of the CLI command for adding a new route after another route:

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
             --request-idle-timeout <request_idle_timeout>s \
             --rate-limit rps=<request_limit>,requests-per-ip
           ```

           For more information about `yc alb virtual-host insert-http-route` options, see this [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/insert-http-route.md).
    
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

      You can add a new route at the beginning, end, or any position within the route list.
      
      **Add a route at the end of the list**
      
      1. See the description of the CLI command for adding a route at the end of the route list:

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
           --request-max-timeout <timeout>s \
           --rate-limit rps=<request_limit>,requests-per-ip
         ```

         For more information about `yc alb virtual-host append-grpc-route` options, see this [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/append-grpc-route.md).

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
      
      **Add a route at the beginning of the list**
      
      1. See the description of the CLI command for adding a route at the beginning of the route list:

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
           --request-max-timeout <timeout>s \
           --rate-limit rps=<request_limit>,requests-per-ip
         ```

         For more information about `yc alb virtual-host prepend-grpc-route` options, see this [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/prepend-grpc-route.md).

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
      
      **Add a route before another route**
      
      1. See the description of the CLI command for adding a route before another route:

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
           --request-max-timeout <timeout>s \
           --rate-limit rps=<request_limit>,requests-per-ip
         ```

          Where:

          * `--virtual-host-name`: Name of the virtual host where you want to add a route.
          * `--before`: Route name following your new route.
          * `--http-router-name`: HTTP router name.
          * `--prefix-fqmn-match`: Service name first word.
          * `--backend-group-name`: Backend group name.
          * `--request-max-timeout`: Timeout in seconds.

         For more information about `yc alb virtual-host insert-grpc-route` options, see this [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/insert-grpc-route.md).

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
      
      **Add a route after another route**
      
      1. See the description of the CLI command for adding a new route after another route:

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
            --request-max-timeout <timeout>s \
            --rate-limit rps=<request_limit>,requests-per-ip
          ```

          Where:

          * `--virtual-host-name`: Name of the virtual host where you want to add a route.
          * `--after`: Route name before your new route.
          * `--http-router-name`: HTTP router name.
          * `--prefix-fqmn-match`: Service name first word.
          * `--backend-group-name`: Backend group name.
          * `--request-max-timeout`: Timeout in seconds.

          For more information about `yc alb virtual-host insert-grpc-route` options, see this [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/insert-grpc-route.md).

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

  1. Open the {{ TF }} configuration file and add the `route` section to your virtual host description:

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

     For more information about `yandex_alb_virtual_host` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/alb_virtual_host).

     The order of routes in the list matters. For more information, see [this article](../../application-load-balancer/concepts/http-router.md#virtual-host).

  1. Check the configuration using this command:

     ```bash
     terraform validate
     ```
     
     If your configuration is correct, you will get this message:
     
     ```text
     Success! The configuration is valid.
     ```

  1. Run this command:

     ```bash
     terraform plan
     ```
  
     You will see a detailed list of resources. No changes will be made at this step. If your configuration contains errors, {{ TF }} will show them.

  1. Apply the changes:

     ```bash
     terraform apply
     ```
     
  1. Type `yes` and press **Enter** to confirm changes.

     You can check virtual host updates in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc alb virtual-host get <virtual_host_ID>
     ```

- API {#api}

  Use the [update](../api-ref/VirtualHost/update.md) REST API method for the [VirtualHost](../api-ref/VirtualHost/index.md) resource or the [VirtualHostService/Update](../api-ref/grpc/VirtualHost/update.md) gRPC API call.

{% endlist %}

## Change your virtual host’s route order {#change-route-order}

To change route order in the HTTP router:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with your HTTP router.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. Click your router name.
  1. Click **{{ ui-key.yacloud.common.edit }}**.
  1. Click **{{ ui-key.yacloud.alb.button_routes-sort }}**.
  1. In the window that opens, drag your route to a new position in the list.
  1. Click **{{ ui-key.yacloud.common.save }}**.
  1. Once you finish edits, click **{{ ui-key.yacloud.common.save }}**.
  
- CLI {#cli}

   * **HTTP**
   
      1. See the description of the CLI command for deleting a route:

          ```bash
          yc application-load-balancer virtual-host remove-http-route --help
          ```
       
      1. Delete a route:   

          ```bash
          yc alb virtual-host remove-http-route <route_name> \
            --virtual-host-name <virtual_host_name> \
            --http-router-name <router_name>
          ```
      
      1. Add your route at a required position as described above.   

   * **gRPC**
   
      1. See the description of the CLI command for deleting a route:

          ```bash
          yc application-load-balancer virtual-host remove-gRPC-route --help
          ```
       
      1. Delete a route:   

          ```bash
          yc alb virtual-host remove-grpc-route <route_name> \
            --virtual-host-name <virtual_host_name> \
            --http-router-name  <router_name>
          ```
      
      1. Add your route at a required position as described above.

- API {#api}

  Use the [update](../api-ref/VirtualHost/update.md) REST API method for the [VirtualHost](../api-ref/VirtualHost/index.md) resource or the [VirtualHostService/Update](../api-ref/grpc/VirtualHost/update.md) gRPC API call.

{% endlist %}
