---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Change the HTTP router parameters

To change the HTTP router parameters:

{% list tabs %}

- Management console
  1. In the [management console]({{ link-console-main }}), select the folder that the HTTP router belongs to.
  1. Select **{{ alb-name }}**.
  1. Open the **HTTP routers** section.
  1. Click on the name of the router you need.
  1. Click **Edit**.
  1. Edit the router settings.
  1. At the bottom of the page, click **Save changes**.

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

     Command execution result:

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

{% endlist %}

## Adding a route to a virtual host {#add-virtual-host}

To add a new route to an HTTP router's virtual host:

{% list tabs %}

- Management console
  1. In the [management console]({{ link-console-main }}), select the folder that the HTTP router belongs to.
  1. Select **{{ alb-name }}**.
  1. Open the **HTTP routers** section.
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

  You can add a new route to the beginning, end, or specific position in the host's route list.

  **Add a route to the end of the host's route list**

  1. View a description of the CLI command for adding a route to the end of the host's route list:

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

     Command execution result:

     ```
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
           backend_group_id: a5d3e9ko2qf0tbk0s27b
           timeout: 2s
           idle_timeout: 3s
     - name: test-route-toend
     ...
     ```

  **Add a route to the beginning of the host's route list**

  1. View a description of the CLI command for adding a route to the beginning of the host's route list:

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

     Command execution result:

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
     --before <name of the route to follow the new route> \
     --http-router-name <HTTP router name> \
     --match-http-method GET \
     --exact-path-match / \
     --backend-group-name <backend group name> \
     --request-timeout <request timeout>s \
     --request-idle-timeout <request idle timeout>s
     ```

     Command execution result:

     ```
     done (2s)
     name: test-virtual-host
     authority:
     - your-domain.foo.com
     routes:
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
      --after <name of the route to precede the new route> \
      --http-router-name <HTTP router name> \
      --match-http-method GET \
      --exact-path-match / \
      --backend-group-name <backend group name> \
      --request-timeout <request timeout>s \
      --request-idle-timeout <request idle timeout>s
      ```

      Command execution result:

      ```
      done (2s)
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
            backend_group_id: a5d3e9ko2qf0tbk0s27b
            timeout: 2s
            idle_timeout: 3s
      - name: test-route-insafter
      ...
      ```

{% endlist %}

