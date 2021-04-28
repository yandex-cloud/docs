---
editable: false
---

# HttpRouterService



| Call | Description |
| --- | --- |
| [Get](#Get) |  |
| [List](#List) |  |
| [Create](#Create) |  |
| [Update](#Update) |  |
| [Delete](#Delete) |  |
| [ListOperations](#ListOperations) | Lists operations for the specified http router. |

## Calls HttpRouterService {#calls}

## Get {#Get}



**rpc Get ([GetHttpRouterRequest](#GetHttpRouterRequest)) returns ([HttpRouter](#HttpRouter))**

### GetHttpRouterRequest {#GetHttpRouterRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  


### HttpRouter {#HttpRouter}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the router. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the router. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the router belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
virtual_hosts[] | **[VirtualHost](#VirtualHost)**<br>Only one virtual host with no authority (default match) can be specified. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the http router. 


### VirtualHost {#VirtualHost}

Field | Description
--- | ---
name | **string**<br>Required.  
authority[] | **string**<br>A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '*.foo.com' or '*-bar.foo.com'. If not specified, all domains will be matched. 
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
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the request timeout (overall time request processing is allowed to take) for the route. If not set, default is 60 seconds. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios (i.e. long-polling, server-sent events) - one should set idle_timeout to something meaningful and timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 
prefix_rewrite | **string**<br>If not empty, matched path prefix will be replaced by this value. 
upgrade_types[] | **string**<br>Only specified upgrade types will be allowed. For example, "websocket". 


### RedirectAction {#RedirectAction}

Field | Description
--- | ---
replace_scheme | **string**<br>Replaces scheme. If the original scheme is `http` or `https`, will also remove the 80 or 443 port, if present. 
replace_host | **string**<br>Replaces hostname. 
replace_port | **int64**<br>Replaces port. 
path | **oneof:** `replace_path` or `replace_prefix`<br>
&nbsp;&nbsp;replace_path | **string**<br>Replace path. 
&nbsp;&nbsp;replace_prefix | **string**<br>Replace only matched prefix. Example: match:    {prefix_match: "/some"} redirect: {replace_prefix: "/other"} will redirect "/something" to "/otherthing" 
remove_query | **bool**<br>Remove query part. 
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
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios - one should set idle_timeout to something meaningful and max_timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout. 
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



**rpc List ([ListHttpRoutersRequest](#ListHttpRoutersRequest)) returns ([ListHttpRoutersResponse](#ListHttpRoutersResponse))**

### ListHttpRoutersRequest {#ListHttpRoutersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required.  
page_size | **int64**<br> Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br> The maximum string length in characters is 100.
filter | **string**<br> The maximum string length in characters is 1000.


### ListHttpRoutersResponse {#ListHttpRoutersResponse}

Field | Description
--- | ---
http_routers[] | **[HttpRouter](#HttpRouter1)**<br> 
next_page_token | **string**<br> 


### HttpRouter {#HttpRouter1}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the router. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the router. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the router belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
virtual_hosts[] | **[VirtualHost](#VirtualHost1)**<br>Only one virtual host with no authority (default match) can be specified. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the http router. 


### VirtualHost {#VirtualHost1}

Field | Description
--- | ---
name | **string**<br>Required.  
authority[] | **string**<br>A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '*.foo.com' or '*-bar.foo.com'. If not specified, all domains will be matched. 
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
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the request timeout (overall time request processing is allowed to take) for the route. If not set, default is 60 seconds. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios (i.e. long-polling, server-sent events) - one should set idle_timeout to something meaningful and timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 
prefix_rewrite | **string**<br>If not empty, matched path prefix will be replaced by this value. 
upgrade_types[] | **string**<br>Only specified upgrade types will be allowed. For example, "websocket". 


### RedirectAction {#RedirectAction1}

Field | Description
--- | ---
replace_scheme | **string**<br>Replaces scheme. If the original scheme is `http` or `https`, will also remove the 80 or 443 port, if present. 
replace_host | **string**<br>Replaces hostname. 
replace_port | **int64**<br>Replaces port. 
path | **oneof:** `replace_path` or `replace_prefix`<br>
&nbsp;&nbsp;replace_path | **string**<br>Replace path. 
&nbsp;&nbsp;replace_prefix | **string**<br>Replace only matched prefix. Example: match:    {prefix_match: "/some"} redirect: {replace_prefix: "/other"} will redirect "/something" to "/otherthing" 
remove_query | **bool**<br>Remove query part. 
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
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios - one should set idle_timeout to something meaningful and max_timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout. 
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



**rpc Create ([CreateHttpRouterRequest](#CreateHttpRouterRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateHttpRouterMetadata](#CreateHttpRouterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[HttpRouter](#HttpRouter2)<br>

### CreateHttpRouterRequest {#CreateHttpRouterRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required.  
name | **string**<br> Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
virtual_hosts[] | **[VirtualHost](#VirtualHost2)**<br> 
https_redirect | **bool**<br> 


### VirtualHost {#VirtualHost2}

Field | Description
--- | ---
name | **string**<br>Required.  
authority[] | **string**<br>A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '*.foo.com' or '*-bar.foo.com'. If not specified, all domains will be matched. 
routes[] | **[Route](#Route2)**<br>Routes are matched *in-order*. Be careful when adding them to the end. For instance, having http '/' match first makes all other routes unused. 
modify_request_headers[] | **[HeaderModification](#HeaderModification2)**<br>Apply the following modifications to the request headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification2)**<br>Apply the following modifications to the response headers. 


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
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the request timeout (overall time request processing is allowed to take) for the route. If not set, default is 60 seconds. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios (i.e. long-polling, server-sent events) - one should set idle_timeout to something meaningful and timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 
prefix_rewrite | **string**<br>If not empty, matched path prefix will be replaced by this value. 
upgrade_types[] | **string**<br>Only specified upgrade types will be allowed. For example, "websocket". 


### RedirectAction {#RedirectAction2}

Field | Description
--- | ---
replace_scheme | **string**<br>Replaces scheme. If the original scheme is `http` or `https`, will also remove the 80 or 443 port, if present. 
replace_host | **string**<br>Replaces hostname. 
replace_port | **int64**<br>Replaces port. 
path | **oneof:** `replace_path` or `replace_prefix`<br>
&nbsp;&nbsp;replace_path | **string**<br>Replace path. 
&nbsp;&nbsp;replace_prefix | **string**<br>Replace only matched prefix. Example: match:    {prefix_match: "/some"} redirect: {replace_prefix: "/other"} will redirect "/something" to "/otherthing" 
remove_query | **bool**<br>Remove query part. 
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
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios - one should set idle_timeout to something meaningful and max_timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout. 
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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateHttpRouterMetadata](#CreateHttpRouterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[HttpRouter](#HttpRouter2)>**<br>if operation finished successfully. 


### CreateHttpRouterMetadata {#CreateHttpRouterMetadata}

Field | Description
--- | ---
http_router_id | **string**<br> 


### HttpRouter {#HttpRouter2}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the router. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the router. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the router belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
virtual_hosts[] | **[VirtualHost](#VirtualHost3)**<br>Only one virtual host with no authority (default match) can be specified. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the http router. 


### VirtualHost {#VirtualHost3}

Field | Description
--- | ---
name | **string**<br>Required.  
authority[] | **string**<br>A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '*.foo.com' or '*-bar.foo.com'. If not specified, all domains will be matched. 
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
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the request timeout (overall time request processing is allowed to take) for the route. If not set, default is 60 seconds. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios (i.e. long-polling, server-sent events) - one should set idle_timeout to something meaningful and timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 
prefix_rewrite | **string**<br>If not empty, matched path prefix will be replaced by this value. 
upgrade_types[] | **string**<br>Only specified upgrade types will be allowed. For example, "websocket". 


### RedirectAction {#RedirectAction3}

Field | Description
--- | ---
replace_scheme | **string**<br>Replaces scheme. If the original scheme is `http` or `https`, will also remove the 80 or 443 port, if present. 
replace_host | **string**<br>Replaces hostname. 
replace_port | **int64**<br>Replaces port. 
path | **oneof:** `replace_path` or `replace_prefix`<br>
&nbsp;&nbsp;replace_path | **string**<br>Replace path. 
&nbsp;&nbsp;replace_prefix | **string**<br>Replace only matched prefix. Example: match:    {prefix_match: "/some"} redirect: {replace_prefix: "/other"} will redirect "/something" to "/otherthing" 
remove_query | **bool**<br>Remove query part. 
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
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios - one should set idle_timeout to something meaningful and max_timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout. 
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



**rpc Update ([UpdateHttpRouterRequest](#UpdateHttpRouterRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateHttpRouterMetadata](#UpdateHttpRouterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[HttpRouter](#HttpRouter3)<br>

### UpdateHttpRouterRequest {#UpdateHttpRouterRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
name | **string**<br> Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
virtual_hosts[] | **[VirtualHost](#VirtualHost4)**<br> 
https_redirect | **bool**<br> 


### VirtualHost {#VirtualHost4}

Field | Description
--- | ---
name | **string**<br>Required.  
authority[] | **string**<br>A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '*.foo.com' or '*-bar.foo.com'. If not specified, all domains will be matched. 
routes[] | **[Route](#Route4)**<br>Routes are matched *in-order*. Be careful when adding them to the end. For instance, having http '/' match first makes all other routes unused. 
modify_request_headers[] | **[HeaderModification](#HeaderModification4)**<br>Apply the following modifications to the request headers. 
modify_response_headers[] | **[HeaderModification](#HeaderModification4)**<br>Apply the following modifications to the response headers. 


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
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the request timeout (overall time request processing is allowed to take) for the route. If not set, default is 60 seconds. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios (i.e. long-polling, server-sent events) - one should set idle_timeout to something meaningful and timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 
prefix_rewrite | **string**<br>If not empty, matched path prefix will be replaced by this value. 
upgrade_types[] | **string**<br>Only specified upgrade types will be allowed. For example, "websocket". 


### RedirectAction {#RedirectAction4}

Field | Description
--- | ---
replace_scheme | **string**<br>Replaces scheme. If the original scheme is `http` or `https`, will also remove the 80 or 443 port, if present. 
replace_host | **string**<br>Replaces hostname. 
replace_port | **int64**<br>Replaces port. 
path | **oneof:** `replace_path` or `replace_prefix`<br>
&nbsp;&nbsp;replace_path | **string**<br>Replace path. 
&nbsp;&nbsp;replace_prefix | **string**<br>Replace only matched prefix. Example: match:    {prefix_match: "/some"} redirect: {replace_prefix: "/other"} will redirect "/something" to "/otherthing" 
remove_query | **bool**<br>Remove query part. 
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
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios - one should set idle_timeout to something meaningful and max_timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout. 
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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateHttpRouterMetadata](#UpdateHttpRouterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[HttpRouter](#HttpRouter3)>**<br>if operation finished successfully. 


### UpdateHttpRouterMetadata {#UpdateHttpRouterMetadata}

Field | Description
--- | ---
http_router_id | **string**<br> 


### HttpRouter {#HttpRouter3}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the router. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the router. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the router belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
virtual_hosts[] | **[VirtualHost](#VirtualHost5)**<br>Only one virtual host with no authority (default match) can be specified. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the http router. 


### VirtualHost {#VirtualHost5}

Field | Description
--- | ---
name | **string**<br>Required.  
authority[] | **string**<br>A list of domains (host/authority header) that will be matched to this virtual host. Wildcard hosts are supported in the form of '*.foo.com' or '*-bar.foo.com'. If not specified, all domains will be matched. 
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
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the request timeout (overall time request processing is allowed to take) for the route. If not set, default is 60 seconds. 
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios (i.e. long-polling, server-sent events) - one should set idle_timeout to something meaningful and timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout. 
host_rewrite_specifier | **oneof:** `host_rewrite` or `auto_host_rewrite`<br>
&nbsp;&nbsp;host_rewrite | **string**<br> 
&nbsp;&nbsp;auto_host_rewrite | **bool**<br> 
prefix_rewrite | **string**<br>If not empty, matched path prefix will be replaced by this value. 
upgrade_types[] | **string**<br>Only specified upgrade types will be allowed. For example, "websocket". 


### RedirectAction {#RedirectAction5}

Field | Description
--- | ---
replace_scheme | **string**<br>Replaces scheme. If the original scheme is `http` or `https`, will also remove the 80 or 443 port, if present. 
replace_host | **string**<br>Replaces hostname. 
replace_port | **int64**<br>Replaces port. 
path | **oneof:** `replace_path` or `replace_prefix`<br>
&nbsp;&nbsp;replace_path | **string**<br>Replace path. 
&nbsp;&nbsp;replace_prefix | **string**<br>Replace only matched prefix. Example: match:    {prefix_match: "/some"} redirect: {replace_prefix: "/other"} will redirect "/something" to "/otherthing" 
remove_query | **bool**<br>Remove query part. 
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
idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Specifies the idle timeout (time without any data transfer for the active request) for the route. It is useful for streaming scenarios - one should set idle_timeout to something meaningful and max_timeout to the maximum time the stream is allowed to be alive. If not specified, there is no per-route idle timeout. 
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



**rpc Delete ([DeleteHttpRouterRequest](#DeleteHttpRouterRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteHttpRouterMetadata](#DeleteHttpRouterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteHttpRouterRequest {#DeleteHttpRouterRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteHttpRouterMetadata](#DeleteHttpRouterMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteHttpRouterMetadata {#DeleteHttpRouterMetadata}

Field | Description
--- | ---
http_router_id | **string**<br> 


## ListOperations {#ListOperations}

Lists operations for the specified http router.

**rpc ListOperations ([ListHttpRouterOperationsRequest](#ListHttpRouterOperationsRequest)) returns ([ListHttpRouterOperationsResponse](#ListHttpRouterOperationsResponse))**

### ListHttpRouterOperationsRequest {#ListHttpRouterOperationsRequest}

Field | Description
--- | ---
http_router_id | **string**<br>Required. ID of the http router to get operations for. <br>To get the http router ID, use a [HttpRouterService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListHttpRouterOperationsResponse.next_page_token](#ListHttpRouterOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListHttpRouterOperationsResponse.next_page_token](#ListHttpRouterOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListHttpRouterOperationsResponse {#ListHttpRouterOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified target group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListHttpRouterOperationsRequest.page_size](#ListHttpRouterOperationsRequest), use the `next_page_token` as the value for the [ListHttpRouterOperationsRequest.page_token](#ListHttpRouterOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any. 


