---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Create HTTP router

To create an HTTP router and add a route to it:

{% list tabs %}

- Management console
  1. In the [management console]({{ link-console-main }}), select the folder where you want to create an HTTP router.
  1. In the list of services, select **{{ alb-name }}**.
  1. In the menu on the left, select **HTTP routers**.
  1. Click **Create HTTP router**.
  1. Enter the router name: `test-router`.
  1. Under **Virtual hosts**, click **Add host**. Specify the backend settings:
  1. Enter the host name: `test-host-1`.
  1. Click **Add route**.
  1. Enter **Name**: `test-route`.
  1. In the **Path** field, select `Exact match` and specify the path `/`.
  1. In the **HTTP methods** list, select `GET`.
  1. In the **Action** field, leave the value `Routing`.
  1. In the **Backend group** list, select `test-backend-group`.
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

     Command execution result:

     ```
     id: a5dcsselagj4o2v4a6e7
     name: test-http-router
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2021-02-11T21:04:59.438292069Z"
     ```

  1. View a description of the CLI command for creating a virtual host:

     ```
     yc alb virtual-host create --help
     ```

  1. Create a virtual host, specifying the name of an HTTP router and the virtual host settings:

     ```
     yc alb virtual-host create <virtual host name> \
     --http-router-name <HTTP router name> \
     --authority your-domain.foo.com \
     --modify-request-header name=Accept-Language,append=ru-RU
     ```

     Command parameters:
     * `--authority`: Domains for the `Host` and `authority` headers that will be associated with this virtual host. Wildcards are supported, for example, `*.foo.com` or `*-bar.foo.com`.
     * `--modify-request-header`: Settings for modifying request headers:
       * `name`: Name of the header to be modified.
       * `append`: String to be added to the header value.

     Command execution result:

     ```
     name: test-virtual-host
     authority:
     - your-domain.foo.com
     modify_request_headers:
     - name: Accept-Language
       append: ru-RU
     ```

  1. View a description of the CLI command for adding a host:

     ```
     yc alb virtual-host append-http-route --help
     ```

  1. Add a route, indicating the router ID or name and the routing parameters:

     ```
     yc alb virtual-host append-http-route <route name> \
     --virtual-host-name <virtual host name> \
     --http-router-name <HTTP router name> \
     --prefix-path-match / \
     --backend-group-name <backend group name> \
     --request-timeout <request timeout>s \
     --request-idle-timeout <request idle timeout>s
     ```

     Command execution result:

     ```
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

{% endlist %}

