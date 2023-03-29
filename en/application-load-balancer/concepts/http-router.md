# HTTP routers

An HTTP router defines the routing rules for HTTP requests to [backend groups](backend-group.md).

You can only set HTTP routers for [listeners](application-load-balancer.md#listener) of the **HTTP** type. If a listener accepts <q>pure</q> TCP traffic (of the **Stream** type), a backend group is explicitly specified for it.

{% include [http-router-deletion-restriction](../../_includes/application-load-balancer/http-router-deletion-restriction.md) %}

Using HTTP router settings, you can modify request and response headers and generate small static responses directly in the load balancer. You can create an empty HTTP router and then add routes to it.

Routes inside an HTTP router are combined in [virtual hosts](#virtual-host). Routing is a two-step process.

1. The most suitable virtual host is selected based on the `Host` header (`:authority` in the case of HTTP/2).

1. The first route whose predicate matches the request is selected. The order of virtual hosts inside the router doesn't matter. However, the order of routes inside the virtual host matters: the most specific routes must be at the top of the list.

## Virtual hosts {#virtual-host}

Virtual hosts combine [routes](#routes) belonging to the same set of domains: the `Host` header values of an HTTP request. Both exact matches and wildcards are supported. When an incoming request is received, the balancer checks route predicates one-by-one and selects the first predicate matching the request.

How the headers of HTTP requests and responses are modified is also configured at the virtual host level.

## Routes {#routes}

Routes are sets of conditions (predicates) that are used by the load balancer to select a route for the request and actions on the request. Possible conditions and actions depend on the route type.

### Route types {#routes-types}

HTTP routers support two route types: **HTTP** and **gRPC**:

1. HTTP routes process HTTP requests over HTTP/1.1 and HTTP/2.

   You can set the beginning of or full name of the request and the request method (for example, GET and POST) as route conditions.

   You can perform one of the actions with the request that satisfies the conditions:

   * Sending a request to a [backend group](backend-group.md) of the **HTTP** type for processing. In this case, you can set up timeouts for request processing, add WebSocket support, or modification of the URI before sending the request to the backends.
   * Redirecting a request to another address with the selected response code and request URI modifications. In this case, you can modify the path (completely or partially), delete query parameters, and change the host, port, and schema.
   * Immediate return of the static response.

1. gRPC routes are designed for processing gRPC requests ([remote procedure calls](https://en.wikipedia.org/wiki/Remote_procedure_call)) over HTTP/2.

   You can specify the beginning of or the full method name (FQMN, fully qualified method name) as a condition of a gRPC route. The value must start with a slash `/`.

   You can perform one of the actions with the request that satisfies the conditions:

   * Sending a request to a [backend group](backend-group.md) of the **gRPC** type for processing. In this case, you can replace the Host header and configure timeouts to process the request.
   * Immediate return of the static response.



