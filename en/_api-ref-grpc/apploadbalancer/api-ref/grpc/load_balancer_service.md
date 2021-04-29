---
editable: false
---

# LoadBalancerService



| Call | Description |
| --- | --- |
| [Get](#Get) |  |
| [List](#List) |  |
| [Create](#Create) |  |
| [Update](#Update) |  |
| [Delete](#Delete) |  |
| [Start](#Start) |  |
| [Stop](#Stop) |  |
| [AddListener](#AddListener) | AddListener/UpdateListener technically do the same, but have different semantics. |
| [RemoveListener](#RemoveListener) |  |
| [UpdateListener](#UpdateListener) |  |
| [AddSniMatch](#AddSniMatch) |  |
| [UpdateSniMatch](#UpdateSniMatch) |  |
| [RemoveSniMatch](#RemoveSniMatch) |  |
| [GetTargetStates](#GetTargetStates) | Returns zonal state of each target within target group for a given backend group and load balancer. |
| [ListOperations](#ListOperations) | Lists operations for the specified load balancer. |

## Calls LoadBalancerService {#calls}

## Get {#Get}



**rpc Get ([GetLoadBalancerRequest](#GetLoadBalancerRequest)) returns ([LoadBalancer](#LoadBalancer))**

### GetLoadBalancerRequest {#GetLoadBalancerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  


### LoadBalancer {#LoadBalancer}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the load balancer. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the load balancer. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the load balancer belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: Application load balancer is being created.</li><li>`STARTING`: Application load balancer is being started.</li><li>`ACTIVE`: Application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: Application load balancer is being stopped.</li><li>`STOPPED`: Application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: Application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the load balancer located at. 
network_id | **string**<br>ID of the network that the load balancer located at. 
listeners[] | **[Listener](#Listener)**<br>List of listeners for the application load balancer. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy)**<br>Allocation sites for application load balancer instances. 
log_group_id | **string**<br>Cloud log group used by the load balancer to store access logs. 
security_group_ids[] | **string**<br>ID's of security groups attached to the load balancer. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the load balancer. 


### Listener {#Listener}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. 
endpoints[] | **[Endpoint](#Endpoint)**<br>Network endpoints (addresses and ports) of the listener. 
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](#HttpListener)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener)**<br> 


### Endpoint {#Endpoint}

Field | Description
--- | ---
addresses[] | **[Address](#Address)**<br> The number of elements must be greater than 0.
ports[] | **int64**<br> The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address)**<br> 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address)**<br> 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address)**<br> 


### ExternalIpv4Address {#ExternalIpv4Address}

Field | Description
--- | ---
address | **string**<br> 


### InternalIpv4Address {#InternalIpv4Address}

Field | Description
--- | ---
address | **string**<br> 
subnet_id | **string**<br> 


### ExternalIpv6Address {#ExternalIpv6Address}

Field | Description
--- | ---
address | **string**<br> 


### HttpListener {#HttpListener}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler)**<br>Sets plaintext HTTP router, optional. 
redirects | **[Redirects](#Redirects)**<br>Shortcut for adding http -> https redirects, can be used instead of the HttpHandler above. 


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### Redirects {#Redirects}

Field | Description
--- | ---
http_to_https | **bool**<br>Adds "*" VirtualHost with a http -> https redirect. 


### TlsListener {#TlsListener}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler)**<br>Required.  
sni_handlers[] | **[SniMatch](#SniMatch)**<br> 


### TlsHandler {#TlsHandler}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler1)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler1}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options1)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options1}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### SniMatch {#SniMatch}

Field | Description
--- | ---
name | **string**<br>Required.  
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler1)**<br>Required.  


### TlsHandler {#TlsHandler1}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler2)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler2}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options2)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options2}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### AllocationPolicy {#AllocationPolicy}

Field | Description
--- | ---
locations[] | **[Location](#Location)**<br> The minimum number of elements is 1.


### Location {#Location}

Field | Description
--- | ---
zone_id | **string**<br>Required.  
subnet_id | **string**<br> 
disable_traffic | **bool**<br>If set, will disable all L7 instances in the zone for request handling. 


## List {#List}



**rpc List ([ListLoadBalancersRequest](#ListLoadBalancersRequest)) returns ([ListLoadBalancersResponse](#ListLoadBalancersResponse))**

### ListLoadBalancersRequest {#ListLoadBalancersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required.  
page_size | **int64**<br> Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br> The maximum string length in characters is 100.
filter | **string**<br> The maximum string length in characters is 1000.


### ListLoadBalancersResponse {#ListLoadBalancersResponse}

Field | Description
--- | ---
load_balancers[] | **[LoadBalancer](#LoadBalancer1)**<br> 
next_page_token | **string**<br> 


### LoadBalancer {#LoadBalancer1}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the load balancer. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the load balancer. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the load balancer belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: Application load balancer is being created.</li><li>`STARTING`: Application load balancer is being started.</li><li>`ACTIVE`: Application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: Application load balancer is being stopped.</li><li>`STOPPED`: Application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: Application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the load balancer located at. 
network_id | **string**<br>ID of the network that the load balancer located at. 
listeners[] | **[Listener](#Listener1)**<br>List of listeners for the application load balancer. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy1)**<br>Allocation sites for application load balancer instances. 
log_group_id | **string**<br>Cloud log group used by the load balancer to store access logs. 
security_group_ids[] | **string**<br>ID's of security groups attached to the load balancer. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the load balancer. 


### Listener {#Listener1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. 
endpoints[] | **[Endpoint](#Endpoint1)**<br>Network endpoints (addresses and ports) of the listener. 
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](#HttpListener1)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener1)**<br> 


### Endpoint {#Endpoint1}

Field | Description
--- | ---
addresses[] | **[Address](#Address1)**<br> The number of elements must be greater than 0.
ports[] | **int64**<br> The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address1}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address1)**<br> 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address1)**<br> 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address1)**<br> 


### ExternalIpv4Address {#ExternalIpv4Address1}

Field | Description
--- | ---
address | **string**<br> 


### InternalIpv4Address {#InternalIpv4Address1}

Field | Description
--- | ---
address | **string**<br> 
subnet_id | **string**<br> 


### ExternalIpv6Address {#ExternalIpv6Address1}

Field | Description
--- | ---
address | **string**<br> 


### HttpListener {#HttpListener1}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler3)**<br>Sets plaintext HTTP router, optional. 
redirects | **[Redirects](#Redirects1)**<br>Shortcut for adding http -> https redirects, can be used instead of the HttpHandler above. 


### HttpHandler {#HttpHandler3}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options3)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options3}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### Redirects {#Redirects1}

Field | Description
--- | ---
http_to_https | **bool**<br>Adds "*" VirtualHost with a http -> https redirect. 


### TlsListener {#TlsListener1}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler2)**<br>Required.  
sni_handlers[] | **[SniMatch](#SniMatch1)**<br> 


### TlsHandler {#TlsHandler2}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler4)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler4}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options4)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options4}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### SniMatch {#SniMatch1}

Field | Description
--- | ---
name | **string**<br>Required.  
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler3)**<br>Required.  


### TlsHandler {#TlsHandler3}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler5)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler5}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options5)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options5}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### AllocationPolicy {#AllocationPolicy1}

Field | Description
--- | ---
locations[] | **[Location](#Location1)**<br> The minimum number of elements is 1.


### Location {#Location1}

Field | Description
--- | ---
zone_id | **string**<br>Required.  
subnet_id | **string**<br> 
disable_traffic | **bool**<br>If set, will disable all L7 instances in the zone for request handling. 


## Create {#Create}



**rpc Create ([CreateLoadBalancerRequest](#CreateLoadBalancerRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateLoadBalancerMetadata](#CreateLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](#LoadBalancer2)<br>

### CreateLoadBalancerRequest {#CreateLoadBalancerRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required.  
name | **string**<br> Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
region_id | **string**<br>Required.  
network_id | **string**<br>Required.  
listener_specs[] | **[ListenerSpec](#ListenerSpec)**<br> 
allocation_policy | **[AllocationPolicy](#AllocationPolicy2)**<br> 
security_group_ids[] | **string**<br> 


### ListenerSpec {#ListenerSpec}

Field | Description
--- | ---
name | **string**<br>Required.  Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
endpoint_specs[] | **[EndpointSpec](#EndpointSpec)**<br> The number of elements must be greater than 0.
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](#HttpListener2)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener2)**<br> 


### EndpointSpec {#EndpointSpec}

Field | Description
--- | ---
address_specs[] | **[AddressSpec](#AddressSpec)**<br> The number of elements must be greater than 0.
ports[] | **int64**<br> The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### AddressSpec {#AddressSpec}

Field | Description
--- | ---
address_spec | **oneof:** `external_ipv4_address_spec`, `internal_ipv4_address_spec` or `external_ipv6_address_spec`<br>
&nbsp;&nbsp;external_ipv4_address_spec | **[ExternalIpv4AddressSpec](#ExternalIpv4AddressSpec)**<br> 
&nbsp;&nbsp;internal_ipv4_address_spec | **[InternalIpv4AddressSpec](#InternalIpv4AddressSpec)**<br> 
&nbsp;&nbsp;external_ipv6_address_spec | **[ExternalIpv6AddressSpec](#ExternalIpv6AddressSpec)**<br> 


### ExternalIpv4AddressSpec {#ExternalIpv4AddressSpec}

Field | Description
--- | ---
address | **string**<br> 


### InternalIpv4AddressSpec {#InternalIpv4AddressSpec}

Field | Description
--- | ---
address | **string**<br> 
subnet_id | **string**<br> 


### ExternalIpv6AddressSpec {#ExternalIpv6AddressSpec}

Field | Description
--- | ---
address | **string**<br> 


### HttpListener {#HttpListener2}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler6)**<br>Sets plaintext HTTP router, optional. 
redirects | **[Redirects](#Redirects2)**<br>Shortcut for adding http -> https redirects, can be used instead of the HttpHandler above. 


### HttpHandler {#HttpHandler6}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options6)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options6}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### Redirects {#Redirects2}

Field | Description
--- | ---
http_to_https | **bool**<br>Adds "*" VirtualHost with a http -> https redirect. 


### TlsListener {#TlsListener2}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler4)**<br>Required.  
sni_handlers[] | **[SniMatch](#SniMatch2)**<br> 


### TlsHandler {#TlsHandler4}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler7)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler7}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options7)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options7}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### SniMatch {#SniMatch2}

Field | Description
--- | ---
name | **string**<br>Required.  
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler5)**<br>Required.  


### TlsHandler {#TlsHandler5}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler8)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler8}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options8)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options8}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### AllocationPolicy {#AllocationPolicy2}

Field | Description
--- | ---
locations[] | **[Location](#Location2)**<br> The minimum number of elements is 1.


### Location {#Location2}

Field | Description
--- | ---
zone_id | **string**<br>Required.  
subnet_id | **string**<br> 
disable_traffic | **bool**<br>If set, will disable all L7 instances in the zone for request handling. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateLoadBalancerMetadata](#CreateLoadBalancerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LoadBalancer](#LoadBalancer2)>**<br>if operation finished successfully. 


### CreateLoadBalancerMetadata {#CreateLoadBalancerMetadata}

Field | Description
--- | ---
load_balancer_id | **string**<br> 


### LoadBalancer {#LoadBalancer2}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the load balancer. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the load balancer. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the load balancer belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: Application load balancer is being created.</li><li>`STARTING`: Application load balancer is being started.</li><li>`ACTIVE`: Application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: Application load balancer is being stopped.</li><li>`STOPPED`: Application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: Application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the load balancer located at. 
network_id | **string**<br>ID of the network that the load balancer located at. 
listeners[] | **[Listener](#Listener2)**<br>List of listeners for the application load balancer. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy3)**<br>Allocation sites for application load balancer instances. 
log_group_id | **string**<br>Cloud log group used by the load balancer to store access logs. 
security_group_ids[] | **string**<br>ID's of security groups attached to the load balancer. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the load balancer. 


### Listener {#Listener2}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. 
endpoints[] | **[Endpoint](#Endpoint2)**<br>Network endpoints (addresses and ports) of the listener. 
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](#HttpListener3)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener3)**<br> 


### Endpoint {#Endpoint2}

Field | Description
--- | ---
addresses[] | **[Address](#Address2)**<br> The number of elements must be greater than 0.
ports[] | **int64**<br> The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address2}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address2)**<br> 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address2)**<br> 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address2)**<br> 


### ExternalIpv4Address {#ExternalIpv4Address2}

Field | Description
--- | ---
address | **string**<br> 


### InternalIpv4Address {#InternalIpv4Address2}

Field | Description
--- | ---
address | **string**<br> 
subnet_id | **string**<br> 


### ExternalIpv6Address {#ExternalIpv6Address2}

Field | Description
--- | ---
address | **string**<br> 


### HttpListener {#HttpListener3}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler9)**<br>Sets plaintext HTTP router, optional. 
redirects | **[Redirects](#Redirects3)**<br>Shortcut for adding http -> https redirects, can be used instead of the HttpHandler above. 


### HttpHandler {#HttpHandler9}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options9)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options9}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### Redirects {#Redirects3}

Field | Description
--- | ---
http_to_https | **bool**<br>Adds "*" VirtualHost with a http -> https redirect. 


### TlsListener {#TlsListener3}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler6)**<br>Required.  
sni_handlers[] | **[SniMatch](#SniMatch3)**<br> 


### TlsHandler {#TlsHandler6}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler10)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler10}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options10)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options10}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### SniMatch {#SniMatch3}

Field | Description
--- | ---
name | **string**<br>Required.  
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler7)**<br>Required.  


### TlsHandler {#TlsHandler7}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler11)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler11}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options11)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options11}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### AllocationPolicy {#AllocationPolicy3}

Field | Description
--- | ---
locations[] | **[Location](#Location3)**<br> The minimum number of elements is 1.


### Location {#Location3}

Field | Description
--- | ---
zone_id | **string**<br>Required.  
subnet_id | **string**<br> 
disable_traffic | **bool**<br>If set, will disable all L7 instances in the zone for request handling. 


## Update {#Update}



**rpc Update ([UpdateLoadBalancerRequest](#UpdateLoadBalancerRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateLoadBalancerMetadata](#UpdateLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](#LoadBalancer3)<br>

### UpdateLoadBalancerRequest {#UpdateLoadBalancerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
name | **string**<br> Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
listener_specs[] | **[ListenerSpec](#ListenerSpec)**<br> 
allocation_policy | **[AllocationPolicy](#AllocationPolicy4)**<br> 
security_group_ids[] | **string**<br> 


### ListenerSpec {#ListenerSpec1}

Field | Description
--- | ---
name | **string**<br>Required.  Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
endpoint_specs[] | **[EndpointSpec](#EndpointSpec)**<br> The number of elements must be greater than 0.
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](#HttpListener4)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener4)**<br> 


### EndpointSpec {#EndpointSpec1}

Field | Description
--- | ---
address_specs[] | **[AddressSpec](#AddressSpec)**<br> The number of elements must be greater than 0.
ports[] | **int64**<br> The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### AddressSpec {#AddressSpec1}

Field | Description
--- | ---
address_spec | **oneof:** `external_ipv4_address_spec`, `internal_ipv4_address_spec` or `external_ipv6_address_spec`<br>
&nbsp;&nbsp;external_ipv4_address_spec | **[ExternalIpv4AddressSpec](#ExternalIpv4AddressSpec)**<br> 
&nbsp;&nbsp;internal_ipv4_address_spec | **[InternalIpv4AddressSpec](#InternalIpv4AddressSpec)**<br> 
&nbsp;&nbsp;external_ipv6_address_spec | **[ExternalIpv6AddressSpec](#ExternalIpv6AddressSpec)**<br> 


### ExternalIpv4AddressSpec {#ExternalIpv4AddressSpec1}

Field | Description
--- | ---
address | **string**<br> 


### InternalIpv4AddressSpec {#InternalIpv4AddressSpec1}

Field | Description
--- | ---
address | **string**<br> 
subnet_id | **string**<br> 


### ExternalIpv6AddressSpec {#ExternalIpv6AddressSpec1}

Field | Description
--- | ---
address | **string**<br> 


### HttpListener {#HttpListener4}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler12)**<br>Sets plaintext HTTP router, optional. 
redirects | **[Redirects](#Redirects4)**<br>Shortcut for adding http -> https redirects, can be used instead of the HttpHandler above. 


### HttpHandler {#HttpHandler12}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options12)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options12}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### Redirects {#Redirects4}

Field | Description
--- | ---
http_to_https | **bool**<br>Adds "*" VirtualHost with a http -> https redirect. 


### TlsListener {#TlsListener4}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler8)**<br>Required.  
sni_handlers[] | **[SniMatch](#SniMatch4)**<br> 


### TlsHandler {#TlsHandler8}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler13)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler13}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options13)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options13}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### SniMatch {#SniMatch4}

Field | Description
--- | ---
name | **string**<br>Required.  
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler9)**<br>Required.  


### TlsHandler {#TlsHandler9}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler14)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler14}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options14)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options14}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### AllocationPolicy {#AllocationPolicy4}

Field | Description
--- | ---
locations[] | **[Location](#Location4)**<br> The minimum number of elements is 1.


### Location {#Location4}

Field | Description
--- | ---
zone_id | **string**<br>Required.  
subnet_id | **string**<br> 
disable_traffic | **bool**<br>If set, will disable all L7 instances in the zone for request handling. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateLoadBalancerMetadata](#UpdateLoadBalancerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LoadBalancer](#LoadBalancer3)>**<br>if operation finished successfully. 


### UpdateLoadBalancerMetadata {#UpdateLoadBalancerMetadata}

Field | Description
--- | ---
load_balancer_id | **string**<br> 


### LoadBalancer {#LoadBalancer3}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the load balancer. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the load balancer. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the load balancer belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: Application load balancer is being created.</li><li>`STARTING`: Application load balancer is being started.</li><li>`ACTIVE`: Application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: Application load balancer is being stopped.</li><li>`STOPPED`: Application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: Application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the load balancer located at. 
network_id | **string**<br>ID of the network that the load balancer located at. 
listeners[] | **[Listener](#Listener3)**<br>List of listeners for the application load balancer. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy5)**<br>Allocation sites for application load balancer instances. 
log_group_id | **string**<br>Cloud log group used by the load balancer to store access logs. 
security_group_ids[] | **string**<br>ID's of security groups attached to the load balancer. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the load balancer. 


### Listener {#Listener3}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. 
endpoints[] | **[Endpoint](#Endpoint3)**<br>Network endpoints (addresses and ports) of the listener. 
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](#HttpListener5)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener5)**<br> 


### Endpoint {#Endpoint3}

Field | Description
--- | ---
addresses[] | **[Address](#Address3)**<br> The number of elements must be greater than 0.
ports[] | **int64**<br> The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address3}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address3)**<br> 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address3)**<br> 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address3)**<br> 


### ExternalIpv4Address {#ExternalIpv4Address3}

Field | Description
--- | ---
address | **string**<br> 


### InternalIpv4Address {#InternalIpv4Address3}

Field | Description
--- | ---
address | **string**<br> 
subnet_id | **string**<br> 


### ExternalIpv6Address {#ExternalIpv6Address3}

Field | Description
--- | ---
address | **string**<br> 


### HttpListener {#HttpListener5}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler15)**<br>Sets plaintext HTTP router, optional. 
redirects | **[Redirects](#Redirects5)**<br>Shortcut for adding http -> https redirects, can be used instead of the HttpHandler above. 


### HttpHandler {#HttpHandler15}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options15)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options15}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### Redirects {#Redirects5}

Field | Description
--- | ---
http_to_https | **bool**<br>Adds "*" VirtualHost with a http -> https redirect. 


### TlsListener {#TlsListener5}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler10)**<br>Required.  
sni_handlers[] | **[SniMatch](#SniMatch5)**<br> 


### TlsHandler {#TlsHandler10}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler16)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler16}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options16)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options16}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### SniMatch {#SniMatch5}

Field | Description
--- | ---
name | **string**<br>Required.  
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler11)**<br>Required.  


### TlsHandler {#TlsHandler11}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler17)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler17}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options17)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options17}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### AllocationPolicy {#AllocationPolicy5}

Field | Description
--- | ---
locations[] | **[Location](#Location5)**<br> The minimum number of elements is 1.


### Location {#Location5}

Field | Description
--- | ---
zone_id | **string**<br>Required.  
subnet_id | **string**<br> 
disable_traffic | **bool**<br>If set, will disable all L7 instances in the zone for request handling. 


## Delete {#Delete}



**rpc Delete ([DeleteLoadBalancerRequest](#DeleteLoadBalancerRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteLoadBalancerMetadata](#DeleteLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteLoadBalancerRequest {#DeleteLoadBalancerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteLoadBalancerMetadata](#DeleteLoadBalancerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteLoadBalancerMetadata {#DeleteLoadBalancerMetadata}

Field | Description
--- | ---
load_balancer_id | **string**<br> 


## Start {#Start}



**rpc Start ([StartLoadBalancerRequest](#StartLoadBalancerRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartLoadBalancerMetadata](#StartLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](#LoadBalancer4)<br>

### StartLoadBalancerRequest {#StartLoadBalancerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartLoadBalancerMetadata](#StartLoadBalancerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LoadBalancer](#LoadBalancer4)>**<br>if operation finished successfully. 


### StartLoadBalancerMetadata {#StartLoadBalancerMetadata}

Field | Description
--- | ---
load_balancer_id | **string**<br> 


### LoadBalancer {#LoadBalancer4}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the load balancer. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the load balancer. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the load balancer belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: Application load balancer is being created.</li><li>`STARTING`: Application load balancer is being started.</li><li>`ACTIVE`: Application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: Application load balancer is being stopped.</li><li>`STOPPED`: Application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: Application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the load balancer located at. 
network_id | **string**<br>ID of the network that the load balancer located at. 
listeners[] | **[Listener](#Listener4)**<br>List of listeners for the application load balancer. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy6)**<br>Allocation sites for application load balancer instances. 
log_group_id | **string**<br>Cloud log group used by the load balancer to store access logs. 
security_group_ids[] | **string**<br>ID's of security groups attached to the load balancer. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the load balancer. 


### Listener {#Listener4}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. 
endpoints[] | **[Endpoint](#Endpoint4)**<br>Network endpoints (addresses and ports) of the listener. 
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](#HttpListener6)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener6)**<br> 


### Endpoint {#Endpoint4}

Field | Description
--- | ---
addresses[] | **[Address](#Address4)**<br> The number of elements must be greater than 0.
ports[] | **int64**<br> The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address4}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address4)**<br> 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address4)**<br> 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address4)**<br> 


### ExternalIpv4Address {#ExternalIpv4Address4}

Field | Description
--- | ---
address | **string**<br> 


### InternalIpv4Address {#InternalIpv4Address4}

Field | Description
--- | ---
address | **string**<br> 
subnet_id | **string**<br> 


### ExternalIpv6Address {#ExternalIpv6Address4}

Field | Description
--- | ---
address | **string**<br> 


### HttpListener {#HttpListener6}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler18)**<br>Sets plaintext HTTP router, optional. 
redirects | **[Redirects](#Redirects6)**<br>Shortcut for adding http -> https redirects, can be used instead of the HttpHandler above. 


### HttpHandler {#HttpHandler18}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options18)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options18}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### Redirects {#Redirects6}

Field | Description
--- | ---
http_to_https | **bool**<br>Adds "*" VirtualHost with a http -> https redirect. 


### TlsListener {#TlsListener6}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler12)**<br>Required.  
sni_handlers[] | **[SniMatch](#SniMatch6)**<br> 


### TlsHandler {#TlsHandler12}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler19)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler19}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options19)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options19}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### SniMatch {#SniMatch6}

Field | Description
--- | ---
name | **string**<br>Required.  
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler13)**<br>Required.  


### TlsHandler {#TlsHandler13}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler20)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler20}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options20)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options20}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### AllocationPolicy {#AllocationPolicy6}

Field | Description
--- | ---
locations[] | **[Location](#Location6)**<br> The minimum number of elements is 1.


### Location {#Location6}

Field | Description
--- | ---
zone_id | **string**<br>Required.  
subnet_id | **string**<br> 
disable_traffic | **bool**<br>If set, will disable all L7 instances in the zone for request handling. 


## Stop {#Stop}



**rpc Stop ([StopLoadBalancerRequest](#StopLoadBalancerRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopLoadBalancerMetadata](#StopLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](#LoadBalancer5)<br>

### StopLoadBalancerRequest {#StopLoadBalancerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopLoadBalancerMetadata](#StopLoadBalancerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LoadBalancer](#LoadBalancer5)>**<br>if operation finished successfully. 


### StopLoadBalancerMetadata {#StopLoadBalancerMetadata}

Field | Description
--- | ---
load_balancer_id | **string**<br> 


### LoadBalancer {#LoadBalancer5}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the load balancer. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the load balancer. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the load balancer belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: Application load balancer is being created.</li><li>`STARTING`: Application load balancer is being started.</li><li>`ACTIVE`: Application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: Application load balancer is being stopped.</li><li>`STOPPED`: Application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: Application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the load balancer located at. 
network_id | **string**<br>ID of the network that the load balancer located at. 
listeners[] | **[Listener](#Listener5)**<br>List of listeners for the application load balancer. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy7)**<br>Allocation sites for application load balancer instances. 
log_group_id | **string**<br>Cloud log group used by the load balancer to store access logs. 
security_group_ids[] | **string**<br>ID's of security groups attached to the load balancer. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the load balancer. 


### Listener {#Listener5}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. 
endpoints[] | **[Endpoint](#Endpoint5)**<br>Network endpoints (addresses and ports) of the listener. 
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](#HttpListener7)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener7)**<br> 


### Endpoint {#Endpoint5}

Field | Description
--- | ---
addresses[] | **[Address](#Address5)**<br> The number of elements must be greater than 0.
ports[] | **int64**<br> The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address5}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address5)**<br> 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address5)**<br> 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address5)**<br> 


### ExternalIpv4Address {#ExternalIpv4Address5}

Field | Description
--- | ---
address | **string**<br> 


### InternalIpv4Address {#InternalIpv4Address5}

Field | Description
--- | ---
address | **string**<br> 
subnet_id | **string**<br> 


### ExternalIpv6Address {#ExternalIpv6Address5}

Field | Description
--- | ---
address | **string**<br> 


### HttpListener {#HttpListener7}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler21)**<br>Sets plaintext HTTP router, optional. 
redirects | **[Redirects](#Redirects7)**<br>Shortcut for adding http -> https redirects, can be used instead of the HttpHandler above. 


### HttpHandler {#HttpHandler21}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options21)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options21}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### Redirects {#Redirects7}

Field | Description
--- | ---
http_to_https | **bool**<br>Adds "*" VirtualHost with a http -> https redirect. 


### TlsListener {#TlsListener7}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler14)**<br>Required.  
sni_handlers[] | **[SniMatch](#SniMatch7)**<br> 


### TlsHandler {#TlsHandler14}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler22)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler22}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options22)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options22}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### SniMatch {#SniMatch7}

Field | Description
--- | ---
name | **string**<br>Required.  
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler15)**<br>Required.  


### TlsHandler {#TlsHandler15}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler23)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler23}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options23)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options23}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### AllocationPolicy {#AllocationPolicy7}

Field | Description
--- | ---
locations[] | **[Location](#Location7)**<br> The minimum number of elements is 1.


### Location {#Location7}

Field | Description
--- | ---
zone_id | **string**<br>Required.  
subnet_id | **string**<br> 
disable_traffic | **bool**<br>If set, will disable all L7 instances in the zone for request handling. 


## AddListener {#AddListener}

AddListener/UpdateListener technically do the same, but have different semantics.

**rpc AddListener ([AddListenerRequest](#AddListenerRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddListenerMetadata](#AddListenerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](#LoadBalancer6)<br>

### AddListenerRequest {#AddListenerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  
listener_spec | **[ListenerSpec](#ListenerSpec)**<br>Required.  


### ListenerSpec {#ListenerSpec2}

Field | Description
--- | ---
name | **string**<br>Required.  Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
endpoint_specs[] | **[EndpointSpec](#EndpointSpec)**<br> The number of elements must be greater than 0.
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](#HttpListener8)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener8)**<br> 


### EndpointSpec {#EndpointSpec2}

Field | Description
--- | ---
address_specs[] | **[AddressSpec](#AddressSpec)**<br> The number of elements must be greater than 0.
ports[] | **int64**<br> The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### AddressSpec {#AddressSpec2}

Field | Description
--- | ---
address_spec | **oneof:** `external_ipv4_address_spec`, `internal_ipv4_address_spec` or `external_ipv6_address_spec`<br>
&nbsp;&nbsp;external_ipv4_address_spec | **[ExternalIpv4AddressSpec](#ExternalIpv4AddressSpec)**<br> 
&nbsp;&nbsp;internal_ipv4_address_spec | **[InternalIpv4AddressSpec](#InternalIpv4AddressSpec)**<br> 
&nbsp;&nbsp;external_ipv6_address_spec | **[ExternalIpv6AddressSpec](#ExternalIpv6AddressSpec)**<br> 


### ExternalIpv4AddressSpec {#ExternalIpv4AddressSpec2}

Field | Description
--- | ---
address | **string**<br> 


### InternalIpv4AddressSpec {#InternalIpv4AddressSpec2}

Field | Description
--- | ---
address | **string**<br> 
subnet_id | **string**<br> 


### ExternalIpv6AddressSpec {#ExternalIpv6AddressSpec2}

Field | Description
--- | ---
address | **string**<br> 


### HttpListener {#HttpListener8}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler24)**<br>Sets plaintext HTTP router, optional. 
redirects | **[Redirects](#Redirects8)**<br>Shortcut for adding http -> https redirects, can be used instead of the HttpHandler above. 


### HttpHandler {#HttpHandler24}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options24)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options24}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### Redirects {#Redirects8}

Field | Description
--- | ---
http_to_https | **bool**<br>Adds "*" VirtualHost with a http -> https redirect. 


### TlsListener {#TlsListener8}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler16)**<br>Required.  
sni_handlers[] | **[SniMatch](#SniMatch8)**<br> 


### TlsHandler {#TlsHandler16}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler25)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler25}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options25)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options25}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### SniMatch {#SniMatch8}

Field | Description
--- | ---
name | **string**<br>Required.  
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler17)**<br>Required.  


### TlsHandler {#TlsHandler17}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler26)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler26}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options26)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options26}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddListenerMetadata](#AddListenerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LoadBalancer](#LoadBalancer6)>**<br>if operation finished successfully. 


### AddListenerMetadata {#AddListenerMetadata}

Field | Description
--- | ---
load_balancer_id | **string**<br> 
listener_name | **string**<br> 


### LoadBalancer {#LoadBalancer6}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the load balancer. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the load balancer. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the load balancer belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: Application load balancer is being created.</li><li>`STARTING`: Application load balancer is being started.</li><li>`ACTIVE`: Application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: Application load balancer is being stopped.</li><li>`STOPPED`: Application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: Application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the load balancer located at. 
network_id | **string**<br>ID of the network that the load balancer located at. 
listeners[] | **[Listener](#Listener6)**<br>List of listeners for the application load balancer. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy8)**<br>Allocation sites for application load balancer instances. 
log_group_id | **string**<br>Cloud log group used by the load balancer to store access logs. 
security_group_ids[] | **string**<br>ID's of security groups attached to the load balancer. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the load balancer. 


### Listener {#Listener6}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. 
endpoints[] | **[Endpoint](#Endpoint6)**<br>Network endpoints (addresses and ports) of the listener. 
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](#HttpListener9)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener9)**<br> 


### Endpoint {#Endpoint6}

Field | Description
--- | ---
addresses[] | **[Address](#Address6)**<br> The number of elements must be greater than 0.
ports[] | **int64**<br> The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address6}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address6)**<br> 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address6)**<br> 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address6)**<br> 


### ExternalIpv4Address {#ExternalIpv4Address6}

Field | Description
--- | ---
address | **string**<br> 


### InternalIpv4Address {#InternalIpv4Address6}

Field | Description
--- | ---
address | **string**<br> 
subnet_id | **string**<br> 


### ExternalIpv6Address {#ExternalIpv6Address6}

Field | Description
--- | ---
address | **string**<br> 


### HttpListener {#HttpListener9}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler27)**<br>Sets plaintext HTTP router, optional. 
redirects | **[Redirects](#Redirects9)**<br>Shortcut for adding http -> https redirects, can be used instead of the HttpHandler above. 


### HttpHandler {#HttpHandler27}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options27)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options27}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### Redirects {#Redirects9}

Field | Description
--- | ---
http_to_https | **bool**<br>Adds "*" VirtualHost with a http -> https redirect. 


### TlsListener {#TlsListener9}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler18)**<br>Required.  
sni_handlers[] | **[SniMatch](#SniMatch9)**<br> 


### TlsHandler {#TlsHandler18}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler28)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler28}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options28)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options28}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### SniMatch {#SniMatch9}

Field | Description
--- | ---
name | **string**<br>Required.  
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler19)**<br>Required.  


### TlsHandler {#TlsHandler19}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler29)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler29}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options29)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options29}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### AllocationPolicy {#AllocationPolicy8}

Field | Description
--- | ---
locations[] | **[Location](#Location8)**<br> The minimum number of elements is 1.


### Location {#Location8}

Field | Description
--- | ---
zone_id | **string**<br>Required.  
subnet_id | **string**<br> 
disable_traffic | **bool**<br>If set, will disable all L7 instances in the zone for request handling. 


## RemoveListener {#RemoveListener}



**rpc RemoveListener ([RemoveListenerRequest](#RemoveListenerRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveListenerMetadata](#RemoveListenerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](#LoadBalancer7)<br>

### RemoveListenerRequest {#RemoveListenerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  
name | **string**<br>Required.  


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RemoveListenerMetadata](#RemoveListenerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LoadBalancer](#LoadBalancer7)>**<br>if operation finished successfully. 


### RemoveListenerMetadata {#RemoveListenerMetadata}

Field | Description
--- | ---
load_balancer_id | **string**<br> 
listener_name | **string**<br> 


### LoadBalancer {#LoadBalancer7}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the load balancer. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the load balancer. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the load balancer belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: Application load balancer is being created.</li><li>`STARTING`: Application load balancer is being started.</li><li>`ACTIVE`: Application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: Application load balancer is being stopped.</li><li>`STOPPED`: Application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: Application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the load balancer located at. 
network_id | **string**<br>ID of the network that the load balancer located at. 
listeners[] | **[Listener](#Listener7)**<br>List of listeners for the application load balancer. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy9)**<br>Allocation sites for application load balancer instances. 
log_group_id | **string**<br>Cloud log group used by the load balancer to store access logs. 
security_group_ids[] | **string**<br>ID's of security groups attached to the load balancer. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the load balancer. 


### Listener {#Listener7}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. 
endpoints[] | **[Endpoint](#Endpoint7)**<br>Network endpoints (addresses and ports) of the listener. 
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](#HttpListener10)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener10)**<br> 


### Endpoint {#Endpoint7}

Field | Description
--- | ---
addresses[] | **[Address](#Address7)**<br> The number of elements must be greater than 0.
ports[] | **int64**<br> The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address7}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address7)**<br> 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address7)**<br> 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address7)**<br> 


### ExternalIpv4Address {#ExternalIpv4Address7}

Field | Description
--- | ---
address | **string**<br> 


### InternalIpv4Address {#InternalIpv4Address7}

Field | Description
--- | ---
address | **string**<br> 
subnet_id | **string**<br> 


### ExternalIpv6Address {#ExternalIpv6Address7}

Field | Description
--- | ---
address | **string**<br> 


### HttpListener {#HttpListener10}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler30)**<br>Sets plaintext HTTP router, optional. 
redirects | **[Redirects](#Redirects10)**<br>Shortcut for adding http -> https redirects, can be used instead of the HttpHandler above. 


### HttpHandler {#HttpHandler30}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options30)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options30}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### Redirects {#Redirects10}

Field | Description
--- | ---
http_to_https | **bool**<br>Adds "*" VirtualHost with a http -> https redirect. 


### TlsListener {#TlsListener10}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler20)**<br>Required.  
sni_handlers[] | **[SniMatch](#SniMatch10)**<br> 


### TlsHandler {#TlsHandler20}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler31)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler31}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options31)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options31}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### SniMatch {#SniMatch10}

Field | Description
--- | ---
name | **string**<br>Required.  
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler21)**<br>Required.  


### TlsHandler {#TlsHandler21}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler32)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler32}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options32)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options32}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### AllocationPolicy {#AllocationPolicy9}

Field | Description
--- | ---
locations[] | **[Location](#Location9)**<br> The minimum number of elements is 1.


### Location {#Location9}

Field | Description
--- | ---
zone_id | **string**<br>Required.  
subnet_id | **string**<br> 
disable_traffic | **bool**<br>If set, will disable all L7 instances in the zone for request handling. 


## UpdateListener {#UpdateListener}



**rpc UpdateListener ([UpdateListenerRequest](#UpdateListenerRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateListenerMetadata](#UpdateListenerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](#LoadBalancer8)<br>

### UpdateListenerRequest {#UpdateListenerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
listener_spec | **[ListenerSpec](#ListenerSpec)**<br>Required.  


### ListenerSpec {#ListenerSpec3}

Field | Description
--- | ---
name | **string**<br>Required.  Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
endpoint_specs[] | **[EndpointSpec](#EndpointSpec)**<br> The number of elements must be greater than 0.
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](#HttpListener11)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener11)**<br> 


### EndpointSpec {#EndpointSpec3}

Field | Description
--- | ---
address_specs[] | **[AddressSpec](#AddressSpec)**<br> The number of elements must be greater than 0.
ports[] | **int64**<br> The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### AddressSpec {#AddressSpec3}

Field | Description
--- | ---
address_spec | **oneof:** `external_ipv4_address_spec`, `internal_ipv4_address_spec` or `external_ipv6_address_spec`<br>
&nbsp;&nbsp;external_ipv4_address_spec | **[ExternalIpv4AddressSpec](#ExternalIpv4AddressSpec)**<br> 
&nbsp;&nbsp;internal_ipv4_address_spec | **[InternalIpv4AddressSpec](#InternalIpv4AddressSpec)**<br> 
&nbsp;&nbsp;external_ipv6_address_spec | **[ExternalIpv6AddressSpec](#ExternalIpv6AddressSpec)**<br> 


### ExternalIpv4AddressSpec {#ExternalIpv4AddressSpec3}

Field | Description
--- | ---
address | **string**<br> 


### InternalIpv4AddressSpec {#InternalIpv4AddressSpec3}

Field | Description
--- | ---
address | **string**<br> 
subnet_id | **string**<br> 


### ExternalIpv6AddressSpec {#ExternalIpv6AddressSpec3}

Field | Description
--- | ---
address | **string**<br> 


### HttpListener {#HttpListener11}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler33)**<br>Sets plaintext HTTP router, optional. 
redirects | **[Redirects](#Redirects11)**<br>Shortcut for adding http -> https redirects, can be used instead of the HttpHandler above. 


### HttpHandler {#HttpHandler33}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options33)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options33}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### Redirects {#Redirects11}

Field | Description
--- | ---
http_to_https | **bool**<br>Adds "*" VirtualHost with a http -> https redirect. 


### TlsListener {#TlsListener11}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler22)**<br>Required.  
sni_handlers[] | **[SniMatch](#SniMatch11)**<br> 


### TlsHandler {#TlsHandler22}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler34)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler34}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options34)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options34}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### SniMatch {#SniMatch11}

Field | Description
--- | ---
name | **string**<br>Required.  
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler23)**<br>Required.  


### TlsHandler {#TlsHandler23}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler35)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler35}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options35)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options35}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### Operation {#Operation7}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateListenerMetadata](#UpdateListenerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LoadBalancer](#LoadBalancer8)>**<br>if operation finished successfully. 


### UpdateListenerMetadata {#UpdateListenerMetadata}

Field | Description
--- | ---
load_balancer_id | **string**<br> 
listener_name | **string**<br> 


### LoadBalancer {#LoadBalancer8}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the load balancer. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the load balancer. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the load balancer belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: Application load balancer is being created.</li><li>`STARTING`: Application load balancer is being started.</li><li>`ACTIVE`: Application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: Application load balancer is being stopped.</li><li>`STOPPED`: Application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: Application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the load balancer located at. 
network_id | **string**<br>ID of the network that the load balancer located at. 
listeners[] | **[Listener](#Listener8)**<br>List of listeners for the application load balancer. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy10)**<br>Allocation sites for application load balancer instances. 
log_group_id | **string**<br>Cloud log group used by the load balancer to store access logs. 
security_group_ids[] | **string**<br>ID's of security groups attached to the load balancer. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the load balancer. 


### Listener {#Listener8}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. 
endpoints[] | **[Endpoint](#Endpoint8)**<br>Network endpoints (addresses and ports) of the listener. 
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](#HttpListener12)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener12)**<br> 


### Endpoint {#Endpoint8}

Field | Description
--- | ---
addresses[] | **[Address](#Address8)**<br> The number of elements must be greater than 0.
ports[] | **int64**<br> The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address8}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address8)**<br> 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address8)**<br> 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address8)**<br> 


### ExternalIpv4Address {#ExternalIpv4Address8}

Field | Description
--- | ---
address | **string**<br> 


### InternalIpv4Address {#InternalIpv4Address8}

Field | Description
--- | ---
address | **string**<br> 
subnet_id | **string**<br> 


### ExternalIpv6Address {#ExternalIpv6Address8}

Field | Description
--- | ---
address | **string**<br> 


### HttpListener {#HttpListener12}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler36)**<br>Sets plaintext HTTP router, optional. 
redirects | **[Redirects](#Redirects12)**<br>Shortcut for adding http -> https redirects, can be used instead of the HttpHandler above. 


### HttpHandler {#HttpHandler36}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options36)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options36}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### Redirects {#Redirects12}

Field | Description
--- | ---
http_to_https | **bool**<br>Adds "*" VirtualHost with a http -> https redirect. 


### TlsListener {#TlsListener12}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler24)**<br>Required.  
sni_handlers[] | **[SniMatch](#SniMatch12)**<br> 


### TlsHandler {#TlsHandler24}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler37)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler37}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options37)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options37}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### SniMatch {#SniMatch12}

Field | Description
--- | ---
name | **string**<br>Required.  
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler25)**<br>Required.  


### TlsHandler {#TlsHandler25}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler38)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler38}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options38)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options38}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### AllocationPolicy {#AllocationPolicy10}

Field | Description
--- | ---
locations[] | **[Location](#Location10)**<br> The minimum number of elements is 1.


### Location {#Location10}

Field | Description
--- | ---
zone_id | **string**<br>Required.  
subnet_id | **string**<br> 
disable_traffic | **bool**<br>If set, will disable all L7 instances in the zone for request handling. 


## AddSniMatch {#AddSniMatch}



**rpc AddSniMatch ([AddSniMatchRequest](#AddSniMatchRequest)) returns ([operation.Operation](#Operation8))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddSniMatchMetadata](#AddSniMatchMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddSniMatchRequest {#AddSniMatchRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  
listener_name | **string**<br>Required.  
name | **string**<br>Required.  
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler26)**<br>Required.  


### TlsHandler {#TlsHandler26}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler39)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler39}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options39)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options39}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### Operation {#Operation8}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddSniMatchMetadata](#AddSniMatchMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### AddSniMatchMetadata {#AddSniMatchMetadata}

Field | Description
--- | ---
load_balancer_id | **string**<br> 
listener_name | **string**<br> 
sni_match_name | **string**<br> 


## UpdateSniMatch {#UpdateSniMatch}



**rpc UpdateSniMatch ([UpdateSniMatchRequest](#UpdateSniMatchRequest)) returns ([operation.Operation](#Operation9))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSniMatchMetadata](#UpdateSniMatchMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateSniMatchRequest {#UpdateSniMatchRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  
listener_name | **string**<br>Required.  
name | **string**<br>Required.  
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler27)**<br>Required.  


### TlsHandler {#TlsHandler27}

Field | Description
--- | ---
handler | **oneof:** `http_handler`<br>
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler40)**<br> 
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler40}

Field | Description
--- | ---
http_router_id | **string**<br> 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options40)**<br>If set, will enable HTTP2 protocol for the handler. 
&nbsp;&nbsp;allow_http10 | **bool**<br>If set, will enable only HTTP1 protocol with HTTP1.0 support. 


### Http2Options {#Http2Options40}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### Operation {#Operation9}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSniMatchMetadata](#UpdateSniMatchMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### UpdateSniMatchMetadata {#UpdateSniMatchMetadata}

Field | Description
--- | ---
load_balancer_id | **string**<br> 
listener_name | **string**<br> 
sni_match_name | **string**<br> 


## RemoveSniMatch {#RemoveSniMatch}



**rpc RemoveSniMatch ([RemoveSniMatchRequest](#RemoveSniMatchRequest)) returns ([operation.Operation](#Operation10))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveSniMatchMetadata](#RemoveSniMatchMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### RemoveSniMatchRequest {#RemoveSniMatchRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  
listener_name | **string**<br>Required.  
sni_match_name | **string**<br>Required.  


### Operation {#Operation10}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RemoveSniMatchMetadata](#RemoveSniMatchMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### RemoveSniMatchMetadata {#RemoveSniMatchMetadata}

Field | Description
--- | ---
load_balancer_id | **string**<br> 
listener_name | **string**<br> 
sni_match_name | **string**<br> 


## GetTargetStates {#GetTargetStates}

Returns zonal state of each target within target group for a given backend group and load balancer.

**rpc GetTargetStates ([GetTargetStatesRequest](#GetTargetStatesRequest)) returns ([GetTargetStatesResponse](#GetTargetStatesResponse))**

### GetTargetStatesRequest {#GetTargetStatesRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  
backend_group_id | **string**<br>Required.  
target_group_id | **string**<br>Required.  


### GetTargetStatesResponse {#GetTargetStatesResponse}

Field | Description
--- | ---
target_states[] | **[TargetState](#TargetState)**<br> 


### TargetState {#TargetState}

Field | Description
--- | ---
status | **[HealthcheckStatus](#HealthcheckStatus)**<br>Statuses of the target for all known zones. 
target | **[Target](#Target)**<br>Required.  


### HealthcheckStatus {#HealthcheckStatus}

Field | Description
--- | ---
zone_statuses[] | **[ZoneHealthcheckStatus](#ZoneHealthcheckStatus)**<br> 


### ZoneHealthcheckStatus {#ZoneHealthcheckStatus}

Field | Description
--- | ---
zone_id | **string**<br>Required.  
status | **Status**<br>Healthcheck status of target for the specific zone. 
failed_active_hc | **bool**<br>Whether UNHEALTHY status was set due to failed active checks or not. 


### Target {#Target}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>
&nbsp;&nbsp;ip_address | **string**<br> 
subnet_id | **string**<br>ID of the subnet that target connected to. 


## ListOperations {#ListOperations}

Lists operations for the specified load balancer.

**rpc ListOperations ([ListLoadBalancerOperationsRequest](#ListLoadBalancerOperationsRequest)) returns ([ListLoadBalancerOperationsResponse](#ListLoadBalancerOperationsResponse))**

### ListLoadBalancerOperationsRequest {#ListLoadBalancerOperationsRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required. ID of the load balancer to get operations for. <br>To get the load balancer ID, use a [LoadBalancerService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListLoadBalancerOperationsResponse.next_page_token](#ListLoadBalancerOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListLoadBalancerOperationsResponse.next_page_token](#ListLoadBalancerOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListLoadBalancerOperationsResponse {#ListLoadBalancerOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation11)**<br>List of operations for the specified target group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListLoadBalancerOperationsRequest.page_size](#ListLoadBalancerOperationsRequest), use the `next_page_token` as the value for the [ListLoadBalancerOperationsRequest.page_token](#ListLoadBalancerOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation11}

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


