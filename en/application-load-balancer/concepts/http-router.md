# HTTP routers

An HTTP router defines the routing rules for HTTP requests to [backend groups](backend-group.md).

You can only set HTTP routers for [listeners](application-load-balancer.md#listener) of the **{{ ui-key.yacloud.alb.label_listener-type-http }}** type. If a listener accepts <q>pure</q> TCP traffic (**{{ ui-key.yacloud.alb.label_listener-type-stream }}** type), a backend group is explicitly specified for it.

{% include [http-router-deletion-restriction](../../_includes/application-load-balancer/http-router-deletion-restriction.md) %}

Using HTTP router settings, you can modify request and response headers and generate small static responses directly in the load balancer. You can create an empty HTTP router and then add routes to it.

Routes inside an HTTP router are combined in [virtual hosts](#virtual-host). Routing is a two-step process.

1. The most suitable virtual host is selected based on the `Host` header (`:authority` in the case of HTTP/2).

1. The first route whose predicate matches the request is selected. The order of virtual hosts inside the router doesn't matter. However, the order of routes inside the virtual host matters: the most specific routes must be at the top of the list.

## Virtual hosts {#virtual-host}

Virtual hosts combine [routes](#routes) belonging to the same set of domains, i.e., the `Host` (`:authority`) header values of an HTTP request. Both exact matches and wildcards are supported. When an incoming request is received, the balancer checks route predicates one-by-one and selects the first predicate matching the request.

The load balancer routes traffic to the [backend](./backend-group.md) that refers to various resources. These resources may be vulnerable to external threats. You can protect your resources using [{{ sws-full-name }}](../../smartwebsecurity/concepts/index.md) by connecting a [security profile](../../smartwebsecurity/operations/host-connect.md) to the virtual host.

When an {{ alb-name }} [Ingress controller](../tools/k8s-ingress-controller/index.md) manages the load balancer, connect the security profile using an [Ingress resource annotation](../k8s-ref/ingress.md#annot-security-profile-id).

The modifications of the HTTP headers of requests and responses are also configured at the virtual host level.

## Routes {#routes}

Routes are sets of conditions (predicates) that are used by the load balancer to select a route for the request and actions on the request. Possible conditions and actions depend on the route type.

### Route types {#routes-types}

HTTP routers support two types of routes, **{{ ui-key.yacloud.alb.label_proto-http }}** and **{{ ui-key.yacloud.alb.label_proto-grpc }}**:

1. HTTP routes process HTTP requests over HTTP/1.1 and HTTP/2.

   You can set the beginning or full name of a request, or a [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression), and the request method (such as GET or POST) as route conditions.

   You can perform one of the actions with the request that satisfies the conditions:

   * Sending a request to a **{{ ui-key.yacloud.alb.label_proto-http }}** [backend group](backend-group.md) for processing. In this case, you can set up timeouts for request processing, add WebSocket support, or modification of the URI before sending the request to the backends.
   * Redirecting a request to another address with the selected response code and request URI modifications. In this case, you can modify the path (completely or partially), delete query parameters, and change the host, port, and schema.
   * Immediate return of the static response.

1. gRPC routes are designed for processing gRPC requests ([remote procedure calls](https://en.wikipedia.org/wiki/Remote_procedure_call)) over HTTP/2.

   You can specify the beginning of a method, or the full method name (FQMN, fully qualified method name), or a [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression) as a condition for a gRPC route. The value must start with a slash `/`.

   You can perform one of the actions with the request that satisfies the conditions:

   * Sending a request to a **{{ ui-key.yacloud.alb.label_proto-grpc }}** [backend group](backend-group.md) for processing. In this case, you can replace the Host header and configure timeouts to process the request.
   * Immediate return of the static response.
