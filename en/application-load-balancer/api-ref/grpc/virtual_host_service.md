---
editable: false
sourcePath: en/_api-ref-grpc/application-load-balancer/api-ref/grpc/virtual_host_service.md
---

# Application Load Balancer API, gRPC: VirtualHostService

A set of methods for managing virtual hosts of HTTP routers.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified virtual host. |
| [List](#List) | Lists virtual hosts of the specified HTTP router. |
| [Create](#Create) | Creates a virtual host in the specified HTTP router. |
| [Update](#Update) | Updates the specified virtual host of the specified HTTP router. |
| [Delete](#Delete) | Deletes the specified virtual host. |
| [RemoveRoute](#RemoveRoute) | Deletes the specified route from the specified virtual host. |
| [UpdateRoute](#UpdateRoute) | Updates the specified route of the specified virtual host. |

## Calls VirtualHostService {#calls}

## Get {#Get}

Returns the specified virtual host. <br>To get the list of all virtual hosts of an HTTP router, make a [List](#List) request.

**rpc Get ([GetVirtualHostRequest](#GetVirtualHostRequest)) returns ([VirtualHost](#VirtualHost))**

### GetVirtualHostRequest {#GetVirtualHostRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required. ID of the HTTP router that the virtual host belongs to. <br>To get the HTTP router ID, make a [HttpRouterService.List](./http_router_service#List) request. 
virtual_host_name | **string**<br>Required. Name of the virtual host to return. <br>To get the virtual host name, make a [VirtualHostService.List](#List) request. Value must match the regular expression ` ([a-z]([-a-z0-9]{0,61}[a-z0-9])?)? `.


### VirtualHost {#VirtualHost}

Field | Description
--- | ---
name | **string**<br>Required. Name of the virtual host. The name is unique within the HTTP router. 
authority[] | **string**<br>List of domains that are attributed to the virtual host. <br>The host is selected to process the request received by the load balancer if the domain specified in the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header matches a domain specified in the host. <br>A wildcard asterisk character (`*`) matches 0 or more characters. <br>If not specified, all domains are attributed to the host, which is the same as specifying a `*` value. An HTTP router must not contain more than one virtual host to which all domains are attributed. 
routes[] | **[Route](#Route)**<br>Routes of the virtual host. <br>A route contains a set of conditions (predicates) that are used by the load balancer to select the route for the request and an action on the request. For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#routes). <br>The order of routes matters: the first route whose predicate matches the request is selected. The most specific routes should be at the top of the list, so that they are not overridden. For example, if the first HTTP route is configured, via [HttpRoute.match](#HttpRoute), to match paths prefixed with just `/`, other routes are never matched. 
modify_request_headers[] | **[HeaderModification](#HeaderModification)**<br>Deprecated, use route_options.modify_request_headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification)**<br>Deprecated, use route_options.modify_response_headers. 
route_options | **[RouteOptions](#RouteOptions)**<br> 


### Route {#Route}

Field | Description
--- | ---
name | **string**<br>Required. Name of the route. 
route | **oneof:** `http` or `grpc`<br>Route configuration.
&nbsp;&nbsp;http | **[HttpRoute](#HttpRoute)**<br>HTTP route configuration. 
&nbsp;&nbsp;grpc | **[GrpcRoute](#GrpcRoute)**<br>gRPC route configuration. 
route_options | **[RouteOptions](#RouteOptions)**<br> 


### HttpRoute {#HttpRoute}

Field | Description
--- | ---
match | **[HttpRouteMatch](#HttpRouteMatch)**<br>Condition (predicate) used to select the route. 
action | **oneof:** `route`, `redirect` or `direct_response`<br>Action performed on the request if the route is selected.
&nbsp;&nbsp;route | **[HttpRouteAction](#HttpRouteAction)**<br>Forwards the request to a backend group for processing as configured. 
&nbsp;&nbsp;redirect | **[RedirectAction](#RedirectAction)**<br>Redirects the request as configured. 
&nbsp;&nbsp;direct_response | **[DirectResponseAction](#DirectResponseAction)**<br>Instructs the load balancer to respond directly as configured. 


### HttpRouteMatch {#HttpRouteMatch}

Field | Description
--- | ---
http_method[] | **string**<br>HTTP method specified in the request. 
path | **[StringMatch](#StringMatch)**<br>Match settings for the path specified in the request. <br>If not specified, the route matches all paths. 


### StringMatch {#StringMatch}

Field | Description
--- | ---
match | **oneof:** `exact_match`, `prefix_match` or `regex_match`<br>Match string for either exact or prefix match.
&nbsp;&nbsp;exact_match | **string**<br>Exact match string. 
&nbsp;&nbsp;prefix_match | **string**<br>Prefix match string. 
&nbsp;&nbsp;regex_match | **string**<br>Regular expression match string. 


### HttpRouteAction {#HttpRouteAction}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to forward requests to. <br>Stream (TCP) backend groups are not supported. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it. <br>If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code. <br>Default value: `60`. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Idle timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it. <br>Specifying meaningful values for both `timeout` and `idle_timeout` is useful for implementing server-push mechanisms such as long polling, server-sent events (`EventSource` interface) etc. <br>If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code. <br>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see `timeout`). 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers. <br>If not specified, the host is not changed.
&nbsp;&nbsp;host_rewrite | **string**<br>Host replacement. 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br>Automatically replaces the host with that of the target. 
prefix_rewrite | **string**<br>Replacement for the path prefix matched by [StringMatch](#StringMatch1). <br>For instance, if [StringMatch.prefix_match](#StringMatch1) value is `/foo` and `replace_prefix` value is `/bar`, a request with `/foobaz` path is forwarded with `/barbaz` path. For [StringMatch.exact_match](#StringMatch1), the whole path is replaced. <br>If not specified, the path is not changed. 
upgrade_types[] | **string**<br>Supported values for HTTP `Upgrade` header. E.g. `websocket`. 


### RedirectAction {#RedirectAction}

Field | Description
--- | ---
replace_scheme | **string**<br>URI scheme replacement. <br>If `http` or `https` scheme is to be replaced and `80` or `443` port is specified in the original URI, the port is also removed. <br>If not specified, the original scheme and port are used. 
replace_host | **string**<br>URI host replacement. <br>If not specified, the original host is used. 
replace_port | **int64**<br>URI host replacement. <br>If not specified, the original host is used. 
path | **oneof:** `replace_path` or `replace_prefix`<br>URI path replacement. <br>If not specified, the original path is used.
&nbsp;&nbsp;replace_path | **string**<br>Replacement for the whole path. 
&nbsp;&nbsp;replace_prefix | **string**<br>Replacement for the path prefix matched by [StringMatch](#StringMatch1). <br>For instance, if [StringMatch.prefix_match](#StringMatch1) value is `/foo` and `replace_prefix` value is `/bar`, a request with `https://example.com/foobaz` URI is redirected to `https://example.com/barbaz`. For [StringMatch.exact_match](#StringMatch1), the whole path is replaced. 
remove_query | **bool**<br>Removes URI query. 
response_code | enum **RedirectResponseCode**<br>HTTP status code to use in redirect responses. <ul><li>`MOVED_PERMANENTLY`: `301 Moved Permanently` status code.</li><li>`FOUND`: `302 Found` status code.</li><li>`SEE_OTHER`: `303 See Other` status code.</li><li>`TEMPORARY_REDIRECT`: `307 Temporary Redirect` status code.</li><li>`PERMANENT_REDIRECT`: `308 Permanent Redirect` status code.</li></ul>


### DirectResponseAction {#DirectResponseAction}

Field | Description
--- | ---
status | **int64**<br>HTTP status code to use in responses. Acceptable values are 100 to 599, inclusive.
body | **[Payload](#Payload)**<br>Response body. 


### Payload {#Payload}

Field | Description
--- | ---
payload | **oneof:** `text`<br>Payload.
&nbsp;&nbsp;text | **string**<br>Payload text. The string length in characters must be greater than 0.


### GrpcRoute {#GrpcRoute}

Field | Description
--- | ---
match | **[GrpcRouteMatch](#GrpcRouteMatch)**<br>Condition (predicate) used to select the route. 
action | **oneof:** `route` or `status_response`<br>Action performed on the request if the route is selected.
&nbsp;&nbsp;route | **[GrpcRouteAction](#GrpcRouteAction)**<br>Forwards the request to a backend group for processing as configured. 
&nbsp;&nbsp;status_response | **[GrpcStatusResponseAction](#GrpcStatusResponseAction)**<br>Instructs the load balancer to respond directly with a specified status. 


### GrpcRouteMatch {#GrpcRouteMatch}

Field | Description
--- | ---
fqmn | **[StringMatch](#StringMatch1)**<br>Match settings for gRPC service method called in the request. <br>A match string must be a fully qualified method name, e.g. `foo.bar.v1.BazService/Get`, or a prefix of such. <br>If not specified, the route matches all methods. 


### GrpcRouteAction {#GrpcRouteAction}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to forward requests to. 
max_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it. <br>If a client specifies a lower timeout in HTTP `grpc-timeout` header, the `max_timeout` value is ignored. <br>If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code. <br>Default value: `60`. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Idle timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it. <br>Specifying meaningful values for both `max_timeout` and `idle_timeout` is useful for implementing server-push mechanisms such as long polling, server-sent events etc. <br>If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code. <br>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see `max_timeout`). 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers. <br>If not specified, the host is not changed.
&nbsp;&nbsp;host_rewrite | **string**<br>Host replacement. 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br>Automatically replaces the host with that of the target. 


### GrpcStatusResponseAction {#GrpcStatusResponseAction}

Field | Description
--- | ---
status | enum **Status**<br>gRPC [status code](https://grpc.github.io/grpc/core/md_doc_statuscodes.html) to use in responses. <ul><li>`OK`: `OK` (0) status code.</li><li>`INVALID_ARGUMENT`: `INVALID_ARGUMENT` (3) status code.</li><li>`NOT_FOUND`: `NOT_FOUND` (5) status code.</li><li>`PERMISSION_DENIED`: `PERMISSION_DENIED` (7) status code.</li><li>`UNAUTHENTICATED`: `UNAUTHENTICATED` (16) status code.</li><li>`UNIMPLEMENTED`: `UNIMPLEMENTED` (12) status code.</li><li>`INTERNAL`: `INTERNAL` (13) status code.</li><li>`UNAVAILABLE`: `UNAVAILABLE` (14) status code.</li></ul>


### HeaderModification {#HeaderModification}

Field | Description
--- | ---
name | **string**<br>Name of the header. 
operation | **oneof:** `append`, `replace`, `remove` or `rename`<br>Operation to perform on the header.
&nbsp;&nbsp;append | **string**<br>Appends the specified string to the header value. <br>Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers) are supported. 
&nbsp;&nbsp;replace | **string**<br>Replaces the value of the header with the specified string. <br>Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers) are supported. 
&nbsp;&nbsp;remove | **bool**<br>Removes the header. 
&nbsp;&nbsp;rename | **string**<br>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts. 


### RouteOptions {#RouteOptions}

Field | Description
--- | ---
modify_request_headers[] | **[HeaderModification](#HeaderModification1)**<br>Apply the following modifications to the request headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification1)**<br>Apply the following modifications to the response headers. 
rbac | **[RBAC](#RBAC)**<br> 


### RBAC {#RBAC}

Field | Description
--- | ---
action | enum **Action**<br>Required. The action to take if a principal matches. Every action either allows or denies a request. <ul><li>`ALLOW`: Allows the request if and only if there is a principal that matches the request.</li><li>`DENY`: Allows the request if and only if there are no principal that match the request.</li></ul>
principals[] | **[Principals](#Principals)**<br>Required. A match occurs when at least one matches the request. The minimum number of elements is 1.


### Principals {#Principals}

Field | Description
--- | ---
and_principals[] | **[Principal](#Principal)**<br>Required. A match occurs when all principals match the request. The minimum number of elements is 1.


### Principal {#Principal}

Field | Description
--- | ---
identifier | **oneof:** `header`, `remote_ip` or `any`<br>
&nbsp;&nbsp;header | **[HeaderMatcher](#HeaderMatcher)**<br>A header (or pseudo-header such as: path or: method) of the incoming HTTP request. 
&nbsp;&nbsp;remote_ip | **string**<br>A CIDR block or IP that describes the request remote/origin address, e.g. ``192.0.0.0/24`` or``192.0.0.4`` . 
&nbsp;&nbsp;any | **bool**<br>When any is set, it matches any request. 


### HeaderMatcher {#HeaderMatcher}

Field | Description
--- | ---
name | **string**<br>Required. Specifies the name of the header in the request. 
value | **[StringMatch](#StringMatch1)**<br>Specifies how the header match will be performed to route the request. In the absence of value a request that has specified header name will match, regardless of the header's value. 


## List {#List}

Lists virtual hosts of the specified HTTP router.

**rpc List ([ListVirtualHostsRequest](#ListVirtualHostsRequest)) returns ([ListVirtualHostsResponse](#ListVirtualHostsResponse))**

### ListVirtualHostsRequest {#ListVirtualHostsRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required. ID of the HTTP router to list virtual hosts in. <br>To get the HTTP router ID, make a [HttpRouterService.List](./http_router_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListVirtualHostsResponse.next_page_token](#ListVirtualHostsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListVirtualHostsResponse.next_page_token](#ListVirtualHostsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListVirtualHostsResponse {#ListVirtualHostsResponse}

Field | Description
--- | ---
virtual_hosts[] | **[VirtualHost](#VirtualHost1)**<br>List of virtual hosts of the specified HTTP router. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListVirtualHostsRequest.page_size](#ListVirtualHostsRequest), use `next_page_token` as the value for the [ListVirtualHostsRequest.page_token](#ListVirtualHostsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### VirtualHost {#VirtualHost1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the virtual host. The name is unique within the HTTP router. 
authority[] | **string**<br>List of domains that are attributed to the virtual host. <br>The host is selected to process the request received by the load balancer if the domain specified in the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header matches a domain specified in the host. <br>A wildcard asterisk character (`*`) matches 0 or more characters. <br>If not specified, all domains are attributed to the host, which is the same as specifying a `*` value. An HTTP router must not contain more than one virtual host to which all domains are attributed. 
routes[] | **[Route](#Route1)**<br>Routes of the virtual host. <br>A route contains a set of conditions (predicates) that are used by the load balancer to select the route for the request and an action on the request. For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#routes). <br>The order of routes matters: the first route whose predicate matches the request is selected. The most specific routes should be at the top of the list, so that they are not overridden. For example, if the first HTTP route is configured, via [HttpRoute.match](#HttpRoute1), to match paths prefixed with just `/`, other routes are never matched. 
modify_request_headers[] | **[HeaderModification](#HeaderModification1)**<br>Deprecated, use route_options.modify_request_headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification1)**<br>Deprecated, use route_options.modify_response_headers. 
route_options | **[RouteOptions](#RouteOptions1)**<br> 


### Route {#Route1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the route. 
route | **oneof:** `http` or `grpc`<br>Route configuration.
&nbsp;&nbsp;http | **[HttpRoute](#HttpRoute1)**<br>HTTP route configuration. 
&nbsp;&nbsp;grpc | **[GrpcRoute](#GrpcRoute1)**<br>gRPC route configuration. 
route_options | **[RouteOptions](#RouteOptions1)**<br> 


### HttpRoute {#HttpRoute1}

Field | Description
--- | ---
match | **[HttpRouteMatch](#HttpRouteMatch1)**<br>Condition (predicate) used to select the route. 
action | **oneof:** `route`, `redirect` or `direct_response`<br>Action performed on the request if the route is selected.
&nbsp;&nbsp;route | **[HttpRouteAction](#HttpRouteAction1)**<br>Forwards the request to a backend group for processing as configured. 
&nbsp;&nbsp;redirect | **[RedirectAction](#RedirectAction1)**<br>Redirects the request as configured. 
&nbsp;&nbsp;direct_response | **[DirectResponseAction](#DirectResponseAction1)**<br>Instructs the load balancer to respond directly as configured. 


### HttpRouteMatch {#HttpRouteMatch1}

Field | Description
--- | ---
http_method[] | **string**<br>HTTP method specified in the request. 
path | **[StringMatch](#StringMatch1)**<br>Match settings for the path specified in the request. <br>If not specified, the route matches all paths. 


### StringMatch {#StringMatch1}

Field | Description
--- | ---
match | **oneof:** `exact_match`, `prefix_match` or `regex_match`<br>Match string for either exact or prefix match.
&nbsp;&nbsp;exact_match | **string**<br>Exact match string. 
&nbsp;&nbsp;prefix_match | **string**<br>Prefix match string. 
&nbsp;&nbsp;regex_match | **string**<br>Regular expression match string. 


### HttpRouteAction {#HttpRouteAction1}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to forward requests to. <br>Stream (TCP) backend groups are not supported. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it. <br>If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code. <br>Default value: `60`. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Idle timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it. <br>Specifying meaningful values for both `timeout` and `idle_timeout` is useful for implementing server-push mechanisms such as long polling, server-sent events (`EventSource` interface) etc. <br>If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code. <br>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see `timeout`). 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers. <br>If not specified, the host is not changed.
&nbsp;&nbsp;host_rewrite | **string**<br>Host replacement. 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br>Automatically replaces the host with that of the target. 
prefix_rewrite | **string**<br>Replacement for the path prefix matched by [StringMatch](#StringMatch2). <br>For instance, if [StringMatch.prefix_match](#StringMatch2) value is `/foo` and `replace_prefix` value is `/bar`, a request with `/foobaz` path is forwarded with `/barbaz` path. For [StringMatch.exact_match](#StringMatch2), the whole path is replaced. <br>If not specified, the path is not changed. 
upgrade_types[] | **string**<br>Supported values for HTTP `Upgrade` header. E.g. `websocket`. 


### RedirectAction {#RedirectAction1}

Field | Description
--- | ---
replace_scheme | **string**<br>URI scheme replacement. <br>If `http` or `https` scheme is to be replaced and `80` or `443` port is specified in the original URI, the port is also removed. <br>If not specified, the original scheme and port are used. 
replace_host | **string**<br>URI host replacement. <br>If not specified, the original host is used. 
replace_port | **int64**<br>URI host replacement. <br>If not specified, the original host is used. 
path | **oneof:** `replace_path` or `replace_prefix`<br>URI path replacement. <br>If not specified, the original path is used.
&nbsp;&nbsp;replace_path | **string**<br>Replacement for the whole path. 
&nbsp;&nbsp;replace_prefix | **string**<br>Replacement for the path prefix matched by [StringMatch](#StringMatch2). <br>For instance, if [StringMatch.prefix_match](#StringMatch2) value is `/foo` and `replace_prefix` value is `/bar`, a request with `https://example.com/foobaz` URI is redirected to `https://example.com/barbaz`. For [StringMatch.exact_match](#StringMatch2), the whole path is replaced. 
remove_query | **bool**<br>Removes URI query. 
response_code | enum **RedirectResponseCode**<br>HTTP status code to use in redirect responses. <ul><li>`MOVED_PERMANENTLY`: `301 Moved Permanently` status code.</li><li>`FOUND`: `302 Found` status code.</li><li>`SEE_OTHER`: `303 See Other` status code.</li><li>`TEMPORARY_REDIRECT`: `307 Temporary Redirect` status code.</li><li>`PERMANENT_REDIRECT`: `308 Permanent Redirect` status code.</li></ul>


### DirectResponseAction {#DirectResponseAction1}

Field | Description
--- | ---
status | **int64**<br>HTTP status code to use in responses. Acceptable values are 100 to 599, inclusive.
body | **[Payload](#Payload1)**<br>Response body. 


### Payload {#Payload1}

Field | Description
--- | ---
payload | **oneof:** `text`<br>Payload.
&nbsp;&nbsp;text | **string**<br>Payload text. The string length in characters must be greater than 0.


### GrpcRoute {#GrpcRoute1}

Field | Description
--- | ---
match | **[GrpcRouteMatch](#GrpcRouteMatch1)**<br>Condition (predicate) used to select the route. 
action | **oneof:** `route` or `status_response`<br>Action performed on the request if the route is selected.
&nbsp;&nbsp;route | **[GrpcRouteAction](#GrpcRouteAction1)**<br>Forwards the request to a backend group for processing as configured. 
&nbsp;&nbsp;status_response | **[GrpcStatusResponseAction](#GrpcStatusResponseAction1)**<br>Instructs the load balancer to respond directly with a specified status. 


### GrpcRouteMatch {#GrpcRouteMatch1}

Field | Description
--- | ---
fqmn | **[StringMatch](#StringMatch2)**<br>Match settings for gRPC service method called in the request. <br>A match string must be a fully qualified method name, e.g. `foo.bar.v1.BazService/Get`, or a prefix of such. <br>If not specified, the route matches all methods. 


### GrpcRouteAction {#GrpcRouteAction1}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to forward requests to. 
max_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it. <br>If a client specifies a lower timeout in HTTP `grpc-timeout` header, the `max_timeout` value is ignored. <br>If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code. <br>Default value: `60`. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Idle timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it. <br>Specifying meaningful values for both `max_timeout` and `idle_timeout` is useful for implementing server-push mechanisms such as long polling, server-sent events etc. <br>If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code. <br>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see `max_timeout`). 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers. <br>If not specified, the host is not changed.
&nbsp;&nbsp;host_rewrite | **string**<br>Host replacement. 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br>Automatically replaces the host with that of the target. 


### GrpcStatusResponseAction {#GrpcStatusResponseAction1}

Field | Description
--- | ---
status | enum **Status**<br>gRPC [status code](https://grpc.github.io/grpc/core/md_doc_statuscodes.html) to use in responses. <ul><li>`OK`: `OK` (0) status code.</li><li>`INVALID_ARGUMENT`: `INVALID_ARGUMENT` (3) status code.</li><li>`NOT_FOUND`: `NOT_FOUND` (5) status code.</li><li>`PERMISSION_DENIED`: `PERMISSION_DENIED` (7) status code.</li><li>`UNAUTHENTICATED`: `UNAUTHENTICATED` (16) status code.</li><li>`UNIMPLEMENTED`: `UNIMPLEMENTED` (12) status code.</li><li>`INTERNAL`: `INTERNAL` (13) status code.</li><li>`UNAVAILABLE`: `UNAVAILABLE` (14) status code.</li></ul>


### HeaderModification {#HeaderModification1}

Field | Description
--- | ---
name | **string**<br>Name of the header. 
operation | **oneof:** `append`, `replace`, `remove` or `rename`<br>Operation to perform on the header.
&nbsp;&nbsp;append | **string**<br>Appends the specified string to the header value. <br>Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers) are supported. 
&nbsp;&nbsp;replace | **string**<br>Replaces the value of the header with the specified string. <br>Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers) are supported. 
&nbsp;&nbsp;remove | **bool**<br>Removes the header. 
&nbsp;&nbsp;rename | **string**<br>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts. 


### RouteOptions {#RouteOptions1}

Field | Description
--- | ---
modify_request_headers[] | **[HeaderModification](#HeaderModification2)**<br>Apply the following modifications to the request headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification2)**<br>Apply the following modifications to the response headers. 
rbac | **[RBAC](#RBAC1)**<br> 


### RBAC {#RBAC1}

Field | Description
--- | ---
action | enum **Action**<br>Required. The action to take if a principal matches. Every action either allows or denies a request. <ul><li>`ALLOW`: Allows the request if and only if there is a principal that matches the request.</li><li>`DENY`: Allows the request if and only if there are no principal that match the request.</li></ul>
principals[] | **[Principals](#Principals1)**<br>Required. A match occurs when at least one matches the request. The minimum number of elements is 1.


### Principals {#Principals1}

Field | Description
--- | ---
and_principals[] | **[Principal](#Principal1)**<br>Required. A match occurs when all principals match the request. The minimum number of elements is 1.


### Principal {#Principal1}

Field | Description
--- | ---
identifier | **oneof:** `header`, `remote_ip` or `any`<br>
&nbsp;&nbsp;header | **[HeaderMatcher](#HeaderMatcher1)**<br>A header (or pseudo-header such as: path or: method) of the incoming HTTP request. 
&nbsp;&nbsp;remote_ip | **string**<br>A CIDR block or IP that describes the request remote/origin address, e.g. ``192.0.0.0/24`` or``192.0.0.4`` . 
&nbsp;&nbsp;any | **bool**<br>When any is set, it matches any request. 


### HeaderMatcher {#HeaderMatcher1}

Field | Description
--- | ---
name | **string**<br>Required. Specifies the name of the header in the request. 
value | **[StringMatch](#StringMatch2)**<br>Specifies how the header match will be performed to route the request. In the absence of value a request that has specified header name will match, regardless of the header's value. 


## Create {#Create}

Creates a virtual host in the specified HTTP router.

**rpc Create ([CreateVirtualHostRequest](#CreateVirtualHostRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateVirtualHostMetadata](#CreateVirtualHostMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[VirtualHost](#VirtualHost2)<br>

### CreateVirtualHostRequest {#CreateVirtualHostRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required. ID of the HTTP router to create a virtual host in. <br>To get the HTTP router ID, make a [HttpRouterService.List](./http_router_service#List) request. 
name | **string**<br>Name of the virtual host. The name must be unique within the HTTP router and cannot be changed after creation. Value must match the regular expression ` ([a-z]([-a-z0-9]{0,61}[a-z0-9])?)? `.
authority[] | **string**<br>List of domains that are attributed to the virtual host. <br>The host is selected to process the request received by the load balancer if the domain specified in the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header matches a domain specified in the host. <br>A wildcard asterisk character (`*`) matches 0 or more characters. <br>If not specified, all domains are attributed to the host, which is the same as specifying a `*` value. An HTTP router must not contain more than one virtual host to which all domains are attributed. 
routes[] | **[Route](#Route2)**<br>Routes of the virtual host. <br>A route contains a set of conditions (predicates) that are used by the load balancer to select the route for the request and an action on the request. For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#routes). <br>The order of routes matters: the first route whose predicate matches the request is selected. The most specific routes should be at the top of the list, so that they are not overridden. For example, if the first HTTP route is configured, via [HttpRoute.match](#HttpRoute2), to match paths prefixed with just `/`, other routes are never matched. 
modify_request_headers[] | **[HeaderModification](#HeaderModification2)**<br>Modifications that are made to the headers of incoming HTTP requests before they are forwarded to backends. 
modify_response_headers[] | **[HeaderModification](#HeaderModification2)**<br>Modifications that are made to the headers of HTTP responses received from backends before responses are forwarded to clients. 
route_options | **[RouteOptions](#RouteOptions2)**<br>Route options for the virtual host. 


### Route {#Route2}

Field | Description
--- | ---
name | **string**<br>Required. Name of the route. 
route | **oneof:** `http` or `grpc`<br>Route configuration.
&nbsp;&nbsp;http | **[HttpRoute](#HttpRoute2)**<br>HTTP route configuration. 
&nbsp;&nbsp;grpc | **[GrpcRoute](#GrpcRoute2)**<br>gRPC route configuration. 
route_options | **[RouteOptions](#RouteOptions2)**<br> 


### HttpRoute {#HttpRoute2}

Field | Description
--- | ---
match | **[HttpRouteMatch](#HttpRouteMatch2)**<br>Condition (predicate) used to select the route. 
action | **oneof:** `route`, `redirect` or `direct_response`<br>Action performed on the request if the route is selected.
&nbsp;&nbsp;route | **[HttpRouteAction](#HttpRouteAction2)**<br>Forwards the request to a backend group for processing as configured. 
&nbsp;&nbsp;redirect | **[RedirectAction](#RedirectAction2)**<br>Redirects the request as configured. 
&nbsp;&nbsp;direct_response | **[DirectResponseAction](#DirectResponseAction2)**<br>Instructs the load balancer to respond directly as configured. 


### HttpRouteMatch {#HttpRouteMatch2}

Field | Description
--- | ---
http_method[] | **string**<br>HTTP method specified in the request. 
path | **[StringMatch](#StringMatch2)**<br>Match settings for the path specified in the request. <br>If not specified, the route matches all paths. 


### StringMatch {#StringMatch2}

Field | Description
--- | ---
match | **oneof:** `exact_match`, `prefix_match` or `regex_match`<br>Match string for either exact or prefix match.
&nbsp;&nbsp;exact_match | **string**<br>Exact match string. 
&nbsp;&nbsp;prefix_match | **string**<br>Prefix match string. 
&nbsp;&nbsp;regex_match | **string**<br>Regular expression match string. 


### HttpRouteAction {#HttpRouteAction2}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to forward requests to. <br>Stream (TCP) backend groups are not supported. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it. <br>If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code. <br>Default value: `60`. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Idle timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it. <br>Specifying meaningful values for both `timeout` and `idle_timeout` is useful for implementing server-push mechanisms such as long polling, server-sent events (`EventSource` interface) etc. <br>If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code. <br>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see `timeout`). 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers. <br>If not specified, the host is not changed.
&nbsp;&nbsp;host_rewrite | **string**<br>Host replacement. 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br>Automatically replaces the host with that of the target. 
prefix_rewrite | **string**<br>Replacement for the path prefix matched by [StringMatch](#StringMatch3). <br>For instance, if [StringMatch.prefix_match](#StringMatch3) value is `/foo` and `replace_prefix` value is `/bar`, a request with `/foobaz` path is forwarded with `/barbaz` path. For [StringMatch.exact_match](#StringMatch3), the whole path is replaced. <br>If not specified, the path is not changed. 
upgrade_types[] | **string**<br>Supported values for HTTP `Upgrade` header. E.g. `websocket`. 


### RedirectAction {#RedirectAction2}

Field | Description
--- | ---
replace_scheme | **string**<br>URI scheme replacement. <br>If `http` or `https` scheme is to be replaced and `80` or `443` port is specified in the original URI, the port is also removed. <br>If not specified, the original scheme and port are used. 
replace_host | **string**<br>URI host replacement. <br>If not specified, the original host is used. 
replace_port | **int64**<br>URI host replacement. <br>If not specified, the original host is used. 
path | **oneof:** `replace_path` or `replace_prefix`<br>URI path replacement. <br>If not specified, the original path is used.
&nbsp;&nbsp;replace_path | **string**<br>Replacement for the whole path. 
&nbsp;&nbsp;replace_prefix | **string**<br>Replacement for the path prefix matched by [StringMatch](#StringMatch3). <br>For instance, if [StringMatch.prefix_match](#StringMatch3) value is `/foo` and `replace_prefix` value is `/bar`, a request with `https://example.com/foobaz` URI is redirected to `https://example.com/barbaz`. For [StringMatch.exact_match](#StringMatch3), the whole path is replaced. 
remove_query | **bool**<br>Removes URI query. 
response_code | enum **RedirectResponseCode**<br>HTTP status code to use in redirect responses. <ul><li>`MOVED_PERMANENTLY`: `301 Moved Permanently` status code.</li><li>`FOUND`: `302 Found` status code.</li><li>`SEE_OTHER`: `303 See Other` status code.</li><li>`TEMPORARY_REDIRECT`: `307 Temporary Redirect` status code.</li><li>`PERMANENT_REDIRECT`: `308 Permanent Redirect` status code.</li></ul>


### DirectResponseAction {#DirectResponseAction2}

Field | Description
--- | ---
status | **int64**<br>HTTP status code to use in responses. Acceptable values are 100 to 599, inclusive.
body | **[Payload](#Payload2)**<br>Response body. 


### Payload {#Payload2}

Field | Description
--- | ---
payload | **oneof:** `text`<br>Payload.
&nbsp;&nbsp;text | **string**<br>Payload text. The string length in characters must be greater than 0.


### GrpcRoute {#GrpcRoute2}

Field | Description
--- | ---
match | **[GrpcRouteMatch](#GrpcRouteMatch2)**<br>Condition (predicate) used to select the route. 
action | **oneof:** `route` or `status_response`<br>Action performed on the request if the route is selected.
&nbsp;&nbsp;route | **[GrpcRouteAction](#GrpcRouteAction2)**<br>Forwards the request to a backend group for processing as configured. 
&nbsp;&nbsp;status_response | **[GrpcStatusResponseAction](#GrpcStatusResponseAction2)**<br>Instructs the load balancer to respond directly with a specified status. 


### GrpcRouteMatch {#GrpcRouteMatch2}

Field | Description
--- | ---
fqmn | **[StringMatch](#StringMatch3)**<br>Match settings for gRPC service method called in the request. <br>A match string must be a fully qualified method name, e.g. `foo.bar.v1.BazService/Get`, or a prefix of such. <br>If not specified, the route matches all methods. 


### GrpcRouteAction {#GrpcRouteAction2}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to forward requests to. 
max_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it. <br>If a client specifies a lower timeout in HTTP `grpc-timeout` header, the `max_timeout` value is ignored. <br>If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code. <br>Default value: `60`. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Idle timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it. <br>Specifying meaningful values for both `max_timeout` and `idle_timeout` is useful for implementing server-push mechanisms such as long polling, server-sent events etc. <br>If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code. <br>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see `max_timeout`). 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers. <br>If not specified, the host is not changed.
&nbsp;&nbsp;host_rewrite | **string**<br>Host replacement. 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br>Automatically replaces the host with that of the target. 


### GrpcStatusResponseAction {#GrpcStatusResponseAction2}

Field | Description
--- | ---
status | enum **Status**<br>gRPC [status code](https://grpc.github.io/grpc/core/md_doc_statuscodes.html) to use in responses. <ul><li>`OK`: `OK` (0) status code.</li><li>`INVALID_ARGUMENT`: `INVALID_ARGUMENT` (3) status code.</li><li>`NOT_FOUND`: `NOT_FOUND` (5) status code.</li><li>`PERMISSION_DENIED`: `PERMISSION_DENIED` (7) status code.</li><li>`UNAUTHENTICATED`: `UNAUTHENTICATED` (16) status code.</li><li>`UNIMPLEMENTED`: `UNIMPLEMENTED` (12) status code.</li><li>`INTERNAL`: `INTERNAL` (13) status code.</li><li>`UNAVAILABLE`: `UNAVAILABLE` (14) status code.</li></ul>


### HeaderModification {#HeaderModification2}

Field | Description
--- | ---
name | **string**<br>Name of the header. 
operation | **oneof:** `append`, `replace`, `remove` or `rename`<br>Operation to perform on the header.
&nbsp;&nbsp;append | **string**<br>Appends the specified string to the header value. <br>Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers) are supported. 
&nbsp;&nbsp;replace | **string**<br>Replaces the value of the header with the specified string. <br>Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers) are supported. 
&nbsp;&nbsp;remove | **bool**<br>Removes the header. 
&nbsp;&nbsp;rename | **string**<br>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts. 


### RouteOptions {#RouteOptions2}

Field | Description
--- | ---
modify_request_headers[] | **[HeaderModification](#HeaderModification3)**<br>Apply the following modifications to the request headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification3)**<br>Apply the following modifications to the response headers. 
rbac | **[RBAC](#RBAC2)**<br> 


### RBAC {#RBAC2}

Field | Description
--- | ---
action | enum **Action**<br>Required. The action to take if a principal matches. Every action either allows or denies a request. <ul><li>`ALLOW`: Allows the request if and only if there is a principal that matches the request.</li><li>`DENY`: Allows the request if and only if there are no principal that match the request.</li></ul>
principals[] | **[Principals](#Principals2)**<br>Required. A match occurs when at least one matches the request. The minimum number of elements is 1.


### Principals {#Principals2}

Field | Description
--- | ---
and_principals[] | **[Principal](#Principal2)**<br>Required. A match occurs when all principals match the request. The minimum number of elements is 1.


### Principal {#Principal2}

Field | Description
--- | ---
identifier | **oneof:** `header`, `remote_ip` or `any`<br>
&nbsp;&nbsp;header | **[HeaderMatcher](#HeaderMatcher2)**<br>A header (or pseudo-header such as: path or: method) of the incoming HTTP request. 
&nbsp;&nbsp;remote_ip | **string**<br>A CIDR block or IP that describes the request remote/origin address, e.g. ``192.0.0.0/24`` or``192.0.0.4`` . 
&nbsp;&nbsp;any | **bool**<br>When any is set, it matches any request. 


### HeaderMatcher {#HeaderMatcher2}

Field | Description
--- | ---
name | **string**<br>Required. Specifies the name of the header in the request. 
value | **[StringMatch](#StringMatch3)**<br>Specifies how the header match will be performed to route the request. In the absence of value a request that has specified header name will match, regardless of the header's value. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateVirtualHostMetadata](#CreateVirtualHostMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[VirtualHost](#VirtualHost2)>**<br>if operation finished successfully. 


### CreateVirtualHostMetadata {#CreateVirtualHostMetadata}

Field | Description
--- | ---
http_router_id | **string**<br>Required. ID of the HTTP router that the virtual host is being created in. 
virtual_host_name | **string**<br>Name of the virtual host that is being created. 


### VirtualHost {#VirtualHost2}

Field | Description
--- | ---
name | **string**<br>Required. Name of the virtual host. The name is unique within the HTTP router. 
authority[] | **string**<br>List of domains that are attributed to the virtual host. <br>The host is selected to process the request received by the load balancer if the domain specified in the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header matches a domain specified in the host. <br>A wildcard asterisk character (`*`) matches 0 or more characters. <br>If not specified, all domains are attributed to the host, which is the same as specifying a `*` value. An HTTP router must not contain more than one virtual host to which all domains are attributed. 
routes[] | **[Route](#Route3)**<br>Routes of the virtual host. <br>A route contains a set of conditions (predicates) that are used by the load balancer to select the route for the request and an action on the request. For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#routes). <br>The order of routes matters: the first route whose predicate matches the request is selected. The most specific routes should be at the top of the list, so that they are not overridden. For example, if the first HTTP route is configured, via [HttpRoute.match](#HttpRoute3), to match paths prefixed with just `/`, other routes are never matched. 
modify_request_headers[] | **[HeaderModification](#HeaderModification3)**<br>Deprecated, use route_options.modify_request_headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification3)**<br>Deprecated, use route_options.modify_response_headers. 
route_options | **[RouteOptions](#RouteOptions3)**<br> 


## Update {#Update}

Updates the specified virtual host of the specified HTTP router.

**rpc Update ([UpdateVirtualHostRequest](#UpdateVirtualHostRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateVirtualHostMetadata](#UpdateVirtualHostMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[VirtualHost](#VirtualHost3)<br>

### UpdateVirtualHostRequest {#UpdateVirtualHostRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required. ID of the HTTP router to update a virtual host in. <br>To get the HTTP router ID, make a [HttpRouterService.List](./http_router_service#List) request. 
virtual_host_name | **string**<br>Required. Name of the virtual host. <br>Used only to refer to the virtual host. The name of a host cannot be changed. <br>To get the virtual host name, make a [VirtualHostService.List](#List) request. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the virtual host should be updated. 
authority[] | **string**<br>New list of domains to attribute to the virtual host. <br>The host is selected to process the request received by the load balancer if the domain specified in the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header matches a domain specified in the host. <br>A wildcard asterisk character (`*`) matches 0 or more characters. <br>Existing list of domains is completely replaced by the specified list. <br>If not specified, all domains are attributed to the host, which is the same as specifying a `*` value. An HTTP router must not contain more than one virtual host to which all domains are attributed. 
routes[] | **[Route](#Route3)**<br>New list of routes of the virtual host. <br>A route contains a set of conditions (predicates) that are used by the load balancer to select the route for the request and an action on the request. For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#routes). <br>The order of routes matters: the first route whose predicate matches the request is selected. The most specific routes should be at the top of the list, so that they are not overridden. For example, if the first HTTP route is configured, via [HttpRoute.match](#HttpRoute3), to match paths prefixed with just `/`, other routes are never matched. <br>Existing list of routes is completely replaced by the specified list, so if you just want to remove a route, make a [VirtualHostService.RemoveRoute](#RemoveRoute) request. 
modify_request_headers[] | **[HeaderModification](#HeaderModification3)**<br>New list of modifications that are made to the headers of incoming HTTP requests before they are forwarded to backends. <br>Existing list of modifications is completely replaced by the specified list. 
modify_response_headers[] | **[HeaderModification](#HeaderModification3)**<br>New list of modifications that are made to the headers of HTTP responses received from backends before responses are forwarded to clients. <br>Existing list of modifications is completely replaced by the specified list. 
route_options | **[RouteOptions](#RouteOptions3)**<br>New route options for the virtual host. 


### Route {#Route3}

Field | Description
--- | ---
name | **string**<br>Required. Name of the route. 
route | **oneof:** `http` or `grpc`<br>Route configuration.
&nbsp;&nbsp;http | **[HttpRoute](#HttpRoute3)**<br>HTTP route configuration. 
&nbsp;&nbsp;grpc | **[GrpcRoute](#GrpcRoute3)**<br>gRPC route configuration. 
route_options | **[RouteOptions](#RouteOptions3)**<br> 


### HttpRoute {#HttpRoute3}

Field | Description
--- | ---
match | **[HttpRouteMatch](#HttpRouteMatch3)**<br>Condition (predicate) used to select the route. 
action | **oneof:** `route`, `redirect` or `direct_response`<br>Action performed on the request if the route is selected.
&nbsp;&nbsp;route | **[HttpRouteAction](#HttpRouteAction3)**<br>Forwards the request to a backend group for processing as configured. 
&nbsp;&nbsp;redirect | **[RedirectAction](#RedirectAction3)**<br>Redirects the request as configured. 
&nbsp;&nbsp;direct_response | **[DirectResponseAction](#DirectResponseAction3)**<br>Instructs the load balancer to respond directly as configured. 


### HttpRouteMatch {#HttpRouteMatch3}

Field | Description
--- | ---
http_method[] | **string**<br>HTTP method specified in the request. 
path | **[StringMatch](#StringMatch3)**<br>Match settings for the path specified in the request. <br>If not specified, the route matches all paths. 


### StringMatch {#StringMatch3}

Field | Description
--- | ---
match | **oneof:** `exact_match`, `prefix_match` or `regex_match`<br>Match string for either exact or prefix match.
&nbsp;&nbsp;exact_match | **string**<br>Exact match string. 
&nbsp;&nbsp;prefix_match | **string**<br>Prefix match string. 
&nbsp;&nbsp;regex_match | **string**<br>Regular expression match string. 


### HttpRouteAction {#HttpRouteAction3}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to forward requests to. <br>Stream (TCP) backend groups are not supported. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it. <br>If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code. <br>Default value: `60`. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Idle timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it. <br>Specifying meaningful values for both `timeout` and `idle_timeout` is useful for implementing server-push mechanisms such as long polling, server-sent events (`EventSource` interface) etc. <br>If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code. <br>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see `timeout`). 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers. <br>If not specified, the host is not changed.
&nbsp;&nbsp;host_rewrite | **string**<br>Host replacement. 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br>Automatically replaces the host with that of the target. 
prefix_rewrite | **string**<br>Replacement for the path prefix matched by [StringMatch](#StringMatch4). <br>For instance, if [StringMatch.prefix_match](#StringMatch4) value is `/foo` and `replace_prefix` value is `/bar`, a request with `/foobaz` path is forwarded with `/barbaz` path. For [StringMatch.exact_match](#StringMatch4), the whole path is replaced. <br>If not specified, the path is not changed. 
upgrade_types[] | **string**<br>Supported values for HTTP `Upgrade` header. E.g. `websocket`. 


### RedirectAction {#RedirectAction3}

Field | Description
--- | ---
replace_scheme | **string**<br>URI scheme replacement. <br>If `http` or `https` scheme is to be replaced and `80` or `443` port is specified in the original URI, the port is also removed. <br>If not specified, the original scheme and port are used. 
replace_host | **string**<br>URI host replacement. <br>If not specified, the original host is used. 
replace_port | **int64**<br>URI host replacement. <br>If not specified, the original host is used. 
path | **oneof:** `replace_path` or `replace_prefix`<br>URI path replacement. <br>If not specified, the original path is used.
&nbsp;&nbsp;replace_path | **string**<br>Replacement for the whole path. 
&nbsp;&nbsp;replace_prefix | **string**<br>Replacement for the path prefix matched by [StringMatch](#StringMatch4). <br>For instance, if [StringMatch.prefix_match](#StringMatch4) value is `/foo` and `replace_prefix` value is `/bar`, a request with `https://example.com/foobaz` URI is redirected to `https://example.com/barbaz`. For [StringMatch.exact_match](#StringMatch4), the whole path is replaced. 
remove_query | **bool**<br>Removes URI query. 
response_code | enum **RedirectResponseCode**<br>HTTP status code to use in redirect responses. <ul><li>`MOVED_PERMANENTLY`: `301 Moved Permanently` status code.</li><li>`FOUND`: `302 Found` status code.</li><li>`SEE_OTHER`: `303 See Other` status code.</li><li>`TEMPORARY_REDIRECT`: `307 Temporary Redirect` status code.</li><li>`PERMANENT_REDIRECT`: `308 Permanent Redirect` status code.</li></ul>


### DirectResponseAction {#DirectResponseAction3}

Field | Description
--- | ---
status | **int64**<br>HTTP status code to use in responses. Acceptable values are 100 to 599, inclusive.
body | **[Payload](#Payload3)**<br>Response body. 


### Payload {#Payload3}

Field | Description
--- | ---
payload | **oneof:** `text`<br>Payload.
&nbsp;&nbsp;text | **string**<br>Payload text. The string length in characters must be greater than 0.


### GrpcRoute {#GrpcRoute3}

Field | Description
--- | ---
match | **[GrpcRouteMatch](#GrpcRouteMatch3)**<br>Condition (predicate) used to select the route. 
action | **oneof:** `route` or `status_response`<br>Action performed on the request if the route is selected.
&nbsp;&nbsp;route | **[GrpcRouteAction](#GrpcRouteAction3)**<br>Forwards the request to a backend group for processing as configured. 
&nbsp;&nbsp;status_response | **[GrpcStatusResponseAction](#GrpcStatusResponseAction3)**<br>Instructs the load balancer to respond directly with a specified status. 


### GrpcRouteMatch {#GrpcRouteMatch3}

Field | Description
--- | ---
fqmn | **[StringMatch](#StringMatch4)**<br>Match settings for gRPC service method called in the request. <br>A match string must be a fully qualified method name, e.g. `foo.bar.v1.BazService/Get`, or a prefix of such. <br>If not specified, the route matches all methods. 


### GrpcRouteAction {#GrpcRouteAction3}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to forward requests to. 
max_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it. <br>If a client specifies a lower timeout in HTTP `grpc-timeout` header, the `max_timeout` value is ignored. <br>If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code. <br>Default value: `60`. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Idle timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it. <br>Specifying meaningful values for both `max_timeout` and `idle_timeout` is useful for implementing server-push mechanisms such as long polling, server-sent events etc. <br>If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code. <br>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see `max_timeout`). 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers. <br>If not specified, the host is not changed.
&nbsp;&nbsp;host_rewrite | **string**<br>Host replacement. 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br>Automatically replaces the host with that of the target. 


### GrpcStatusResponseAction {#GrpcStatusResponseAction3}

Field | Description
--- | ---
status | enum **Status**<br>gRPC [status code](https://grpc.github.io/grpc/core/md_doc_statuscodes.html) to use in responses. <ul><li>`OK`: `OK` (0) status code.</li><li>`INVALID_ARGUMENT`: `INVALID_ARGUMENT` (3) status code.</li><li>`NOT_FOUND`: `NOT_FOUND` (5) status code.</li><li>`PERMISSION_DENIED`: `PERMISSION_DENIED` (7) status code.</li><li>`UNAUTHENTICATED`: `UNAUTHENTICATED` (16) status code.</li><li>`UNIMPLEMENTED`: `UNIMPLEMENTED` (12) status code.</li><li>`INTERNAL`: `INTERNAL` (13) status code.</li><li>`UNAVAILABLE`: `UNAVAILABLE` (14) status code.</li></ul>


### HeaderModification {#HeaderModification3}

Field | Description
--- | ---
name | **string**<br>Name of the header. 
operation | **oneof:** `append`, `replace`, `remove` or `rename`<br>Operation to perform on the header.
&nbsp;&nbsp;append | **string**<br>Appends the specified string to the header value. <br>Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers) are supported. 
&nbsp;&nbsp;replace | **string**<br>Replaces the value of the header with the specified string. <br>Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers) are supported. 
&nbsp;&nbsp;remove | **bool**<br>Removes the header. 
&nbsp;&nbsp;rename | **string**<br>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts. 


### RouteOptions {#RouteOptions3}

Field | Description
--- | ---
modify_request_headers[] | **[HeaderModification](#HeaderModification4)**<br>Apply the following modifications to the request headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification4)**<br>Apply the following modifications to the response headers. 
rbac | **[RBAC](#RBAC3)**<br> 


### RBAC {#RBAC3}

Field | Description
--- | ---
action | enum **Action**<br>Required. The action to take if a principal matches. Every action either allows or denies a request. <ul><li>`ALLOW`: Allows the request if and only if there is a principal that matches the request.</li><li>`DENY`: Allows the request if and only if there are no principal that match the request.</li></ul>
principals[] | **[Principals](#Principals3)**<br>Required. A match occurs when at least one matches the request. The minimum number of elements is 1.


### Principals {#Principals3}

Field | Description
--- | ---
and_principals[] | **[Principal](#Principal3)**<br>Required. A match occurs when all principals match the request. The minimum number of elements is 1.


### Principal {#Principal3}

Field | Description
--- | ---
identifier | **oneof:** `header`, `remote_ip` or `any`<br>
&nbsp;&nbsp;header | **[HeaderMatcher](#HeaderMatcher3)**<br>A header (or pseudo-header such as: path or: method) of the incoming HTTP request. 
&nbsp;&nbsp;remote_ip | **string**<br>A CIDR block or IP that describes the request remote/origin address, e.g. ``192.0.0.0/24`` or``192.0.0.4`` . 
&nbsp;&nbsp;any | **bool**<br>When any is set, it matches any request. 


### HeaderMatcher {#HeaderMatcher3}

Field | Description
--- | ---
name | **string**<br>Required. Specifies the name of the header in the request. 
value | **[StringMatch](#StringMatch4)**<br>Specifies how the header match will be performed to route the request. In the absence of value a request that has specified header name will match, regardless of the header's value. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateVirtualHostMetadata](#UpdateVirtualHostMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[VirtualHost](#VirtualHost3)>**<br>if operation finished successfully. 


### UpdateVirtualHostMetadata {#UpdateVirtualHostMetadata}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router that the virtual host is being updated in. 
virtual_host_name | **string**<br>Name of the virtual host that is being updated. 


### VirtualHost {#VirtualHost3}

Field | Description
--- | ---
name | **string**<br>Required. Name of the virtual host. The name is unique within the HTTP router. 
authority[] | **string**<br>List of domains that are attributed to the virtual host. <br>The host is selected to process the request received by the load balancer if the domain specified in the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header matches a domain specified in the host. <br>A wildcard asterisk character (`*`) matches 0 or more characters. <br>If not specified, all domains are attributed to the host, which is the same as specifying a `*` value. An HTTP router must not contain more than one virtual host to which all domains are attributed. 
routes[] | **[Route](#Route4)**<br>Routes of the virtual host. <br>A route contains a set of conditions (predicates) that are used by the load balancer to select the route for the request and an action on the request. For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#routes). <br>The order of routes matters: the first route whose predicate matches the request is selected. The most specific routes should be at the top of the list, so that they are not overridden. For example, if the first HTTP route is configured, via [HttpRoute.match](#HttpRoute4), to match paths prefixed with just `/`, other routes are never matched. 
modify_request_headers[] | **[HeaderModification](#HeaderModification4)**<br>Deprecated, use route_options.modify_request_headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification4)**<br>Deprecated, use route_options.modify_response_headers. 
route_options | **[RouteOptions](#RouteOptions4)**<br> 


## Delete {#Delete}

Deletes the specified virtual host.

**rpc Delete ([DeleteVirtualHostRequest](#DeleteVirtualHostRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteVirtualHostMetadata](#DeleteVirtualHostMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteVirtualHostRequest {#DeleteVirtualHostRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required. ID of the HTTP router to delete a virtual host from. <br>To get the HTTP router ID, make a [HttpRouterService.List](./http_router_service#List) request. 
virtual_host_name | **string**<br>Required. Name of the virtual host to delete. <br>To get the virtual host name, make a [VirtualHostService.List](#List) request. Value must match the regular expression ` ([a-z]([-a-z0-9]{0,61}[a-z0-9])?)? `.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteVirtualHostMetadata](#DeleteVirtualHostMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteVirtualHostMetadata {#DeleteVirtualHostMetadata}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router that the virtual host is being deleted from. 
virtual_host_name | **string**<br>Name of the virtual host that is being deleted. 


## RemoveRoute {#RemoveRoute}

Deletes the specified route from the specified virtual host.

**rpc RemoveRoute ([RemoveRouteRequest](#RemoveRouteRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveRouteMetadata](#RemoveRouteMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[VirtualHost](#VirtualHost4)<br>

### RemoveRouteRequest {#RemoveRouteRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required. ID of the HTTP router to delete a route from. <br>To get the HTTP router ID, make a [HttpRouterService.List](./http_router_service#List) request. 
virtual_host_name | **string**<br>Required. Name of the virtual host to delete a route from. <br>To get the virtual host name, make a [VirtualHostService.List](#List) request. 
route_name | **string**<br>Required. Name of the route to delete. <br>To get the route name, make a [VirtualHostService.Get](#Get) request. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RemoveRouteMetadata](#RemoveRouteMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[VirtualHost](#VirtualHost4)>**<br>if operation finished successfully. 


### RemoveRouteMetadata {#RemoveRouteMetadata}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router that the route is being deleted from. 
virtual_host_name | **string**<br>Name of the virtual host that the route is being deleted from. 
route_name | **string**<br>Name of the route that is being deleted. 


### VirtualHost {#VirtualHost4}

Field | Description
--- | ---
name | **string**<br>Required. Name of the virtual host. The name is unique within the HTTP router. 
authority[] | **string**<br>List of domains that are attributed to the virtual host. <br>The host is selected to process the request received by the load balancer if the domain specified in the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header matches a domain specified in the host. <br>A wildcard asterisk character (`*`) matches 0 or more characters. <br>If not specified, all domains are attributed to the host, which is the same as specifying a `*` value. An HTTP router must not contain more than one virtual host to which all domains are attributed. 
routes[] | **[Route](#Route4)**<br>Routes of the virtual host. <br>A route contains a set of conditions (predicates) that are used by the load balancer to select the route for the request and an action on the request. For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#routes). <br>The order of routes matters: the first route whose predicate matches the request is selected. The most specific routes should be at the top of the list, so that they are not overridden. For example, if the first HTTP route is configured, via [HttpRoute.match](#HttpRoute4), to match paths prefixed with just `/`, other routes are never matched. 
modify_request_headers[] | **[HeaderModification](#HeaderModification4)**<br>Deprecated, use route_options.modify_request_headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification4)**<br>Deprecated, use route_options.modify_response_headers. 
route_options | **[RouteOptions](#RouteOptions4)**<br> 


### Route {#Route4}

Field | Description
--- | ---
name | **string**<br>Required. Name of the route. 
route | **oneof:** `http` or `grpc`<br>Route configuration.
&nbsp;&nbsp;http | **[HttpRoute](#HttpRoute4)**<br>HTTP route configuration. 
&nbsp;&nbsp;grpc | **[GrpcRoute](#GrpcRoute4)**<br>gRPC route configuration. 
route_options | **[RouteOptions](#RouteOptions4)**<br> 


### HttpRoute {#HttpRoute4}

Field | Description
--- | ---
match | **[HttpRouteMatch](#HttpRouteMatch4)**<br>Condition (predicate) used to select the route. 
action | **oneof:** `route`, `redirect` or `direct_response`<br>Action performed on the request if the route is selected.
&nbsp;&nbsp;route | **[HttpRouteAction](#HttpRouteAction4)**<br>Forwards the request to a backend group for processing as configured. 
&nbsp;&nbsp;redirect | **[RedirectAction](#RedirectAction4)**<br>Redirects the request as configured. 
&nbsp;&nbsp;direct_response | **[DirectResponseAction](#DirectResponseAction4)**<br>Instructs the load balancer to respond directly as configured. 


### HttpRouteMatch {#HttpRouteMatch4}

Field | Description
--- | ---
http_method[] | **string**<br>HTTP method specified in the request. 
path | **[StringMatch](#StringMatch4)**<br>Match settings for the path specified in the request. <br>If not specified, the route matches all paths. 


### StringMatch {#StringMatch4}

Field | Description
--- | ---
match | **oneof:** `exact_match`, `prefix_match` or `regex_match`<br>Match string for either exact or prefix match.
&nbsp;&nbsp;exact_match | **string**<br>Exact match string. 
&nbsp;&nbsp;prefix_match | **string**<br>Prefix match string. 
&nbsp;&nbsp;regex_match | **string**<br>Regular expression match string. 


### HttpRouteAction {#HttpRouteAction4}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to forward requests to. <br>Stream (TCP) backend groups are not supported. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it. <br>If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code. <br>Default value: `60`. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Idle timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it. <br>Specifying meaningful values for both `timeout` and `idle_timeout` is useful for implementing server-push mechanisms such as long polling, server-sent events (`EventSource` interface) etc. <br>If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code. <br>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see `timeout`). 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers. <br>If not specified, the host is not changed.
&nbsp;&nbsp;host_rewrite | **string**<br>Host replacement. 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br>Automatically replaces the host with that of the target. 
prefix_rewrite | **string**<br>Replacement for the path prefix matched by [StringMatch](#StringMatch5). <br>For instance, if [StringMatch.prefix_match](#StringMatch5) value is `/foo` and `replace_prefix` value is `/bar`, a request with `/foobaz` path is forwarded with `/barbaz` path. For [StringMatch.exact_match](#StringMatch5), the whole path is replaced. <br>If not specified, the path is not changed. 
upgrade_types[] | **string**<br>Supported values for HTTP `Upgrade` header. E.g. `websocket`. 


### RedirectAction {#RedirectAction4}

Field | Description
--- | ---
replace_scheme | **string**<br>URI scheme replacement. <br>If `http` or `https` scheme is to be replaced and `80` or `443` port is specified in the original URI, the port is also removed. <br>If not specified, the original scheme and port are used. 
replace_host | **string**<br>URI host replacement. <br>If not specified, the original host is used. 
replace_port | **int64**<br>URI host replacement. <br>If not specified, the original host is used. 
path | **oneof:** `replace_path` or `replace_prefix`<br>URI path replacement. <br>If not specified, the original path is used.
&nbsp;&nbsp;replace_path | **string**<br>Replacement for the whole path. 
&nbsp;&nbsp;replace_prefix | **string**<br>Replacement for the path prefix matched by [StringMatch](#StringMatch5). <br>For instance, if [StringMatch.prefix_match](#StringMatch5) value is `/foo` and `replace_prefix` value is `/bar`, a request with `https://example.com/foobaz` URI is redirected to `https://example.com/barbaz`. For [StringMatch.exact_match](#StringMatch5), the whole path is replaced. 
remove_query | **bool**<br>Removes URI query. 
response_code | enum **RedirectResponseCode**<br>HTTP status code to use in redirect responses. <ul><li>`MOVED_PERMANENTLY`: `301 Moved Permanently` status code.</li><li>`FOUND`: `302 Found` status code.</li><li>`SEE_OTHER`: `303 See Other` status code.</li><li>`TEMPORARY_REDIRECT`: `307 Temporary Redirect` status code.</li><li>`PERMANENT_REDIRECT`: `308 Permanent Redirect` status code.</li></ul>


### DirectResponseAction {#DirectResponseAction4}

Field | Description
--- | ---
status | **int64**<br>HTTP status code to use in responses. Acceptable values are 100 to 599, inclusive.
body | **[Payload](#Payload4)**<br>Response body. 


### Payload {#Payload4}

Field | Description
--- | ---
payload | **oneof:** `text`<br>Payload.
&nbsp;&nbsp;text | **string**<br>Payload text. The string length in characters must be greater than 0.


### GrpcRoute {#GrpcRoute4}

Field | Description
--- | ---
match | **[GrpcRouteMatch](#GrpcRouteMatch4)**<br>Condition (predicate) used to select the route. 
action | **oneof:** `route` or `status_response`<br>Action performed on the request if the route is selected.
&nbsp;&nbsp;route | **[GrpcRouteAction](#GrpcRouteAction4)**<br>Forwards the request to a backend group for processing as configured. 
&nbsp;&nbsp;status_response | **[GrpcStatusResponseAction](#GrpcStatusResponseAction4)**<br>Instructs the load balancer to respond directly with a specified status. 


### GrpcRouteMatch {#GrpcRouteMatch4}

Field | Description
--- | ---
fqmn | **[StringMatch](#StringMatch5)**<br>Match settings for gRPC service method called in the request. <br>A match string must be a fully qualified method name, e.g. `foo.bar.v1.BazService/Get`, or a prefix of such. <br>If not specified, the route matches all methods. 


### GrpcRouteAction {#GrpcRouteAction4}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to forward requests to. 
max_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it. <br>If a client specifies a lower timeout in HTTP `grpc-timeout` header, the `max_timeout` value is ignored. <br>If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code. <br>Default value: `60`. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Idle timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it. <br>Specifying meaningful values for both `max_timeout` and `idle_timeout` is useful for implementing server-push mechanisms such as long polling, server-sent events etc. <br>If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code. <br>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see `max_timeout`). 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers. <br>If not specified, the host is not changed.
&nbsp;&nbsp;host_rewrite | **string**<br>Host replacement. 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br>Automatically replaces the host with that of the target. 


### GrpcStatusResponseAction {#GrpcStatusResponseAction4}

Field | Description
--- | ---
status | enum **Status**<br>gRPC [status code](https://grpc.github.io/grpc/core/md_doc_statuscodes.html) to use in responses. <ul><li>`OK`: `OK` (0) status code.</li><li>`INVALID_ARGUMENT`: `INVALID_ARGUMENT` (3) status code.</li><li>`NOT_FOUND`: `NOT_FOUND` (5) status code.</li><li>`PERMISSION_DENIED`: `PERMISSION_DENIED` (7) status code.</li><li>`UNAUTHENTICATED`: `UNAUTHENTICATED` (16) status code.</li><li>`UNIMPLEMENTED`: `UNIMPLEMENTED` (12) status code.</li><li>`INTERNAL`: `INTERNAL` (13) status code.</li><li>`UNAVAILABLE`: `UNAVAILABLE` (14) status code.</li></ul>


### HeaderModification {#HeaderModification4}

Field | Description
--- | ---
name | **string**<br>Name of the header. 
operation | **oneof:** `append`, `replace`, `remove` or `rename`<br>Operation to perform on the header.
&nbsp;&nbsp;append | **string**<br>Appends the specified string to the header value. <br>Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers) are supported. 
&nbsp;&nbsp;replace | **string**<br>Replaces the value of the header with the specified string. <br>Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers) are supported. 
&nbsp;&nbsp;remove | **bool**<br>Removes the header. 
&nbsp;&nbsp;rename | **string**<br>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts. 


### RouteOptions {#RouteOptions4}

Field | Description
--- | ---
modify_request_headers[] | **[HeaderModification](#HeaderModification5)**<br>Apply the following modifications to the request headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification5)**<br>Apply the following modifications to the response headers. 
rbac | **[RBAC](#RBAC4)**<br> 


### RBAC {#RBAC4}

Field | Description
--- | ---
action | enum **Action**<br>Required. The action to take if a principal matches. Every action either allows or denies a request. <ul><li>`ALLOW`: Allows the request if and only if there is a principal that matches the request.</li><li>`DENY`: Allows the request if and only if there are no principal that match the request.</li></ul>
principals[] | **[Principals](#Principals4)**<br>Required. A match occurs when at least one matches the request. The minimum number of elements is 1.


### Principals {#Principals4}

Field | Description
--- | ---
and_principals[] | **[Principal](#Principal4)**<br>Required. A match occurs when all principals match the request. The minimum number of elements is 1.


### Principal {#Principal4}

Field | Description
--- | ---
identifier | **oneof:** `header`, `remote_ip` or `any`<br>
&nbsp;&nbsp;header | **[HeaderMatcher](#HeaderMatcher4)**<br>A header (or pseudo-header such as: path or: method) of the incoming HTTP request. 
&nbsp;&nbsp;remote_ip | **string**<br>A CIDR block or IP that describes the request remote/origin address, e.g. ``192.0.0.0/24`` or``192.0.0.4`` . 
&nbsp;&nbsp;any | **bool**<br>When any is set, it matches any request. 


### HeaderMatcher {#HeaderMatcher4}

Field | Description
--- | ---
name | **string**<br>Required. Specifies the name of the header in the request. 
value | **[StringMatch](#StringMatch5)**<br>Specifies how the header match will be performed to route the request. In the absence of value a request that has specified header name will match, regardless of the header's value. 


## UpdateRoute {#UpdateRoute}

Updates the specified route of the specified virtual host.

**rpc UpdateRoute ([UpdateRouteRequest](#UpdateRouteRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateRouteMetadata](#UpdateRouteMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[VirtualHost](#VirtualHost5)<br>

### UpdateRouteRequest {#UpdateRouteRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required. ID of the HTTP router to update a route in. <br>To get the HTTP router ID, make a [HttpRouterService.List](./http_router_service#List) request. 
virtual_host_name | **string**<br>Required. Name of the virtual host to update a route in. <br>To get the virtual host name, make a [VirtualHostService.List](#List) request. 
route_name | **string**<br>Required. Name of the route to update. <br>To get the route name, make a [VirtualHostService.Get](#Get) request. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the route should be updated. 
route | **oneof:** `http` or `grpc`<br>New settings of the route.
&nbsp;&nbsp;http | **[HttpRoute](#HttpRoute5)**<br>New settings of the HTTP route. 
&nbsp;&nbsp;grpc | **[GrpcRoute](#GrpcRoute5)**<br>New settings of the gRPC route. 
route_options | **[RouteOptions](#RouteOptions5)**<br>New route options for the route. 


### HttpRoute {#HttpRoute5}

Field | Description
--- | ---
match | **[HttpRouteMatch](#HttpRouteMatch5)**<br>Condition (predicate) used to select the route. 
action | **oneof:** `route`, `redirect` or `direct_response`<br>Action performed on the request if the route is selected.
&nbsp;&nbsp;route | **[HttpRouteAction](#HttpRouteAction5)**<br>Forwards the request to a backend group for processing as configured. 
&nbsp;&nbsp;redirect | **[RedirectAction](#RedirectAction5)**<br>Redirects the request as configured. 
&nbsp;&nbsp;direct_response | **[DirectResponseAction](#DirectResponseAction5)**<br>Instructs the load balancer to respond directly as configured. 


### HttpRouteMatch {#HttpRouteMatch5}

Field | Description
--- | ---
http_method[] | **string**<br>HTTP method specified in the request. 
path | **[StringMatch](#StringMatch5)**<br>Match settings for the path specified in the request. <br>If not specified, the route matches all paths. 


### StringMatch {#StringMatch5}

Field | Description
--- | ---
match | **oneof:** `exact_match`, `prefix_match` or `regex_match`<br>Match string for either exact or prefix match.
&nbsp;&nbsp;exact_match | **string**<br>Exact match string. 
&nbsp;&nbsp;prefix_match | **string**<br>Prefix match string. 
&nbsp;&nbsp;regex_match | **string**<br>Regular expression match string. 


### HttpRouteAction {#HttpRouteAction5}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to forward requests to. <br>Stream (TCP) backend groups are not supported. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it. <br>If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code. <br>Default value: `60`. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Idle timeout for an HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it. <br>Specifying meaningful values for both `timeout` and `idle_timeout` is useful for implementing server-push mechanisms such as long polling, server-sent events (`EventSource` interface) etc. <br>If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code. <br>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see `timeout`). 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers. <br>If not specified, the host is not changed.
&nbsp;&nbsp;host_rewrite | **string**<br>Host replacement. 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br>Automatically replaces the host with that of the target. 
prefix_rewrite | **string**<br>Replacement for the path prefix matched by [StringMatch](#StringMatch6). <br>For instance, if [StringMatch.prefix_match](#StringMatch6) value is `/foo` and `replace_prefix` value is `/bar`, a request with `/foobaz` path is forwarded with `/barbaz` path. For [StringMatch.exact_match](#StringMatch6), the whole path is replaced. <br>If not specified, the path is not changed. 
upgrade_types[] | **string**<br>Supported values for HTTP `Upgrade` header. E.g. `websocket`. 


### RedirectAction {#RedirectAction5}

Field | Description
--- | ---
replace_scheme | **string**<br>URI scheme replacement. <br>If `http` or `https` scheme is to be replaced and `80` or `443` port is specified in the original URI, the port is also removed. <br>If not specified, the original scheme and port are used. 
replace_host | **string**<br>URI host replacement. <br>If not specified, the original host is used. 
replace_port | **int64**<br>URI host replacement. <br>If not specified, the original host is used. 
path | **oneof:** `replace_path` or `replace_prefix`<br>URI path replacement. <br>If not specified, the original path is used.
&nbsp;&nbsp;replace_path | **string**<br>Replacement for the whole path. 
&nbsp;&nbsp;replace_prefix | **string**<br>Replacement for the path prefix matched by [StringMatch](#StringMatch6). <br>For instance, if [StringMatch.prefix_match](#StringMatch6) value is `/foo` and `replace_prefix` value is `/bar`, a request with `https://example.com/foobaz` URI is redirected to `https://example.com/barbaz`. For [StringMatch.exact_match](#StringMatch6), the whole path is replaced. 
remove_query | **bool**<br>Removes URI query. 
response_code | enum **RedirectResponseCode**<br>HTTP status code to use in redirect responses. <ul><li>`MOVED_PERMANENTLY`: `301 Moved Permanently` status code.</li><li>`FOUND`: `302 Found` status code.</li><li>`SEE_OTHER`: `303 See Other` status code.</li><li>`TEMPORARY_REDIRECT`: `307 Temporary Redirect` status code.</li><li>`PERMANENT_REDIRECT`: `308 Permanent Redirect` status code.</li></ul>


### DirectResponseAction {#DirectResponseAction5}

Field | Description
--- | ---
status | **int64**<br>HTTP status code to use in responses. Acceptable values are 100 to 599, inclusive.
body | **[Payload](#Payload5)**<br>Response body. 


### Payload {#Payload5}

Field | Description
--- | ---
payload | **oneof:** `text`<br>Payload.
&nbsp;&nbsp;text | **string**<br>Payload text. The string length in characters must be greater than 0.


### GrpcRoute {#GrpcRoute5}

Field | Description
--- | ---
match | **[GrpcRouteMatch](#GrpcRouteMatch5)**<br>Condition (predicate) used to select the route. 
action | **oneof:** `route` or `status_response`<br>Action performed on the request if the route is selected.
&nbsp;&nbsp;route | **[GrpcRouteAction](#GrpcRouteAction5)**<br>Forwards the request to a backend group for processing as configured. 
&nbsp;&nbsp;status_response | **[GrpcStatusResponseAction](#GrpcStatusResponseAction5)**<br>Instructs the load balancer to respond directly with a specified status. 


### GrpcRouteMatch {#GrpcRouteMatch5}

Field | Description
--- | ---
fqmn | **[StringMatch](#StringMatch6)**<br>Match settings for gRPC service method called in the request. <br>A match string must be a fully qualified method name, e.g. `foo.bar.v1.BazService/Get`, or a prefix of such. <br>If not specified, the route matches all methods. 


### GrpcRouteAction {#GrpcRouteAction5}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to forward requests to. 
max_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is kept alive for, regardless of whether data is transferred over it. <br>If a client specifies a lower timeout in HTTP `grpc-timeout` header, the `max_timeout` value is ignored. <br>If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code. <br>Default value: `60`. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Idle timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group: the maximum time the connection is allowed to be idle, i.e. without any data transferred over it. <br>Specifying meaningful values for both `max_timeout` and `idle_timeout` is useful for implementing server-push mechanisms such as long polling, server-sent events etc. <br>If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code. <br>If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see `max_timeout`). 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers. <br>If not specified, the host is not changed.
&nbsp;&nbsp;host_rewrite | **string**<br>Host replacement. 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br>Automatically replaces the host with that of the target. 


### GrpcStatusResponseAction {#GrpcStatusResponseAction5}

Field | Description
--- | ---
status | enum **Status**<br>gRPC [status code](https://grpc.github.io/grpc/core/md_doc_statuscodes.html) to use in responses. <ul><li>`OK`: `OK` (0) status code.</li><li>`INVALID_ARGUMENT`: `INVALID_ARGUMENT` (3) status code.</li><li>`NOT_FOUND`: `NOT_FOUND` (5) status code.</li><li>`PERMISSION_DENIED`: `PERMISSION_DENIED` (7) status code.</li><li>`UNAUTHENTICATED`: `UNAUTHENTICATED` (16) status code.</li><li>`UNIMPLEMENTED`: `UNIMPLEMENTED` (12) status code.</li><li>`INTERNAL`: `INTERNAL` (13) status code.</li><li>`UNAVAILABLE`: `UNAVAILABLE` (14) status code.</li></ul>


### RouteOptions {#RouteOptions5}

Field | Description
--- | ---
modify_request_headers[] | **[HeaderModification](#HeaderModification5)**<br>Apply the following modifications to the request headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification5)**<br>Apply the following modifications to the response headers. 
rbac | **[RBAC](#RBAC5)**<br> 


### HeaderModification {#HeaderModification5}

Field | Description
--- | ---
name | **string**<br>Name of the header. 
operation | **oneof:** `append`, `replace`, `remove` or `rename`<br>Operation to perform on the header.
&nbsp;&nbsp;append | **string**<br>Appends the specified string to the header value. <br>Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers) are supported. 
&nbsp;&nbsp;replace | **string**<br>Replaces the value of the header with the specified string. <br>Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers) are supported. 
&nbsp;&nbsp;remove | **bool**<br>Removes the header. 
&nbsp;&nbsp;rename | **string**<br>Replaces the name of the header with the specified string. This operation is only supported for ALB Virtual Hosts. 


### RBAC {#RBAC5}

Field | Description
--- | ---
action | enum **Action**<br>Required. The action to take if a principal matches. Every action either allows or denies a request. <ul><li>`ALLOW`: Allows the request if and only if there is a principal that matches the request.</li><li>`DENY`: Allows the request if and only if there are no principal that match the request.</li></ul>
principals[] | **[Principals](#Principals5)**<br>Required. A match occurs when at least one matches the request. The minimum number of elements is 1.


### Principals {#Principals5}

Field | Description
--- | ---
and_principals[] | **[Principal](#Principal5)**<br>Required. A match occurs when all principals match the request. The minimum number of elements is 1.


### Principal {#Principal5}

Field | Description
--- | ---
identifier | **oneof:** `header`, `remote_ip` or `any`<br>
&nbsp;&nbsp;header | **[HeaderMatcher](#HeaderMatcher5)**<br>A header (or pseudo-header such as: path or: method) of the incoming HTTP request. 
&nbsp;&nbsp;remote_ip | **string**<br>A CIDR block or IP that describes the request remote/origin address, e.g. ``192.0.0.0/24`` or``192.0.0.4`` . 
&nbsp;&nbsp;any | **bool**<br>When any is set, it matches any request. 


### HeaderMatcher {#HeaderMatcher5}

Field | Description
--- | ---
name | **string**<br>Required. Specifies the name of the header in the request. 
value | **[StringMatch](#StringMatch6)**<br>Specifies how the header match will be performed to route the request. In the absence of value a request that has specified header name will match, regardless of the header's value. 


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateRouteMetadata](#UpdateRouteMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[VirtualHost](#VirtualHost5)>**<br>if operation finished successfully. 


### UpdateRouteMetadata {#UpdateRouteMetadata}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router that the route is being updated in. 
virtual_host_name | **string**<br>Name of the virtual host that the route is being updated in. 
route_name | **string**<br>Name of the route that is being updated. 


### VirtualHost {#VirtualHost5}

Field | Description
--- | ---
name | **string**<br>Required. Name of the virtual host. The name is unique within the HTTP router. 
authority[] | **string**<br>List of domains that are attributed to the virtual host. <br>The host is selected to process the request received by the load balancer if the domain specified in the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header matches a domain specified in the host. <br>A wildcard asterisk character (`*`) matches 0 or more characters. <br>If not specified, all domains are attributed to the host, which is the same as specifying a `*` value. An HTTP router must not contain more than one virtual host to which all domains are attributed. 
routes[] | **[Route](#Route5)**<br>Routes of the virtual host. <br>A route contains a set of conditions (predicates) that are used by the load balancer to select the route for the request and an action on the request. For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#routes). <br>The order of routes matters: the first route whose predicate matches the request is selected. The most specific routes should be at the top of the list, so that they are not overridden. For example, if the first HTTP route is configured, via [HttpRoute.match](#HttpRoute6), to match paths prefixed with just `/`, other routes are never matched. 
modify_request_headers[] | **[HeaderModification](#HeaderModification6)**<br>Deprecated, use route_options.modify_request_headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification6)**<br>Deprecated, use route_options.modify_response_headers. 
route_options | **[RouteOptions](#RouteOptions6)**<br> 


### Route {#Route5}

Field | Description
--- | ---
name | **string**<br>Required. Name of the route. 
route | **oneof:** `http` or `grpc`<br>Route configuration.
&nbsp;&nbsp;http | **[HttpRoute](#HttpRoute6)**<br>HTTP route configuration. 
&nbsp;&nbsp;grpc | **[GrpcRoute](#GrpcRoute6)**<br>gRPC route configuration. 
route_options | **[RouteOptions](#RouteOptions6)**<br> 


