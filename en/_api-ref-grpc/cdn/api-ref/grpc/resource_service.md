---
editable: false
---

# ResourceService

Provider's resources management service.

| Call | Description |
| --- | --- |
| [Get](#Get) | Get client's CDN resource by resource id. |
| [List](#List) | List all client's CDN resources. |
| [Create](#Create) | Create client's CDN resource. |
| [Update](#Update) | Update of client's CDN resource. |
| [Delete](#Delete) | Delete client's CDN resource. |
| [GetProviderCName](#GetProviderCName) | Get Provider's CNAME (edge endpoint) binded to specified folder id. |

## Calls ResourceService {#calls}

## Get {#Get}

Get client's CDN resource by resource id.

**rpc Get ([GetResourceRequest](#GetResourceRequest)) returns ([Resource](#Resource))**

### GetResourceRequest {#GetResourceRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. Requested resourc The maximum string length in characters is 50.


### Resource {#Resource}

Field | Description
--- | ---
id | **string**<br>Resource id. 
folder_id | **string**<br>Folder id. 
cname | **string**<br>CDN endpoint CNAME, must be unique among resources. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
active | **bool**<br>Resource state. 
options | **[ResourceOptions](#ResourceOptions)**<br> 
secondary_hostnames[] | **string**<br> 
origin_group_id | **int64**<br> 
origin_group_name | **string**<br> 
origin_protocol | enum **OriginProtocol**<br> <ul><ul/>
ssl_certificate | **[SSLCertificate](#SSLCertificate)**<br> 


### ResourceOptions {#ResourceOptions}

Field | Description
--- | ---
disable_cache | **[BoolOption](#BoolOption)**<br> 
edge_cache_settings | **[EdgeCacheSettings](#EdgeCacheSettings)**<br> 
browser_cache_settings | **[Int64Option](#Int64Option)**<br> 
cache_http_headers | **[StringsListOption](#StringsListOption)**<br> 
query_params_options | **[QueryParamsOptions](#QueryParamsOptions)**<br> 
slice | **[BoolOption](#BoolOption)**<br> 
compression_options | **[CompressionOptions](#CompressionOptions)**<br> 
redirect_options | **[RedirectOptions](#RedirectOptions)**<br> 
host_options | **[HostOptions](#HostOptions)**<br> 
static_headers | **[StringsMapOption](#StringsMapOption)**<br> 
cors | **[StringsListOption](#StringsListOption)**<br> 
stale | **[StringsListOption](#StringsListOption)**<br> 
allowed_http_methods | **[StringsListOption](#StringsListOption)**<br> 
proxy_cache_methods_set | **[BoolOption](#BoolOption)**<br> 
disable_proxy_force_ranges | **[BoolOption](#BoolOption)**<br> 
static_request_headers | **[StringsMapOption](#StringsMapOption)**<br> 
custom_server_name | **[StringOption](#StringOption)**<br> 
ignore_cookie | **[BoolOption](#BoolOption)**<br> 
rewrite | **[RewriteOption](#RewriteOption)**<br> 


### BoolOption {#BoolOption}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **bool**<br> 


### StringOption {#StringOption}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **string**<br> 


### Int64Option {#Int64Option}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **int64**<br> 


### StringsListOption {#StringsListOption}

Field | Description
--- | ---
enabled | **bool**<br> 
value[] | **string**<br> 


### StringsMapOption {#StringsMapOption}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **map<string,string>**<br> 


### CachingTimes {#CachingTimes}

Field | Description
--- | ---
simple_value | **int64**<br> 
custom_values | **map<string,int64>**<br> 


### EdgeCacheSettings {#EdgeCacheSettings}

Field | Description
--- | ---
enabled | **bool**<br> 
values_variant | **oneof:** `value` or `default_value`<br>
&nbsp;&nbsp;value | **[CachingTimes](#CachingTimes)**<br> 
&nbsp;&nbsp;default_value | **int64**<br> 


### StringVariableMapOption {#StringVariableMapOption}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **map<string,OneofString>**<br> 


### OneofString {#OneofString}

Field | Description
--- | ---
string_option | **oneof:** `value` or `values`<br>
&nbsp;&nbsp;value | **[StringOption](#StringOption)**<br> 
&nbsp;&nbsp;values | **[StringsListOption](#StringsListOption)**<br> 


### QueryParamsOptions {#QueryParamsOptions}

Field | Description
--- | ---
query_params_variant | **oneof:** `ignore_query_string`, `query_params_whitelist` or `query_params_blacklist`<br>
&nbsp;&nbsp;ignore_query_string | **[BoolOption](#BoolOption)**<br> 
&nbsp;&nbsp;query_params_whitelist | **[StringsListOption](#StringsListOption)**<br> 
&nbsp;&nbsp;query_params_blacklist | **[StringsListOption](#StringsListOption)**<br> 


### RedirectOptions {#RedirectOptions}

Field | Description
--- | ---
redirect_variant | **oneof:** `redirect_http_to_https` or `redirect_https_to_http`<br>
&nbsp;&nbsp;redirect_http_to_https | **[BoolOption](#BoolOption)**<br> 
&nbsp;&nbsp;redirect_https_to_http | **[BoolOption](#BoolOption)**<br> 


### HostOptions {#HostOptions}

Field | Description
--- | ---
host_variant | **oneof:** `host` or `forward_host_header`<br>
&nbsp;&nbsp;host | **[StringOption](#StringOption)**<br> 
&nbsp;&nbsp;forward_host_header | **[BoolOption](#BoolOption)**<br> 


### CompressionOptions {#CompressionOptions}

Field | Description
--- | ---
compression_variant | **oneof:** `fetch_compressed`, `gzip_on` or `brotli_compression`<br>
&nbsp;&nbsp;fetch_compressed | **[BoolOption](#BoolOption)**<br> 
&nbsp;&nbsp;gzip_on | **[BoolOption](#BoolOption)**<br> 
&nbsp;&nbsp;brotli_compression | **[StringsListOption](#StringsListOption)**<br> 


### RewriteOption {#RewriteOption}

Field | Description
--- | ---
enabled | **bool**<br> 
body | **string**<br> 
flag | enum **RewriteFlag**<br> <ul><ul/>


### SSLCertificate {#SSLCertificate}

Field | Description
--- | ---
type | enum **SSLCertificateType**<br> <ul><ul/>
status | enum **SSLCertificateStatus**<br> <ul><ul/>
data | **[SSLCertificateData](#SSLCertificateData)**<br> 


### SSLCertificateData {#SSLCertificateData}

Field | Description
--- | ---
ssl_certificate_data_variant | **oneof:** `cm`<br>
&nbsp;&nbsp;cm | **[SSLCertificateCMData](#SSLCertificateCMData)**<br> 


### SSLCertificateCMData {#SSLCertificateCMData}

Field | Description
--- | ---
id | **string**<br> 


## List {#List}

List all client's CDN resources.

**rpc List ([ListResourcesRequest](#ListResourcesRequest)) returns ([ListResourcesResponse](#ListResourcesResponse))**

### ListResourcesRequest {#ListResourcesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID to request listing for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListResourcesResponse.next_page_token](#ListResourcesResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListResourcesResponse.next_page_token](#ListResourcesResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListResourcesResponse {#ListResourcesResponse}

Field | Description
--- | ---
resources[] | **[Resource](#Resource1)**<br> 
next_page_token | **string**<br>`next_page_token` token allows you to get the next page of results for list requests. If the number of results is larger than [ListResourcesRequest.page_size](#ListResourcesRequest), use the `next_page_token` as the value for the [ListResourcesRequest.page_token](#ListResourcesRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Resource {#Resource1}

Field | Description
--- | ---
id | **string**<br>Resource id. 
folder_id | **string**<br>Folder id. 
cname | **string**<br>CDN endpoint CNAME, must be unique among resources. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
active | **bool**<br>Resource state. 
options | **[ResourceOptions](#ResourceOptions1)**<br> 
secondary_hostnames[] | **string**<br> 
origin_group_id | **int64**<br> 
origin_group_name | **string**<br> 
origin_protocol | enum **OriginProtocol**<br> <ul><ul/>
ssl_certificate | **[SSLCertificate](#SSLCertificate1)**<br> 


### ResourceOptions {#ResourceOptions1}

Field | Description
--- | ---
disable_cache | **[BoolOption](#BoolOption1)**<br> 
edge_cache_settings | **[EdgeCacheSettings](#EdgeCacheSettings1)**<br> 
browser_cache_settings | **[Int64Option](#Int64Option1)**<br> 
cache_http_headers | **[StringsListOption](#StringsListOption1)**<br> 
query_params_options | **[QueryParamsOptions](#QueryParamsOptions1)**<br> 
slice | **[BoolOption](#BoolOption1)**<br> 
compression_options | **[CompressionOptions](#CompressionOptions1)**<br> 
redirect_options | **[RedirectOptions](#RedirectOptions1)**<br> 
host_options | **[HostOptions](#HostOptions1)**<br> 
static_headers | **[StringsMapOption](#StringsMapOption1)**<br> 
cors | **[StringsListOption](#StringsListOption1)**<br> 
stale | **[StringsListOption](#StringsListOption1)**<br> 
allowed_http_methods | **[StringsListOption](#StringsListOption1)**<br> 
proxy_cache_methods_set | **[BoolOption](#BoolOption1)**<br> 
disable_proxy_force_ranges | **[BoolOption](#BoolOption1)**<br> 
static_request_headers | **[StringsMapOption](#StringsMapOption1)**<br> 
custom_server_name | **[StringOption](#StringOption1)**<br> 
ignore_cookie | **[BoolOption](#BoolOption1)**<br> 
rewrite | **[RewriteOption](#RewriteOption1)**<br> 


### BoolOption {#BoolOption1}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **bool**<br> 


### StringOption {#StringOption1}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **string**<br> 


### Int64Option {#Int64Option1}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **int64**<br> 


### StringsListOption {#StringsListOption1}

Field | Description
--- | ---
enabled | **bool**<br> 
value[] | **string**<br> 


### StringsMapOption {#StringsMapOption1}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **map<string,string>**<br> 


### CachingTimes {#CachingTimes1}

Field | Description
--- | ---
simple_value | **int64**<br> 
custom_values | **map<string,int64>**<br> 


### EdgeCacheSettings {#EdgeCacheSettings1}

Field | Description
--- | ---
enabled | **bool**<br> 
values_variant | **oneof:** `value` or `default_value`<br>
&nbsp;&nbsp;value | **[CachingTimes](#CachingTimes1)**<br> 
&nbsp;&nbsp;default_value | **int64**<br> 


### StringVariableMapOption {#StringVariableMapOption1}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **map<string,OneofString>**<br> 


### OneofString {#OneofString1}

Field | Description
--- | ---
string_option | **oneof:** `value` or `values`<br>
&nbsp;&nbsp;value | **[StringOption](#StringOption1)**<br> 
&nbsp;&nbsp;values | **[StringsListOption](#StringsListOption1)**<br> 


### QueryParamsOptions {#QueryParamsOptions1}

Field | Description
--- | ---
query_params_variant | **oneof:** `ignore_query_string`, `query_params_whitelist` or `query_params_blacklist`<br>
&nbsp;&nbsp;ignore_query_string | **[BoolOption](#BoolOption1)**<br> 
&nbsp;&nbsp;query_params_whitelist | **[StringsListOption](#StringsListOption1)**<br> 
&nbsp;&nbsp;query_params_blacklist | **[StringsListOption](#StringsListOption1)**<br> 


### RedirectOptions {#RedirectOptions1}

Field | Description
--- | ---
redirect_variant | **oneof:** `redirect_http_to_https` or `redirect_https_to_http`<br>
&nbsp;&nbsp;redirect_http_to_https | **[BoolOption](#BoolOption1)**<br> 
&nbsp;&nbsp;redirect_https_to_http | **[BoolOption](#BoolOption1)**<br> 


### HostOptions {#HostOptions1}

Field | Description
--- | ---
host_variant | **oneof:** `host` or `forward_host_header`<br>
&nbsp;&nbsp;host | **[StringOption](#StringOption1)**<br> 
&nbsp;&nbsp;forward_host_header | **[BoolOption](#BoolOption1)**<br> 


### CompressionOptions {#CompressionOptions1}

Field | Description
--- | ---
compression_variant | **oneof:** `fetch_compressed`, `gzip_on` or `brotli_compression`<br>
&nbsp;&nbsp;fetch_compressed | **[BoolOption](#BoolOption1)**<br> 
&nbsp;&nbsp;gzip_on | **[BoolOption](#BoolOption1)**<br> 
&nbsp;&nbsp;brotli_compression | **[StringsListOption](#StringsListOption1)**<br> 


### RewriteOption {#RewriteOption1}

Field | Description
--- | ---
enabled | **bool**<br> 
body | **string**<br> 
flag | enum **RewriteFlag**<br> <ul><ul/>


### SSLCertificate {#SSLCertificate1}

Field | Description
--- | ---
type | enum **SSLCertificateType**<br> <ul><ul/>
status | enum **SSLCertificateStatus**<br> <ul><ul/>
data | **[SSLCertificateData](#SSLCertificateData1)**<br> 


### SSLCertificateData {#SSLCertificateData1}

Field | Description
--- | ---
ssl_certificate_data_variant | **oneof:** `cm`<br>
&nbsp;&nbsp;cm | **[SSLCertificateCMData](#SSLCertificateCMData1)**<br> 


### SSLCertificateCMData {#SSLCertificateCMData1}

Field | Description
--- | ---
id | **string**<br> 


## Create {#Create}

Create client's CDN resource.

**rpc Create ([CreateResourceRequest](#CreateResourceRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateResourceMetadata](#CreateResourceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Resource](#Resource2)<br>

### CreateResourceRequest {#CreateResourceRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID to bind with new resource. The maximum string length in characters is 50.
cname | **string**<br>Required. CDN endpoint CNAME, must be unique among clients's resources. 
origin | **[Origin](#Origin)**<br>Required. Specify the origins to be used for CDN resources requests. 
secondary_hostnames | **[SecondaryHostnames](#SecondaryHostnames)**<br>List of additional CNAMEs. 
origin_protocol | enum **OriginProtocol**<br>Specify the protocol schema to be used in communication with origin . <ul><ul/>
active | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Flag to create Resource either in active or disabled state. In active state Origins payload could be transmitted from CDN CNAME requests. Default value: true 
options | **[ResourceOptions](#ResourceOptions2)**<br>Resource settings and options to tune CDN edge behavior. Most is unset. 
ssl_certificate | **[SSLTargetCertificate](#SSLTargetCertificate)**<br>SSL Certificate options. 


### Origin {#Origin}

Field | Description
--- | ---
origin_variant | **oneof:** `origin_group_id`, `origin_source` or `origin_source_params`<br>
&nbsp;&nbsp;origin_group_id | **int64**<br>ID of pre-created origin group. 
&nbsp;&nbsp;origin_source | **string**<br>Create new Origins group with single source, it's id will be returned in result. 
&nbsp;&nbsp;origin_source_params | **[ResourceOriginParams](#ResourceOriginParams)**<br> 


### Origin {#Origin}

Field | Description
--- | ---
id | **int64**<br>Origin unique ID. 
origin_group_id | **int64**<br>Parent origin group ID. 
source | **string**<br>Source: IP address or Domain name of your origin and the port (if custom). 
enabled | **bool**<br>The setting allows to enable or disable an Origin source in the Origins group. <br>It has two possible values: <br>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origins. False - The origin is disabled and the CDN is not using it to pull content. 
backup | **bool**<br>backup option has two possible values: <br>True - The option is active. The origin will not be used until one of active origins become unavailable. False - The option is disabled. 
meta | **[OriginMeta](#OriginMeta)**<br> 


### OriginMeta {#OriginMeta}

Field | Description
--- | ---
origin_meta_variant | **oneof:** `common`, `bucket`, `website` or `balancer`<br>
&nbsp;&nbsp;common | **[OriginNamedMeta](#OriginNamedMeta)**<br> 
&nbsp;&nbsp;bucket | **[OriginNamedMeta](#OriginNamedMeta)**<br> 
&nbsp;&nbsp;website | **[OriginNamedMeta](#OriginNamedMeta)**<br> 
&nbsp;&nbsp;balancer | **[OriginBalancerMeta](#OriginBalancerMeta)**<br> 


### OriginNamedMeta {#OriginNamedMeta}

Field | Description
--- | ---
name | **string**<br> 


### OriginBalancerMeta {#OriginBalancerMeta}

Field | Description
--- | ---
id | **string**<br> 


### SecondaryHostnames {#SecondaryHostnames}

Field | Description
--- | ---
values[] | **string**<br> 


### ResourceOptions {#ResourceOptions2}

Field | Description
--- | ---
disable_cache | **[BoolOption](#BoolOption2)**<br> 
edge_cache_settings | **[EdgeCacheSettings](#EdgeCacheSettings2)**<br> 
browser_cache_settings | **[Int64Option](#Int64Option2)**<br> 
cache_http_headers | **[StringsListOption](#StringsListOption2)**<br> 
query_params_options | **[QueryParamsOptions](#QueryParamsOptions2)**<br> 
slice | **[BoolOption](#BoolOption2)**<br> 
compression_options | **[CompressionOptions](#CompressionOptions2)**<br> 
redirect_options | **[RedirectOptions](#RedirectOptions2)**<br> 
host_options | **[HostOptions](#HostOptions2)**<br> 
static_headers | **[StringsMapOption](#StringsMapOption2)**<br> 
cors | **[StringsListOption](#StringsListOption2)**<br> 
stale | **[StringsListOption](#StringsListOption2)**<br> 
allowed_http_methods | **[StringsListOption](#StringsListOption2)**<br> 
proxy_cache_methods_set | **[BoolOption](#BoolOption2)**<br> 
disable_proxy_force_ranges | **[BoolOption](#BoolOption2)**<br> 
static_request_headers | **[StringsMapOption](#StringsMapOption2)**<br> 
custom_server_name | **[StringOption](#StringOption2)**<br> 
ignore_cookie | **[BoolOption](#BoolOption2)**<br> 
rewrite | **[RewriteOption](#RewriteOption2)**<br> 


### BoolOption {#BoolOption2}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **bool**<br> 


### StringOption {#StringOption2}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **string**<br> 


### Int64Option {#Int64Option2}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **int64**<br> 


### StringsListOption {#StringsListOption2}

Field | Description
--- | ---
enabled | **bool**<br> 
value[] | **string**<br> 


### StringsMapOption {#StringsMapOption2}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **map<string,string>**<br> 


### CachingTimes {#CachingTimes2}

Field | Description
--- | ---
simple_value | **int64**<br> 
custom_values | **map<string,int64>**<br> 


### EdgeCacheSettings {#EdgeCacheSettings2}

Field | Description
--- | ---
enabled | **bool**<br> 
values_variant | **oneof:** `value` or `default_value`<br>
&nbsp;&nbsp;value | **[CachingTimes](#CachingTimes2)**<br> 
&nbsp;&nbsp;default_value | **int64**<br> 


### StringVariableMapOption {#StringVariableMapOption2}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **map<string,OneofString>**<br> 


### OneofString {#OneofString2}

Field | Description
--- | ---
string_option | **oneof:** `value` or `values`<br>
&nbsp;&nbsp;value | **[StringOption](#StringOption2)**<br> 
&nbsp;&nbsp;values | **[StringsListOption](#StringsListOption2)**<br> 


### QueryParamsOptions {#QueryParamsOptions2}

Field | Description
--- | ---
query_params_variant | **oneof:** `ignore_query_string`, `query_params_whitelist` or `query_params_blacklist`<br>
&nbsp;&nbsp;ignore_query_string | **[BoolOption](#BoolOption2)**<br> 
&nbsp;&nbsp;query_params_whitelist | **[StringsListOption](#StringsListOption2)**<br> 
&nbsp;&nbsp;query_params_blacklist | **[StringsListOption](#StringsListOption2)**<br> 


### RedirectOptions {#RedirectOptions2}

Field | Description
--- | ---
redirect_variant | **oneof:** `redirect_http_to_https` or `redirect_https_to_http`<br>
&nbsp;&nbsp;redirect_http_to_https | **[BoolOption](#BoolOption2)**<br> 
&nbsp;&nbsp;redirect_https_to_http | **[BoolOption](#BoolOption2)**<br> 


### HostOptions {#HostOptions2}

Field | Description
--- | ---
host_variant | **oneof:** `host` or `forward_host_header`<br>
&nbsp;&nbsp;host | **[StringOption](#StringOption2)**<br> 
&nbsp;&nbsp;forward_host_header | **[BoolOption](#BoolOption2)**<br> 


### CompressionOptions {#CompressionOptions2}

Field | Description
--- | ---
compression_variant | **oneof:** `fetch_compressed`, `gzip_on` or `brotli_compression`<br>
&nbsp;&nbsp;fetch_compressed | **[BoolOption](#BoolOption2)**<br> 
&nbsp;&nbsp;gzip_on | **[BoolOption](#BoolOption2)**<br> 
&nbsp;&nbsp;brotli_compression | **[StringsListOption](#StringsListOption2)**<br> 


### RewriteOption {#RewriteOption2}

Field | Description
--- | ---
enabled | **bool**<br> 
body | **string**<br> 
flag | enum **RewriteFlag**<br> <ul><ul/>


### SSLTargetCertificate {#SSLTargetCertificate}

Field | Description
--- | ---
type | enum **SSLCertificateType**<br> <ul><ul/>
data | **[SSLCertificateData](#SSLCertificateData2)**<br> 


### SSLCertificateData {#SSLCertificateData2}

Field | Description
--- | ---
ssl_certificate_data_variant | **oneof:** `cm`<br>
&nbsp;&nbsp;cm | **[SSLCertificateCMData](#SSLCertificateCMData2)**<br> 


### SSLCertificateCMData {#SSLCertificateCMData2}

Field | Description
--- | ---
id | **string**<br> 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateResourceMetadata](#CreateResourceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Resource](#Resource2)>**<br>if operation finished successfully. 


### CreateResourceMetadata {#CreateResourceMetadata}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of created resource. The maximum string length in characters is 50.


### Resource {#Resource2}

Field | Description
--- | ---
id | **string**<br>Resource id. 
folder_id | **string**<br>Folder id. 
cname | **string**<br>CDN endpoint CNAME, must be unique among resources. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
active | **bool**<br>Resource state. 
options | **[ResourceOptions](#ResourceOptions3)**<br> 
secondary_hostnames[] | **string**<br> 
origin_group_id | **int64**<br> 
origin_group_name | **string**<br> 
origin_protocol | enum **OriginProtocol**<br> <ul><ul/>
ssl_certificate | **[SSLCertificate](#SSLCertificate2)**<br> 


### ResourceOptions {#ResourceOptions3}

Field | Description
--- | ---
disable_cache | **[BoolOption](#BoolOption3)**<br> 
edge_cache_settings | **[EdgeCacheSettings](#EdgeCacheSettings3)**<br> 
browser_cache_settings | **[Int64Option](#Int64Option3)**<br> 
cache_http_headers | **[StringsListOption](#StringsListOption3)**<br> 
query_params_options | **[QueryParamsOptions](#QueryParamsOptions3)**<br> 
slice | **[BoolOption](#BoolOption3)**<br> 
compression_options | **[CompressionOptions](#CompressionOptions3)**<br> 
redirect_options | **[RedirectOptions](#RedirectOptions3)**<br> 
host_options | **[HostOptions](#HostOptions3)**<br> 
static_headers | **[StringsMapOption](#StringsMapOption3)**<br> 
cors | **[StringsListOption](#StringsListOption3)**<br> 
stale | **[StringsListOption](#StringsListOption3)**<br> 
allowed_http_methods | **[StringsListOption](#StringsListOption3)**<br> 
proxy_cache_methods_set | **[BoolOption](#BoolOption3)**<br> 
disable_proxy_force_ranges | **[BoolOption](#BoolOption3)**<br> 
static_request_headers | **[StringsMapOption](#StringsMapOption3)**<br> 
custom_server_name | **[StringOption](#StringOption3)**<br> 
ignore_cookie | **[BoolOption](#BoolOption3)**<br> 
rewrite | **[RewriteOption](#RewriteOption3)**<br> 


### BoolOption {#BoolOption3}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **bool**<br> 


### StringOption {#StringOption3}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **string**<br> 


### Int64Option {#Int64Option3}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **int64**<br> 


### StringsListOption {#StringsListOption3}

Field | Description
--- | ---
enabled | **bool**<br> 
value[] | **string**<br> 


### StringsMapOption {#StringsMapOption3}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **map<string,string>**<br> 


### CachingTimes {#CachingTimes3}

Field | Description
--- | ---
simple_value | **int64**<br> 
custom_values | **map<string,int64>**<br> 


### EdgeCacheSettings {#EdgeCacheSettings3}

Field | Description
--- | ---
enabled | **bool**<br> 
values_variant | **oneof:** `value` or `default_value`<br>
&nbsp;&nbsp;value | **[CachingTimes](#CachingTimes3)**<br> 
&nbsp;&nbsp;default_value | **int64**<br> 


### StringVariableMapOption {#StringVariableMapOption3}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **map<string,OneofString>**<br> 


### OneofString {#OneofString3}

Field | Description
--- | ---
string_option | **oneof:** `value` or `values`<br>
&nbsp;&nbsp;value | **[StringOption](#StringOption3)**<br> 
&nbsp;&nbsp;values | **[StringsListOption](#StringsListOption3)**<br> 


### QueryParamsOptions {#QueryParamsOptions3}

Field | Description
--- | ---
query_params_variant | **oneof:** `ignore_query_string`, `query_params_whitelist` or `query_params_blacklist`<br>
&nbsp;&nbsp;ignore_query_string | **[BoolOption](#BoolOption3)**<br> 
&nbsp;&nbsp;query_params_whitelist | **[StringsListOption](#StringsListOption3)**<br> 
&nbsp;&nbsp;query_params_blacklist | **[StringsListOption](#StringsListOption3)**<br> 


### RedirectOptions {#RedirectOptions3}

Field | Description
--- | ---
redirect_variant | **oneof:** `redirect_http_to_https` or `redirect_https_to_http`<br>
&nbsp;&nbsp;redirect_http_to_https | **[BoolOption](#BoolOption3)**<br> 
&nbsp;&nbsp;redirect_https_to_http | **[BoolOption](#BoolOption3)**<br> 


### HostOptions {#HostOptions3}

Field | Description
--- | ---
host_variant | **oneof:** `host` or `forward_host_header`<br>
&nbsp;&nbsp;host | **[StringOption](#StringOption3)**<br> 
&nbsp;&nbsp;forward_host_header | **[BoolOption](#BoolOption3)**<br> 


### CompressionOptions {#CompressionOptions3}

Field | Description
--- | ---
compression_variant | **oneof:** `fetch_compressed`, `gzip_on` or `brotli_compression`<br>
&nbsp;&nbsp;fetch_compressed | **[BoolOption](#BoolOption3)**<br> 
&nbsp;&nbsp;gzip_on | **[BoolOption](#BoolOption3)**<br> 
&nbsp;&nbsp;brotli_compression | **[StringsListOption](#StringsListOption3)**<br> 


### RewriteOption {#RewriteOption3}

Field | Description
--- | ---
enabled | **bool**<br> 
body | **string**<br> 
flag | enum **RewriteFlag**<br> <ul><ul/>


### SSLCertificate {#SSLCertificate2}

Field | Description
--- | ---
type | enum **SSLCertificateType**<br> <ul><ul/>
status | enum **SSLCertificateStatus**<br> <ul><ul/>
data | **[SSLCertificateData](#SSLCertificateData3)**<br> 


### SSLCertificateData {#SSLCertificateData3}

Field | Description
--- | ---
ssl_certificate_data_variant | **oneof:** `cm`<br>
&nbsp;&nbsp;cm | **[SSLCertificateCMData](#SSLCertificateCMData3)**<br> 


### SSLCertificateCMData {#SSLCertificateCMData3}

Field | Description
--- | ---
id | **string**<br> 


## Update {#Update}

Update of client's CDN resource. (PATCH behavior)

**rpc Update ([UpdateResourceRequest](#UpdateResourceRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateResourceMetadata](#UpdateResourceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Resource](#Resource3)<br>

### UpdateResourceRequest {#UpdateResourceRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required.  The maximum string length in characters is 50.
origin_group_id | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> 
secondary_hostnames | **[SecondaryHostnames](#SecondaryHostnames1)**<br> 
options | **[ResourceOptions](#ResourceOptions4)**<br> 
origin_protocol | enum **OriginProtocol**<br> <ul><ul/>
active | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
ssl_certificate | **[SSLTargetCertificate](#SSLTargetCertificate1)**<br> 


### SecondaryHostnames {#SecondaryHostnames1}

Field | Description
--- | ---
values[] | **string**<br> 


### ResourceOptions {#ResourceOptions4}

Field | Description
--- | ---
disable_cache | **[BoolOption](#BoolOption4)**<br> 
edge_cache_settings | **[EdgeCacheSettings](#EdgeCacheSettings4)**<br> 
browser_cache_settings | **[Int64Option](#Int64Option4)**<br> 
cache_http_headers | **[StringsListOption](#StringsListOption4)**<br> 
query_params_options | **[QueryParamsOptions](#QueryParamsOptions4)**<br> 
slice | **[BoolOption](#BoolOption4)**<br> 
compression_options | **[CompressionOptions](#CompressionOptions4)**<br> 
redirect_options | **[RedirectOptions](#RedirectOptions4)**<br> 
host_options | **[HostOptions](#HostOptions4)**<br> 
static_headers | **[StringsMapOption](#StringsMapOption4)**<br> 
cors | **[StringsListOption](#StringsListOption4)**<br> 
stale | **[StringsListOption](#StringsListOption4)**<br> 
allowed_http_methods | **[StringsListOption](#StringsListOption4)**<br> 
proxy_cache_methods_set | **[BoolOption](#BoolOption4)**<br> 
disable_proxy_force_ranges | **[BoolOption](#BoolOption4)**<br> 
static_request_headers | **[StringsMapOption](#StringsMapOption4)**<br> 
custom_server_name | **[StringOption](#StringOption4)**<br> 
ignore_cookie | **[BoolOption](#BoolOption4)**<br> 
rewrite | **[RewriteOption](#RewriteOption4)**<br> 


### BoolOption {#BoolOption4}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **bool**<br> 


### StringOption {#StringOption4}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **string**<br> 


### Int64Option {#Int64Option4}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **int64**<br> 


### StringsListOption {#StringsListOption4}

Field | Description
--- | ---
enabled | **bool**<br> 
value[] | **string**<br> 


### StringsMapOption {#StringsMapOption4}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **map<string,string>**<br> 


### CachingTimes {#CachingTimes4}

Field | Description
--- | ---
simple_value | **int64**<br> 
custom_values | **map<string,int64>**<br> 


### EdgeCacheSettings {#EdgeCacheSettings4}

Field | Description
--- | ---
enabled | **bool**<br> 
values_variant | **oneof:** `value` or `default_value`<br>
&nbsp;&nbsp;value | **[CachingTimes](#CachingTimes4)**<br> 
&nbsp;&nbsp;default_value | **int64**<br> 


### StringVariableMapOption {#StringVariableMapOption4}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **map<string,OneofString>**<br> 


### OneofString {#OneofString4}

Field | Description
--- | ---
string_option | **oneof:** `value` or `values`<br>
&nbsp;&nbsp;value | **[StringOption](#StringOption4)**<br> 
&nbsp;&nbsp;values | **[StringsListOption](#StringsListOption4)**<br> 


### QueryParamsOptions {#QueryParamsOptions4}

Field | Description
--- | ---
query_params_variant | **oneof:** `ignore_query_string`, `query_params_whitelist` or `query_params_blacklist`<br>
&nbsp;&nbsp;ignore_query_string | **[BoolOption](#BoolOption4)**<br> 
&nbsp;&nbsp;query_params_whitelist | **[StringsListOption](#StringsListOption4)**<br> 
&nbsp;&nbsp;query_params_blacklist | **[StringsListOption](#StringsListOption4)**<br> 


### RedirectOptions {#RedirectOptions4}

Field | Description
--- | ---
redirect_variant | **oneof:** `redirect_http_to_https` or `redirect_https_to_http`<br>
&nbsp;&nbsp;redirect_http_to_https | **[BoolOption](#BoolOption4)**<br> 
&nbsp;&nbsp;redirect_https_to_http | **[BoolOption](#BoolOption4)**<br> 


### HostOptions {#HostOptions4}

Field | Description
--- | ---
host_variant | **oneof:** `host` or `forward_host_header`<br>
&nbsp;&nbsp;host | **[StringOption](#StringOption4)**<br> 
&nbsp;&nbsp;forward_host_header | **[BoolOption](#BoolOption4)**<br> 


### CompressionOptions {#CompressionOptions4}

Field | Description
--- | ---
compression_variant | **oneof:** `fetch_compressed`, `gzip_on` or `brotli_compression`<br>
&nbsp;&nbsp;fetch_compressed | **[BoolOption](#BoolOption4)**<br> 
&nbsp;&nbsp;gzip_on | **[BoolOption](#BoolOption4)**<br> 
&nbsp;&nbsp;brotli_compression | **[StringsListOption](#StringsListOption4)**<br> 


### RewriteOption {#RewriteOption4}

Field | Description
--- | ---
enabled | **bool**<br> 
body | **string**<br> 
flag | enum **RewriteFlag**<br> <ul><ul/>


### SSLTargetCertificate {#SSLTargetCertificate1}

Field | Description
--- | ---
type | enum **SSLCertificateType**<br> <ul><ul/>
data | **[SSLCertificateData](#SSLCertificateData4)**<br> 


### SSLCertificateData {#SSLCertificateData4}

Field | Description
--- | ---
ssl_certificate_data_variant | **oneof:** `cm`<br>
&nbsp;&nbsp;cm | **[SSLCertificateCMData](#SSLCertificateCMData4)**<br> 


### SSLCertificateCMData {#SSLCertificateCMData4}

Field | Description
--- | ---
id | **string**<br> 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateResourceMetadata](#UpdateResourceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Resource](#Resource3)>**<br>if operation finished successfully. 


### UpdateResourceMetadata {#UpdateResourceMetadata}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of updated resource. The maximum string length in characters is 50.


### Resource {#Resource3}

Field | Description
--- | ---
id | **string**<br>Resource id. 
folder_id | **string**<br>Folder id. 
cname | **string**<br>CDN endpoint CNAME, must be unique among resources. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
active | **bool**<br>Resource state. 
options | **[ResourceOptions](#ResourceOptions5)**<br> 
secondary_hostnames[] | **string**<br> 
origin_group_id | **int64**<br> 
origin_group_name | **string**<br> 
origin_protocol | enum **OriginProtocol**<br> <ul><ul/>
ssl_certificate | **[SSLCertificate](#SSLCertificate3)**<br> 


### ResourceOptions {#ResourceOptions5}

Field | Description
--- | ---
disable_cache | **[BoolOption](#BoolOption5)**<br> 
edge_cache_settings | **[EdgeCacheSettings](#EdgeCacheSettings5)**<br> 
browser_cache_settings | **[Int64Option](#Int64Option5)**<br> 
cache_http_headers | **[StringsListOption](#StringsListOption5)**<br> 
query_params_options | **[QueryParamsOptions](#QueryParamsOptions5)**<br> 
slice | **[BoolOption](#BoolOption5)**<br> 
compression_options | **[CompressionOptions](#CompressionOptions5)**<br> 
redirect_options | **[RedirectOptions](#RedirectOptions5)**<br> 
host_options | **[HostOptions](#HostOptions5)**<br> 
static_headers | **[StringsMapOption](#StringsMapOption5)**<br> 
cors | **[StringsListOption](#StringsListOption5)**<br> 
stale | **[StringsListOption](#StringsListOption5)**<br> 
allowed_http_methods | **[StringsListOption](#StringsListOption5)**<br> 
proxy_cache_methods_set | **[BoolOption](#BoolOption5)**<br> 
disable_proxy_force_ranges | **[BoolOption](#BoolOption5)**<br> 
static_request_headers | **[StringsMapOption](#StringsMapOption5)**<br> 
custom_server_name | **[StringOption](#StringOption5)**<br> 
ignore_cookie | **[BoolOption](#BoolOption5)**<br> 
rewrite | **[RewriteOption](#RewriteOption5)**<br> 


### BoolOption {#BoolOption5}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **bool**<br> 


### StringOption {#StringOption5}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **string**<br> 


### Int64Option {#Int64Option5}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **int64**<br> 


### StringsListOption {#StringsListOption5}

Field | Description
--- | ---
enabled | **bool**<br> 
value[] | **string**<br> 


### StringsMapOption {#StringsMapOption5}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **map<string,string>**<br> 


### CachingTimes {#CachingTimes5}

Field | Description
--- | ---
simple_value | **int64**<br> 
custom_values | **map<string,int64>**<br> 


### EdgeCacheSettings {#EdgeCacheSettings5}

Field | Description
--- | ---
enabled | **bool**<br> 
values_variant | **oneof:** `value` or `default_value`<br>
&nbsp;&nbsp;value | **[CachingTimes](#CachingTimes5)**<br> 
&nbsp;&nbsp;default_value | **int64**<br> 


### StringVariableMapOption {#StringVariableMapOption5}

Field | Description
--- | ---
enabled | **bool**<br> 
value | **map<string,OneofString>**<br> 


### OneofString {#OneofString5}

Field | Description
--- | ---
string_option | **oneof:** `value` or `values`<br>
&nbsp;&nbsp;value | **[StringOption](#StringOption5)**<br> 
&nbsp;&nbsp;values | **[StringsListOption](#StringsListOption5)**<br> 


### QueryParamsOptions {#QueryParamsOptions5}

Field | Description
--- | ---
query_params_variant | **oneof:** `ignore_query_string`, `query_params_whitelist` or `query_params_blacklist`<br>
&nbsp;&nbsp;ignore_query_string | **[BoolOption](#BoolOption5)**<br> 
&nbsp;&nbsp;query_params_whitelist | **[StringsListOption](#StringsListOption5)**<br> 
&nbsp;&nbsp;query_params_blacklist | **[StringsListOption](#StringsListOption5)**<br> 


### RedirectOptions {#RedirectOptions5}

Field | Description
--- | ---
redirect_variant | **oneof:** `redirect_http_to_https` or `redirect_https_to_http`<br>
&nbsp;&nbsp;redirect_http_to_https | **[BoolOption](#BoolOption5)**<br> 
&nbsp;&nbsp;redirect_https_to_http | **[BoolOption](#BoolOption5)**<br> 


### HostOptions {#HostOptions5}

Field | Description
--- | ---
host_variant | **oneof:** `host` or `forward_host_header`<br>
&nbsp;&nbsp;host | **[StringOption](#StringOption5)**<br> 
&nbsp;&nbsp;forward_host_header | **[BoolOption](#BoolOption5)**<br> 


### CompressionOptions {#CompressionOptions5}

Field | Description
--- | ---
compression_variant | **oneof:** `fetch_compressed`, `gzip_on` or `brotli_compression`<br>
&nbsp;&nbsp;fetch_compressed | **[BoolOption](#BoolOption5)**<br> 
&nbsp;&nbsp;gzip_on | **[BoolOption](#BoolOption5)**<br> 
&nbsp;&nbsp;brotli_compression | **[StringsListOption](#StringsListOption5)**<br> 


### RewriteOption {#RewriteOption5}

Field | Description
--- | ---
enabled | **bool**<br> 
body | **string**<br> 
flag | enum **RewriteFlag**<br> <ul><ul/>


### SSLCertificate {#SSLCertificate3}

Field | Description
--- | ---
type | enum **SSLCertificateType**<br> <ul><ul/>
status | enum **SSLCertificateStatus**<br> <ul><ul/>
data | **[SSLCertificateData](#SSLCertificateData5)**<br> 


### SSLCertificateData {#SSLCertificateData5}

Field | Description
--- | ---
ssl_certificate_data_variant | **oneof:** `cm`<br>
&nbsp;&nbsp;cm | **[SSLCertificateCMData](#SSLCertificateCMData5)**<br> 


### SSLCertificateCMData {#SSLCertificateCMData5}

Field | Description
--- | ---
id | **string**<br> 


## Delete {#Delete}

Delete client's CDN resource.

**rpc Delete ([DeleteResourceRequest](#DeleteResourceRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteResourceMetadata](#DeleteResourceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteResourceRequest {#DeleteResourceRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of resource to delete. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteResourceMetadata](#DeleteResourceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteResourceMetadata {#DeleteResourceMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of deleted resource. 


## GetProviderCName {#GetProviderCName}

Get Provider's CNAME (edge endpoint) binded to specified folder id. Return UNIMPLEMENTED error, if provider doesn't support CNAME request.

**rpc GetProviderCName ([GetProviderCNameRequest](#GetProviderCNameRequest)) returns ([GetProviderCNameResponse](#GetProviderCNameResponse))**

### GetProviderCNameRequest {#GetProviderCNameRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID to get provider's CNAME. The maximum string length in characters is 50.


### GetProviderCNameResponse {#GetProviderCNameResponse}

Field | Description
--- | ---
cname | **string**<br>Provider's CNAME. 
folder_id | **string**<br>Owner folder id. 


