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
| [AddListener](#AddListener) | AddListener/UpdateListener technically do the same, but have different semantics. |
| [RemoveListener](#RemoveListener) |  |
| [UpdateListener](#UpdateListener) |  |
| [GetTargetStates](#GetTargetStates) | Returns zonal state of each target within target group for a given backend group and load balancer. |
| [ListOperations](#ListOperations) | Lists operations for the specified load balancer. |

## Calls LoadBalancerService {#calls}

## Get {#Get}



**rpc Get ([GetLoadBalancerRequest](#GetLoadBalancerRequest)) returns ([LoadBalancer](../load_balancer.proto#LoadBalancer))**

### GetLoadBalancerRequest {#GetLoadBalancerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  false


### LoadBalancer {#LoadBalancer}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the load balancer. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the load balancer. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the load balancer belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
listeners[] | **[Listener](../load_balancer.proto#Listener)**<br>List of listeners for the application load balancer. 
allocation_policy | **[AllocationPolicy](../load_balancer.proto#AllocationPolicy)**<br>Allocation sites for application load balancer instances. 
log_group_id | **string**<br> 
region_id | **string**<br> 


### Listener {#Listener}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. false
port | **int64**<br>Port. Acceptable values are 1 to 65535, inclusive.
address | **string**<br>IP address for the listener. 
subnet_id | **string**<br>ID of the subnet. 
ip_version | enum **IpVersion**<br> <ul><ul/>
type | enum **Type**<br> <ul><ul/>
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](../load_balancer.proto#HttpListener)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](../load_balancer.proto#TlsListener)**<br> 


### HttpListener {#HttpListener}

Field | Description
--- | ---
handler | **[HttpHandler](../load_balancer.proto#HttpHandler)**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### TlsListener {#TlsListener}

Field | Description
--- | ---
default_handler | **[TlsHandler](../load_balancer.proto#TlsHandler)**<br>Required.  false
sni_handlers[] | **[SniMatch](../load_balancer.proto#SniMatch)**<br> 


### TlsHandler {#TlsHandler}

Field | Description
--- | ---
handler | **oneof:** `stream_handler` or `http_handler`<br>
&nbsp;&nbsp;stream_handler | **[StreamHandler](../load_balancer.proto#StreamHandler)**<br> 
&nbsp;&nbsp;http_handler | **[HttpHandler](../load_balancer.proto#HttpHandler1)**<br> 
tls | **[ListenerTls](../load_balancer.proto#ListenerTls)**<br>Required.  false


### StreamHandler {#StreamHandler}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options1)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### ListenerTls {#ListenerTls}

Field | Description
--- | ---
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.
tls_options | **[TlsOptions](../tls.proto#TlsOptions)**<br> 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### SniMatch {#SniMatch}

Field | Description
--- | ---
name | **string**<br>Required.  false
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](../load_balancer.proto#TlsHandler1)**<br>Required.  false


### TlsHandler {#TlsHandler}

Field | Description
--- | ---
handler | **oneof:** `stream_handler` or `http_handler`<br>
&nbsp;&nbsp;stream_handler | **[StreamHandler](../load_balancer.proto#StreamHandler1)**<br> 
&nbsp;&nbsp;http_handler | **[HttpHandler](../load_balancer.proto#HttpHandler2)**<br> 
tls | **[ListenerTls](../load_balancer.proto#ListenerTls1)**<br>Required.  false


### StreamHandler {#StreamHandler}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options2)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### ListenerTls {#ListenerTls}

Field | Description
--- | ---
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.
tls_options | **[TlsOptions](../tls.proto#TlsOptions1)**<br> 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### AllocationPolicy {#AllocationPolicy}

Field | Description
--- | ---
locations[] | **[Location](../load_balancer.proto#Location)**<br> The minimum number of elements is 1. false


### Location {#Location}

Field | Description
--- | ---
zone_id | **string**<br>Required.  false
subnet_id | **string**<br> 
disable_traffic | **bool**<br>If set, will disable all L7 instances in the zone for request handling. 


## List {#List}



**rpc List ([ListLoadBalancersRequest](#ListLoadBalancersRequest)) returns ([ListLoadBalancersResponse](#ListLoadBalancersResponse))**

### ListLoadBalancersRequest {#ListLoadBalancersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required.  false
page_size | **int64**<br> Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br> The maximum string length in characters is 100.
filter | **string**<br> The maximum string length in characters is 1000.


### ListLoadBalancersResponse {#ListLoadBalancersResponse}

Field | Description
--- | ---
load_balancers[] | **[LoadBalancer](../load_balancer.proto#LoadBalancer1)**<br> 
next_page_token | **string**<br> 


### LoadBalancer {#LoadBalancer}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the load balancer. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the load balancer. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the load balancer belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
listeners[] | **[Listener](../load_balancer.proto#Listener1)**<br>List of listeners for the application load balancer. 
allocation_policy | **[AllocationPolicy](../load_balancer.proto#AllocationPolicy1)**<br>Allocation sites for application load balancer instances. 
log_group_id | **string**<br> 
region_id | **string**<br> 


### Listener {#Listener}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. false
port | **int64**<br>Port. Acceptable values are 1 to 65535, inclusive.
address | **string**<br>IP address for the listener. 
subnet_id | **string**<br>ID of the subnet. 
ip_version | enum **IpVersion**<br> <ul><ul/>
type | enum **Type**<br> <ul><ul/>
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](../load_balancer.proto#HttpListener1)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](../load_balancer.proto#TlsListener1)**<br> 


### HttpListener {#HttpListener}

Field | Description
--- | ---
handler | **[HttpHandler](../load_balancer.proto#HttpHandler3)**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options3)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### TlsListener {#TlsListener}

Field | Description
--- | ---
default_handler | **[TlsHandler](../load_balancer.proto#TlsHandler2)**<br>Required.  false
sni_handlers[] | **[SniMatch](../load_balancer.proto#SniMatch1)**<br> 


### TlsHandler {#TlsHandler}

Field | Description
--- | ---
handler | **oneof:** `stream_handler` or `http_handler`<br>
&nbsp;&nbsp;stream_handler | **[StreamHandler](../load_balancer.proto#StreamHandler2)**<br> 
&nbsp;&nbsp;http_handler | **[HttpHandler](../load_balancer.proto#HttpHandler4)**<br> 
tls | **[ListenerTls](../load_balancer.proto#ListenerTls2)**<br>Required.  false


### StreamHandler {#StreamHandler}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options4)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### ListenerTls {#ListenerTls}

Field | Description
--- | ---
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.
tls_options | **[TlsOptions](../tls.proto#TlsOptions2)**<br> 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### SniMatch {#SniMatch}

Field | Description
--- | ---
name | **string**<br>Required.  false
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](../load_balancer.proto#TlsHandler3)**<br>Required.  false


### TlsHandler {#TlsHandler}

Field | Description
--- | ---
handler | **oneof:** `stream_handler` or `http_handler`<br>
&nbsp;&nbsp;stream_handler | **[StreamHandler](../load_balancer.proto#StreamHandler3)**<br> 
&nbsp;&nbsp;http_handler | **[HttpHandler](../load_balancer.proto#HttpHandler5)**<br> 
tls | **[ListenerTls](../load_balancer.proto#ListenerTls3)**<br>Required.  false


### StreamHandler {#StreamHandler}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options5)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### ListenerTls {#ListenerTls}

Field | Description
--- | ---
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.
tls_options | **[TlsOptions](../tls.proto#TlsOptions3)**<br> 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### AllocationPolicy {#AllocationPolicy}

Field | Description
--- | ---
locations[] | **[Location](../load_balancer.proto#Location1)**<br> The minimum number of elements is 1. false


### Location {#Location}

Field | Description
--- | ---
zone_id | **string**<br>Required.  false
subnet_id | **string**<br> 
disable_traffic | **bool**<br>If set, will disable all L7 instances in the zone for request handling. 


## Create {#Create}



**rpc Create ([CreateLoadBalancerRequest](#CreateLoadBalancerRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateLoadBalancerMetadata](#CreateLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](../load_balancer.proto#LoadBalancer2)<br>

### CreateLoadBalancerRequest {#CreateLoadBalancerRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required.  false
name | **string**<br> Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
listener_specs[] | **[ListenerSpec](#ListenerSpec)**<br> 
allocation_policy | **[AllocationPolicy](../load_balancer.proto#AllocationPolicy2)**<br> 
network_id | **string**<br>Required.  false


### ListenerSpec {#ListenerSpec}

Field | Description
--- | ---
name | **string**<br>Required.  false Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
port | **int64**<br> Acceptable values are 1 to 65535, inclusive.
address | **oneof:** `external_address_spec` or `internal_address_spec`<br>
&nbsp;&nbsp;external_address_spec | **[ExternalAddressSpec](#ExternalAddressSpec)**<br> 
&nbsp;&nbsp;internal_address_spec | **[InternalAddressSpec](#InternalAddressSpec)**<br> 
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](../load_balancer.proto#HttpListener2)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](../load_balancer.proto#TlsListener2)**<br> 


### ExternalAddressSpec {#ExternalAddressSpec}

Field | Description
--- | ---
address | **string**<br> 
ip_version | **[Listener.IpVersion](../load_balancer.proto#Listener2)**<br>Required.  false


### InternalAddressSpec {#InternalAddressSpec}

Field | Description
--- | ---
address | **string**<br> 
subnet_id | **string**<br> 
ip_version | **[Listener.IpVersion](../load_balancer.proto#Listener2)**<br>Required.  false


### HttpListener {#HttpListener}

Field | Description
--- | ---
handler | **[HttpHandler](../load_balancer.proto#HttpHandler6)**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options6)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### TlsListener {#TlsListener}

Field | Description
--- | ---
default_handler | **[TlsHandler](../load_balancer.proto#TlsHandler4)**<br>Required.  false
sni_handlers[] | **[SniMatch](../load_balancer.proto#SniMatch2)**<br> 


### TlsHandler {#TlsHandler}

Field | Description
--- | ---
handler | **oneof:** `stream_handler` or `http_handler`<br>
&nbsp;&nbsp;stream_handler | **[StreamHandler](../load_balancer.proto#StreamHandler4)**<br> 
&nbsp;&nbsp;http_handler | **[HttpHandler](../load_balancer.proto#HttpHandler7)**<br> 
tls | **[ListenerTls](../load_balancer.proto#ListenerTls4)**<br>Required.  false


### StreamHandler {#StreamHandler}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options7)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### ListenerTls {#ListenerTls}

Field | Description
--- | ---
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.
tls_options | **[TlsOptions](../tls.proto#TlsOptions4)**<br> 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### SniMatch {#SniMatch}

Field | Description
--- | ---
name | **string**<br>Required.  false
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](../load_balancer.proto#TlsHandler5)**<br>Required.  false


### TlsHandler {#TlsHandler}

Field | Description
--- | ---
handler | **oneof:** `stream_handler` or `http_handler`<br>
&nbsp;&nbsp;stream_handler | **[StreamHandler](../load_balancer.proto#StreamHandler5)**<br> 
&nbsp;&nbsp;http_handler | **[HttpHandler](../load_balancer.proto#HttpHandler8)**<br> 
tls | **[ListenerTls](../load_balancer.proto#ListenerTls5)**<br>Required.  false


### StreamHandler {#StreamHandler}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options8)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### ListenerTls {#ListenerTls}

Field | Description
--- | ---
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.
tls_options | **[TlsOptions](../tls.proto#TlsOptions5)**<br> 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### AllocationPolicy {#AllocationPolicy}

Field | Description
--- | ---
locations[] | **[Location](../load_balancer.proto#Location2)**<br> The minimum number of elements is 1. false


### Location {#Location}

Field | Description
--- | ---
zone_id | **string**<br>Required.  false
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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LoadBalancer](../load_balancer.proto#LoadBalancer2)>**<br>if operation finished successfully. 


### CreateLoadBalancerMetadata {#CreateLoadBalancerMetadata}

Field | Description
--- | ---
load_balancer_id | **string**<br> 


### LoadBalancer {#LoadBalancer}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the load balancer. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the load balancer. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the load balancer belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
listeners[] | **[Listener](../load_balancer.proto#Listener2)**<br>List of listeners for the application load balancer. 
allocation_policy | **[AllocationPolicy](../load_balancer.proto#AllocationPolicy3)**<br>Allocation sites for application load balancer instances. 
log_group_id | **string**<br> 
region_id | **string**<br> 


## Update {#Update}



**rpc Update ([UpdateLoadBalancerRequest](#UpdateLoadBalancerRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateLoadBalancerMetadata](#UpdateLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](../load_balancer.proto#LoadBalancer3)<br>

### UpdateLoadBalancerRequest {#UpdateLoadBalancerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  false
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
name | **string**<br> Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
listener_specs[] | **[ListenerSpec](#ListenerSpec1)**<br> 
allocation_policy | **[AllocationPolicy](../load_balancer.proto#AllocationPolicy3)**<br> 


### ListenerSpec {#ListenerSpec}

Field | Description
--- | ---
name | **string**<br>Required.  false Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
port | **int64**<br> Acceptable values are 1 to 65535, inclusive.
address | **oneof:** `external_address_spec` or `internal_address_spec`<br>
&nbsp;&nbsp;external_address_spec | **[ExternalAddressSpec](#ExternalAddressSpec1)**<br> 
&nbsp;&nbsp;internal_address_spec | **[InternalAddressSpec](#InternalAddressSpec1)**<br> 
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](../load_balancer.proto#HttpListener3)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](../load_balancer.proto#TlsListener3)**<br> 


### ExternalAddressSpec {#ExternalAddressSpec}

Field | Description
--- | ---
address | **string**<br> 
ip_version | **[Listener.IpVersion](../load_balancer.proto#Listener2)**<br>Required.  false


### InternalAddressSpec {#InternalAddressSpec}

Field | Description
--- | ---
address | **string**<br> 
subnet_id | **string**<br> 
ip_version | **[Listener.IpVersion](../load_balancer.proto#Listener2)**<br>Required.  false


### HttpListener {#HttpListener}

Field | Description
--- | ---
handler | **[HttpHandler](../load_balancer.proto#HttpHandler9)**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options9)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### TlsListener {#TlsListener}

Field | Description
--- | ---
default_handler | **[TlsHandler](../load_balancer.proto#TlsHandler6)**<br>Required.  false
sni_handlers[] | **[SniMatch](../load_balancer.proto#SniMatch3)**<br> 


### TlsHandler {#TlsHandler}

Field | Description
--- | ---
handler | **oneof:** `stream_handler` or `http_handler`<br>
&nbsp;&nbsp;stream_handler | **[StreamHandler](../load_balancer.proto#StreamHandler6)**<br> 
&nbsp;&nbsp;http_handler | **[HttpHandler](../load_balancer.proto#HttpHandler10)**<br> 
tls | **[ListenerTls](../load_balancer.proto#ListenerTls6)**<br>Required.  false


### StreamHandler {#StreamHandler}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options10)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### ListenerTls {#ListenerTls}

Field | Description
--- | ---
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.
tls_options | **[TlsOptions](../tls.proto#TlsOptions6)**<br> 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### SniMatch {#SniMatch}

Field | Description
--- | ---
name | **string**<br>Required.  false
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](../load_balancer.proto#TlsHandler7)**<br>Required.  false


### TlsHandler {#TlsHandler}

Field | Description
--- | ---
handler | **oneof:** `stream_handler` or `http_handler`<br>
&nbsp;&nbsp;stream_handler | **[StreamHandler](../load_balancer.proto#StreamHandler7)**<br> 
&nbsp;&nbsp;http_handler | **[HttpHandler](../load_balancer.proto#HttpHandler11)**<br> 
tls | **[ListenerTls](../load_balancer.proto#ListenerTls7)**<br>Required.  false


### StreamHandler {#StreamHandler}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options11)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### ListenerTls {#ListenerTls}

Field | Description
--- | ---
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.
tls_options | **[TlsOptions](../tls.proto#TlsOptions7)**<br> 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### AllocationPolicy {#AllocationPolicy}

Field | Description
--- | ---
locations[] | **[Location](../load_balancer.proto#Location3)**<br> The minimum number of elements is 1. false


### Location {#Location}

Field | Description
--- | ---
zone_id | **string**<br>Required.  false
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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateLoadBalancerMetadata](#UpdateLoadBalancerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LoadBalancer](../load_balancer.proto#LoadBalancer3)>**<br>if operation finished successfully. 


### UpdateLoadBalancerMetadata {#UpdateLoadBalancerMetadata}

Field | Description
--- | ---
load_balancer_id | **string**<br> 


### LoadBalancer {#LoadBalancer}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the load balancer. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the load balancer. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the load balancer belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
listeners[] | **[Listener](../load_balancer.proto#Listener2)**<br>List of listeners for the application load balancer. 
allocation_policy | **[AllocationPolicy](../load_balancer.proto#AllocationPolicy4)**<br>Allocation sites for application load balancer instances. 
log_group_id | **string**<br> 
region_id | **string**<br> 


## Delete {#Delete}



**rpc Delete ([DeleteLoadBalancerRequest](#DeleteLoadBalancerRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteLoadBalancerMetadata](#DeleteLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteLoadBalancerRequest {#DeleteLoadBalancerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  false


### Operation {#Operation}

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


## AddListener {#AddListener}

AddListener/UpdateListener technically do the same, but have different semantics.

**rpc AddListener ([AddListenerRequest](#AddListenerRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddListenerMetadata](#AddListenerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](../load_balancer.proto#LoadBalancer4)<br>

### AddListenerRequest {#AddListenerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  false
listener_spec | **[ListenerSpec](#ListenerSpec2)**<br>Required.  false


### ListenerSpec {#ListenerSpec}

Field | Description
--- | ---
name | **string**<br>Required.  false Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
port | **int64**<br> Acceptable values are 1 to 65535, inclusive.
address | **oneof:** `external_address_spec` or `internal_address_spec`<br>
&nbsp;&nbsp;external_address_spec | **[ExternalAddressSpec](#ExternalAddressSpec2)**<br> 
&nbsp;&nbsp;internal_address_spec | **[InternalAddressSpec](#InternalAddressSpec2)**<br> 
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](../load_balancer.proto#HttpListener4)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](../load_balancer.proto#TlsListener4)**<br> 


### ExternalAddressSpec {#ExternalAddressSpec}

Field | Description
--- | ---
address | **string**<br> 
ip_version | **[Listener.IpVersion](../load_balancer.proto#Listener2)**<br>Required.  false


### InternalAddressSpec {#InternalAddressSpec}

Field | Description
--- | ---
address | **string**<br> 
subnet_id | **string**<br> 
ip_version | **[Listener.IpVersion](../load_balancer.proto#Listener2)**<br>Required.  false


### HttpListener {#HttpListener}

Field | Description
--- | ---
handler | **[HttpHandler](../load_balancer.proto#HttpHandler12)**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options12)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### TlsListener {#TlsListener}

Field | Description
--- | ---
default_handler | **[TlsHandler](../load_balancer.proto#TlsHandler8)**<br>Required.  false
sni_handlers[] | **[SniMatch](../load_balancer.proto#SniMatch4)**<br> 


### TlsHandler {#TlsHandler}

Field | Description
--- | ---
handler | **oneof:** `stream_handler` or `http_handler`<br>
&nbsp;&nbsp;stream_handler | **[StreamHandler](../load_balancer.proto#StreamHandler8)**<br> 
&nbsp;&nbsp;http_handler | **[HttpHandler](../load_balancer.proto#HttpHandler13)**<br> 
tls | **[ListenerTls](../load_balancer.proto#ListenerTls8)**<br>Required.  false


### StreamHandler {#StreamHandler}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options13)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### ListenerTls {#ListenerTls}

Field | Description
--- | ---
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.
tls_options | **[TlsOptions](../tls.proto#TlsOptions8)**<br> 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### SniMatch {#SniMatch}

Field | Description
--- | ---
name | **string**<br>Required.  false
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](../load_balancer.proto#TlsHandler9)**<br>Required.  false


### TlsHandler {#TlsHandler}

Field | Description
--- | ---
handler | **oneof:** `stream_handler` or `http_handler`<br>
&nbsp;&nbsp;stream_handler | **[StreamHandler](../load_balancer.proto#StreamHandler9)**<br> 
&nbsp;&nbsp;http_handler | **[HttpHandler](../load_balancer.proto#HttpHandler14)**<br> 
tls | **[ListenerTls](../load_balancer.proto#ListenerTls9)**<br>Required.  false


### StreamHandler {#StreamHandler}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options14)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### ListenerTls {#ListenerTls}

Field | Description
--- | ---
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.
tls_options | **[TlsOptions](../tls.proto#TlsOptions9)**<br> 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LoadBalancer](../load_balancer.proto#LoadBalancer4)>**<br>if operation finished successfully. 


### AddListenerMetadata {#AddListenerMetadata}

Field | Description
--- | ---
load_balancer_id | **string**<br> 
listener_name | **string**<br> 


### LoadBalancer {#LoadBalancer}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the load balancer. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the load balancer. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the load balancer belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
listeners[] | **[Listener](../load_balancer.proto#Listener2)**<br>List of listeners for the application load balancer. 
allocation_policy | **[AllocationPolicy](../load_balancer.proto#AllocationPolicy4)**<br>Allocation sites for application load balancer instances. 
log_group_id | **string**<br> 
region_id | **string**<br> 


## RemoveListener {#RemoveListener}



**rpc RemoveListener ([RemoveListenerRequest](#RemoveListenerRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveListenerMetadata](#RemoveListenerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](../load_balancer.proto#LoadBalancer5)<br>

### RemoveListenerRequest {#RemoveListenerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  false
name | **string**<br>Required.  false


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LoadBalancer](../load_balancer.proto#LoadBalancer5)>**<br>if operation finished successfully. 


### RemoveListenerMetadata {#RemoveListenerMetadata}

Field | Description
--- | ---
load_balancer_id | **string**<br> 
listener_name | **string**<br> 


### LoadBalancer {#LoadBalancer}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the load balancer. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the load balancer. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the load balancer belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
listeners[] | **[Listener](../load_balancer.proto#Listener2)**<br>List of listeners for the application load balancer. 
allocation_policy | **[AllocationPolicy](../load_balancer.proto#AllocationPolicy4)**<br>Allocation sites for application load balancer instances. 
log_group_id | **string**<br> 
region_id | **string**<br> 


## UpdateListener {#UpdateListener}



**rpc UpdateListener ([UpdateListenerRequest](#UpdateListenerRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateListenerMetadata](#UpdateListenerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](../load_balancer.proto#LoadBalancer6)<br>

### UpdateListenerRequest {#UpdateListenerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  false
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
listener_spec | **[ListenerSpec](#ListenerSpec3)**<br>Required.  false


### ListenerSpec {#ListenerSpec}

Field | Description
--- | ---
name | **string**<br>Required.  false Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
port | **int64**<br> Acceptable values are 1 to 65535, inclusive.
address | **oneof:** `external_address_spec` or `internal_address_spec`<br>
&nbsp;&nbsp;external_address_spec | **[ExternalAddressSpec](#ExternalAddressSpec3)**<br> 
&nbsp;&nbsp;internal_address_spec | **[InternalAddressSpec](#InternalAddressSpec3)**<br> 
listener | **oneof:** `http` or `tls`<br>
&nbsp;&nbsp;http | **[HttpListener](../load_balancer.proto#HttpListener5)**<br> 
&nbsp;&nbsp;tls | **[TlsListener](../load_balancer.proto#TlsListener5)**<br> 


### ExternalAddressSpec {#ExternalAddressSpec}

Field | Description
--- | ---
address | **string**<br> 
ip_version | **[Listener.IpVersion](../load_balancer.proto#Listener2)**<br>Required.  false


### InternalAddressSpec {#InternalAddressSpec}

Field | Description
--- | ---
address | **string**<br> 
subnet_id | **string**<br> 
ip_version | **[Listener.IpVersion](../load_balancer.proto#Listener2)**<br>Required.  false


### HttpListener {#HttpListener}

Field | Description
--- | ---
handler | **[HttpHandler](../load_balancer.proto#HttpHandler15)**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options15)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### TlsListener {#TlsListener}

Field | Description
--- | ---
default_handler | **[TlsHandler](../load_balancer.proto#TlsHandler10)**<br>Required.  false
sni_handlers[] | **[SniMatch](../load_balancer.proto#SniMatch5)**<br> 


### TlsHandler {#TlsHandler}

Field | Description
--- | ---
handler | **oneof:** `stream_handler` or `http_handler`<br>
&nbsp;&nbsp;stream_handler | **[StreamHandler](../load_balancer.proto#StreamHandler10)**<br> 
&nbsp;&nbsp;http_handler | **[HttpHandler](../load_balancer.proto#HttpHandler16)**<br> 
tls | **[ListenerTls](../load_balancer.proto#ListenerTls10)**<br>Required.  false


### StreamHandler {#StreamHandler}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options16)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### ListenerTls {#ListenerTls}

Field | Description
--- | ---
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.
tls_options | **[TlsOptions](../tls.proto#TlsOptions10)**<br> 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### SniMatch {#SniMatch}

Field | Description
--- | ---
name | **string**<br>Required.  false
server_names[] | **string**<br> The number of elements must be greater than 0.
handler | **[TlsHandler](../load_balancer.proto#TlsHandler11)**<br>Required.  false


### TlsHandler {#TlsHandler}

Field | Description
--- | ---
handler | **oneof:** `stream_handler` or `http_handler`<br>
&nbsp;&nbsp;stream_handler | **[StreamHandler](../load_balancer.proto#StreamHandler11)**<br> 
&nbsp;&nbsp;http_handler | **[HttpHandler](../load_balancer.proto#HttpHandler17)**<br> 
tls | **[ListenerTls](../load_balancer.proto#ListenerTls11)**<br>Required.  false


### StreamHandler {#StreamHandler}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  false


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>Required.  false
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>
&nbsp;&nbsp;http2_options | **[Http2Options](../load_balancer.proto#Http2Options17)**<br> 
&nbsp;&nbsp;allow_http10 | **bool**<br> 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br> 


### ListenerTls {#ListenerTls}

Field | Description
--- | ---
certificate_ids[] | **string**<br>Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used. The number of elements must be greater than 0.
tls_options | **[TlsOptions](../tls.proto#TlsOptions11)**<br> 


### TlsOptions {#TlsOptions}

Field | Description
--- | ---
tls_min_version | enum **TlsVersion**<br>Minimum TLS protocol version. <ul><ul/>
tls_max_version | enum **TlsVersion**<br>Maximum TLS protocol version. <ul><ul/>
cipher_suites[] | enum **CipherSuite**<br>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used. <ul><ul/>
ecdh_curves[] | enum **EcdhCurve**<br>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used. <ul><ul/>


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LoadBalancer](../load_balancer.proto#LoadBalancer6)>**<br>if operation finished successfully. 


### UpdateListenerMetadata {#UpdateListenerMetadata}

Field | Description
--- | ---
load_balancer_id | **string**<br> 
listener_name | **string**<br> 


### LoadBalancer {#LoadBalancer}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the load balancer. 
name | **string**<br>The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Description of the load balancer. 0-256 characters long. 
folder_id | **string**<br>ID of the folder that the load balancer belongs to. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
listeners[] | **[Listener](../load_balancer.proto#Listener2)**<br>List of listeners for the application load balancer. 
allocation_policy | **[AllocationPolicy](../load_balancer.proto#AllocationPolicy4)**<br>Allocation sites for application load balancer instances. 
log_group_id | **string**<br> 
region_id | **string**<br> 


## GetTargetStates {#GetTargetStates}

Returns zonal state of each target within target group for a given backend group and load balancer.

**rpc GetTargetStates ([GetTargetStatesRequest](#GetTargetStatesRequest)) returns ([GetTargetStatesResponse](#GetTargetStatesResponse))**

### GetTargetStatesRequest {#GetTargetStatesRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required.  false
backend_group_id | **string**<br>Required.  false
target_group_id | **string**<br>Required.  false


### GetTargetStatesResponse {#GetTargetStatesResponse}

Field | Description
--- | ---
target_states[] | **[TargetState](../load_balancer.proto#TargetState)**<br> 


### TargetState {#TargetState}

Field | Description
--- | ---
status | **[HealthcheckStatus](../load_balancer.proto#HealthcheckStatus)**<br>Statuses of the target for all known zones. 
target | **[Target](../target_group.proto#Target)**<br>Required.  false


### HealthcheckStatus {#HealthcheckStatus}

Field | Description
--- | ---
zone_statuses[] | **[ZoneHealthcheckStatus](../load_balancer.proto#ZoneHealthcheckStatus)**<br> 


### ZoneHealthcheckStatus {#ZoneHealthcheckStatus}

Field | Description
--- | ---
zone_id | **string**<br>Required.  false
status | **Status**<br>Healthcheck status of target for the specific zone. 
failed_active_hc | **bool**<br>Whether UNHEALTHY status was set due to failed active checks or not. 


### Target {#Target}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>
&nbsp;&nbsp;ip_address | **string**<br> 
port | **int64**<br>Endpoint port. Takes priority over Backend::port setting. Acceptable values are 0 to 65535, inclusive.
subnet_id | **string**<br>ID of the subnet that target connected to. 


## ListOperations {#ListOperations}

Lists operations for the specified load balancer.

**rpc ListOperations ([ListLoadBalancerOperationsRequest](#ListLoadBalancerOperationsRequest)) returns ([ListLoadBalancerOperationsResponse](#ListLoadBalancerOperationsResponse))**

### ListLoadBalancerOperationsRequest {#ListLoadBalancerOperationsRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required. ID of the load balancer to get operations for. <br>To get the load balancer ID, use a [LoadBalancerService.List](#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListLoadBalancerOperationsResponse.next_page_token](#ListLoadBalancerOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListLoadBalancerOperationsResponse.next_page_token](#ListLoadBalancerOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListLoadBalancerOperationsResponse {#ListLoadBalancerOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation6)**<br>List of operations for the specified target group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListLoadBalancerOperationsRequest.page_size](#ListLoadBalancerOperationsRequest1), use the `next_page_token` as the value for the [ListLoadBalancerOperationsRequest.page_token](#ListLoadBalancerOperationsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation}

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


