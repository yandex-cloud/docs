---
editable: false
---

# LoadBalancerService

A set of methods for managing application load balancers.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified application load balancer. |
| [List](#List) | Lists application load balancers in the specified folder. |
| [Create](#Create) | Creates an application load balancer in the specified folder. |
| [Update](#Update) | Updates the specified application load balancer. |
| [Delete](#Delete) | Deletes the specified application load balancer. |
| [Start](#Start) | Starts the specified application load balancer. |
| [Stop](#Stop) | Stops the specified application load balancer. |
| [AddListener](#AddListener) | AddListener/UpdateListener technically do the same, but have different semantics. |
| [RemoveListener](#RemoveListener) | Deletes the specified listener. |
| [UpdateListener](#UpdateListener) | Updates the specified listener of the specified application load balancer. |
| [AddSniMatch](#AddSniMatch) | Adds a SNI handler to the specified listener. |
| [UpdateSniMatch](#UpdateSniMatch) | Updates the specified SNI handler of the specified listener. |
| [RemoveSniMatch](#RemoveSniMatch) | Deletes the specified SNI handler. |
| [GetTargetStates](#GetTargetStates) | Returns the statuses of all targets of the specified backend group in all their availability zones. |
| [ListOperations](#ListOperations) | Lists operations for the specified application load balancer. |

## Calls LoadBalancerService {#calls}

## Get {#Get}

Returns the specified application load balancer. <br>To get the list of all available application load balancers, make a [List](#List) request.

**rpc Get ([GetLoadBalancerRequest](#GetLoadBalancerRequest)) returns ([LoadBalancer](#LoadBalancer))**

### GetLoadBalancerRequest {#GetLoadBalancerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required. ID of the application load balancer to return. <br>To get the application load balancer ID, make a [LoadBalancerService.List](#List) request. 


### LoadBalancer {#LoadBalancer}

Field | Description
--- | ---
id | **string**<br>ID of the application load balancer. Generated at creation time. 
name | **string**<br>Name of the application load balancer. The name is unique within the folder. 
description | **string**<br>Description of the application load balancer. 
folder_id | **string**<br>ID of the folder that the application load balancer belongs to. 
labels | **map<string,string>**<br>Application load balancer labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: The application load balancer is being created.</li><li>`STARTING`: The application load balancer is being started.</li><li>`ACTIVE`: The application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: The application load balancer is being stopped.</li><li>`STOPPED`: The application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: The application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the application load balancer is located at. <br>Currently Yandex Cloud supports only `ru-central1` region. 
network_id | **string**<br>ID of the network that the application load balancer belongs to. 
listeners[] | **[Listener](#Listener)**<br>Listeners that belong to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener). 
allocation_policy | **[AllocationPolicy](#AllocationPolicy)**<br>Locality settings of the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location). 
log_group_id | **string**<br>ID of the log group that stores access logs of the application load balancer. <br>The logs can be accessed using a Cloud Functions [trigger for Cloud Logs](/docs/functions/operations/trigger/cloudlogs-trigger-create). 
security_group_ids[] | **string**<br>ID's of the security groups attributed to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#security-groups). 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### Listener {#Listener}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name is unique within the application load balancer. The string length in characters is 3-63. 
endpoints[] | **[Endpoint](#Endpoint)**<br>Endpoints of the listener. <br>Endpoints are defined by their IP addresses and ports. 
listener | **oneof:** `http`, `tls` or `tcp`<br>HTTP or HTTPS (HTTP over TLS) listener settings.
&nbsp;&nbsp;http | **[HttpListener](#HttpListener)**<br>HTTP listener settings. 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener)**<br>HTTPS (HTTP over TLS) listener settings. 
&nbsp;&nbsp;tcp | **[TcpListener](#TcpListener)**<br>TCP listener settings. 


### Endpoint {#Endpoint}

Field | Description
--- | ---
addresses[] | **[Address](#Address)**<br>Endpoint public (external) and internal addresses. The number of elements must be greater than 0.
ports[] | **int64**<br>Endpoint ports. The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address)**<br>Public IPv4 endpoint address. 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address)**<br>Internal IPv4 endpoint address. <br>To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address)**<br>Public IPv6 endpoint address. 


### ExternalIpv4Address {#ExternalIpv4Address}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 


### InternalIpv4Address {#InternalIpv4Address}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 
subnet_id | **string**<br>ID of the subnet that the address belongs to. 


### ExternalIpv6Address {#ExternalIpv6Address}

Field | Description
--- | ---
address | **string**<br>IPv6 address. 


### HttpListener {#HttpListener}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler)**<br>Settings for handling HTTP requests. <br>Only one of `handler` and `redirects` can be specified. 
redirects | **[Redirects](#Redirects)**<br>Redirects settings. <br>Only one of `redirects` and `handler` can be specified. 


### HttpHandler {#HttpHandler}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### Redirects {#Redirects}

Field | Description
--- | ---
http_to_https | **bool**<br>Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`. <br>The setting has the same effect as a single, catch-all [HttpRoute](#HttpRoute) with [RedirectAction.replace_scheme](#RedirectAction) set to `https`. 


### TlsListener {#TlsListener}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler)**<br>Required. Settings for handling HTTPS requests by default, with Server Name Indication (SNI) not matching any of the `sni_handlers`. 
sni_handlers[] | **[SniMatch](#SniMatch)**<br>Settings for handling HTTPS requests with Server Name Indication (SNI) matching one of [SniMatch.server_names](#SniMatch) values. 


### TlsHandler {#TlsHandler}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler1)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler1}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options1)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options1}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### SniMatch {#SniMatch}

Field | Description
--- | ---
name | **string**<br>Required. Name of the SNI handler. 
server_names[] | **string**<br>Server names that are matched by the SNI handler. The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler1)**<br>Required. Settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. 


### TlsHandler {#TlsHandler1}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler2)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler1)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler2}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options2)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options2}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler1}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### TcpListener {#TcpListener}

Field | Description
--- | ---
handler | **[StreamHandler](#StreamHandler2)**<br>Required.  


### StreamHandler {#StreamHandler2}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### AllocationPolicy {#AllocationPolicy}

Field | Description
--- | ---
locations[] | **[Location](#Location)**<br>Availability zones and subnets that the application load balancer resides. The minimum number of elements is 1.


### Location {#Location}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the application load balancer resides. <br>Each Yandex Cloud availability zone can only be specified once. 
subnet_id | **string**<br>ID of the subnet that the application load balancer belongs to. 
disable_traffic | **bool**<br>Disables the load balancer node in the specified availability zone. <br>Backends in the availability zone are not directly affected by this setting. They still may receive traffic from the load balancer nodes in other availability zones, subject to [LoadBalancingConfig.locality_aware_routing_percent](#LoadBalancingConfig) and [LoadBalancingConfig.strict_locality](#LoadBalancingConfig) settings. 


## List {#List}

Lists application load balancers in the specified folder.

**rpc List ([ListLoadBalancersRequest](#ListLoadBalancersRequest)) returns ([ListLoadBalancersResponse](#ListLoadBalancersResponse))**

### ListLoadBalancersRequest {#ListLoadBalancersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list application load balancers in. <br>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListLoadBalancersResponse.next_page_token](#ListLoadBalancersResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListLoadBalancersResponse.next_page_token](#ListLoadBalancersResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently you can use filtering only on [LoadBalancer.name](#LoadBalancer1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol> The maximum string length in characters is 1000.


### ListLoadBalancersResponse {#ListLoadBalancersResponse}

Field | Description
--- | ---
load_balancers[] | **[LoadBalancer](#LoadBalancer1)**<br>List of application load balancers in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListLoadBalancersRequest.page_size](#ListLoadBalancersRequest), use `next_page_token` as the value for the [ListLoadBalancersRequest.page_token](#ListLoadBalancersRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### LoadBalancer {#LoadBalancer1}

Field | Description
--- | ---
id | **string**<br>ID of the application load balancer. Generated at creation time. 
name | **string**<br>Name of the application load balancer. The name is unique within the folder. 
description | **string**<br>Description of the application load balancer. 
folder_id | **string**<br>ID of the folder that the application load balancer belongs to. 
labels | **map<string,string>**<br>Application load balancer labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: The application load balancer is being created.</li><li>`STARTING`: The application load balancer is being started.</li><li>`ACTIVE`: The application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: The application load balancer is being stopped.</li><li>`STOPPED`: The application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: The application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the application load balancer is located at. <br>Currently Yandex Cloud supports only `ru-central1` region. 
network_id | **string**<br>ID of the network that the application load balancer belongs to. 
listeners[] | **[Listener](#Listener1)**<br>Listeners that belong to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener). 
allocation_policy | **[AllocationPolicy](#AllocationPolicy1)**<br>Locality settings of the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location). 
log_group_id | **string**<br>ID of the log group that stores access logs of the application load balancer. <br>The logs can be accessed using a Cloud Functions [trigger for Cloud Logs](/docs/functions/operations/trigger/cloudlogs-trigger-create). 
security_group_ids[] | **string**<br>ID's of the security groups attributed to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#security-groups). 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### Listener {#Listener1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name is unique within the application load balancer. The string length in characters is 3-63. 
endpoints[] | **[Endpoint](#Endpoint1)**<br>Endpoints of the listener. <br>Endpoints are defined by their IP addresses and ports. 
listener | **oneof:** `http`, `tls` or `tcp`<br>HTTP or HTTPS (HTTP over TLS) listener settings.
&nbsp;&nbsp;http | **[HttpListener](#HttpListener1)**<br>HTTP listener settings. 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener1)**<br>HTTPS (HTTP over TLS) listener settings. 
&nbsp;&nbsp;tcp | **[TcpListener](#TcpListener1)**<br>TCP listener settings. 


### Endpoint {#Endpoint1}

Field | Description
--- | ---
addresses[] | **[Address](#Address1)**<br>Endpoint public (external) and internal addresses. The number of elements must be greater than 0.
ports[] | **int64**<br>Endpoint ports. The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address1}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address1)**<br>Public IPv4 endpoint address. 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address1)**<br>Internal IPv4 endpoint address. <br>To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address1)**<br>Public IPv6 endpoint address. 


### ExternalIpv4Address {#ExternalIpv4Address1}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 


### InternalIpv4Address {#InternalIpv4Address1}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 
subnet_id | **string**<br>ID of the subnet that the address belongs to. 


### ExternalIpv6Address {#ExternalIpv6Address1}

Field | Description
--- | ---
address | **string**<br>IPv6 address. 


### HttpListener {#HttpListener1}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler3)**<br>Settings for handling HTTP requests. <br>Only one of `handler` and `redirects` can be specified. 
redirects | **[Redirects](#Redirects1)**<br>Redirects settings. <br>Only one of `redirects` and `handler` can be specified. 


### HttpHandler {#HttpHandler3}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options3)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options3}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### Redirects {#Redirects1}

Field | Description
--- | ---
http_to_https | **bool**<br>Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`. <br>The setting has the same effect as a single, catch-all [HttpRoute](#HttpRoute) with [RedirectAction.replace_scheme](#RedirectAction) set to `https`. 


### TlsListener {#TlsListener1}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler2)**<br>Required. Settings for handling HTTPS requests by default, with Server Name Indication (SNI) not matching any of the `sni_handlers`. 
sni_handlers[] | **[SniMatch](#SniMatch1)**<br>Settings for handling HTTPS requests with Server Name Indication (SNI) matching one of [SniMatch.server_names](#SniMatch1) values. 


### TlsHandler {#TlsHandler2}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler4)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler3)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler4}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options4)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options4}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler3}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### SniMatch {#SniMatch1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the SNI handler. 
server_names[] | **string**<br>Server names that are matched by the SNI handler. The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler3)**<br>Required. Settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. 


### TlsHandler {#TlsHandler3}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler5)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler4)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler5}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options5)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options5}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler4}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### TcpListener {#TcpListener1}

Field | Description
--- | ---
handler | **[StreamHandler](#StreamHandler5)**<br>Required.  


### StreamHandler {#StreamHandler5}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### AllocationPolicy {#AllocationPolicy1}

Field | Description
--- | ---
locations[] | **[Location](#Location1)**<br>Availability zones and subnets that the application load balancer resides. The minimum number of elements is 1.


### Location {#Location1}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the application load balancer resides. <br>Each Yandex Cloud availability zone can only be specified once. 
subnet_id | **string**<br>ID of the subnet that the application load balancer belongs to. 
disable_traffic | **bool**<br>Disables the load balancer node in the specified availability zone. <br>Backends in the availability zone are not directly affected by this setting. They still may receive traffic from the load balancer nodes in other availability zones, subject to [LoadBalancingConfig.locality_aware_routing_percent](#LoadBalancingConfig) and [LoadBalancingConfig.strict_locality](#LoadBalancingConfig) settings. 


## Create {#Create}

Creates an application load balancer in the specified folder.

**rpc Create ([CreateLoadBalancerRequest](#CreateLoadBalancerRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateLoadBalancerMetadata](#CreateLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](#LoadBalancer2)<br>

### CreateLoadBalancerRequest {#CreateLoadBalancerRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create an application load balancer in. <br>To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
name | **string**<br>Name of the application load balancer. The name must be unique within the folder. Value must match the regular expression ` ([a-z]([-a-z0-9]{0,61}[a-z0-9])?)? `.
description | **string**<br>Description of the application load balancer. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Application load balancer labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
region_id | **string**<br>Required. ID of the region that the application load balancer is located at. <br>The only supported value is `ru-central1`. 
network_id | **string**<br>Required. ID of the network that the application load balancer belongs to. 
listener_specs[] | **[ListenerSpec](#ListenerSpec)**<br>Listeners that belong to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener). 
allocation_policy | **[AllocationPolicy](#AllocationPolicy2)**<br>Locality settings of the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location). 
security_group_ids[] | **string**<br>ID's of the security groups attributed to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#security-groups). 


### ListenerSpec {#ListenerSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name is unique within the application load balancer. Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
endpoint_specs[] | **[EndpointSpec](#EndpointSpec)**<br>Endpoints of the listener. <br>Endpoints are defined by their IP addresses and ports. The number of elements must be greater than 0.
listener | **oneof:** `http` or `tls`<br>HTTP or HTTPS (HTTP over TLS) listener settings.
&nbsp;&nbsp;http | **[HttpListener](#HttpListener2)**<br>HTTP listener settings. 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener2)**<br>HTTPS (HTTP over TLS) listener settings. 


### EndpointSpec {#EndpointSpec}

Field | Description
--- | ---
address_specs[] | **[AddressSpec](#AddressSpec)**<br>Endpoint public (external) and internal addresses. The number of elements must be greater than 0.
ports[] | **int64**<br>Endpoint ports. The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### AddressSpec {#AddressSpec}

Field | Description
--- | ---
address_spec | **oneof:** `external_ipv4_address_spec`, `internal_ipv4_address_spec` or `external_ipv6_address_spec`<br>Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address.
&nbsp;&nbsp;external_ipv4_address_spec | **[ExternalIpv4AddressSpec](#ExternalIpv4AddressSpec)**<br>Public IPv4 endpoint address. 
&nbsp;&nbsp;internal_ipv4_address_spec | **[InternalIpv4AddressSpec](#InternalIpv4AddressSpec)**<br>Internal IPv4 endpoint address. <br>To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). 
&nbsp;&nbsp;external_ipv6_address_spec | **[ExternalIpv6AddressSpec](#ExternalIpv6AddressSpec)**<br>Public IPv6 endpoint address. 


### ExternalIpv4AddressSpec {#ExternalIpv4AddressSpec}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 


### InternalIpv4AddressSpec {#InternalIpv4AddressSpec}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 
subnet_id | **string**<br>ID of the subnet that the address belongs to. 


### ExternalIpv6AddressSpec {#ExternalIpv6AddressSpec}

Field | Description
--- | ---
address | **string**<br>IPv6 address. 


### HttpListener {#HttpListener2}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler6)**<br>Settings for handling HTTP requests. <br>Only one of `handler` and `redirects` can be specified. 
redirects | **[Redirects](#Redirects2)**<br>Redirects settings. <br>Only one of `redirects` and `handler` can be specified. 


### HttpHandler {#HttpHandler6}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options6)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options6}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### Redirects {#Redirects2}

Field | Description
--- | ---
http_to_https | **bool**<br>Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`. <br>The setting has the same effect as a single, catch-all [HttpRoute](#HttpRoute) with [RedirectAction.replace_scheme](#RedirectAction) set to `https`. 


### TlsListener {#TlsListener2}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler4)**<br>Required. Settings for handling HTTPS requests by default, with Server Name Indication (SNI) not matching any of the `sni_handlers`. 
sni_handlers[] | **[SniMatch](#SniMatch2)**<br>Settings for handling HTTPS requests with Server Name Indication (SNI) matching one of [SniMatch.server_names](#SniMatch2) values. 


### TlsHandler {#TlsHandler4}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler7)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler6)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler7}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options7)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options7}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler6}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### SniMatch {#SniMatch2}

Field | Description
--- | ---
name | **string**<br>Required. Name of the SNI handler. 
server_names[] | **string**<br>Server names that are matched by the SNI handler. The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler5)**<br>Required. Settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. 


### TlsHandler {#TlsHandler5}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler8)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler7)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler8}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options8)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options8}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler7}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### AllocationPolicy {#AllocationPolicy2}

Field | Description
--- | ---
locations[] | **[Location](#Location2)**<br>Availability zones and subnets that the application load balancer resides. The minimum number of elements is 1.


### Location {#Location2}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the application load balancer resides. <br>Each Yandex Cloud availability zone can only be specified once. 
subnet_id | **string**<br>ID of the subnet that the application load balancer belongs to. 
disable_traffic | **bool**<br>Disables the load balancer node in the specified availability zone. <br>Backends in the availability zone are not directly affected by this setting. They still may receive traffic from the load balancer nodes in other availability zones, subject to [LoadBalancingConfig.locality_aware_routing_percent](#LoadBalancingConfig) and [LoadBalancingConfig.strict_locality](#LoadBalancingConfig) settings. 


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
load_balancer_id | **string**<br>ID of the application load balancer that is being created. 


### LoadBalancer {#LoadBalancer2}

Field | Description
--- | ---
id | **string**<br>ID of the application load balancer. Generated at creation time. 
name | **string**<br>Name of the application load balancer. The name is unique within the folder. 
description | **string**<br>Description of the application load balancer. 
folder_id | **string**<br>ID of the folder that the application load balancer belongs to. 
labels | **map<string,string>**<br>Application load balancer labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: The application load balancer is being created.</li><li>`STARTING`: The application load balancer is being started.</li><li>`ACTIVE`: The application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: The application load balancer is being stopped.</li><li>`STOPPED`: The application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: The application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the application load balancer is located at. <br>Currently Yandex Cloud supports only `ru-central1` region. 
network_id | **string**<br>ID of the network that the application load balancer belongs to. 
listeners[] | **[Listener](#Listener2)**<br>Listeners that belong to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener). 
allocation_policy | **[AllocationPolicy](#AllocationPolicy3)**<br>Locality settings of the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location). 
log_group_id | **string**<br>ID of the log group that stores access logs of the application load balancer. <br>The logs can be accessed using a Cloud Functions [trigger for Cloud Logs](/docs/functions/operations/trigger/cloudlogs-trigger-create). 
security_group_ids[] | **string**<br>ID's of the security groups attributed to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#security-groups). 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### Listener {#Listener2}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name is unique within the application load balancer. The string length in characters is 3-63. 
endpoints[] | **[Endpoint](#Endpoint2)**<br>Endpoints of the listener. <br>Endpoints are defined by their IP addresses and ports. 
listener | **oneof:** `http`, `tls` or `tcp`<br>HTTP or HTTPS (HTTP over TLS) listener settings.
&nbsp;&nbsp;http | **[HttpListener](#HttpListener3)**<br>HTTP listener settings. 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener3)**<br>HTTPS (HTTP over TLS) listener settings. 
&nbsp;&nbsp;tcp | **[TcpListener](#TcpListener2)**<br>TCP listener settings. 


### Endpoint {#Endpoint2}

Field | Description
--- | ---
addresses[] | **[Address](#Address2)**<br>Endpoint public (external) and internal addresses. The number of elements must be greater than 0.
ports[] | **int64**<br>Endpoint ports. The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address2}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address2)**<br>Public IPv4 endpoint address. 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address2)**<br>Internal IPv4 endpoint address. <br>To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address2)**<br>Public IPv6 endpoint address. 


### ExternalIpv4Address {#ExternalIpv4Address2}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 


### InternalIpv4Address {#InternalIpv4Address2}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 
subnet_id | **string**<br>ID of the subnet that the address belongs to. 


### ExternalIpv6Address {#ExternalIpv6Address2}

Field | Description
--- | ---
address | **string**<br>IPv6 address. 


### HttpListener {#HttpListener3}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler9)**<br>Settings for handling HTTP requests. <br>Only one of `handler` and `redirects` can be specified. 
redirects | **[Redirects](#Redirects3)**<br>Redirects settings. <br>Only one of `redirects` and `handler` can be specified. 


### HttpHandler {#HttpHandler9}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options9)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options9}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### Redirects {#Redirects3}

Field | Description
--- | ---
http_to_https | **bool**<br>Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`. <br>The setting has the same effect as a single, catch-all [HttpRoute](#HttpRoute) with [RedirectAction.replace_scheme](#RedirectAction) set to `https`. 


### TlsListener {#TlsListener3}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler6)**<br>Required. Settings for handling HTTPS requests by default, with Server Name Indication (SNI) not matching any of the `sni_handlers`. 
sni_handlers[] | **[SniMatch](#SniMatch3)**<br>Settings for handling HTTPS requests with Server Name Indication (SNI) matching one of [SniMatch.server_names](#SniMatch3) values. 


### TlsHandler {#TlsHandler6}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler10)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler8)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler10}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options10)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options10}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler8}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### SniMatch {#SniMatch3}

Field | Description
--- | ---
name | **string**<br>Required. Name of the SNI handler. 
server_names[] | **string**<br>Server names that are matched by the SNI handler. The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler7)**<br>Required. Settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. 


### TlsHandler {#TlsHandler7}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler11)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler9)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler11}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options11)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options11}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler9}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### TcpListener {#TcpListener2}

Field | Description
--- | ---
handler | **[StreamHandler](#StreamHandler10)**<br>Required.  


### StreamHandler {#StreamHandler10}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### AllocationPolicy {#AllocationPolicy3}

Field | Description
--- | ---
locations[] | **[Location](#Location3)**<br>Availability zones and subnets that the application load balancer resides. The minimum number of elements is 1.


### Location {#Location3}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the application load balancer resides. <br>Each Yandex Cloud availability zone can only be specified once. 
subnet_id | **string**<br>ID of the subnet that the application load balancer belongs to. 
disable_traffic | **bool**<br>Disables the load balancer node in the specified availability zone. <br>Backends in the availability zone are not directly affected by this setting. They still may receive traffic from the load balancer nodes in other availability zones, subject to [LoadBalancingConfig.locality_aware_routing_percent](#LoadBalancingConfig) and [LoadBalancingConfig.strict_locality](#LoadBalancingConfig) settings. 


## Update {#Update}

Updates the specified application load balancer.

**rpc Update ([UpdateLoadBalancerRequest](#UpdateLoadBalancerRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateLoadBalancerMetadata](#UpdateLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](#LoadBalancer3)<br>

### UpdateLoadBalancerRequest {#UpdateLoadBalancerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required. ID of the application load balancer to update. <br>To get the application load balancer ID, make a [LoadBalancerService.List](#List) request. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the application load balancer should be updated. 
name | **string**<br>New name for the application load balancer. The name must be unique within the folder. Value must match the regular expression ` ([a-z]([-a-z0-9]{0,61}[a-z0-9])?)? `.
description | **string**<br>New description of the application load balancer. The maximum string length in characters is 256.
labels | **map<string,string>**<br><ol><li>Get the current set of labels with a [LoadBalancerService.Get](#Get) request. </li><li>Add or remove a label in this set. </li><li>Send the new set in this field.</li></ol> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
listener_specs[] | **[ListenerSpec](#ListenerSpec)**<br>New listeners for the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener). <br>Existing list of listeners is completely replaced by the specified list, so if you just want to add, update, or remove a listener, make a [LoadBalancerService.AddListener](#AddListener) request, a [LoadBalancerService.UpdateListener](#UpdateListener) request, or a [LoadBalancerService.RemoveListener](#RemoveListener) request. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy4)**<br><ol><li>Get the current settings with a [LoadBalancerService.Get](#Get) request. </li><li>Add or remove a policy in this set. </li><li>Send the new set in this field.</li></ol> 
security_group_ids[] | **string**<br><ol><li>Get the current set of security groups with a [LoadBalancerService.Get](#Get) request. </li><li>Add or remove a group in this set. </li><li>Send the new set in this field.</li></ol> 


### ListenerSpec {#ListenerSpec1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name is unique within the application load balancer. Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
endpoint_specs[] | **[EndpointSpec](#EndpointSpec)**<br>Endpoints of the listener. <br>Endpoints are defined by their IP addresses and ports. The number of elements must be greater than 0.
listener | **oneof:** `http` or `tls`<br>HTTP or HTTPS (HTTP over TLS) listener settings.
&nbsp;&nbsp;http | **[HttpListener](#HttpListener4)**<br>HTTP listener settings. 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener4)**<br>HTTPS (HTTP over TLS) listener settings. 


### EndpointSpec {#EndpointSpec1}

Field | Description
--- | ---
address_specs[] | **[AddressSpec](#AddressSpec)**<br>Endpoint public (external) and internal addresses. The number of elements must be greater than 0.
ports[] | **int64**<br>Endpoint ports. The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### AddressSpec {#AddressSpec1}

Field | Description
--- | ---
address_spec | **oneof:** `external_ipv4_address_spec`, `internal_ipv4_address_spec` or `external_ipv6_address_spec`<br>Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address.
&nbsp;&nbsp;external_ipv4_address_spec | **[ExternalIpv4AddressSpec](#ExternalIpv4AddressSpec)**<br>Public IPv4 endpoint address. 
&nbsp;&nbsp;internal_ipv4_address_spec | **[InternalIpv4AddressSpec](#InternalIpv4AddressSpec)**<br>Internal IPv4 endpoint address. <br>To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). 
&nbsp;&nbsp;external_ipv6_address_spec | **[ExternalIpv6AddressSpec](#ExternalIpv6AddressSpec)**<br>Public IPv6 endpoint address. 


### ExternalIpv4AddressSpec {#ExternalIpv4AddressSpec1}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 


### InternalIpv4AddressSpec {#InternalIpv4AddressSpec1}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 
subnet_id | **string**<br>ID of the subnet that the address belongs to. 


### ExternalIpv6AddressSpec {#ExternalIpv6AddressSpec1}

Field | Description
--- | ---
address | **string**<br>IPv6 address. 


### HttpListener {#HttpListener4}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler12)**<br>Settings for handling HTTP requests. <br>Only one of `handler` and `redirects` can be specified. 
redirects | **[Redirects](#Redirects4)**<br>Redirects settings. <br>Only one of `redirects` and `handler` can be specified. 


### HttpHandler {#HttpHandler12}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options12)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options12}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### Redirects {#Redirects4}

Field | Description
--- | ---
http_to_https | **bool**<br>Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`. <br>The setting has the same effect as a single, catch-all [HttpRoute](#HttpRoute) with [RedirectAction.replace_scheme](#RedirectAction) set to `https`. 


### TlsListener {#TlsListener4}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler8)**<br>Required. Settings for handling HTTPS requests by default, with Server Name Indication (SNI) not matching any of the `sni_handlers`. 
sni_handlers[] | **[SniMatch](#SniMatch4)**<br>Settings for handling HTTPS requests with Server Name Indication (SNI) matching one of [SniMatch.server_names](#SniMatch4) values. 


### TlsHandler {#TlsHandler8}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler13)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler11)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler13}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options13)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options13}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler11}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### SniMatch {#SniMatch4}

Field | Description
--- | ---
name | **string**<br>Required. Name of the SNI handler. 
server_names[] | **string**<br>Server names that are matched by the SNI handler. The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler9)**<br>Required. Settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. 


### TlsHandler {#TlsHandler9}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler14)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler12)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler14}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options14)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options14}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler12}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### AllocationPolicy {#AllocationPolicy4}

Field | Description
--- | ---
locations[] | **[Location](#Location4)**<br>Availability zones and subnets that the application load balancer resides. The minimum number of elements is 1.


### Location {#Location4}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the application load balancer resides. <br>Each Yandex Cloud availability zone can only be specified once. 
subnet_id | **string**<br>ID of the subnet that the application load balancer belongs to. 
disable_traffic | **bool**<br>Disables the load balancer node in the specified availability zone. <br>Backends in the availability zone are not directly affected by this setting. They still may receive traffic from the load balancer nodes in other availability zones, subject to [LoadBalancingConfig.locality_aware_routing_percent](#LoadBalancingConfig) and [LoadBalancingConfig.strict_locality](#LoadBalancingConfig) settings. 


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
load_balancer_id | **string**<br>ID of the application load balancer that is being updated. 


### LoadBalancer {#LoadBalancer3}

Field | Description
--- | ---
id | **string**<br>ID of the application load balancer. Generated at creation time. 
name | **string**<br>Name of the application load balancer. The name is unique within the folder. 
description | **string**<br>Description of the application load balancer. 
folder_id | **string**<br>ID of the folder that the application load balancer belongs to. 
labels | **map<string,string>**<br>Application load balancer labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: The application load balancer is being created.</li><li>`STARTING`: The application load balancer is being started.</li><li>`ACTIVE`: The application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: The application load balancer is being stopped.</li><li>`STOPPED`: The application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: The application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the application load balancer is located at. <br>Currently Yandex Cloud supports only `ru-central1` region. 
network_id | **string**<br>ID of the network that the application load balancer belongs to. 
listeners[] | **[Listener](#Listener3)**<br>Listeners that belong to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener). 
allocation_policy | **[AllocationPolicy](#AllocationPolicy5)**<br>Locality settings of the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location). 
log_group_id | **string**<br>ID of the log group that stores access logs of the application load balancer. <br>The logs can be accessed using a Cloud Functions [trigger for Cloud Logs](/docs/functions/operations/trigger/cloudlogs-trigger-create). 
security_group_ids[] | **string**<br>ID's of the security groups attributed to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#security-groups). 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### Listener {#Listener3}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name is unique within the application load balancer. The string length in characters is 3-63. 
endpoints[] | **[Endpoint](#Endpoint3)**<br>Endpoints of the listener. <br>Endpoints are defined by their IP addresses and ports. 
listener | **oneof:** `http`, `tls` or `tcp`<br>HTTP or HTTPS (HTTP over TLS) listener settings.
&nbsp;&nbsp;http | **[HttpListener](#HttpListener5)**<br>HTTP listener settings. 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener5)**<br>HTTPS (HTTP over TLS) listener settings. 
&nbsp;&nbsp;tcp | **[TcpListener](#TcpListener3)**<br>TCP listener settings. 


### Endpoint {#Endpoint3}

Field | Description
--- | ---
addresses[] | **[Address](#Address3)**<br>Endpoint public (external) and internal addresses. The number of elements must be greater than 0.
ports[] | **int64**<br>Endpoint ports. The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address3}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address3)**<br>Public IPv4 endpoint address. 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address3)**<br>Internal IPv4 endpoint address. <br>To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address3)**<br>Public IPv6 endpoint address. 


### ExternalIpv4Address {#ExternalIpv4Address3}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 


### InternalIpv4Address {#InternalIpv4Address3}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 
subnet_id | **string**<br>ID of the subnet that the address belongs to. 


### ExternalIpv6Address {#ExternalIpv6Address3}

Field | Description
--- | ---
address | **string**<br>IPv6 address. 


### HttpListener {#HttpListener5}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler15)**<br>Settings for handling HTTP requests. <br>Only one of `handler` and `redirects` can be specified. 
redirects | **[Redirects](#Redirects5)**<br>Redirects settings. <br>Only one of `redirects` and `handler` can be specified. 


### HttpHandler {#HttpHandler15}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options15)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options15}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### Redirects {#Redirects5}

Field | Description
--- | ---
http_to_https | **bool**<br>Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`. <br>The setting has the same effect as a single, catch-all [HttpRoute](#HttpRoute) with [RedirectAction.replace_scheme](#RedirectAction) set to `https`. 


### TlsListener {#TlsListener5}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler10)**<br>Required. Settings for handling HTTPS requests by default, with Server Name Indication (SNI) not matching any of the `sni_handlers`. 
sni_handlers[] | **[SniMatch](#SniMatch5)**<br>Settings for handling HTTPS requests with Server Name Indication (SNI) matching one of [SniMatch.server_names](#SniMatch5) values. 


### TlsHandler {#TlsHandler10}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler16)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler13)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler16}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options16)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options16}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler13}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### SniMatch {#SniMatch5}

Field | Description
--- | ---
name | **string**<br>Required. Name of the SNI handler. 
server_names[] | **string**<br>Server names that are matched by the SNI handler. The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler11)**<br>Required. Settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. 


### TlsHandler {#TlsHandler11}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler17)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler14)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler17}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options17)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options17}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler14}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### TcpListener {#TcpListener3}

Field | Description
--- | ---
handler | **[StreamHandler](#StreamHandler15)**<br>Required.  


### StreamHandler {#StreamHandler15}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### AllocationPolicy {#AllocationPolicy5}

Field | Description
--- | ---
locations[] | **[Location](#Location5)**<br>Availability zones and subnets that the application load balancer resides. The minimum number of elements is 1.


### Location {#Location5}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the application load balancer resides. <br>Each Yandex Cloud availability zone can only be specified once. 
subnet_id | **string**<br>ID of the subnet that the application load balancer belongs to. 
disable_traffic | **bool**<br>Disables the load balancer node in the specified availability zone. <br>Backends in the availability zone are not directly affected by this setting. They still may receive traffic from the load balancer nodes in other availability zones, subject to [LoadBalancingConfig.locality_aware_routing_percent](#LoadBalancingConfig) and [LoadBalancingConfig.strict_locality](#LoadBalancingConfig) settings. 


## Delete {#Delete}

Deletes the specified application load balancer.

**rpc Delete ([DeleteLoadBalancerRequest](#DeleteLoadBalancerRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteLoadBalancerMetadata](#DeleteLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteLoadBalancerRequest {#DeleteLoadBalancerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required. ID of the application load balancer to delete. <br>To get the application load balancer ID, make a [LoadBalancerService.List](#List) request. 


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
load_balancer_id | **string**<br>ID of the application load balancer that is being deleted. 


## Start {#Start}

Starts the specified application load balancer.

**rpc Start ([StartLoadBalancerRequest](#StartLoadBalancerRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartLoadBalancerMetadata](#StartLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](#LoadBalancer4)<br>

### StartLoadBalancerRequest {#StartLoadBalancerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required. ID of the application load balancer to start. <br>The application load balancer must have a `STOPPED` status ([LoadBalancer.status](#LoadBalancer4)). <br>To get the application load balancer ID, make a [LoadBalancerService.List](#List) request. 


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
load_balancer_id | **string**<br>ID of the application load balancer that is being started. 


### LoadBalancer {#LoadBalancer4}

Field | Description
--- | ---
id | **string**<br>ID of the application load balancer. Generated at creation time. 
name | **string**<br>Name of the application load balancer. The name is unique within the folder. 
description | **string**<br>Description of the application load balancer. 
folder_id | **string**<br>ID of the folder that the application load balancer belongs to. 
labels | **map<string,string>**<br>Application load balancer labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: The application load balancer is being created.</li><li>`STARTING`: The application load balancer is being started.</li><li>`ACTIVE`: The application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: The application load balancer is being stopped.</li><li>`STOPPED`: The application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: The application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the application load balancer is located at. <br>Currently Yandex Cloud supports only `ru-central1` region. 
network_id | **string**<br>ID of the network that the application load balancer belongs to. 
listeners[] | **[Listener](#Listener4)**<br>Listeners that belong to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener). 
allocation_policy | **[AllocationPolicy](#AllocationPolicy6)**<br>Locality settings of the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location). 
log_group_id | **string**<br>ID of the log group that stores access logs of the application load balancer. <br>The logs can be accessed using a Cloud Functions [trigger for Cloud Logs](/docs/functions/operations/trigger/cloudlogs-trigger-create). 
security_group_ids[] | **string**<br>ID's of the security groups attributed to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#security-groups). 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### Listener {#Listener4}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name is unique within the application load balancer. The string length in characters is 3-63. 
endpoints[] | **[Endpoint](#Endpoint4)**<br>Endpoints of the listener. <br>Endpoints are defined by their IP addresses and ports. 
listener | **oneof:** `http`, `tls` or `tcp`<br>HTTP or HTTPS (HTTP over TLS) listener settings.
&nbsp;&nbsp;http | **[HttpListener](#HttpListener6)**<br>HTTP listener settings. 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener6)**<br>HTTPS (HTTP over TLS) listener settings. 
&nbsp;&nbsp;tcp | **[TcpListener](#TcpListener4)**<br>TCP listener settings. 


### Endpoint {#Endpoint4}

Field | Description
--- | ---
addresses[] | **[Address](#Address4)**<br>Endpoint public (external) and internal addresses. The number of elements must be greater than 0.
ports[] | **int64**<br>Endpoint ports. The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address4}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address4)**<br>Public IPv4 endpoint address. 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address4)**<br>Internal IPv4 endpoint address. <br>To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address4)**<br>Public IPv6 endpoint address. 


### ExternalIpv4Address {#ExternalIpv4Address4}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 


### InternalIpv4Address {#InternalIpv4Address4}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 
subnet_id | **string**<br>ID of the subnet that the address belongs to. 


### ExternalIpv6Address {#ExternalIpv6Address4}

Field | Description
--- | ---
address | **string**<br>IPv6 address. 


### HttpListener {#HttpListener6}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler18)**<br>Settings for handling HTTP requests. <br>Only one of `handler` and `redirects` can be specified. 
redirects | **[Redirects](#Redirects6)**<br>Redirects settings. <br>Only one of `redirects` and `handler` can be specified. 


### HttpHandler {#HttpHandler18}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options18)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options18}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### Redirects {#Redirects6}

Field | Description
--- | ---
http_to_https | **bool**<br>Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`. <br>The setting has the same effect as a single, catch-all [HttpRoute](#HttpRoute) with [RedirectAction.replace_scheme](#RedirectAction) set to `https`. 


### TlsListener {#TlsListener6}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler12)**<br>Required. Settings for handling HTTPS requests by default, with Server Name Indication (SNI) not matching any of the `sni_handlers`. 
sni_handlers[] | **[SniMatch](#SniMatch6)**<br>Settings for handling HTTPS requests with Server Name Indication (SNI) matching one of [SniMatch.server_names](#SniMatch6) values. 


### TlsHandler {#TlsHandler12}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler19)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler16)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler19}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options19)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options19}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler16}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### SniMatch {#SniMatch6}

Field | Description
--- | ---
name | **string**<br>Required. Name of the SNI handler. 
server_names[] | **string**<br>Server names that are matched by the SNI handler. The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler13)**<br>Required. Settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. 


### TlsHandler {#TlsHandler13}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler20)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler17)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler20}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options20)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options20}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler17}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### TcpListener {#TcpListener4}

Field | Description
--- | ---
handler | **[StreamHandler](#StreamHandler18)**<br>Required.  


### StreamHandler {#StreamHandler18}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### AllocationPolicy {#AllocationPolicy6}

Field | Description
--- | ---
locations[] | **[Location](#Location6)**<br>Availability zones and subnets that the application load balancer resides. The minimum number of elements is 1.


### Location {#Location6}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the application load balancer resides. <br>Each Yandex Cloud availability zone can only be specified once. 
subnet_id | **string**<br>ID of the subnet that the application load balancer belongs to. 
disable_traffic | **bool**<br>Disables the load balancer node in the specified availability zone. <br>Backends in the availability zone are not directly affected by this setting. They still may receive traffic from the load balancer nodes in other availability zones, subject to [LoadBalancingConfig.locality_aware_routing_percent](#LoadBalancingConfig) and [LoadBalancingConfig.strict_locality](#LoadBalancingConfig) settings. 


## Stop {#Stop}

Stops the specified application load balancer.

**rpc Stop ([StopLoadBalancerRequest](#StopLoadBalancerRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopLoadBalancerMetadata](#StopLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](#LoadBalancer5)<br>

### StopLoadBalancerRequest {#StopLoadBalancerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required. ID of the application load balancer to stop. <br>The application load balancer must have an `ACTIVE` status ([LoadBalancer.status](#LoadBalancer5)). <br>To get the application load balancer ID, make a [LoadBalancerService.List](#List) request. 


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
load_balancer_id | **string**<br>ID of the application load balancer that is being stopped. 


### LoadBalancer {#LoadBalancer5}

Field | Description
--- | ---
id | **string**<br>ID of the application load balancer. Generated at creation time. 
name | **string**<br>Name of the application load balancer. The name is unique within the folder. 
description | **string**<br>Description of the application load balancer. 
folder_id | **string**<br>ID of the folder that the application load balancer belongs to. 
labels | **map<string,string>**<br>Application load balancer labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: The application load balancer is being created.</li><li>`STARTING`: The application load balancer is being started.</li><li>`ACTIVE`: The application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: The application load balancer is being stopped.</li><li>`STOPPED`: The application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: The application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the application load balancer is located at. <br>Currently Yandex Cloud supports only `ru-central1` region. 
network_id | **string**<br>ID of the network that the application load balancer belongs to. 
listeners[] | **[Listener](#Listener5)**<br>Listeners that belong to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener). 
allocation_policy | **[AllocationPolicy](#AllocationPolicy7)**<br>Locality settings of the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location). 
log_group_id | **string**<br>ID of the log group that stores access logs of the application load balancer. <br>The logs can be accessed using a Cloud Functions [trigger for Cloud Logs](/docs/functions/operations/trigger/cloudlogs-trigger-create). 
security_group_ids[] | **string**<br>ID's of the security groups attributed to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#security-groups). 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### Listener {#Listener5}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name is unique within the application load balancer. The string length in characters is 3-63. 
endpoints[] | **[Endpoint](#Endpoint5)**<br>Endpoints of the listener. <br>Endpoints are defined by their IP addresses and ports. 
listener | **oneof:** `http`, `tls` or `tcp`<br>HTTP or HTTPS (HTTP over TLS) listener settings.
&nbsp;&nbsp;http | **[HttpListener](#HttpListener7)**<br>HTTP listener settings. 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener7)**<br>HTTPS (HTTP over TLS) listener settings. 
&nbsp;&nbsp;tcp | **[TcpListener](#TcpListener5)**<br>TCP listener settings. 


### Endpoint {#Endpoint5}

Field | Description
--- | ---
addresses[] | **[Address](#Address5)**<br>Endpoint public (external) and internal addresses. The number of elements must be greater than 0.
ports[] | **int64**<br>Endpoint ports. The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address5}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address5)**<br>Public IPv4 endpoint address. 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address5)**<br>Internal IPv4 endpoint address. <br>To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address5)**<br>Public IPv6 endpoint address. 


### ExternalIpv4Address {#ExternalIpv4Address5}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 


### InternalIpv4Address {#InternalIpv4Address5}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 
subnet_id | **string**<br>ID of the subnet that the address belongs to. 


### ExternalIpv6Address {#ExternalIpv6Address5}

Field | Description
--- | ---
address | **string**<br>IPv6 address. 


### HttpListener {#HttpListener7}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler21)**<br>Settings for handling HTTP requests. <br>Only one of `handler` and `redirects` can be specified. 
redirects | **[Redirects](#Redirects7)**<br>Redirects settings. <br>Only one of `redirects` and `handler` can be specified. 


### HttpHandler {#HttpHandler21}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options21)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options21}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### Redirects {#Redirects7}

Field | Description
--- | ---
http_to_https | **bool**<br>Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`. <br>The setting has the same effect as a single, catch-all [HttpRoute](#HttpRoute) with [RedirectAction.replace_scheme](#RedirectAction) set to `https`. 


### TlsListener {#TlsListener7}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler14)**<br>Required. Settings for handling HTTPS requests by default, with Server Name Indication (SNI) not matching any of the `sni_handlers`. 
sni_handlers[] | **[SniMatch](#SniMatch7)**<br>Settings for handling HTTPS requests with Server Name Indication (SNI) matching one of [SniMatch.server_names](#SniMatch7) values. 


### TlsHandler {#TlsHandler14}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler22)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler19)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler22}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options22)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options22}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler19}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### SniMatch {#SniMatch7}

Field | Description
--- | ---
name | **string**<br>Required. Name of the SNI handler. 
server_names[] | **string**<br>Server names that are matched by the SNI handler. The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler15)**<br>Required. Settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. 


### TlsHandler {#TlsHandler15}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler23)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler20)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler23}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options23)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options23}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler20}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### TcpListener {#TcpListener5}

Field | Description
--- | ---
handler | **[StreamHandler](#StreamHandler21)**<br>Required.  


### StreamHandler {#StreamHandler21}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### AllocationPolicy {#AllocationPolicy7}

Field | Description
--- | ---
locations[] | **[Location](#Location7)**<br>Availability zones and subnets that the application load balancer resides. The minimum number of elements is 1.


### Location {#Location7}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the application load balancer resides. <br>Each Yandex Cloud availability zone can only be specified once. 
subnet_id | **string**<br>ID of the subnet that the application load balancer belongs to. 
disable_traffic | **bool**<br>Disables the load balancer node in the specified availability zone. <br>Backends in the availability zone are not directly affected by this setting. They still may receive traffic from the load balancer nodes in other availability zones, subject to [LoadBalancingConfig.locality_aware_routing_percent](#LoadBalancingConfig) and [LoadBalancingConfig.strict_locality](#LoadBalancingConfig) settings. 


## AddListener {#AddListener}

AddListener/UpdateListener technically do the same, but have different semantics. Adds a listener to the specified application load balancer.

**rpc AddListener ([AddListenerRequest](#AddListenerRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddListenerMetadata](#AddListenerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](#LoadBalancer6)<br>

### AddListenerRequest {#AddListenerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required. ID of the application load balancer to add a listener to. 
listener_spec | **[ListenerSpec](#ListenerSpec)**<br>Required. Listener to add to the application load balancer. 


### ListenerSpec {#ListenerSpec2}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name is unique within the application load balancer. Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
endpoint_specs[] | **[EndpointSpec](#EndpointSpec)**<br>Endpoints of the listener. <br>Endpoints are defined by their IP addresses and ports. The number of elements must be greater than 0.
listener | **oneof:** `http` or `tls`<br>HTTP or HTTPS (HTTP over TLS) listener settings.
&nbsp;&nbsp;http | **[HttpListener](#HttpListener8)**<br>HTTP listener settings. 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener8)**<br>HTTPS (HTTP over TLS) listener settings. 


### EndpointSpec {#EndpointSpec2}

Field | Description
--- | ---
address_specs[] | **[AddressSpec](#AddressSpec)**<br>Endpoint public (external) and internal addresses. The number of elements must be greater than 0.
ports[] | **int64**<br>Endpoint ports. The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### AddressSpec {#AddressSpec2}

Field | Description
--- | ---
address_spec | **oneof:** `external_ipv4_address_spec`, `internal_ipv4_address_spec` or `external_ipv6_address_spec`<br>Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address.
&nbsp;&nbsp;external_ipv4_address_spec | **[ExternalIpv4AddressSpec](#ExternalIpv4AddressSpec)**<br>Public IPv4 endpoint address. 
&nbsp;&nbsp;internal_ipv4_address_spec | **[InternalIpv4AddressSpec](#InternalIpv4AddressSpec)**<br>Internal IPv4 endpoint address. <br>To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). 
&nbsp;&nbsp;external_ipv6_address_spec | **[ExternalIpv6AddressSpec](#ExternalIpv6AddressSpec)**<br>Public IPv6 endpoint address. 


### ExternalIpv4AddressSpec {#ExternalIpv4AddressSpec2}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 


### InternalIpv4AddressSpec {#InternalIpv4AddressSpec2}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 
subnet_id | **string**<br>ID of the subnet that the address belongs to. 


### ExternalIpv6AddressSpec {#ExternalIpv6AddressSpec2}

Field | Description
--- | ---
address | **string**<br>IPv6 address. 


### HttpListener {#HttpListener8}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler24)**<br>Settings for handling HTTP requests. <br>Only one of `handler` and `redirects` can be specified. 
redirects | **[Redirects](#Redirects8)**<br>Redirects settings. <br>Only one of `redirects` and `handler` can be specified. 


### HttpHandler {#HttpHandler24}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options24)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options24}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### Redirects {#Redirects8}

Field | Description
--- | ---
http_to_https | **bool**<br>Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`. <br>The setting has the same effect as a single, catch-all [HttpRoute](#HttpRoute) with [RedirectAction.replace_scheme](#RedirectAction) set to `https`. 


### TlsListener {#TlsListener8}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler16)**<br>Required. Settings for handling HTTPS requests by default, with Server Name Indication (SNI) not matching any of the `sni_handlers`. 
sni_handlers[] | **[SniMatch](#SniMatch8)**<br>Settings for handling HTTPS requests with Server Name Indication (SNI) matching one of [SniMatch.server_names](#SniMatch8) values. 


### TlsHandler {#TlsHandler16}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler25)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler22)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler25}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options25)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options25}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler22}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### SniMatch {#SniMatch8}

Field | Description
--- | ---
name | **string**<br>Required. Name of the SNI handler. 
server_names[] | **string**<br>Server names that are matched by the SNI handler. The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler17)**<br>Required. Settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. 


### TlsHandler {#TlsHandler17}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler26)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler23)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler26}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options26)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options26}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler23}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


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
load_balancer_id | **string**<br>ID of the application load balancer that the listener is being added to. 
listener_name | **string**<br>Name of the listener that is being added to the application load balancer. 


### LoadBalancer {#LoadBalancer6}

Field | Description
--- | ---
id | **string**<br>ID of the application load balancer. Generated at creation time. 
name | **string**<br>Name of the application load balancer. The name is unique within the folder. 
description | **string**<br>Description of the application load balancer. 
folder_id | **string**<br>ID of the folder that the application load balancer belongs to. 
labels | **map<string,string>**<br>Application load balancer labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: The application load balancer is being created.</li><li>`STARTING`: The application load balancer is being started.</li><li>`ACTIVE`: The application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: The application load balancer is being stopped.</li><li>`STOPPED`: The application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: The application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the application load balancer is located at. <br>Currently Yandex Cloud supports only `ru-central1` region. 
network_id | **string**<br>ID of the network that the application load balancer belongs to. 
listeners[] | **[Listener](#Listener6)**<br>Listeners that belong to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener). 
allocation_policy | **[AllocationPolicy](#AllocationPolicy8)**<br>Locality settings of the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location). 
log_group_id | **string**<br>ID of the log group that stores access logs of the application load balancer. <br>The logs can be accessed using a Cloud Functions [trigger for Cloud Logs](/docs/functions/operations/trigger/cloudlogs-trigger-create). 
security_group_ids[] | **string**<br>ID's of the security groups attributed to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#security-groups). 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### Listener {#Listener6}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name is unique within the application load balancer. The string length in characters is 3-63. 
endpoints[] | **[Endpoint](#Endpoint6)**<br>Endpoints of the listener. <br>Endpoints are defined by their IP addresses and ports. 
listener | **oneof:** `http`, `tls` or `tcp`<br>HTTP or HTTPS (HTTP over TLS) listener settings.
&nbsp;&nbsp;http | **[HttpListener](#HttpListener9)**<br>HTTP listener settings. 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener9)**<br>HTTPS (HTTP over TLS) listener settings. 
&nbsp;&nbsp;tcp | **[TcpListener](#TcpListener6)**<br>TCP listener settings. 


### Endpoint {#Endpoint6}

Field | Description
--- | ---
addresses[] | **[Address](#Address6)**<br>Endpoint public (external) and internal addresses. The number of elements must be greater than 0.
ports[] | **int64**<br>Endpoint ports. The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address6}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address6)**<br>Public IPv4 endpoint address. 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address6)**<br>Internal IPv4 endpoint address. <br>To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address6)**<br>Public IPv6 endpoint address. 


### ExternalIpv4Address {#ExternalIpv4Address6}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 


### InternalIpv4Address {#InternalIpv4Address6}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 
subnet_id | **string**<br>ID of the subnet that the address belongs to. 


### ExternalIpv6Address {#ExternalIpv6Address6}

Field | Description
--- | ---
address | **string**<br>IPv6 address. 


### HttpListener {#HttpListener9}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler27)**<br>Settings for handling HTTP requests. <br>Only one of `handler` and `redirects` can be specified. 
redirects | **[Redirects](#Redirects9)**<br>Redirects settings. <br>Only one of `redirects` and `handler` can be specified. 


### HttpHandler {#HttpHandler27}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options27)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options27}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### Redirects {#Redirects9}

Field | Description
--- | ---
http_to_https | **bool**<br>Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`. <br>The setting has the same effect as a single, catch-all [HttpRoute](#HttpRoute) with [RedirectAction.replace_scheme](#RedirectAction) set to `https`. 


### TlsListener {#TlsListener9}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler18)**<br>Required. Settings for handling HTTPS requests by default, with Server Name Indication (SNI) not matching any of the `sni_handlers`. 
sni_handlers[] | **[SniMatch](#SniMatch9)**<br>Settings for handling HTTPS requests with Server Name Indication (SNI) matching one of [SniMatch.server_names](#SniMatch9) values. 


### TlsHandler {#TlsHandler18}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler28)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler24)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler28}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options28)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options28}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler24}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### SniMatch {#SniMatch9}

Field | Description
--- | ---
name | **string**<br>Required. Name of the SNI handler. 
server_names[] | **string**<br>Server names that are matched by the SNI handler. The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler19)**<br>Required. Settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. 


### TlsHandler {#TlsHandler19}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler29)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler25)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler29}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options29)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options29}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler25}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### TcpListener {#TcpListener6}

Field | Description
--- | ---
handler | **[StreamHandler](#StreamHandler26)**<br>Required.  


### StreamHandler {#StreamHandler26}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### AllocationPolicy {#AllocationPolicy8}

Field | Description
--- | ---
locations[] | **[Location](#Location8)**<br>Availability zones and subnets that the application load balancer resides. The minimum number of elements is 1.


### Location {#Location8}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the application load balancer resides. <br>Each Yandex Cloud availability zone can only be specified once. 
subnet_id | **string**<br>ID of the subnet that the application load balancer belongs to. 
disable_traffic | **bool**<br>Disables the load balancer node in the specified availability zone. <br>Backends in the availability zone are not directly affected by this setting. They still may receive traffic from the load balancer nodes in other availability zones, subject to [LoadBalancingConfig.locality_aware_routing_percent](#LoadBalancingConfig) and [LoadBalancingConfig.strict_locality](#LoadBalancingConfig) settings. 


## RemoveListener {#RemoveListener}

Deletes the specified listener.

**rpc RemoveListener ([RemoveListenerRequest](#RemoveListenerRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveListenerMetadata](#RemoveListenerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](#LoadBalancer7)<br>

### RemoveListenerRequest {#RemoveListenerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required. ID of the application load balancer to remove the listener from. 
name | **string**<br>Required. Name of the listener to remove from the application load balancer. 


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
load_balancer_id | **string**<br>ID of the application load balancer that the listener is being removed from. 
listener_name | **string**<br>Name of the listener that is being removed from the application load balancer. 


### LoadBalancer {#LoadBalancer7}

Field | Description
--- | ---
id | **string**<br>ID of the application load balancer. Generated at creation time. 
name | **string**<br>Name of the application load balancer. The name is unique within the folder. 
description | **string**<br>Description of the application load balancer. 
folder_id | **string**<br>ID of the folder that the application load balancer belongs to. 
labels | **map<string,string>**<br>Application load balancer labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: The application load balancer is being created.</li><li>`STARTING`: The application load balancer is being started.</li><li>`ACTIVE`: The application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: The application load balancer is being stopped.</li><li>`STOPPED`: The application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: The application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the application load balancer is located at. <br>Currently Yandex Cloud supports only `ru-central1` region. 
network_id | **string**<br>ID of the network that the application load balancer belongs to. 
listeners[] | **[Listener](#Listener7)**<br>Listeners that belong to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener). 
allocation_policy | **[AllocationPolicy](#AllocationPolicy9)**<br>Locality settings of the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location). 
log_group_id | **string**<br>ID of the log group that stores access logs of the application load balancer. <br>The logs can be accessed using a Cloud Functions [trigger for Cloud Logs](/docs/functions/operations/trigger/cloudlogs-trigger-create). 
security_group_ids[] | **string**<br>ID's of the security groups attributed to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#security-groups). 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### Listener {#Listener7}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name is unique within the application load balancer. The string length in characters is 3-63. 
endpoints[] | **[Endpoint](#Endpoint7)**<br>Endpoints of the listener. <br>Endpoints are defined by their IP addresses and ports. 
listener | **oneof:** `http`, `tls` or `tcp`<br>HTTP or HTTPS (HTTP over TLS) listener settings.
&nbsp;&nbsp;http | **[HttpListener](#HttpListener10)**<br>HTTP listener settings. 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener10)**<br>HTTPS (HTTP over TLS) listener settings. 
&nbsp;&nbsp;tcp | **[TcpListener](#TcpListener7)**<br>TCP listener settings. 


### Endpoint {#Endpoint7}

Field | Description
--- | ---
addresses[] | **[Address](#Address7)**<br>Endpoint public (external) and internal addresses. The number of elements must be greater than 0.
ports[] | **int64**<br>Endpoint ports. The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address7}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address7)**<br>Public IPv4 endpoint address. 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address7)**<br>Internal IPv4 endpoint address. <br>To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address7)**<br>Public IPv6 endpoint address. 


### ExternalIpv4Address {#ExternalIpv4Address7}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 


### InternalIpv4Address {#InternalIpv4Address7}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 
subnet_id | **string**<br>ID of the subnet that the address belongs to. 


### ExternalIpv6Address {#ExternalIpv6Address7}

Field | Description
--- | ---
address | **string**<br>IPv6 address. 


### HttpListener {#HttpListener10}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler30)**<br>Settings for handling HTTP requests. <br>Only one of `handler` and `redirects` can be specified. 
redirects | **[Redirects](#Redirects10)**<br>Redirects settings. <br>Only one of `redirects` and `handler` can be specified. 


### HttpHandler {#HttpHandler30}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options30)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options30}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### Redirects {#Redirects10}

Field | Description
--- | ---
http_to_https | **bool**<br>Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`. <br>The setting has the same effect as a single, catch-all [HttpRoute](#HttpRoute) with [RedirectAction.replace_scheme](#RedirectAction) set to `https`. 


### TlsListener {#TlsListener10}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler20)**<br>Required. Settings for handling HTTPS requests by default, with Server Name Indication (SNI) not matching any of the `sni_handlers`. 
sni_handlers[] | **[SniMatch](#SniMatch10)**<br>Settings for handling HTTPS requests with Server Name Indication (SNI) matching one of [SniMatch.server_names](#SniMatch10) values. 


### TlsHandler {#TlsHandler20}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler31)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler27)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler31}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options31)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options31}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler27}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### SniMatch {#SniMatch10}

Field | Description
--- | ---
name | **string**<br>Required. Name of the SNI handler. 
server_names[] | **string**<br>Server names that are matched by the SNI handler. The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler21)**<br>Required. Settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. 


### TlsHandler {#TlsHandler21}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler32)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler28)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler32}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options32)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options32}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler28}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### TcpListener {#TcpListener7}

Field | Description
--- | ---
handler | **[StreamHandler](#StreamHandler29)**<br>Required.  


### StreamHandler {#StreamHandler29}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### AllocationPolicy {#AllocationPolicy9}

Field | Description
--- | ---
locations[] | **[Location](#Location9)**<br>Availability zones and subnets that the application load balancer resides. The minimum number of elements is 1.


### Location {#Location9}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the application load balancer resides. <br>Each Yandex Cloud availability zone can only be specified once. 
subnet_id | **string**<br>ID of the subnet that the application load balancer belongs to. 
disable_traffic | **bool**<br>Disables the load balancer node in the specified availability zone. <br>Backends in the availability zone are not directly affected by this setting. They still may receive traffic from the load balancer nodes in other availability zones, subject to [LoadBalancingConfig.locality_aware_routing_percent](#LoadBalancingConfig) and [LoadBalancingConfig.strict_locality](#LoadBalancingConfig) settings. 


## UpdateListener {#UpdateListener}

Updates the specified listener of the specified application load balancer.

**rpc UpdateListener ([UpdateListenerRequest](#UpdateListenerRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateListenerMetadata](#UpdateListenerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LoadBalancer](#LoadBalancer8)<br>

### UpdateListenerRequest {#UpdateListenerRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required. ID of the application load balancer to update the listener in. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the listener should be updated. 
listener_spec | **[ListenerSpec](#ListenerSpec)**<br>Required. New attributes of the listener. 


### ListenerSpec {#ListenerSpec3}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name is unique within the application load balancer. Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
endpoint_specs[] | **[EndpointSpec](#EndpointSpec)**<br>Endpoints of the listener. <br>Endpoints are defined by their IP addresses and ports. The number of elements must be greater than 0.
listener | **oneof:** `http` or `tls`<br>HTTP or HTTPS (HTTP over TLS) listener settings.
&nbsp;&nbsp;http | **[HttpListener](#HttpListener11)**<br>HTTP listener settings. 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener11)**<br>HTTPS (HTTP over TLS) listener settings. 


### EndpointSpec {#EndpointSpec3}

Field | Description
--- | ---
address_specs[] | **[AddressSpec](#AddressSpec)**<br>Endpoint public (external) and internal addresses. The number of elements must be greater than 0.
ports[] | **int64**<br>Endpoint ports. The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### AddressSpec {#AddressSpec3}

Field | Description
--- | ---
address_spec | **oneof:** `external_ipv4_address_spec`, `internal_ipv4_address_spec` or `external_ipv6_address_spec`<br>Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address.
&nbsp;&nbsp;external_ipv4_address_spec | **[ExternalIpv4AddressSpec](#ExternalIpv4AddressSpec)**<br>Public IPv4 endpoint address. 
&nbsp;&nbsp;internal_ipv4_address_spec | **[InternalIpv4AddressSpec](#InternalIpv4AddressSpec)**<br>Internal IPv4 endpoint address. <br>To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). 
&nbsp;&nbsp;external_ipv6_address_spec | **[ExternalIpv6AddressSpec](#ExternalIpv6AddressSpec)**<br>Public IPv6 endpoint address. 


### ExternalIpv4AddressSpec {#ExternalIpv4AddressSpec3}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 


### InternalIpv4AddressSpec {#InternalIpv4AddressSpec3}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 
subnet_id | **string**<br>ID of the subnet that the address belongs to. 


### ExternalIpv6AddressSpec {#ExternalIpv6AddressSpec3}

Field | Description
--- | ---
address | **string**<br>IPv6 address. 


### HttpListener {#HttpListener11}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler33)**<br>Settings for handling HTTP requests. <br>Only one of `handler` and `redirects` can be specified. 
redirects | **[Redirects](#Redirects11)**<br>Redirects settings. <br>Only one of `redirects` and `handler` can be specified. 


### HttpHandler {#HttpHandler33}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options33)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options33}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### Redirects {#Redirects11}

Field | Description
--- | ---
http_to_https | **bool**<br>Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`. <br>The setting has the same effect as a single, catch-all [HttpRoute](#HttpRoute) with [RedirectAction.replace_scheme](#RedirectAction) set to `https`. 


### TlsListener {#TlsListener11}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler22)**<br>Required. Settings for handling HTTPS requests by default, with Server Name Indication (SNI) not matching any of the `sni_handlers`. 
sni_handlers[] | **[SniMatch](#SniMatch11)**<br>Settings for handling HTTPS requests with Server Name Indication (SNI) matching one of [SniMatch.server_names](#SniMatch11) values. 


### TlsHandler {#TlsHandler22}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler34)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler30)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler34}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options34)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options34}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler30}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### SniMatch {#SniMatch11}

Field | Description
--- | ---
name | **string**<br>Required. Name of the SNI handler. 
server_names[] | **string**<br>Server names that are matched by the SNI handler. The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler23)**<br>Required. Settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. 


### TlsHandler {#TlsHandler23}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler35)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler31)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler35}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options35)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options35}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler31}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


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
load_balancer_id | **string**<br>ID of the application load balancer that the listener is being updated in. 
listener_name | **string**<br>Name of the listener that is being updated. 


### LoadBalancer {#LoadBalancer8}

Field | Description
--- | ---
id | **string**<br>ID of the application load balancer. Generated at creation time. 
name | **string**<br>Name of the application load balancer. The name is unique within the folder. 
description | **string**<br>Description of the application load balancer. 
folder_id | **string**<br>ID of the folder that the application load balancer belongs to. 
labels | **map<string,string>**<br>Application load balancer labels as `key:value` pairs. For details about the concept, see [documentation](/docs/overview/concepts/services#labels). 
status | enum **Status**<br>Status of the application load balancer. <ul><li>`CREATING`: The application load balancer is being created.</li><li>`STARTING`: The application load balancer is being started.</li><li>`ACTIVE`: The application load balancer is active and sends traffic to the targets.</li><li>`STOPPING`: The application load balancer is being stopped.</li><li>`STOPPED`: The application load balancer is stopped and doesn't send traffic to the targets.</li><li>`DELETING`: The application load balancer is being deleted.</li><ul/>
region_id | **string**<br>ID of the region that the application load balancer is located at. <br>Currently Yandex Cloud supports only `ru-central1` region. 
network_id | **string**<br>ID of the network that the application load balancer belongs to. 
listeners[] | **[Listener](#Listener8)**<br>Listeners that belong to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener). 
allocation_policy | **[AllocationPolicy](#AllocationPolicy10)**<br>Locality settings of the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location). 
log_group_id | **string**<br>ID of the log group that stores access logs of the application load balancer. <br>The logs can be accessed using a Cloud Functions [trigger for Cloud Logs](/docs/functions/operations/trigger/cloudlogs-trigger-create). 
security_group_ids[] | **string**<br>ID's of the security groups attributed to the application load balancer. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#security-groups). 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


### Listener {#Listener8}

Field | Description
--- | ---
name | **string**<br>Required. Name of the listener. The name is unique within the application load balancer. The string length in characters is 3-63. 
endpoints[] | **[Endpoint](#Endpoint8)**<br>Endpoints of the listener. <br>Endpoints are defined by their IP addresses and ports. 
listener | **oneof:** `http`, `tls` or `tcp`<br>HTTP or HTTPS (HTTP over TLS) listener settings.
&nbsp;&nbsp;http | **[HttpListener](#HttpListener12)**<br>HTTP listener settings. 
&nbsp;&nbsp;tls | **[TlsListener](#TlsListener12)**<br>HTTPS (HTTP over TLS) listener settings. 
&nbsp;&nbsp;tcp | **[TcpListener](#TcpListener8)**<br>TCP listener settings. 


### Endpoint {#Endpoint8}

Field | Description
--- | ---
addresses[] | **[Address](#Address8)**<br>Endpoint public (external) and internal addresses. The number of elements must be greater than 0.
ports[] | **int64**<br>Endpoint ports. The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.


### Address {#Address8}

Field | Description
--- | ---
address | **oneof:** `external_ipv4_address`, `internal_ipv4_address` or `external_ipv6_address`<br>Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address.
&nbsp;&nbsp;external_ipv4_address | **[ExternalIpv4Address](#ExternalIpv4Address8)**<br>Public IPv4 endpoint address. 
&nbsp;&nbsp;internal_ipv4_address | **[InternalIpv4Address](#InternalIpv4Address8)**<br>Internal IPv4 endpoint address. <br>To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). 
&nbsp;&nbsp;external_ipv6_address | **[ExternalIpv6Address](#ExternalIpv6Address8)**<br>Public IPv6 endpoint address. 


### ExternalIpv4Address {#ExternalIpv4Address8}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 


### InternalIpv4Address {#InternalIpv4Address8}

Field | Description
--- | ---
address | **string**<br>IPv4 address. 
subnet_id | **string**<br>ID of the subnet that the address belongs to. 


### ExternalIpv6Address {#ExternalIpv6Address8}

Field | Description
--- | ---
address | **string**<br>IPv6 address. 


### HttpListener {#HttpListener12}

Field | Description
--- | ---
handler | **[HttpHandler](#HttpHandler36)**<br>Settings for handling HTTP requests. <br>Only one of `handler` and `redirects` can be specified. 
redirects | **[Redirects](#Redirects12)**<br>Redirects settings. <br>Only one of `redirects` and `handler` can be specified. 


### HttpHandler {#HttpHandler36}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options36)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options36}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### Redirects {#Redirects12}

Field | Description
--- | ---
http_to_https | **bool**<br>Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`. <br>The setting has the same effect as a single, catch-all [HttpRoute](#HttpRoute) with [RedirectAction.replace_scheme](#RedirectAction) set to `https`. 


### TlsListener {#TlsListener12}

Field | Description
--- | ---
default_handler | **[TlsHandler](#TlsHandler24)**<br>Required. Settings for handling HTTPS requests by default, with Server Name Indication (SNI) not matching any of the `sni_handlers`. 
sni_handlers[] | **[SniMatch](#SniMatch12)**<br>Settings for handling HTTPS requests with Server Name Indication (SNI) matching one of [SniMatch.server_names](#SniMatch12) values. 


### TlsHandler {#TlsHandler24}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler37)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler32)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler37}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options37)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options37}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler32}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### SniMatch {#SniMatch12}

Field | Description
--- | ---
name | **string**<br>Required. Name of the SNI handler. 
server_names[] | **string**<br>Server names that are matched by the SNI handler. The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler25)**<br>Required. Settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. 


### TlsHandler {#TlsHandler25}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler38)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler33)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler38}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options38)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options38}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler33}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### TcpListener {#TcpListener8}

Field | Description
--- | ---
handler | **[StreamHandler](#StreamHandler34)**<br>Required.  


### StreamHandler {#StreamHandler34}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


### AllocationPolicy {#AllocationPolicy10}

Field | Description
--- | ---
locations[] | **[Location](#Location10)**<br>Availability zones and subnets that the application load balancer resides. The minimum number of elements is 1.


### Location {#Location10}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the application load balancer resides. <br>Each Yandex Cloud availability zone can only be specified once. 
subnet_id | **string**<br>ID of the subnet that the application load balancer belongs to. 
disable_traffic | **bool**<br>Disables the load balancer node in the specified availability zone. <br>Backends in the availability zone are not directly affected by this setting. They still may receive traffic from the load balancer nodes in other availability zones, subject to [LoadBalancingConfig.locality_aware_routing_percent](#LoadBalancingConfig) and [LoadBalancingConfig.strict_locality](#LoadBalancingConfig) settings. 


## AddSniMatch {#AddSniMatch}

Adds a SNI handler to the specified listener. <br>This request does not allow to add [TlsListener.default_handler](#TlsListener13). Make an [UpdateListener](#UpdateListener) request instead.

**rpc AddSniMatch ([AddSniMatchRequest](#AddSniMatchRequest)) returns ([operation.Operation](#Operation8))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddSniMatchMetadata](#AddSniMatchMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddSniMatchRequest {#AddSniMatchRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required. ID of the application load balancer to add a SNI handler to. 
listener_name | **string**<br>Required. Name of the listener to add a SNI handler to. 
name | **string**<br>Required. Name of the SNI handler to add. 
server_names[] | **string**<br>Server names that are matched by the SNI handler. The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler26)**<br>Required. Settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. 


### TlsHandler {#TlsHandler26}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler39)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler35)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler39}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options39)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options39}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler35}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


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
load_balancer_id | **string**<br>ID of the application load balancer that the SNI handler is being added to. 
listener_name | **string**<br>Name of the listener that the SNI handler is being added to. 
sni_match_name | **string**<br>Name of the SNI handler that is being added to the listener. 


## UpdateSniMatch {#UpdateSniMatch}

Updates the specified SNI handler of the specified listener. <br>This request does not allow to update [TlsListener.default_handler](#TlsListener13). Make an [UpdateListener](#UpdateListener) request instead.

**rpc UpdateSniMatch ([UpdateSniMatchRequest](#UpdateSniMatchRequest)) returns ([operation.Operation](#Operation9))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSniMatchMetadata](#UpdateSniMatchMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateSniMatchRequest {#UpdateSniMatchRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required. ID of the application load balancer to update the SNI handler in. 
listener_name | **string**<br>Required. Name of the listener to update the SNI handler in. 
name | **string**<br>Required. Name of the SNI handler to update. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the SNI handler should be updated. 
server_names[] | **string**<br><ol><li>Get the current set of server names with a [LoadBalancerService.Get](#Get) request. </li><li>Add or remove a server name in this set. </li><li>Send the new set in this field.</li></ol> The number of elements must be greater than 0.
handler | **[TlsHandler](#TlsHandler27)**<br>Required. New settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. 


### TlsHandler {#TlsHandler27}

Field | Description
--- | ---
handler | **oneof:** `http_handler` or `stream_handler`<br>Settings for handling requests.
&nbsp;&nbsp;http_handler | **[HttpHandler](#HttpHandler40)**<br>HTTP handler. 
&nbsp;&nbsp;stream_handler | **[StreamHandler](#StreamHandler36)**<br>Stream handler 
certificate_ids[] | **string**<br>ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/). <br>RSA and ECDSA certificates are supported, and only the first certificate of each type is used. The number of elements must be greater than 0.


### HttpHandler {#HttpHandler40}

Field | Description
--- | ---
http_router_id | **string**<br>ID of the HTTP router processing requests. <br>For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router). 
protocol_settings | **oneof:** `http2_options` or `allow_http10`<br>Protocol settings. <br>For HTTPS (HTTP over TLS) connections, settings are applied to the protocol negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
&nbsp;&nbsp;http2_options | **[Http2Options](#Http2Options40)**<br>HTTP/2 settings. <br>If specified, incoming HTTP/2 requests are supported by the listener. 
&nbsp;&nbsp;allow_http10 | **bool**<br>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests. 


### Http2Options {#Http2Options40}

Field | Description
--- | ---
max_concurrent_streams | **int64**<br>Maximum number of concurrent HTTP/2 streams in a connection. 


### StreamHandler {#StreamHandler36}

Field | Description
--- | ---
backend_group_id | **string**<br>Required.  


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
load_balancer_id | **string**<br>ID of the application load balancer that the SNI handler is being updated in. 
listener_name | **string**<br>Name of the listener that the SNI handler is being updated in. 
sni_match_name | **string**<br>Name of the SNI handler that is being updated. 


## RemoveSniMatch {#RemoveSniMatch}

Deletes the specified SNI handler. <br>This request does not allow to delete [TlsListener.default_handler](#TlsListener13).

**rpc RemoveSniMatch ([RemoveSniMatchRequest](#RemoveSniMatchRequest)) returns ([operation.Operation](#Operation10))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveSniMatchMetadata](#RemoveSniMatchMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### RemoveSniMatchRequest {#RemoveSniMatchRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required. ID of the application load balancer to remove the SNI handler from. 
listener_name | **string**<br>Required. Name of the listener te remove the SNI handler from. 
sni_match_name | **string**<br>Required. Name of the SNI handler to remove. 


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
load_balancer_id | **string**<br>ID of the application load balancer that the SNI handler is being removed from. 
listener_name | **string**<br>Name of the listener that the SNI handler is being removed from. 
sni_match_name | **string**<br>Name of the SNI handler that is being removed. 


## GetTargetStates {#GetTargetStates}

Returns the statuses of all targets of the specified backend group in all their availability zones.

**rpc GetTargetStates ([GetTargetStatesRequest](#GetTargetStatesRequest)) returns ([GetTargetStatesResponse](#GetTargetStatesResponse))**

### GetTargetStatesRequest {#GetTargetStatesRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required. ID of the application load balancer that the backend group is attributed to. 
backend_group_id | **string**<br>Required. ID of the backend group that the target group is attributed to. 
target_group_id | **string**<br>Required. ID of the target group to get target states of. 


### GetTargetStatesResponse {#GetTargetStatesResponse}

Field | Description
--- | ---
target_states[] | **[TargetState](#TargetState)**<br>Target states of the specified target group. 


### TargetState {#TargetState}

Field | Description
--- | ---
status | **[HealthcheckStatus](#HealthcheckStatus)**<br>Health of the target, i.e. its statuses in all availability zones. 
target | **[Target](#Target)**<br>Required. Target. 


### HealthcheckStatus {#HealthcheckStatus}

Field | Description
--- | ---
zone_statuses[] | **[ZoneHealthcheckStatus](#ZoneHealthcheckStatus)**<br>Statuses of the target in its availability zones. 


### ZoneHealthcheckStatus {#ZoneHealthcheckStatus}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone. 
status | **Status**<br>Status of the target in the availability zone. 
failed_active_hc | **bool**<br>Indicates whether the target has been marked `UNHEALTHY` due to failing active health checks, which determine target statuses as configured in [HttpBackend.healthchecks](#HttpBackend) or [GrpcBackend.healthchecks](#GrpcBackend). <br>Currently the only type of health checks is active, as described above. Passive health checks, which determine the health of a target based on its responses to production requests (HTTP 5xx status codes, connection errors etc.), are not implemented yet. 


### Target {#Target}

Field | Description
--- | ---
address_type | **oneof:** `ip_address`<br>Reference to the target. As of now, targets must only be referred to by their IP addresses.
&nbsp;&nbsp;ip_address | **string**<br>IP address of the target. 
subnet_id | **string**<br>ID of the subnet that the target is connected to. 


## ListOperations {#ListOperations}

Lists operations for the specified application load balancer.

**rpc ListOperations ([ListLoadBalancerOperationsRequest](#ListLoadBalancerOperationsRequest)) returns ([ListLoadBalancerOperationsResponse](#ListLoadBalancerOperationsResponse))**

### ListLoadBalancerOperationsRequest {#ListLoadBalancerOperationsRequest}

Field | Description
--- | ---
load_balancer_id | **string**<br>Required. ID of the application load balancer to get operations for. <br>To get the application load balancer ID, use a [LoadBalancerService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListLoadBalancerOperationsResponse.next_page_token](#ListLoadBalancerOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListLoadBalancerOperationsResponse.next_page_token](#ListLoadBalancerOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListLoadBalancerOperationsResponse {#ListLoadBalancerOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation11)**<br>List of operations for the specified application load balancer. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListLoadBalancerOperationsRequest.page_size](#ListLoadBalancerOperationsRequest), use `next_page_token` as the value for the [ListLoadBalancerOperationsRequest.page_token](#ListLoadBalancerOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


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


