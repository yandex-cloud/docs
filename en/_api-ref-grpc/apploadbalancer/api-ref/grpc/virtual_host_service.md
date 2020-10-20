---
editable: false
---

# VirtualHostService

A set of methods for managing virtual hosts of HTTP Router resource.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified VirtualHost resource. |
| [List](#List) | Retrieves the list of virtual hosts in the specified HTTP Router. |
| [Create](#Create) | Creates a new virtual host in the specified HTTP Router. |
| [Update](#Update) | Updates an existing VirtualHost in the specified HTTP Router. |
| [Delete](#Delete) | Deletes the specified virtual host. |
| [RemoveRoute](#RemoveRoute) |  |
| [UpdateRoute](#UpdateRoute) |  |

## Calls VirtualHostService {#calls}

## Get {#Get}

Returns the specified VirtualHost resource.

**rpc Get ([GetVirtualHostRequest](#GetVirtualHostRequest)) returns ([VirtualHost](#VirtualHost))**

### GetVirtualHostRequest {#GetVirtualHostRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required. ID of the HTTP Router that the virtual host belongs to. 
virtual_host_name | **string**<br>Required. Name of the VirtualHost resource to return. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.


### VirtualHost {#VirtualHost}

Field | Description
--- | ---
name | **string**<br>Required.  
authority[] | **string**<br>A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '*.foo.com' or '*-bar.foo.com'. If not specified, all domains will be matched. 
ports[] | **int64**<br><ol><li></li></ol> 
routes[] | **[Route](#Route)**<br>Routes are matched *in-order*. Be careful when adding them to the end. For instance, having http '/' match first makes all other routes unused. 
modify_request_headers[] | **[HeaderModification](#HeaderModification)**<br>Apply the following modifications to the request headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification)**<br>Apply the following modifications to the response headers. 


### Route {#Route}

Field | Description
--- | ---
name | **string**<br>Required.  
route | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpRoute](#HttpRoute)**<br> 
&nbsp;&nbsp;grpc | **[GrpcRoute](#GrpcRoute)**<br> 


### HttpRoute {#HttpRoute}

Field | Description
--- | ---
match | **[HttpRouteMatch](#HttpRouteMatch)**<br>Checks "/" prefix by default. 
action | **oneof:** `route`, `redirect` or `direct_response`<br>
&nbsp;&nbsp;route | **[HttpRouteAction](#HttpRouteAction)**<br> 
&nbsp;&nbsp;redirect | **[RedirectAction](#RedirectAction)**<br> 
&nbsp;&nbsp;direct_response | **[DirectResponseAction](#DirectResponseAction)**<br> 


### HttpRouteMatch {#HttpRouteMatch}

Field | Description
--- | ---
http_method[] | **string**<br> 
path | **[StringMatch](#StringMatch)**<br>If not set, '/' is assumed. 


### StringMatch {#StringMatch}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### HttpRouteAction {#HttpRouteAction}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 
prefix_rewrite | **string**<br>If not empty, matched path prefix will be replaced by this value. 
support_websockets | **bool**<br>Allows websocket upgrades. 


### RedirectAction {#RedirectAction}

Field | Description
--- | ---
replace_scheme | **string**<br>Replaces scheme. If the original scheme is `http` or `https`, will also remove the 80 or 443 port, if present. 
response_code | enum **RedirectResponseCode**<br>The HTTP status code to use in the redirect response. <ul><li>`MOVED_PERMANENTLY`: Moved Permanently HTTP Status Code - 301.</li><li>`FOUND`: Found HTTP Status Code - 302.</li><li>`SEE_OTHER`: See Other HTTP Status Code - 303.</li><li>`TEMPORARY_REDIRECT`: Temporary Redirect HTTP Status Code - 307.</li><li>`PERMANENT_REDIRECT`: Permanent Redirect HTTP Status Code - 308.</li><ul/>


### DirectResponseAction {#DirectResponseAction}

Field | Description
--- | ---
status | **int64**<br>HTTP response status. Acceptable values are 100 to 599, inclusive.
body | **[Payload](#Payload)**<br>Optional response body. 


### Payload {#Payload}

Field | Description
--- | ---
payload | **oneof:** `text`<br>
&nbsp;&nbsp;text | **string**<br>Text message. The string length in characters must be greater than 0.


### GrpcRoute {#GrpcRoute}

Field | Description
--- | ---
match | **[GrpcRouteMatch](#GrpcRouteMatch)**<br>Checks "/" prefix by default. 
action | **oneof:** `route` or `status_response`<br>
&nbsp;&nbsp;route | **[GrpcRouteAction](#GrpcRouteAction)**<br> 
&nbsp;&nbsp;status_response | **[GrpcStatusResponseAction](#GrpcStatusResponseAction)**<br> 


### GrpcRouteMatch {#GrpcRouteMatch}

Field | Description
--- | ---
fqmn | **[StringMatch](#StringMatch1)**<br>If not set, all services/methods are assumed. 


### StringMatch {#StringMatch1}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### GrpcRouteAction {#GrpcRouteAction}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
max_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Lower timeout may be specified by the client (using grpc-timeout header). If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 


### GrpcStatusResponseAction {#GrpcStatusResponseAction}

Field | Description
--- | ---
status | enum **Status**<br> <ul><ul/>


### HeaderModification {#HeaderModification}

Field | Description
--- | ---
name | **string**<br>Name of the header. 
operation | **oneof:** `append`, `replace`, `remove` or `rename`<br>Header values support the following formatters: https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers
&nbsp;&nbsp;append | **string**<br>Append string to the header value. 
&nbsp;&nbsp;replace | **string**<br>New value for a header. 
&nbsp;&nbsp;remove | **bool**<br>Remove the header. 
&nbsp;&nbsp;rename | **string**<br>New name for a header. 


## List {#List}

Retrieves the list of virtual hosts in the specified HTTP Router.

**rpc List ([ListVirtualHostsRequest](#ListVirtualHostsRequest)) returns ([ListVirtualHostsResponse](#ListVirtualHostsResponse))**

### ListVirtualHostsRequest {#ListVirtualHostsRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required. ID of the HTTP Router that the virtual host belongs to. 
page_size | **int64**<br> The maximum value is 1000.
page_token | **string**<br> The maximum string length in characters is 100.


### ListVirtualHostsResponse {#ListVirtualHostsResponse}

Field | Description
--- | ---
virtual_hosts[] | **[VirtualHost](#VirtualHost1)**<br>List of virtual hosts. 
next_page_token | **string**<br> 


### VirtualHost {#VirtualHost1}

Field | Description
--- | ---
name | **string**<br>Required.  
authority[] | **string**<br>A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '*.foo.com' or '*-bar.foo.com'. If not specified, all domains will be matched. 
ports[] | **int64**<br><ol><li></li></ol> 
routes[] | **[Route](#Route1)**<br>Routes are matched *in-order*. Be careful when adding them to the end. For instance, having http '/' match first makes all other routes unused. 
modify_request_headers[] | **[HeaderModification](#HeaderModification1)**<br>Apply the following modifications to the request headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification1)**<br>Apply the following modifications to the response headers. 


### Route {#Route1}

Field | Description
--- | ---
name | **string**<br>Required.  
route | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpRoute](#HttpRoute1)**<br> 
&nbsp;&nbsp;grpc | **[GrpcRoute](#GrpcRoute1)**<br> 


### HttpRoute {#HttpRoute1}

Field | Description
--- | ---
match | **[HttpRouteMatch](#HttpRouteMatch1)**<br>Checks "/" prefix by default. 
action | **oneof:** `route`, `redirect` or `direct_response`<br>
&nbsp;&nbsp;route | **[HttpRouteAction](#HttpRouteAction1)**<br> 
&nbsp;&nbsp;redirect | **[RedirectAction](#RedirectAction1)**<br> 
&nbsp;&nbsp;direct_response | **[DirectResponseAction](#DirectResponseAction1)**<br> 


### HttpRouteMatch {#HttpRouteMatch1}

Field | Description
--- | ---
http_method[] | **string**<br> 
path | **[StringMatch](#StringMatch2)**<br>If not set, '/' is assumed. 


### StringMatch {#StringMatch2}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### HttpRouteAction {#HttpRouteAction1}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 
prefix_rewrite | **string**<br>If not empty, matched path prefix will be replaced by this value. 
support_websockets | **bool**<br>Allows websocket upgrades. 


### RedirectAction {#RedirectAction1}

Field | Description
--- | ---
replace_scheme | **string**<br>Replaces scheme. If the original scheme is `http` or `https`, will also remove the 80 or 443 port, if present. 
response_code | enum **RedirectResponseCode**<br>The HTTP status code to use in the redirect response. <ul><li>`MOVED_PERMANENTLY`: Moved Permanently HTTP Status Code - 301.</li><li>`FOUND`: Found HTTP Status Code - 302.</li><li>`SEE_OTHER`: See Other HTTP Status Code - 303.</li><li>`TEMPORARY_REDIRECT`: Temporary Redirect HTTP Status Code - 307.</li><li>`PERMANENT_REDIRECT`: Permanent Redirect HTTP Status Code - 308.</li><ul/>


### DirectResponseAction {#DirectResponseAction1}

Field | Description
--- | ---
status | **int64**<br>HTTP response status. Acceptable values are 100 to 599, inclusive.
body | **[Payload](#Payload1)**<br>Optional response body. 


### Payload {#Payload1}

Field | Description
--- | ---
payload | **oneof:** `text`<br>
&nbsp;&nbsp;text | **string**<br>Text message. The string length in characters must be greater than 0.


### GrpcRoute {#GrpcRoute1}

Field | Description
--- | ---
match | **[GrpcRouteMatch](#GrpcRouteMatch1)**<br>Checks "/" prefix by default. 
action | **oneof:** `route` or `status_response`<br>
&nbsp;&nbsp;route | **[GrpcRouteAction](#GrpcRouteAction1)**<br> 
&nbsp;&nbsp;status_response | **[GrpcStatusResponseAction](#GrpcStatusResponseAction1)**<br> 


### GrpcRouteMatch {#GrpcRouteMatch1}

Field | Description
--- | ---
fqmn | **[StringMatch](#StringMatch3)**<br>If not set, all services/methods are assumed. 


### StringMatch {#StringMatch3}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### GrpcRouteAction {#GrpcRouteAction1}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
max_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Lower timeout may be specified by the client (using grpc-timeout header). If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 


### GrpcStatusResponseAction {#GrpcStatusResponseAction1}

Field | Description
--- | ---
status | enum **Status**<br> <ul><ul/>


### HeaderModification {#HeaderModification1}

Field | Description
--- | ---
name | **string**<br>Name of the header. 
operation | **oneof:** `append`, `replace`, `remove` or `rename`<br>Header values support the following formatters: https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers
&nbsp;&nbsp;append | **string**<br>Append string to the header value. 
&nbsp;&nbsp;replace | **string**<br>New value for a header. 
&nbsp;&nbsp;remove | **bool**<br>Remove the header. 
&nbsp;&nbsp;rename | **string**<br>New name for a header. 


## Create {#Create}

Creates a new virtual host in the specified HTTP Router.

**rpc Create ([CreateVirtualHostRequest](#CreateVirtualHostRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateVirtualHostMetadata](#CreateVirtualHostMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[VirtualHost](#VirtualHost2)<br>

### CreateVirtualHostRequest {#CreateVirtualHostRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required. ID of the HTTP Router that the virtual host belongs to. 
name | **string**<br>Configuration of the virtual host to create. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
authority[] | **string**<br> 
ports[] | **int64**<br> 
routes[] | **[Route](#Route2)**<br> 
modify_request_headers[] | **[HeaderModification](#HeaderModification2)**<br> 
modify_response_headers[] | **[HeaderModification](#HeaderModification2)**<br> 


### Route {#Route2}

Field | Description
--- | ---
name | **string**<br>Required.  
route | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpRoute](#HttpRoute2)**<br> 
&nbsp;&nbsp;grpc | **[GrpcRoute](#GrpcRoute2)**<br> 


### HttpRoute {#HttpRoute2}

Field | Description
--- | ---
match | **[HttpRouteMatch](#HttpRouteMatch2)**<br>Checks "/" prefix by default. 
action | **oneof:** `route`, `redirect` or `direct_response`<br>
&nbsp;&nbsp;route | **[HttpRouteAction](#HttpRouteAction2)**<br> 
&nbsp;&nbsp;redirect | **[RedirectAction](#RedirectAction2)**<br> 
&nbsp;&nbsp;direct_response | **[DirectResponseAction](#DirectResponseAction2)**<br> 


### HttpRouteMatch {#HttpRouteMatch2}

Field | Description
--- | ---
http_method[] | **string**<br> 
path | **[StringMatch](#StringMatch4)**<br>If not set, '/' is assumed. 


### StringMatch {#StringMatch4}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### HttpRouteAction {#HttpRouteAction2}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 
prefix_rewrite | **string**<br>If not empty, matched path prefix will be replaced by this value. 
support_websockets | **bool**<br>Allows websocket upgrades. 


### RedirectAction {#RedirectAction2}

Field | Description
--- | ---
replace_scheme | **string**<br>Replaces scheme. If the original scheme is `http` or `https`, will also remove the 80 or 443 port, if present. 
response_code | enum **RedirectResponseCode**<br>The HTTP status code to use in the redirect response. <ul><li>`MOVED_PERMANENTLY`: Moved Permanently HTTP Status Code - 301.</li><li>`FOUND`: Found HTTP Status Code - 302.</li><li>`SEE_OTHER`: See Other HTTP Status Code - 303.</li><li>`TEMPORARY_REDIRECT`: Temporary Redirect HTTP Status Code - 307.</li><li>`PERMANENT_REDIRECT`: Permanent Redirect HTTP Status Code - 308.</li><ul/>


### DirectResponseAction {#DirectResponseAction2}

Field | Description
--- | ---
status | **int64**<br>HTTP response status. Acceptable values are 100 to 599, inclusive.
body | **[Payload](#Payload2)**<br>Optional response body. 


### Payload {#Payload2}

Field | Description
--- | ---
payload | **oneof:** `text`<br>
&nbsp;&nbsp;text | **string**<br>Text message. The string length in characters must be greater than 0.


### GrpcRoute {#GrpcRoute2}

Field | Description
--- | ---
match | **[GrpcRouteMatch](#GrpcRouteMatch2)**<br>Checks "/" prefix by default. 
action | **oneof:** `route` or `status_response`<br>
&nbsp;&nbsp;route | **[GrpcRouteAction](#GrpcRouteAction2)**<br> 
&nbsp;&nbsp;status_response | **[GrpcStatusResponseAction](#GrpcStatusResponseAction2)**<br> 


### GrpcRouteMatch {#GrpcRouteMatch2}

Field | Description
--- | ---
fqmn | **[StringMatch](#StringMatch5)**<br>If not set, all services/methods are assumed. 


### StringMatch {#StringMatch5}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### GrpcRouteAction {#GrpcRouteAction2}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
max_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Lower timeout may be specified by the client (using grpc-timeout header). If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 


### GrpcStatusResponseAction {#GrpcStatusResponseAction2}

Field | Description
--- | ---
status | enum **Status**<br> <ul><ul/>


### HeaderModification {#HeaderModification2}

Field | Description
--- | ---
name | **string**<br>Name of the header. 
operation | **oneof:** `append`, `replace`, `remove` or `rename`<br>Header values support the following formatters: https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers
&nbsp;&nbsp;append | **string**<br>Append string to the header value. 
&nbsp;&nbsp;replace | **string**<br>New value for a header. 
&nbsp;&nbsp;remove | **bool**<br>Remove the header. 
&nbsp;&nbsp;rename | **string**<br>New name for a header. 


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
http_router_id | **string**<br>Required. ID of the HTTP Router that the virtual host is being created. 
virtual_host_name | **string**<br>Name of the virtual host that is being created. 


### VirtualHost {#VirtualHost2}

Field | Description
--- | ---
name | **string**<br>Required.  
authority[] | **string**<br>A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '*.foo.com' or '*-bar.foo.com'. If not specified, all domains will be matched. 
ports[] | **int64**<br><ol><li></li></ol> 
routes[] | **[Route](#Route3)**<br>Routes are matched *in-order*. Be careful when adding them to the end. For instance, having http '/' match first makes all other routes unused. 
modify_request_headers[] | **[HeaderModification](#HeaderModification3)**<br>Apply the following modifications to the request headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification3)**<br>Apply the following modifications to the response headers. 


### Route {#Route3}

Field | Description
--- | ---
name | **string**<br>Required.  
route | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpRoute](#HttpRoute3)**<br> 
&nbsp;&nbsp;grpc | **[GrpcRoute](#GrpcRoute3)**<br> 


### HttpRoute {#HttpRoute3}

Field | Description
--- | ---
match | **[HttpRouteMatch](#HttpRouteMatch3)**<br>Checks "/" prefix by default. 
action | **oneof:** `route`, `redirect` or `direct_response`<br>
&nbsp;&nbsp;route | **[HttpRouteAction](#HttpRouteAction3)**<br> 
&nbsp;&nbsp;redirect | **[RedirectAction](#RedirectAction3)**<br> 
&nbsp;&nbsp;direct_response | **[DirectResponseAction](#DirectResponseAction3)**<br> 


### HttpRouteMatch {#HttpRouteMatch3}

Field | Description
--- | ---
http_method[] | **string**<br> 
path | **[StringMatch](#StringMatch6)**<br>If not set, '/' is assumed. 


### StringMatch {#StringMatch6}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### HttpRouteAction {#HttpRouteAction3}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 
prefix_rewrite | **string**<br>If not empty, matched path prefix will be replaced by this value. 
support_websockets | **bool**<br>Allows websocket upgrades. 


### RedirectAction {#RedirectAction3}

Field | Description
--- | ---
replace_scheme | **string**<br>Replaces scheme. If the original scheme is `http` or `https`, will also remove the 80 or 443 port, if present. 
response_code | enum **RedirectResponseCode**<br>The HTTP status code to use in the redirect response. <ul><li>`MOVED_PERMANENTLY`: Moved Permanently HTTP Status Code - 301.</li><li>`FOUND`: Found HTTP Status Code - 302.</li><li>`SEE_OTHER`: See Other HTTP Status Code - 303.</li><li>`TEMPORARY_REDIRECT`: Temporary Redirect HTTP Status Code - 307.</li><li>`PERMANENT_REDIRECT`: Permanent Redirect HTTP Status Code - 308.</li><ul/>


### DirectResponseAction {#DirectResponseAction3}

Field | Description
--- | ---
status | **int64**<br>HTTP response status. Acceptable values are 100 to 599, inclusive.
body | **[Payload](#Payload3)**<br>Optional response body. 


### Payload {#Payload3}

Field | Description
--- | ---
payload | **oneof:** `text`<br>
&nbsp;&nbsp;text | **string**<br>Text message. The string length in characters must be greater than 0.


### GrpcRoute {#GrpcRoute3}

Field | Description
--- | ---
match | **[GrpcRouteMatch](#GrpcRouteMatch3)**<br>Checks "/" prefix by default. 
action | **oneof:** `route` or `status_response`<br>
&nbsp;&nbsp;route | **[GrpcRouteAction](#GrpcRouteAction3)**<br> 
&nbsp;&nbsp;status_response | **[GrpcStatusResponseAction](#GrpcStatusResponseAction3)**<br> 


### GrpcRouteMatch {#GrpcRouteMatch3}

Field | Description
--- | ---
fqmn | **[StringMatch](#StringMatch7)**<br>If not set, all services/methods are assumed. 


### StringMatch {#StringMatch7}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### GrpcRouteAction {#GrpcRouteAction3}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
max_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Lower timeout may be specified by the client (using grpc-timeout header). If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 


### GrpcStatusResponseAction {#GrpcStatusResponseAction3}

Field | Description
--- | ---
status | enum **Status**<br> <ul><ul/>


### HeaderModification {#HeaderModification3}

Field | Description
--- | ---
name | **string**<br>Name of the header. 
operation | **oneof:** `append`, `replace`, `remove` or `rename`<br>Header values support the following formatters: https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers
&nbsp;&nbsp;append | **string**<br>Append string to the header value. 
&nbsp;&nbsp;replace | **string**<br>New value for a header. 
&nbsp;&nbsp;remove | **bool**<br>Remove the header. 
&nbsp;&nbsp;rename | **string**<br>New name for a header. 


## Update {#Update}

Updates an existing VirtualHost in the specified HTTP Router.

**rpc Update ([UpdateVirtualHostRequest](#UpdateVirtualHostRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateVirtualHostMetadata](#UpdateVirtualHostMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[VirtualHost](#VirtualHost3)<br>

### UpdateVirtualHostRequest {#UpdateVirtualHostRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required. ID of the HTTP Router that the virtual host belongs to. 
virtual_host_name | **string**<br>Required.  
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
authority[] | **string**<br>Fields of the virtual host to update. Except name, that field used to address virtual host within the http router and cannot be changed after creation. 
ports[] | **int64**<br> 
routes[] | **[Route](#Route4)**<br> 
modify_request_headers[] | **[HeaderModification](#HeaderModification4)**<br> 
modify_response_headers[] | **[HeaderModification](#HeaderModification4)**<br> 


### Route {#Route4}

Field | Description
--- | ---
name | **string**<br>Required.  
route | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpRoute](#HttpRoute4)**<br> 
&nbsp;&nbsp;grpc | **[GrpcRoute](#GrpcRoute4)**<br> 


### HttpRoute {#HttpRoute4}

Field | Description
--- | ---
match | **[HttpRouteMatch](#HttpRouteMatch4)**<br>Checks "/" prefix by default. 
action | **oneof:** `route`, `redirect` or `direct_response`<br>
&nbsp;&nbsp;route | **[HttpRouteAction](#HttpRouteAction4)**<br> 
&nbsp;&nbsp;redirect | **[RedirectAction](#RedirectAction4)**<br> 
&nbsp;&nbsp;direct_response | **[DirectResponseAction](#DirectResponseAction4)**<br> 


### HttpRouteMatch {#HttpRouteMatch4}

Field | Description
--- | ---
http_method[] | **string**<br> 
path | **[StringMatch](#StringMatch8)**<br>If not set, '/' is assumed. 


### StringMatch {#StringMatch8}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### HttpRouteAction {#HttpRouteAction4}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 
prefix_rewrite | **string**<br>If not empty, matched path prefix will be replaced by this value. 
support_websockets | **bool**<br>Allows websocket upgrades. 


### RedirectAction {#RedirectAction4}

Field | Description
--- | ---
replace_scheme | **string**<br>Replaces scheme. If the original scheme is `http` or `https`, will also remove the 80 or 443 port, if present. 
response_code | enum **RedirectResponseCode**<br>The HTTP status code to use in the redirect response. <ul><li>`MOVED_PERMANENTLY`: Moved Permanently HTTP Status Code - 301.</li><li>`FOUND`: Found HTTP Status Code - 302.</li><li>`SEE_OTHER`: See Other HTTP Status Code - 303.</li><li>`TEMPORARY_REDIRECT`: Temporary Redirect HTTP Status Code - 307.</li><li>`PERMANENT_REDIRECT`: Permanent Redirect HTTP Status Code - 308.</li><ul/>


### DirectResponseAction {#DirectResponseAction4}

Field | Description
--- | ---
status | **int64**<br>HTTP response status. Acceptable values are 100 to 599, inclusive.
body | **[Payload](#Payload4)**<br>Optional response body. 


### Payload {#Payload4}

Field | Description
--- | ---
payload | **oneof:** `text`<br>
&nbsp;&nbsp;text | **string**<br>Text message. The string length in characters must be greater than 0.


### GrpcRoute {#GrpcRoute4}

Field | Description
--- | ---
match | **[GrpcRouteMatch](#GrpcRouteMatch4)**<br>Checks "/" prefix by default. 
action | **oneof:** `route` or `status_response`<br>
&nbsp;&nbsp;route | **[GrpcRouteAction](#GrpcRouteAction4)**<br> 
&nbsp;&nbsp;status_response | **[GrpcStatusResponseAction](#GrpcStatusResponseAction4)**<br> 


### GrpcRouteMatch {#GrpcRouteMatch4}

Field | Description
--- | ---
fqmn | **[StringMatch](#StringMatch9)**<br>If not set, all services/methods are assumed. 


### StringMatch {#StringMatch9}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### GrpcRouteAction {#GrpcRouteAction4}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
max_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Lower timeout may be specified by the client (using grpc-timeout header). If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 


### GrpcStatusResponseAction {#GrpcStatusResponseAction4}

Field | Description
--- | ---
status | enum **Status**<br> <ul><ul/>


### HeaderModification {#HeaderModification4}

Field | Description
--- | ---
name | **string**<br>Name of the header. 
operation | **oneof:** `append`, `replace`, `remove` or `rename`<br>Header values support the following formatters: https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers
&nbsp;&nbsp;append | **string**<br>Append string to the header value. 
&nbsp;&nbsp;replace | **string**<br>New value for a header. 
&nbsp;&nbsp;remove | **bool**<br>Remove the header. 
&nbsp;&nbsp;rename | **string**<br>New name for a header. 


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
http_router_id | **string**<br>ID of the HTTP Router where a virtual host is being updated. 
virtual_host_name | **string**<br>Name of the updated virtual host. 


### VirtualHost {#VirtualHost3}

Field | Description
--- | ---
name | **string**<br>Required.  
authority[] | **string**<br>A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '*.foo.com' or '*-bar.foo.com'. If not specified, all domains will be matched. 
ports[] | **int64**<br><ol><li></li></ol> 
routes[] | **[Route](#Route5)**<br>Routes are matched *in-order*. Be careful when adding them to the end. For instance, having http '/' match first makes all other routes unused. 
modify_request_headers[] | **[HeaderModification](#HeaderModification5)**<br>Apply the following modifications to the request headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification5)**<br>Apply the following modifications to the response headers. 


### Route {#Route5}

Field | Description
--- | ---
name | **string**<br>Required.  
route | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpRoute](#HttpRoute5)**<br> 
&nbsp;&nbsp;grpc | **[GrpcRoute](#GrpcRoute5)**<br> 


### HttpRoute {#HttpRoute5}

Field | Description
--- | ---
match | **[HttpRouteMatch](#HttpRouteMatch5)**<br>Checks "/" prefix by default. 
action | **oneof:** `route`, `redirect` or `direct_response`<br>
&nbsp;&nbsp;route | **[HttpRouteAction](#HttpRouteAction5)**<br> 
&nbsp;&nbsp;redirect | **[RedirectAction](#RedirectAction5)**<br> 
&nbsp;&nbsp;direct_response | **[DirectResponseAction](#DirectResponseAction5)**<br> 


### HttpRouteMatch {#HttpRouteMatch5}

Field | Description
--- | ---
http_method[] | **string**<br> 
path | **[StringMatch](#StringMatch10)**<br>If not set, '/' is assumed. 


### StringMatch {#StringMatch10}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### HttpRouteAction {#HttpRouteAction5}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 
prefix_rewrite | **string**<br>If not empty, matched path prefix will be replaced by this value. 
support_websockets | **bool**<br>Allows websocket upgrades. 


### RedirectAction {#RedirectAction5}

Field | Description
--- | ---
replace_scheme | **string**<br>Replaces scheme. If the original scheme is `http` or `https`, will also remove the 80 or 443 port, if present. 
response_code | enum **RedirectResponseCode**<br>The HTTP status code to use in the redirect response. <ul><li>`MOVED_PERMANENTLY`: Moved Permanently HTTP Status Code - 301.</li><li>`FOUND`: Found HTTP Status Code - 302.</li><li>`SEE_OTHER`: See Other HTTP Status Code - 303.</li><li>`TEMPORARY_REDIRECT`: Temporary Redirect HTTP Status Code - 307.</li><li>`PERMANENT_REDIRECT`: Permanent Redirect HTTP Status Code - 308.</li><ul/>


### DirectResponseAction {#DirectResponseAction5}

Field | Description
--- | ---
status | **int64**<br>HTTP response status. Acceptable values are 100 to 599, inclusive.
body | **[Payload](#Payload5)**<br>Optional response body. 


### Payload {#Payload5}

Field | Description
--- | ---
payload | **oneof:** `text`<br>
&nbsp;&nbsp;text | **string**<br>Text message. The string length in characters must be greater than 0.


### GrpcRoute {#GrpcRoute5}

Field | Description
--- | ---
match | **[GrpcRouteMatch](#GrpcRouteMatch5)**<br>Checks "/" prefix by default. 
action | **oneof:** `route` or `status_response`<br>
&nbsp;&nbsp;route | **[GrpcRouteAction](#GrpcRouteAction5)**<br> 
&nbsp;&nbsp;status_response | **[GrpcStatusResponseAction](#GrpcStatusResponseAction5)**<br> 


### GrpcRouteMatch {#GrpcRouteMatch5}

Field | Description
--- | ---
fqmn | **[StringMatch](#StringMatch11)**<br>If not set, all services/methods are assumed. 


### StringMatch {#StringMatch11}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### GrpcRouteAction {#GrpcRouteAction5}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
max_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Lower timeout may be specified by the client (using grpc-timeout header). If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 


### GrpcStatusResponseAction {#GrpcStatusResponseAction5}

Field | Description
--- | ---
status | enum **Status**<br> <ul><ul/>


### HeaderModification {#HeaderModification5}

Field | Description
--- | ---
name | **string**<br>Name of the header. 
operation | **oneof:** `append`, `replace`, `remove` or `rename`<br>Header values support the following formatters: https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers
&nbsp;&nbsp;append | **string**<br>Append string to the header value. 
&nbsp;&nbsp;replace | **string**<br>New value for a header. 
&nbsp;&nbsp;remove | **bool**<br>Remove the header. 
&nbsp;&nbsp;rename | **string**<br>New name for a header. 


## Delete {#Delete}

Deletes the specified virtual host.

**rpc Delete ([DeleteVirtualHostRequest](#DeleteVirtualHostRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteVirtualHostMetadata](#DeleteVirtualHostMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteVirtualHostRequest {#DeleteVirtualHostRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required. ID of the HTTP Router to delete a virtual host in. 
virtual_host_name | **string**<br>Required. Name of the virtual host to delete. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.


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
http_router_id | **string**<br>ID of the HTTP Router where a virtual host is being deleted. 
virtual_host_name | **string**<br>Name of the virtual host that is being deleted. 


## RemoveRoute {#RemoveRoute}



**rpc RemoveRoute ([RemoveRouteRequest](#RemoveRouteRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveRouteMetadata](#RemoveRouteMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[VirtualHost](#VirtualHost4)<br>

### RemoveRouteRequest {#RemoveRouteRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  
virtual_host_name | **string**<br>Required.  
route_name | **string**<br>Required.  


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
http_router_id | **string**<br> 
virtual_host_name | **string**<br> 
route_name | **string**<br> 


### VirtualHost {#VirtualHost4}

Field | Description
--- | ---
name | **string**<br>Required.  
authority[] | **string**<br>A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '*.foo.com' or '*-bar.foo.com'. If not specified, all domains will be matched. 
ports[] | **int64**<br><ol><li></li></ol> 
routes[] | **[Route](#Route6)**<br>Routes are matched *in-order*. Be careful when adding them to the end. For instance, having http '/' match first makes all other routes unused. 
modify_request_headers[] | **[HeaderModification](#HeaderModification6)**<br>Apply the following modifications to the request headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification6)**<br>Apply the following modifications to the response headers. 


### Route {#Route6}

Field | Description
--- | ---
name | **string**<br>Required.  
route | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpRoute](#HttpRoute6)**<br> 
&nbsp;&nbsp;grpc | **[GrpcRoute](#GrpcRoute6)**<br> 


### HttpRoute {#HttpRoute6}

Field | Description
--- | ---
match | **[HttpRouteMatch](#HttpRouteMatch6)**<br>Checks "/" prefix by default. 
action | **oneof:** `route`, `redirect` or `direct_response`<br>
&nbsp;&nbsp;route | **[HttpRouteAction](#HttpRouteAction6)**<br> 
&nbsp;&nbsp;redirect | **[RedirectAction](#RedirectAction6)**<br> 
&nbsp;&nbsp;direct_response | **[DirectResponseAction](#DirectResponseAction6)**<br> 


### HttpRouteMatch {#HttpRouteMatch6}

Field | Description
--- | ---
http_method[] | **string**<br> 
path | **[StringMatch](#StringMatch12)**<br>If not set, '/' is assumed. 


### StringMatch {#StringMatch12}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### HttpRouteAction {#HttpRouteAction6}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 
prefix_rewrite | **string**<br>If not empty, matched path prefix will be replaced by this value. 
support_websockets | **bool**<br>Allows websocket upgrades. 


### RedirectAction {#RedirectAction6}

Field | Description
--- | ---
replace_scheme | **string**<br>Replaces scheme. If the original scheme is `http` or `https`, will also remove the 80 or 443 port, if present. 
response_code | enum **RedirectResponseCode**<br>The HTTP status code to use in the redirect response. <ul><li>`MOVED_PERMANENTLY`: Moved Permanently HTTP Status Code - 301.</li><li>`FOUND`: Found HTTP Status Code - 302.</li><li>`SEE_OTHER`: See Other HTTP Status Code - 303.</li><li>`TEMPORARY_REDIRECT`: Temporary Redirect HTTP Status Code - 307.</li><li>`PERMANENT_REDIRECT`: Permanent Redirect HTTP Status Code - 308.</li><ul/>


### DirectResponseAction {#DirectResponseAction6}

Field | Description
--- | ---
status | **int64**<br>HTTP response status. Acceptable values are 100 to 599, inclusive.
body | **[Payload](#Payload6)**<br>Optional response body. 


### Payload {#Payload6}

Field | Description
--- | ---
payload | **oneof:** `text`<br>
&nbsp;&nbsp;text | **string**<br>Text message. The string length in characters must be greater than 0.


### GrpcRoute {#GrpcRoute6}

Field | Description
--- | ---
match | **[GrpcRouteMatch](#GrpcRouteMatch6)**<br>Checks "/" prefix by default. 
action | **oneof:** `route` or `status_response`<br>
&nbsp;&nbsp;route | **[GrpcRouteAction](#GrpcRouteAction6)**<br> 
&nbsp;&nbsp;status_response | **[GrpcStatusResponseAction](#GrpcStatusResponseAction6)**<br> 


### GrpcRouteMatch {#GrpcRouteMatch6}

Field | Description
--- | ---
fqmn | **[StringMatch](#StringMatch13)**<br>If not set, all services/methods are assumed. 


### StringMatch {#StringMatch13}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### GrpcRouteAction {#GrpcRouteAction6}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
max_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Lower timeout may be specified by the client (using grpc-timeout header). If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 


### GrpcStatusResponseAction {#GrpcStatusResponseAction6}

Field | Description
--- | ---
status | enum **Status**<br> <ul><ul/>


### HeaderModification {#HeaderModification6}

Field | Description
--- | ---
name | **string**<br>Name of the header. 
operation | **oneof:** `append`, `replace`, `remove` or `rename`<br>Header values support the following formatters: https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers
&nbsp;&nbsp;append | **string**<br>Append string to the header value. 
&nbsp;&nbsp;replace | **string**<br>New value for a header. 
&nbsp;&nbsp;remove | **bool**<br>Remove the header. 
&nbsp;&nbsp;rename | **string**<br>New name for a header. 


## UpdateRoute {#UpdateRoute}



**rpc UpdateRoute ([UpdateRouteRequest](#UpdateRouteRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateRouteMetadata](#UpdateRouteMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[VirtualHost](#VirtualHost5)<br>

### UpdateRouteRequest {#UpdateRouteRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  
virtual_host_name | **string**<br>Required.  
route_name | **string**<br>Required.  
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
route | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpRoute](#HttpRoute7)**<br> 
&nbsp;&nbsp;grpc | **[GrpcRoute](#GrpcRoute7)**<br> 


### HttpRoute {#HttpRoute7}

Field | Description
--- | ---
match | **[HttpRouteMatch](#HttpRouteMatch7)**<br>Checks "/" prefix by default. 
action | **oneof:** `route`, `redirect` or `direct_response`<br>
&nbsp;&nbsp;route | **[HttpRouteAction](#HttpRouteAction7)**<br> 
&nbsp;&nbsp;redirect | **[RedirectAction](#RedirectAction7)**<br> 
&nbsp;&nbsp;direct_response | **[DirectResponseAction](#DirectResponseAction7)**<br> 


### HttpRouteMatch {#HttpRouteMatch7}

Field | Description
--- | ---
http_method[] | **string**<br> 
path | **[StringMatch](#StringMatch14)**<br>If not set, '/' is assumed. 


### StringMatch {#StringMatch14}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### HttpRouteAction {#HttpRouteAction7}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 
prefix_rewrite | **string**<br>If not empty, matched path prefix will be replaced by this value. 
support_websockets | **bool**<br>Allows websocket upgrades. 


### RedirectAction {#RedirectAction7}

Field | Description
--- | ---
replace_scheme | **string**<br>Replaces scheme. If the original scheme is `http` or `https`, will also remove the 80 or 443 port, if present. 
response_code | enum **RedirectResponseCode**<br>The HTTP status code to use in the redirect response. <ul><li>`MOVED_PERMANENTLY`: Moved Permanently HTTP Status Code - 301.</li><li>`FOUND`: Found HTTP Status Code - 302.</li><li>`SEE_OTHER`: See Other HTTP Status Code - 303.</li><li>`TEMPORARY_REDIRECT`: Temporary Redirect HTTP Status Code - 307.</li><li>`PERMANENT_REDIRECT`: Permanent Redirect HTTP Status Code - 308.</li><ul/>


### DirectResponseAction {#DirectResponseAction7}

Field | Description
--- | ---
status | **int64**<br>HTTP response status. Acceptable values are 100 to 599, inclusive.
body | **[Payload](#Payload7)**<br>Optional response body. 


### Payload {#Payload7}

Field | Description
--- | ---
payload | **oneof:** `text`<br>
&nbsp;&nbsp;text | **string**<br>Text message. The string length in characters must be greater than 0.


### GrpcRoute {#GrpcRoute7}

Field | Description
--- | ---
match | **[GrpcRouteMatch](#GrpcRouteMatch7)**<br>Checks "/" prefix by default. 
action | **oneof:** `route` or `status_response`<br>
&nbsp;&nbsp;route | **[GrpcRouteAction](#GrpcRouteAction7)**<br> 
&nbsp;&nbsp;status_response | **[GrpcStatusResponseAction](#GrpcStatusResponseAction7)**<br> 


### GrpcRouteMatch {#GrpcRouteMatch7}

Field | Description
--- | ---
fqmn | **[StringMatch](#StringMatch15)**<br>If not set, all services/methods are assumed. 


### StringMatch {#StringMatch15}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### GrpcRouteAction {#GrpcRouteAction7}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
max_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Lower timeout may be specified by the client (using grpc-timeout header). If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 


### GrpcStatusResponseAction {#GrpcStatusResponseAction7}

Field | Description
--- | ---
status | enum **Status**<br> <ul><ul/>


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
http_router_id | **string**<br> 
virtual_host_name | **string**<br> 
route_name | **string**<br> 


### VirtualHost {#VirtualHost5}

Field | Description
--- | ---
name | **string**<br>Required.  
authority[] | **string**<br>A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '*.foo.com' or '*-bar.foo.com'. If not specified, all domains will be matched. 
ports[] | **int64**<br><ol><li></li></ol> 
routes[] | **[Route](#Route7)**<br>Routes are matched *in-order*. Be careful when adding them to the end. For instance, having http '/' match first makes all other routes unused. 
modify_request_headers[] | **[HeaderModification](#HeaderModification7)**<br>Apply the following modifications to the request headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification7)**<br>Apply the following modifications to the response headers. 


### Route {#Route7}

Field | Description
--- | ---
name | **string**<br>Required.  
route | **oneof:** `http` or `grpc`<br>
&nbsp;&nbsp;http | **[HttpRoute](#HttpRoute8)**<br> 
&nbsp;&nbsp;grpc | **[GrpcRoute](#GrpcRoute8)**<br> 


### HttpRoute {#HttpRoute8}

Field | Description
--- | ---
match | **[HttpRouteMatch](#HttpRouteMatch8)**<br>Checks "/" prefix by default. 
action | **oneof:** `route`, `redirect` or `direct_response`<br>
&nbsp;&nbsp;route | **[HttpRouteAction](#HttpRouteAction8)**<br> 
&nbsp;&nbsp;redirect | **[RedirectAction](#RedirectAction8)**<br> 
&nbsp;&nbsp;direct_response | **[DirectResponseAction](#DirectResponseAction8)**<br> 


### HttpRouteMatch {#HttpRouteMatch8}

Field | Description
--- | ---
http_method[] | **string**<br> 
path | **[StringMatch](#StringMatch16)**<br>If not set, '/' is assumed. 


### StringMatch {#StringMatch16}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### HttpRouteAction {#HttpRouteAction8}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 
prefix_rewrite | **string**<br>If not empty, matched path prefix will be replaced by this value. 
support_websockets | **bool**<br>Allows websocket upgrades. 


### RedirectAction {#RedirectAction8}

Field | Description
--- | ---
replace_scheme | **string**<br>Replaces scheme. If the original scheme is `http` or `https`, will also remove the 80 or 443 port, if present. 
response_code | enum **RedirectResponseCode**<br>The HTTP status code to use in the redirect response. <ul><li>`MOVED_PERMANENTLY`: Moved Permanently HTTP Status Code - 301.</li><li>`FOUND`: Found HTTP Status Code - 302.</li><li>`SEE_OTHER`: See Other HTTP Status Code - 303.</li><li>`TEMPORARY_REDIRECT`: Temporary Redirect HTTP Status Code - 307.</li><li>`PERMANENT_REDIRECT`: Permanent Redirect HTTP Status Code - 308.</li><ul/>


### DirectResponseAction {#DirectResponseAction8}

Field | Description
--- | ---
status | **int64**<br>HTTP response status. Acceptable values are 100 to 599, inclusive.
body | **[Payload](#Payload8)**<br>Optional response body. 


### Payload {#Payload8}

Field | Description
--- | ---
payload | **oneof:** `text`<br>
&nbsp;&nbsp;text | **string**<br>Text message. The string length in characters must be greater than 0.


### GrpcRoute {#GrpcRoute8}

Field | Description
--- | ---
match | **[GrpcRouteMatch](#GrpcRouteMatch8)**<br>Checks "/" prefix by default. 
action | **oneof:** `route` or `status_response`<br>
&nbsp;&nbsp;route | **[GrpcRouteAction](#GrpcRouteAction8)**<br> 
&nbsp;&nbsp;status_response | **[GrpcStatusResponseAction](#GrpcStatusResponseAction8)**<br> 


### GrpcRouteMatch {#GrpcRouteMatch8}

Field | Description
--- | ---
fqmn | **[StringMatch](#StringMatch17)**<br>If not set, all services/methods are assumed. 


### StringMatch {#StringMatch17}

Field | Description
--- | ---
match | **oneof:** `exact_match` or `prefix_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> 
&nbsp;&nbsp;prefix_match | **string**<br> 


### GrpcRouteAction {#GrpcRouteAction8}

Field | Description
--- | ---
backend_group_id | **string**<br>Required. Backend group to route requests. 
max_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Lower timeout may be specified by the client (using grpc-timeout header). If not set, default is 60 seconds. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 


### GrpcStatusResponseAction {#GrpcStatusResponseAction8}

Field | Description
--- | ---
status | enum **Status**<br> <ul><ul/>


### HeaderModification {#HeaderModification7}

Field | Description
--- | ---
name | **string**<br>Name of the header. 
operation | **oneof:** `append`, `replace`, `remove` or `rename`<br>Header values support the following formatters: https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers
&nbsp;&nbsp;append | **string**<br>Append string to the header value. 
&nbsp;&nbsp;replace | **string**<br>New value for a header. 
&nbsp;&nbsp;remove | **bool**<br>Remove the header. 
&nbsp;&nbsp;rename | **string**<br>New name for a header. 


