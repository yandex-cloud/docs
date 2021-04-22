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
     yc alb http-router create test-http-router
     ```

     Command execution result:

     ```
     id: a5dcsselagj4o2v4a6e7
     name: test-http-router
     folder_id: aoerb349v3h4bupphtaf
     ```

  1. Create a virtual host by specifying the ID or name of an HTTP router and the virtual host settings.

     Possible parameters:
     * `--authority`: Domains for the `Host` and `authority` headers that will be associated with this virtual host. Wildcards are supported, for example, `*.foo.com` or `*-bar.foo.com`.
     * `--modify-request-header`: Settings for modifying request headers:
       * `name`: Name of the header to be modified.
       * `append`: String to be added to the header value.
       * `replace`: Value to replace the header value.
       * `rename`: New name for the header.
       * `remove`: Removing the header.
     * `--modify-response-header`: Settings for modifying response headers:
       * `name`: Name of the header to be modified.
       * `append`: String to be added to the header value.
       * `replace`: Value to replace the header value.
       * `rename`: New name for the header.
       * `remove`: Removing the header.

     ```
     yc alb  virtual-host create test-virtual-host \
     --http-router-name test-http-router \
     --authority your-domain.foo.com \
     --modify-request-header name=Accept-Language,append=ru-RU
     ```

     Command execution result:

     ```
     name: test-virtual-host
     authority:
     - your-domain.foo.com
     modify_request_headers:
     - name: Accept-Language
       append: ru-RU
     ```

  1. Add a route, indicating the router ID or name and the routing parameters:
     * `--match-http-method`: HTTP method for the route. Possible values:
       * `GET`
       * `HEAD`
       * `POST`
       * `PUT`
       * `DELETE`
       * `CONNECT`
       * `OPTIONS`
       * `TRACE`
       * `PATCH`
     * `--exact-path-match`: Exact path for routing the request.
     * `--prefix-path-match`: Path prefix for routing the request.
     * `--backend-group-id`: ID of the backend group.
     * `--backend-group-name`: Name of the backend group.
     * `--request-timeout`: Maximum time allotted for processing the request.
     * `--request-idle-timeout`: Maximum time for the balancer to wait for data from the backend.
     * `--upgrade-types`: Acceptable header values for the `Upgrade` request that can be received by the client.
     * `--auto-host-rewrite`: Replace the `Host` or `:authority` header values with the IP address of the target resource.
     * `--host-rewrite` : Host to replace the `Host` or `:authority` header values when sending requests to the backend.
     * `--path-prefix-rewrite`: Value that will replace the route prefix. The path for the request will precede the value.
     * `--direct-response-code`: HTTP code of the balancer's direct response for this route.
     * `--direct-response-body`: Body of the balancer's direct response to requests for this route.
     * `--direct-response-body-file`: Path to the file with the body of the balancer's direct response.
     * `--redirect-code`: HTTP code (`302`, `303`) or text representation (`FOUND`, `SEE_OTHER`) of a redirect to the specified route. Default value: `301`, `MOVED_PERMANENTLY`.
     * `--redirect-scheme`: Redirect scheme for requests over the specified route. If omitted, the `http` scheme is used.
     * `--redirect-host`: Value that replaces the `Host` or `:authority` headers. If omitted, the header is not changed.
     * `--redirect-port`: Redirect port on the specified route. If omitted, standard redirects are used (for example, redirect from port `80` to port `443` in the case of an HTTP-to-HTTPS redirect) or ports don't change.
     * `--redirect-path`: Redirect path on the specified route.
     * `--redirect-prefix`: URI resource prefix used for a redirect.
     * `--redirect-strip-query`: Strip the original request parameters from a redirect.

  ```
  yc alb virtual-host append-http-route test-route \
  --http-router-name test-http-router \
  --match-http-method GET \
  --exact-path-match / \--backend-group-name test-backend-group \
  --request-timeout 2s \
  --request-idle-timeout 3s
  ```

{% endlist %}

