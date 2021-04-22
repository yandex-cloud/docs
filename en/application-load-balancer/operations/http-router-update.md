# Edit an HTTP router

{% list tabs %}

- Management console

  To edit an HTTP router:

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
     yc alb http-router update router-1 --new-name router-1-new
     ```

{% endlist %}

## Adding a route to a virtual host {#add-virtual-host}

{% list tabs %}

- Management console

  To add a new route to an HTTP router's virtual host:
  
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

  1. See the description of the CLI command for managing virtual hosts:

     ```
     yc alb virtual-host --help
     ```

  1. You can add a new route to the beginning, end, or specific position in the host's route list.

     To add a route to the end of the list:

     ```
     yc alb virtual-host append-http-route <route name> \
     --virtual-host-name <virtual host name> \
     --http-router-name <HTTP router name> \
     --match-http-method GET \
     --exact-path-match / \
     --backend-group-name <backend group name> \
     --request-timeout 2s \
     --request-idle-timeout 3s
     ```

     To add a route to the top of the list:

     ```
     yc alb virtual-host prepend-http-route <route name> \
     --virtual-host-name <virtual host name> \
     --http-router-name <HTTP router name> \
     --match-http-method GET \
     --exact-path-match / \
     --backend-group-name <backend group name> \
     --request-timeout 2s \
     --request-idle-timeout 3s
     ```

     To add a new route before a specific route:

     ```
     yc alb virtual-host insert-http-route new-route \
     --virtual-host-name <virtual host name> \
     --before <name of the route to follow the new route> \
     --http-router-name router-1 \
     --match-http-method GET \
     --exact-path-match / \
     --backend-group-name <backend group name> \
     --request-timeout 2s \
     --request-idle-timeout 3s
     ```

     To add a route after a specific route:

     ```
     yc alb virtual-host insert-http-route new-route \
     --virtual-host-name <virtual host name> \
     --after <name of the route to precede the new route> \
     --http-router-name <HTTP router name> \
     --match-http-method GET \
     --exact-path-match / \
     --backend-group-name <backend group name> \
     --request-timeout 2s \
     --request-idle-timeout 3s
     ```

{% endlist %}

