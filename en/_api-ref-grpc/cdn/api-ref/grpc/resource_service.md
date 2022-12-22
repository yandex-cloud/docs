---
editable: false
---

# Cloud CDN API, gRPC: ResourceService

Provider's resources management service.

| Call | Description |
| --- | --- |
| [Get](#Get) | Get client's CDN resource by resource id. |
| [List](#List) | Lists CDN resources. |
| [Create](#Create) | Creates a CDN resource in the specified folder. |
| [Update](#Update) | Updates the specified CDN resource. |
| [Delete](#Delete) | Deletes client's CDN resource. |
| [GetProviderCName](#GetProviderCName) | Get Provider's CNAME (edge endpoint) bind to specified folder id. |

## Calls ResourceService {#calls}

## Get {#Get}

Get client's CDN resource by resource id.

**rpc Get ([GetResourceRequest](#GetResourceRequest)) returns ([Resource](#Resource))**

### GetResourceRequest {#GetResourceRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the requested resource. The maximum string length in characters is 50.


### Resource {#Resource}

Field | Description
--- | ---
id | **string**<br>ID of the resource. 
folder_id | **string**<br>Folder id. 
cname | **string**<br>CDN endpoint CNAME, must be unique among resources. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
active | **bool**<br>Flag to create Resource either in active or disabled state. True - the content from CDN is available to clients. False - the content from CDN isn't available to clients. 
options | **[ResourceOptions](#ResourceOptions)**<br>Resource settings and options to tune CDN edge behavior. 
secondary_hostnames[] | **string**<br>List of secondary hostname strings. 
origin_group_id | **int64**<br>ID of the origin group. 
origin_group_name | **string**<br>Name of the origin group. 
origin_protocol | enum **OriginProtocol**<br>Specify the protocol schema to be used in communication with origin. <ul><li>`HTTP`: CDN servers will connect to your origin via HTTP.</li><li>`HTTPS`: CDN servers will connect to your origin via HTTPS.</li><li>`MATCH`: Connection protocol will be chosen automatically (content on the origin source should be available for the CDN both through HTTP and HTTPS).</li></ul>
ssl_certificate | **[SSLCertificate](#SSLCertificate)**<br>SSL certificate options. 


### ResourceOptions {#ResourceOptions}

Field | Description
--- | ---
disable_cache | **[BoolOption](#BoolOption)**<br>Set up a cache status. 
edge_cache_settings | **[EdgeCacheSettings](#EdgeCacheSettings)**<br>Set up [EdgeCacheSettings](#EdgeCacheSettings). 
browser_cache_settings | **[Int64Option](#Int64Option)**<br>Using [Int64Option](#Int64Option). Set up a cache period for the end-users browser. Content will be cached due to origin settings. If there are no cache settings on your origin, the content will not be cached. The list of HTTP response codes that can be cached in browsers: 200, 201, 204, 206, 301, 302, 303, 304, 307, 308. Other response codes will not be cached. The default value is 4 days. 
cache_http_headers | **[StringsListOption](#StringsListOption)**<br>List HTTP headers that must be included in responses to clients. 
query_params_options | **[QueryParamsOptions](#QueryParamsOptions)**<br>Set up [QueryParamsOptions](#QueryParamsOptions). 
slice | **[BoolOption](#BoolOption)**<br>Files larger than 10 MB will be requested and cached in parts (no larger than 10 MB each part). It reduces time to first byte. <br>The origin must support HTTP Range requests. <br>By default the option is disabled. 
compression_options | **[CompressionOptions](#CompressionOptions)**<br>Set up compression variant. 
redirect_options | **[RedirectOptions](#RedirectOptions)**<br>Set up redirects. 
host_options | **[HostOptions](#HostOptions)**<br>Set up host parameters. 
static_headers | **[StringsMapOption](#StringsMapOption)**<br>Set up static headers that CDN servers send in responses to clients. 
cors | **[StringsListOption](#StringsListOption)**<br>Parameter that lets browsers get access to selected resources from a domain different to a domain from which the request is received. [Read more](/docs/cdn/concepts/cors). 
stale | **[StringsListOption](#StringsListOption)**<br>List of errors which instruct CDN servers to serve stale content to clients. <br>Possible values: `error`, `http_403`, `http_404`, `http_429`, `http_500`, `http_502`, `http_503`, `http_504`, `invalid_header`, `timeout`, `updating`. 
allowed_http_methods | **[StringsListOption](#StringsListOption)**<br>HTTP methods for your CDN content. By default the following methods are allowed: GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS. In case some methods are not allowed to the user, they will get the 405 (Method Not Allowed) response. If the method is not supported, the user gets the 501 (Not Implemented) response. 
proxy_cache_methods_set | **[BoolOption](#BoolOption)**<br>Allows caching for GET, HEAD and POST requests. 
disable_proxy_force_ranges | **[BoolOption](#BoolOption)**<br>Disabling proxy force ranges. 
static_request_headers | **[StringsMapOption](#StringsMapOption)**<br>Set up custom headers that CDN servers send in requests to origins. The Header name field can contain letters (A-Z, a-z), numbers (0-9), dashes (-) and underscores (_). The Value field can contain letters (A-Z, a-z), numbers (0-9), dashes (-), underscores (_), slashes (/), colons (:), equal (=), dots (.), and spaces. 
custom_server_name | **[StringOption](#StringOption)**<br>Wildcard additional CNAME. If a resource has a wildcard additional CNAME, you can use your own certificate for content delivery via HTTPS. Read-only. 
ignore_cookie | **[BoolOption](#BoolOption)**<br>Using [BoolOption](#BoolOption) for ignoring cookie. 
rewrite | **[RewriteOption](#RewriteOption)**<br>Changing or redirecting query paths. 


### BoolOption {#BoolOption}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **bool**<br>Value of the option. 


### StringOption {#StringOption}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **string**<br>Value of the option. 


### Int64Option {#Int64Option}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **int64**<br>Value of the option. 


### StringsListOption {#StringsListOption}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value[] | **string**<br>Value of the option. 


### StringsMapOption {#StringsMapOption}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **map<string,string>**<br>Value of the option. 


### CachingTimes {#CachingTimes}

Field | Description
--- | ---
simple_value | **int64**<br>Caching time for a response with codes 200, 206, 301, 302. Responses with codes 4xx, 5xx will not be cached. Use `0s` disable to caching. Use `custom_values` field to specify a custom caching time for a response with specific codes. 
custom_values | **map<string,int64>**<br>Caching time for a response with specific codes. These settings have a higher priority than the value field. Response code (`304`, `404` for example). Use `any` to specify caching time for all response codes. Caching time in seconds (`0s`, `600s` for example). Use `0s` to disable caching for a specific response code. 


### EdgeCacheSettings {#EdgeCacheSettings}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `values_variant` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
values_variant | **oneof:** `value` or `default_value`<br>
&nbsp;&nbsp;value | **[CachingTimes](#CachingTimes)**<br>Value of the option. 
&nbsp;&nbsp;default_value | **int64**<br>Content will be cached according to origin cache settings. The value applies for a response with codes 200, 201, 204, 206, 301, 302, 303, 304, 307, 308 if an origin server does not have caching HTTP headers. Responses with other codes will not be cached. 


### StringVariableMapOption {#StringVariableMapOption}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **map<string,OneofString>**<br>Value of the option. 


### OneofString {#OneofString}

Field | Description
--- | ---
string_option | **oneof:** `value` or `values`<br>
&nbsp;&nbsp;value | **[StringOption](#StringOption)**<br>Using [StringOption](#StringOption) to set value. 
&nbsp;&nbsp;values | **[StringsListOption](#StringsListOption)**<br>Using [StringsListOption](#StringsListOption) to set values. 


### QueryParamsOptions {#QueryParamsOptions}

Field | Description
--- | ---
query_params_variant | **oneof:** `ignore_query_string`, `query_params_whitelist` or `query_params_blacklist`<br>
&nbsp;&nbsp;ignore_query_string | **[BoolOption](#BoolOption)**<br>Using [BoolOption](#BoolOption). Selected by default. Files with different query parameters are cached as objects with the same key regardless of the parameter value. 
&nbsp;&nbsp;query_params_whitelist | **[StringsListOption](#StringsListOption)**<br>Ignore All Except. Files with the specified query parameters are cached as objects with different keys, files with other parameters are cached as objects with the same key. 
&nbsp;&nbsp;query_params_blacklist | **[StringsListOption](#StringsListOption)**<br>Ignore only. Files with the specified query parameters are cached as objects with the same key, files with other parameters are cached as objects with different keys. 


### RedirectOptions {#RedirectOptions}

Field | Description
--- | ---
redirect_variant | **oneof:** `redirect_http_to_https` or `redirect_https_to_http`<br>
&nbsp;&nbsp;redirect_http_to_https | **[BoolOption](#BoolOption)**<br>Using [BoolOption](#BoolOption). Set up a redirect from HTTPS to HTTP. 
&nbsp;&nbsp;redirect_https_to_http | **[BoolOption](#BoolOption)**<br>Using [BoolOption](#BoolOption). Set up a redirect from HTTP to HTTPS. 


### HostOptions {#HostOptions}

Field | Description
--- | ---
host_variant | **oneof:** `host` or `forward_host_header`<br>
&nbsp;&nbsp;host | **[StringOption](#StringOption)**<br>Custom value for the Host header. <br>Your server must be able to process requests with the chosen header. <br>Default value (if [StringOption.enabled](#StringOption) is `false`) is [Resource.cname](#Resource1). 
&nbsp;&nbsp;forward_host_header | **[BoolOption](#BoolOption)**<br>Using [BoolOption](#BoolOption). Choose the Forward Host header option if is important to send in the request to the Origin the same Host header as was sent in the request to CDN server. 


### CompressionOptions {#CompressionOptions}

Field | Description
--- | ---
compression_variant | **oneof:** `fetch_compressed`, `gzip_on` or `brotli_compression`<br>
&nbsp;&nbsp;fetch_compressed | **[BoolOption](#BoolOption)**<br>The Fetch compressed option helps you to reduce the bandwidth between origin and CDN servers. Also, content delivery speed becomes higher because of reducing the time for compressing files in a CDN. 
&nbsp;&nbsp;gzip_on | **[BoolOption](#BoolOption)**<br>Using [BoolOption](#BoolOption). GZip compression at CDN servers reduces file size by 70% and can be as high as 90%. 
&nbsp;&nbsp;brotli_compression | **[StringsListOption](#StringsListOption)**<br>The option allows to compress content with brotli on the CDN's end. <br>Compression is performed on the Origin Shielding. If a pre-cache server doesn't active for a resource, compression does not occur even if the option is enabled. <br>Specify the content-type for each type of content you wish to have compressed. CDN servers will request only uncompressed content from the origin. 


### RewriteOption {#RewriteOption}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `flag` is applied to the resource. False - the option is disabled and its default value of the `flag` is used for the resource. 
body | **string**<br>Pattern for rewrite. <br>The value must have the following format: `<source path> <destination path>`, where both paths are regular expressions which use at least one group. E.g., `/foo/(.*) /bar/$1`. 
flag | enum **RewriteFlag**<br>Break flag is applied to the option by default. It is not shown in the field. <ul><li>`LAST`: Stops processing of the current set of ngx_http_rewrite_module directives and starts a search for a new location matching changed URI.</li><li>`BREAK`: Stops processing of the current set of the Rewrite option.</li><li>`REDIRECT`: Returns a temporary redirect with the 302 code; It is used when a replacement string does not start with "http://", "https://", or "$scheme".</li><li>`PERMANENT`: Returns a permanent redirect with the 301 code.</li></ul>


### SSLCertificate {#SSLCertificate}

Field | Description
--- | ---
type | enum **SSLCertificateType**<br>Type of the certificate. <ul><li>`SSL_CERTIFICATE_TYPE_UNSPECIFIED`: SSL certificate is unspecified.</li><li>`DONT_USE`: No SSL certificate is added, the requests are sent via HTTP.</li><li>`LETS_ENCRYPT_GCORE`: Works only if you have already pointed your domain name to the protected IP address in your DNS</li><li>`CM`: Add your SSL certificate by uploading the certificate in PEM format and your private key</li></ul>
status | enum **SSLCertificateStatus**<br>Active status. <ul><li>`SSL_CERTIFICATE_STATUS_UNSPECIFIED`: SSL certificate is unspecified.</li><li>`READY`: SSL certificate is ready to use.</li><li>`CREATING`: SSL certificate is creating.</li></ul>
data | **[SSLCertificateData](#SSLCertificateData)**<br>Certificate data. 


### SSLCertificateData {#SSLCertificateData}

Field | Description
--- | ---
ssl_certificate_data_variant | **oneof:** `cm`<br>
&nbsp;&nbsp;cm | **[SSLCertificateCMData](#SSLCertificateCMData)**<br>Custom (add your SSL certificate by uploading the certificate in PEM format and your private key). 


### SSLCertificateCMData {#SSLCertificateCMData}

Field | Description
--- | ---
id | **string**<br>ID of the custom certificate. 


## List {#List}

Lists CDN resources.

**rpc List ([ListResourcesRequest](#ListResourcesRequest)) returns ([ListResourcesResponse](#ListResourcesResponse))**

### ListResourcesRequest {#ListResourcesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to request listing for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListResourcesResponse.next_page_token](#ListResourcesResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListResourcesResponse.next_page_token](#ListResourcesResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListResourcesResponse {#ListResourcesResponse}

Field | Description
--- | ---
resources[] | **[Resource](#Resource1)**<br>List of the resources 
next_page_token | **string**<br>`next_page_token` token allows you to get the next page of results for list requests. If the number of results is larger than [ListResourcesRequest.page_size](#ListResourcesRequest), use the `next_page_token` as the value for the [ListResourcesRequest.page_token](#ListResourcesRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Resource {#Resource1}

Field | Description
--- | ---
id | **string**<br>ID of the resource. 
folder_id | **string**<br>Folder id. 
cname | **string**<br>CDN endpoint CNAME, must be unique among resources. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
active | **bool**<br>Flag to create Resource either in active or disabled state. True - the content from CDN is available to clients. False - the content from CDN isn't available to clients. 
options | **[ResourceOptions](#ResourceOptions1)**<br>Resource settings and options to tune CDN edge behavior. 
secondary_hostnames[] | **string**<br>List of secondary hostname strings. 
origin_group_id | **int64**<br>ID of the origin group. 
origin_group_name | **string**<br>Name of the origin group. 
origin_protocol | enum **OriginProtocol**<br>Specify the protocol schema to be used in communication with origin. <ul><li>`HTTP`: CDN servers will connect to your origin via HTTP.</li><li>`HTTPS`: CDN servers will connect to your origin via HTTPS.</li><li>`MATCH`: Connection protocol will be chosen automatically (content on the origin source should be available for the CDN both through HTTP and HTTPS).</li></ul>
ssl_certificate | **[SSLCertificate](#SSLCertificate1)**<br>SSL certificate options. 


### ResourceOptions {#ResourceOptions1}

Field | Description
--- | ---
disable_cache | **[BoolOption](#BoolOption1)**<br>Set up a cache status. 
edge_cache_settings | **[EdgeCacheSettings](#EdgeCacheSettings1)**<br>Set up [EdgeCacheSettings](#EdgeCacheSettings1). 
browser_cache_settings | **[Int64Option](#Int64Option1)**<br>Using [Int64Option](#Int64Option1). Set up a cache period for the end-users browser. Content will be cached due to origin settings. If there are no cache settings on your origin, the content will not be cached. The list of HTTP response codes that can be cached in browsers: 200, 201, 204, 206, 301, 302, 303, 304, 307, 308. Other response codes will not be cached. The default value is 4 days. 
cache_http_headers | **[StringsListOption](#StringsListOption1)**<br>List HTTP headers that must be included in responses to clients. 
query_params_options | **[QueryParamsOptions](#QueryParamsOptions1)**<br>Set up [QueryParamsOptions](#QueryParamsOptions1). 
slice | **[BoolOption](#BoolOption1)**<br>Files larger than 10 MB will be requested and cached in parts (no larger than 10 MB each part). It reduces time to first byte. <br>The origin must support HTTP Range requests. <br>By default the option is disabled. 
compression_options | **[CompressionOptions](#CompressionOptions1)**<br>Set up compression variant. 
redirect_options | **[RedirectOptions](#RedirectOptions1)**<br>Set up redirects. 
host_options | **[HostOptions](#HostOptions1)**<br>Set up host parameters. 
static_headers | **[StringsMapOption](#StringsMapOption1)**<br>Set up static headers that CDN servers send in responses to clients. 
cors | **[StringsListOption](#StringsListOption1)**<br>Parameter that lets browsers get access to selected resources from a domain different to a domain from which the request is received. [Read more](/docs/cdn/concepts/cors). 
stale | **[StringsListOption](#StringsListOption1)**<br>List of errors which instruct CDN servers to serve stale content to clients. <br>Possible values: `error`, `http_403`, `http_404`, `http_429`, `http_500`, `http_502`, `http_503`, `http_504`, `invalid_header`, `timeout`, `updating`. 
allowed_http_methods | **[StringsListOption](#StringsListOption1)**<br>HTTP methods for your CDN content. By default the following methods are allowed: GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS. In case some methods are not allowed to the user, they will get the 405 (Method Not Allowed) response. If the method is not supported, the user gets the 501 (Not Implemented) response. 
proxy_cache_methods_set | **[BoolOption](#BoolOption1)**<br>Allows caching for GET, HEAD and POST requests. 
disable_proxy_force_ranges | **[BoolOption](#BoolOption1)**<br>Disabling proxy force ranges. 
static_request_headers | **[StringsMapOption](#StringsMapOption1)**<br>Set up custom headers that CDN servers send in requests to origins. The Header name field can contain letters (A-Z, a-z), numbers (0-9), dashes (-) and underscores (_). The Value field can contain letters (A-Z, a-z), numbers (0-9), dashes (-), underscores (_), slashes (/), colons (:), equal (=), dots (.), and spaces. 
custom_server_name | **[StringOption](#StringOption1)**<br>Wildcard additional CNAME. If a resource has a wildcard additional CNAME, you can use your own certificate for content delivery via HTTPS. Read-only. 
ignore_cookie | **[BoolOption](#BoolOption1)**<br>Using [BoolOption](#BoolOption1) for ignoring cookie. 
rewrite | **[RewriteOption](#RewriteOption1)**<br>Changing or redirecting query paths. 


### BoolOption {#BoolOption1}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **bool**<br>Value of the option. 


### StringOption {#StringOption1}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **string**<br>Value of the option. 


### Int64Option {#Int64Option1}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **int64**<br>Value of the option. 


### StringsListOption {#StringsListOption1}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value[] | **string**<br>Value of the option. 


### StringsMapOption {#StringsMapOption1}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **map<string,string>**<br>Value of the option. 


### CachingTimes {#CachingTimes1}

Field | Description
--- | ---
simple_value | **int64**<br>Caching time for a response with codes 200, 206, 301, 302. Responses with codes 4xx, 5xx will not be cached. Use `0s` disable to caching. Use `custom_values` field to specify a custom caching time for a response with specific codes. 
custom_values | **map<string,int64>**<br>Caching time for a response with specific codes. These settings have a higher priority than the value field. Response code (`304`, `404` for example). Use `any` to specify caching time for all response codes. Caching time in seconds (`0s`, `600s` for example). Use `0s` to disable caching for a specific response code. 


### EdgeCacheSettings {#EdgeCacheSettings1}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `values_variant` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
values_variant | **oneof:** `value` or `default_value`<br>
&nbsp;&nbsp;value | **[CachingTimes](#CachingTimes1)**<br>Value of the option. 
&nbsp;&nbsp;default_value | **int64**<br>Content will be cached according to origin cache settings. The value applies for a response with codes 200, 201, 204, 206, 301, 302, 303, 304, 307, 308 if an origin server does not have caching HTTP headers. Responses with other codes will not be cached. 


### StringVariableMapOption {#StringVariableMapOption1}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **map<string,OneofString>**<br>Value of the option. 


### OneofString {#OneofString1}

Field | Description
--- | ---
string_option | **oneof:** `value` or `values`<br>
&nbsp;&nbsp;value | **[StringOption](#StringOption1)**<br>Using [StringOption](#StringOption1) to set value. 
&nbsp;&nbsp;values | **[StringsListOption](#StringsListOption1)**<br>Using [StringsListOption](#StringsListOption1) to set values. 


### QueryParamsOptions {#QueryParamsOptions1}

Field | Description
--- | ---
query_params_variant | **oneof:** `ignore_query_string`, `query_params_whitelist` or `query_params_blacklist`<br>
&nbsp;&nbsp;ignore_query_string | **[BoolOption](#BoolOption1)**<br>Using [BoolOption](#BoolOption1). Selected by default. Files with different query parameters are cached as objects with the same key regardless of the parameter value. 
&nbsp;&nbsp;query_params_whitelist | **[StringsListOption](#StringsListOption1)**<br>Ignore All Except. Files with the specified query parameters are cached as objects with different keys, files with other parameters are cached as objects with the same key. 
&nbsp;&nbsp;query_params_blacklist | **[StringsListOption](#StringsListOption1)**<br>Ignore only. Files with the specified query parameters are cached as objects with the same key, files with other parameters are cached as objects with different keys. 


### RedirectOptions {#RedirectOptions1}

Field | Description
--- | ---
redirect_variant | **oneof:** `redirect_http_to_https` or `redirect_https_to_http`<br>
&nbsp;&nbsp;redirect_http_to_https | **[BoolOption](#BoolOption1)**<br>Using [BoolOption](#BoolOption1). Set up a redirect from HTTPS to HTTP. 
&nbsp;&nbsp;redirect_https_to_http | **[BoolOption](#BoolOption1)**<br>Using [BoolOption](#BoolOption1). Set up a redirect from HTTP to HTTPS. 


### HostOptions {#HostOptions1}

Field | Description
--- | ---
host_variant | **oneof:** `host` or `forward_host_header`<br>
&nbsp;&nbsp;host | **[StringOption](#StringOption1)**<br>Custom value for the Host header. <br>Your server must be able to process requests with the chosen header. <br>Default value (if [StringOption.enabled](#StringOption1) is `false`) is [Resource.cname](#Resource2). 
&nbsp;&nbsp;forward_host_header | **[BoolOption](#BoolOption1)**<br>Using [BoolOption](#BoolOption1). Choose the Forward Host header option if is important to send in the request to the Origin the same Host header as was sent in the request to CDN server. 


### CompressionOptions {#CompressionOptions1}

Field | Description
--- | ---
compression_variant | **oneof:** `fetch_compressed`, `gzip_on` or `brotli_compression`<br>
&nbsp;&nbsp;fetch_compressed | **[BoolOption](#BoolOption1)**<br>The Fetch compressed option helps you to reduce the bandwidth between origin and CDN servers. Also, content delivery speed becomes higher because of reducing the time for compressing files in a CDN. 
&nbsp;&nbsp;gzip_on | **[BoolOption](#BoolOption1)**<br>Using [BoolOption](#BoolOption1). GZip compression at CDN servers reduces file size by 70% and can be as high as 90%. 
&nbsp;&nbsp;brotli_compression | **[StringsListOption](#StringsListOption1)**<br>The option allows to compress content with brotli on the CDN's end. <br>Compression is performed on the Origin Shielding. If a pre-cache server doesn't active for a resource, compression does not occur even if the option is enabled. <br>Specify the content-type for each type of content you wish to have compressed. CDN servers will request only uncompressed content from the origin. 


### RewriteOption {#RewriteOption1}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `flag` is applied to the resource. False - the option is disabled and its default value of the `flag` is used for the resource. 
body | **string**<br>Pattern for rewrite. <br>The value must have the following format: `<source path> <destination path>`, where both paths are regular expressions which use at least one group. E.g., `/foo/(.*) /bar/$1`. 
flag | enum **RewriteFlag**<br>Break flag is applied to the option by default. It is not shown in the field. <ul><li>`LAST`: Stops processing of the current set of ngx_http_rewrite_module directives and starts a search for a new location matching changed URI.</li><li>`BREAK`: Stops processing of the current set of the Rewrite option.</li><li>`REDIRECT`: Returns a temporary redirect with the 302 code; It is used when a replacement string does not start with "http://", "https://", or "$scheme".</li><li>`PERMANENT`: Returns a permanent redirect with the 301 code.</li></ul>


### SSLCertificate {#SSLCertificate1}

Field | Description
--- | ---
type | enum **SSLCertificateType**<br>Type of the certificate. <ul><li>`SSL_CERTIFICATE_TYPE_UNSPECIFIED`: SSL certificate is unspecified.</li><li>`DONT_USE`: No SSL certificate is added, the requests are sent via HTTP.</li><li>`LETS_ENCRYPT_GCORE`: Works only if you have already pointed your domain name to the protected IP address in your DNS</li><li>`CM`: Add your SSL certificate by uploading the certificate in PEM format and your private key</li></ul>
status | enum **SSLCertificateStatus**<br>Active status. <ul><li>`SSL_CERTIFICATE_STATUS_UNSPECIFIED`: SSL certificate is unspecified.</li><li>`READY`: SSL certificate is ready to use.</li><li>`CREATING`: SSL certificate is creating.</li></ul>
data | **[SSLCertificateData](#SSLCertificateData1)**<br>Certificate data. 


### SSLCertificateData {#SSLCertificateData1}

Field | Description
--- | ---
ssl_certificate_data_variant | **oneof:** `cm`<br>
&nbsp;&nbsp;cm | **[SSLCertificateCMData](#SSLCertificateCMData1)**<br>Custom (add your SSL certificate by uploading the certificate in PEM format and your private key). 


### SSLCertificateCMData {#SSLCertificateCMData1}

Field | Description
--- | ---
id | **string**<br>ID of the custom certificate. 


## Create {#Create}

Creates a CDN resource in the specified folder. <br>Creation may take up to 15 minutes.

**rpc Create ([CreateResourceRequest](#CreateResourceRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateResourceMetadata](#CreateResourceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Resource](#Resource2)<br>

### CreateResourceRequest {#CreateResourceRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the to bind with new resource. The maximum string length in characters is 50.
cname | **string**<br>Required. CDN endpoint CNAME, must be unique among clients's resources. 
origin | **[Origin](#Origin)**<br>Required. Specify the origins to be used for CDN resources requests. 
secondary_hostnames | **[SecondaryHostnames](#SecondaryHostnames)**<br>List of additional CNAMEs. 
origin_protocol | enum **OriginProtocol**<br>Specify the protocol schema to be used in communication with origin. <ul><li>`HTTP`: CDN servers will connect to your origin via HTTP.</li><li>`HTTPS`: CDN servers will connect to your origin via HTTPS.</li><li>`MATCH`: Connection protocol will be chosen automatically (content on the origin source should be available for the CDN both through HTTP and HTTPS).</li></ul>
active | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Flag to create Resource either in active or disabled state. In active state Origins payload could be transmitted from CDN CNAME requests. Default value: true 
options | **[ResourceOptions](#ResourceOptions2)**<br>Resource settings and options to tune CDN edge behavior. Most is unset. 
ssl_certificate | **[SSLTargetCertificate](#SSLTargetCertificate)**<br>SSL Certificate options. 


### Origin {#Origin}

Field | Description
--- | ---
origin_variant | **oneof:** `origin_group_id`, `origin_source` or `origin_source_params`<br>
&nbsp;&nbsp;origin_group_id | **int64**<br>ID of pre-created origin group. 
&nbsp;&nbsp;origin_source | **string**<br>Create new Origins group with single source, it's id will be returned in result. 
&nbsp;&nbsp;origin_source_params | **[ResourceOriginParams](#ResourceOriginParams)**<br>Set up resource origin parameters. 


### Origin {#Origin}

Field | Description
--- | ---
id | **int64**<br>ID of the origin. 
origin_group_id | **int64**<br>ID of the parent origin group. 
source | **string**<br>IP address or Domain name of your origin and the port (if custom). Used if `meta` variant is `common`. 
enabled | **bool**<br>The setting allows to enable or disable an Origin source in the Origins group. <br>It has two possible values: <br>True - The origin is enabled and used as a source for the CDN. An origins group must contain at least one enabled origin. False - The origin is disabled and the CDN is not using it to pull content. 
backup | **bool**<br>Specifies whether the origin is used in its origin group as backup. A backup origin is used when one of active origins becomes unavailable. 
meta | **[OriginMeta](#OriginMeta)**<br>Set up origin of the content. 


### OriginMeta {#OriginMeta}

Field | Description
--- | ---
origin_meta_variant | **oneof:** `common`, `bucket`, `website` or `balancer`<br>Type of the origin.
&nbsp;&nbsp;common | **[OriginNamedMeta](#OriginNamedMeta)**<br>A server with a domain name linked to it 
&nbsp;&nbsp;bucket | **[OriginNamedMeta](#OriginNamedMeta)**<br>An Object Storage bucket not configured as a static site hosting. 
&nbsp;&nbsp;website | **[OriginNamedMeta](#OriginNamedMeta)**<br>An Object Storage bucket configured as a static site hosting. 
&nbsp;&nbsp;balancer | **[OriginBalancerMeta](#OriginBalancerMeta)**<br>An L7 load balancer from Application Load Balancer. CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings. 


### OriginNamedMeta {#OriginNamedMeta}

Field | Description
--- | ---
name | **string**<br>Name of the origin. 


### OriginBalancerMeta {#OriginBalancerMeta}

Field | Description
--- | ---
id | **string**<br>ID of the origin. 


### SecondaryHostnames {#SecondaryHostnames}

Field | Description
--- | ---
values[] | **string**<br>List of secondary hostname values. 


### ResourceOptions {#ResourceOptions2}

Field | Description
--- | ---
disable_cache | **[BoolOption](#BoolOption2)**<br>Set up a cache status. 
edge_cache_settings | **[EdgeCacheSettings](#EdgeCacheSettings2)**<br>Set up [EdgeCacheSettings](#EdgeCacheSettings2). 
browser_cache_settings | **[Int64Option](#Int64Option2)**<br>Using [Int64Option](#Int64Option2). Set up a cache period for the end-users browser. Content will be cached due to origin settings. If there are no cache settings on your origin, the content will not be cached. The list of HTTP response codes that can be cached in browsers: 200, 201, 204, 206, 301, 302, 303, 304, 307, 308. Other response codes will not be cached. The default value is 4 days. 
cache_http_headers | **[StringsListOption](#StringsListOption2)**<br>List HTTP headers that must be included in responses to clients. 
query_params_options | **[QueryParamsOptions](#QueryParamsOptions2)**<br>Set up [QueryParamsOptions](#QueryParamsOptions2). 
slice | **[BoolOption](#BoolOption2)**<br>Files larger than 10 MB will be requested and cached in parts (no larger than 10 MB each part). It reduces time to first byte. <br>The origin must support HTTP Range requests. <br>By default the option is disabled. 
compression_options | **[CompressionOptions](#CompressionOptions2)**<br>Set up compression variant. 
redirect_options | **[RedirectOptions](#RedirectOptions2)**<br>Set up redirects. 
host_options | **[HostOptions](#HostOptions2)**<br>Set up host parameters. 
static_headers | **[StringsMapOption](#StringsMapOption2)**<br>Set up static headers that CDN servers send in responses to clients. 
cors | **[StringsListOption](#StringsListOption2)**<br>Parameter that lets browsers get access to selected resources from a domain different to a domain from which the request is received. [Read more](/docs/cdn/concepts/cors). 
stale | **[StringsListOption](#StringsListOption2)**<br>List of errors which instruct CDN servers to serve stale content to clients. <br>Possible values: `error`, `http_403`, `http_404`, `http_429`, `http_500`, `http_502`, `http_503`, `http_504`, `invalid_header`, `timeout`, `updating`. 
allowed_http_methods | **[StringsListOption](#StringsListOption2)**<br>HTTP methods for your CDN content. By default the following methods are allowed: GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS. In case some methods are not allowed to the user, they will get the 405 (Method Not Allowed) response. If the method is not supported, the user gets the 501 (Not Implemented) response. 
proxy_cache_methods_set | **[BoolOption](#BoolOption2)**<br>Allows caching for GET, HEAD and POST requests. 
disable_proxy_force_ranges | **[BoolOption](#BoolOption2)**<br>Disabling proxy force ranges. 
static_request_headers | **[StringsMapOption](#StringsMapOption2)**<br>Set up custom headers that CDN servers send in requests to origins. The Header name field can contain letters (A-Z, a-z), numbers (0-9), dashes (-) and underscores (_). The Value field can contain letters (A-Z, a-z), numbers (0-9), dashes (-), underscores (_), slashes (/), colons (:), equal (=), dots (.), and spaces. 
custom_server_name | **[StringOption](#StringOption2)**<br>Wildcard additional CNAME. If a resource has a wildcard additional CNAME, you can use your own certificate for content delivery via HTTPS. Read-only. 
ignore_cookie | **[BoolOption](#BoolOption2)**<br>Using [BoolOption](#BoolOption2) for ignoring cookie. 
rewrite | **[RewriteOption](#RewriteOption2)**<br>Changing or redirecting query paths. 


### BoolOption {#BoolOption2}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **bool**<br>Value of the option. 


### StringOption {#StringOption2}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **string**<br>Value of the option. 


### Int64Option {#Int64Option2}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **int64**<br>Value of the option. 


### StringsListOption {#StringsListOption2}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value[] | **string**<br>Value of the option. 


### StringsMapOption {#StringsMapOption2}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **map<string,string>**<br>Value of the option. 


### CachingTimes {#CachingTimes2}

Field | Description
--- | ---
simple_value | **int64**<br>Caching time for a response with codes 200, 206, 301, 302. Responses with codes 4xx, 5xx will not be cached. Use `0s` disable to caching. Use `custom_values` field to specify a custom caching time for a response with specific codes. 
custom_values | **map<string,int64>**<br>Caching time for a response with specific codes. These settings have a higher priority than the value field. Response code (`304`, `404` for example). Use `any` to specify caching time for all response codes. Caching time in seconds (`0s`, `600s` for example). Use `0s` to disable caching for a specific response code. 


### EdgeCacheSettings {#EdgeCacheSettings2}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `values_variant` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
values_variant | **oneof:** `value` or `default_value`<br>
&nbsp;&nbsp;value | **[CachingTimes](#CachingTimes2)**<br>Value of the option. 
&nbsp;&nbsp;default_value | **int64**<br>Content will be cached according to origin cache settings. The value applies for a response with codes 200, 201, 204, 206, 301, 302, 303, 304, 307, 308 if an origin server does not have caching HTTP headers. Responses with other codes will not be cached. 


### StringVariableMapOption {#StringVariableMapOption2}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **map<string,OneofString>**<br>Value of the option. 


### OneofString {#OneofString2}

Field | Description
--- | ---
string_option | **oneof:** `value` or `values`<br>
&nbsp;&nbsp;value | **[StringOption](#StringOption2)**<br>Using [StringOption](#StringOption2) to set value. 
&nbsp;&nbsp;values | **[StringsListOption](#StringsListOption2)**<br>Using [StringsListOption](#StringsListOption2) to set values. 


### QueryParamsOptions {#QueryParamsOptions2}

Field | Description
--- | ---
query_params_variant | **oneof:** `ignore_query_string`, `query_params_whitelist` or `query_params_blacklist`<br>
&nbsp;&nbsp;ignore_query_string | **[BoolOption](#BoolOption2)**<br>Using [BoolOption](#BoolOption2). Selected by default. Files with different query parameters are cached as objects with the same key regardless of the parameter value. 
&nbsp;&nbsp;query_params_whitelist | **[StringsListOption](#StringsListOption2)**<br>Ignore All Except. Files with the specified query parameters are cached as objects with different keys, files with other parameters are cached as objects with the same key. 
&nbsp;&nbsp;query_params_blacklist | **[StringsListOption](#StringsListOption2)**<br>Ignore only. Files with the specified query parameters are cached as objects with the same key, files with other parameters are cached as objects with different keys. 


### RedirectOptions {#RedirectOptions2}

Field | Description
--- | ---
redirect_variant | **oneof:** `redirect_http_to_https` or `redirect_https_to_http`<br>
&nbsp;&nbsp;redirect_http_to_https | **[BoolOption](#BoolOption2)**<br>Using [BoolOption](#BoolOption2). Set up a redirect from HTTPS to HTTP. 
&nbsp;&nbsp;redirect_https_to_http | **[BoolOption](#BoolOption2)**<br>Using [BoolOption](#BoolOption2). Set up a redirect from HTTP to HTTPS. 


### HostOptions {#HostOptions2}

Field | Description
--- | ---
host_variant | **oneof:** `host` or `forward_host_header`<br>
&nbsp;&nbsp;host | **[StringOption](#StringOption2)**<br>Custom value for the Host header. <br>Your server must be able to process requests with the chosen header. <br>Default value (if [StringOption.enabled](#StringOption2) is `false`) is [Resource.cname](#Resource2). 
&nbsp;&nbsp;forward_host_header | **[BoolOption](#BoolOption2)**<br>Using [BoolOption](#BoolOption2). Choose the Forward Host header option if is important to send in the request to the Origin the same Host header as was sent in the request to CDN server. 


### CompressionOptions {#CompressionOptions2}

Field | Description
--- | ---
compression_variant | **oneof:** `fetch_compressed`, `gzip_on` or `brotli_compression`<br>
&nbsp;&nbsp;fetch_compressed | **[BoolOption](#BoolOption2)**<br>The Fetch compressed option helps you to reduce the bandwidth between origin and CDN servers. Also, content delivery speed becomes higher because of reducing the time for compressing files in a CDN. 
&nbsp;&nbsp;gzip_on | **[BoolOption](#BoolOption2)**<br>Using [BoolOption](#BoolOption2). GZip compression at CDN servers reduces file size by 70% and can be as high as 90%. 
&nbsp;&nbsp;brotli_compression | **[StringsListOption](#StringsListOption2)**<br>The option allows to compress content with brotli on the CDN's end. <br>Compression is performed on the Origin Shielding. If a pre-cache server doesn't active for a resource, compression does not occur even if the option is enabled. <br>Specify the content-type for each type of content you wish to have compressed. CDN servers will request only uncompressed content from the origin. 


### RewriteOption {#RewriteOption2}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `flag` is applied to the resource. False - the option is disabled and its default value of the `flag` is used for the resource. 
body | **string**<br>Pattern for rewrite. <br>The value must have the following format: `<source path> <destination path>`, where both paths are regular expressions which use at least one group. E.g., `/foo/(.*) /bar/$1`. 
flag | enum **RewriteFlag**<br>Break flag is applied to the option by default. It is not shown in the field. <ul><li>`LAST`: Stops processing of the current set of ngx_http_rewrite_module directives and starts a search for a new location matching changed URI.</li><li>`BREAK`: Stops processing of the current set of the Rewrite option.</li><li>`REDIRECT`: Returns a temporary redirect with the 302 code; It is used when a replacement string does not start with "http://", "https://", or "$scheme".</li><li>`PERMANENT`: Returns a permanent redirect with the 301 code.</li></ul>


### SSLTargetCertificate {#SSLTargetCertificate}

Field | Description
--- | ---
type | enum **SSLCertificateType**<br>Type of the certificate. <ul><li>`SSL_CERTIFICATE_TYPE_UNSPECIFIED`: SSL certificate is unspecified.</li><li>`DONT_USE`: No SSL certificate is added, the requests are sent via HTTP.</li><li>`LETS_ENCRYPT_GCORE`: Works only if you have already pointed your domain name to the protected IP address in your DNS</li><li>`CM`: Add your SSL certificate by uploading the certificate in PEM format and your private key</li></ul>
data | **[SSLCertificateData](#SSLCertificateData2)**<br>Certificate data. 


### SSLCertificateData {#SSLCertificateData2}

Field | Description
--- | ---
ssl_certificate_data_variant | **oneof:** `cm`<br>
&nbsp;&nbsp;cm | **[SSLCertificateCMData](#SSLCertificateCMData2)**<br>Custom (add your SSL certificate by uploading the certificate in PEM format and your private key). 


### SSLCertificateCMData {#SSLCertificateCMData2}

Field | Description
--- | ---
id | **string**<br>ID of the custom certificate. 


### ResourceOriginParams {#ResourceOriginParams}

Field | Description
--- | ---
source | **string**<br>Source of the content. 
meta | **[OriginMeta](#OriginMeta1)**<br>Set up type of the origin. 


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
id | **string**<br>ID of the resource. 
folder_id | **string**<br>Folder id. 
cname | **string**<br>CDN endpoint CNAME, must be unique among resources. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
active | **bool**<br>Flag to create Resource either in active or disabled state. True - the content from CDN is available to clients. False - the content from CDN isn't available to clients. 
options | **[ResourceOptions](#ResourceOptions3)**<br>Resource settings and options to tune CDN edge behavior. 
secondary_hostnames[] | **string**<br>List of secondary hostname strings. 
origin_group_id | **int64**<br>ID of the origin group. 
origin_group_name | **string**<br>Name of the origin group. 
origin_protocol | enum **OriginProtocol**<br>Specify the protocol schema to be used in communication with origin. <ul><li>`HTTP`: CDN servers will connect to your origin via HTTP.</li><li>`HTTPS`: CDN servers will connect to your origin via HTTPS.</li><li>`MATCH`: Connection protocol will be chosen automatically (content on the origin source should be available for the CDN both through HTTP and HTTPS).</li></ul>
ssl_certificate | **[SSLCertificate](#SSLCertificate2)**<br>SSL certificate options. 


### SSLCertificate {#SSLCertificate2}

Field | Description
--- | ---
type | enum **SSLCertificateType**<br>Type of the certificate. <ul><li>`SSL_CERTIFICATE_TYPE_UNSPECIFIED`: SSL certificate is unspecified.</li><li>`DONT_USE`: No SSL certificate is added, the requests are sent via HTTP.</li><li>`LETS_ENCRYPT_GCORE`: Works only if you have already pointed your domain name to the protected IP address in your DNS</li><li>`CM`: Add your SSL certificate by uploading the certificate in PEM format and your private key</li></ul>
status | enum **SSLCertificateStatus**<br>Active status. <ul><li>`SSL_CERTIFICATE_STATUS_UNSPECIFIED`: SSL certificate is unspecified.</li><li>`READY`: SSL certificate is ready to use.</li><li>`CREATING`: SSL certificate is creating.</li></ul>
data | **[SSLCertificateData](#SSLCertificateData3)**<br>Certificate data. 


## Update {#Update}

Updates the specified CDN resource. <br>The method implements patch behaviour, i.e. only the fields specified in the request are updated in the resource. <br>Changes may take up to 15 minutes to apply. Afterwards, it is recommended to purge the resource's cache via a [CacheService.Purge](./cache_service#Purge) request.

**rpc Update ([UpdateResourceRequest](#UpdateResourceRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateResourceMetadata](#UpdateResourceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Resource](#Resource3)<br>

### UpdateResourceRequest {#UpdateResourceRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of updated resource. The maximum string length in characters is 50.
origin_group_id | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>ID of updated origin group. 
secondary_hostnames | **[SecondaryHostnames](#SecondaryHostnames1)**<br>List of additional CNAMEs. 
options | **[ResourceOptions](#ResourceOptions3)**<br>Resource settings and options to tune CDN edge behavior. 
origin_protocol | enum **OriginProtocol**<br>Specify the protocol schema to be used in communication with origin. <ul><li>`HTTP`: CDN servers will connect to your origin via HTTP.</li><li>`HTTPS`: CDN servers will connect to your origin via HTTPS.</li><li>`MATCH`: Connection protocol will be chosen automatically (content on the origin source should be available for the CDN both through HTTP and HTTPS).</li></ul>
active | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Flag to create Resource either in active or disabled state. In active state Origins payload could be transmitted from CDN CNAME requests. Default value: true 
ssl_certificate | **[SSLTargetCertificate](#SSLTargetCertificate1)**<br>SSL Certificate options. 


### SecondaryHostnames {#SecondaryHostnames1}

Field | Description
--- | ---
values[] | **string**<br>List of secondary hostname values. 


### ResourceOptions {#ResourceOptions3}

Field | Description
--- | ---
disable_cache | **[BoolOption](#BoolOption3)**<br>Set up a cache status. 
edge_cache_settings | **[EdgeCacheSettings](#EdgeCacheSettings3)**<br>Set up [EdgeCacheSettings](#EdgeCacheSettings3). 
browser_cache_settings | **[Int64Option](#Int64Option3)**<br>Using [Int64Option](#Int64Option3). Set up a cache period for the end-users browser. Content will be cached due to origin settings. If there are no cache settings on your origin, the content will not be cached. The list of HTTP response codes that can be cached in browsers: 200, 201, 204, 206, 301, 302, 303, 304, 307, 308. Other response codes will not be cached. The default value is 4 days. 
cache_http_headers | **[StringsListOption](#StringsListOption3)**<br>List HTTP headers that must be included in responses to clients. 
query_params_options | **[QueryParamsOptions](#QueryParamsOptions3)**<br>Set up [QueryParamsOptions](#QueryParamsOptions3). 
slice | **[BoolOption](#BoolOption3)**<br>Files larger than 10 MB will be requested and cached in parts (no larger than 10 MB each part). It reduces time to first byte. <br>The origin must support HTTP Range requests. <br>By default the option is disabled. 
compression_options | **[CompressionOptions](#CompressionOptions3)**<br>Set up compression variant. 
redirect_options | **[RedirectOptions](#RedirectOptions3)**<br>Set up redirects. 
host_options | **[HostOptions](#HostOptions3)**<br>Set up host parameters. 
static_headers | **[StringsMapOption](#StringsMapOption3)**<br>Set up static headers that CDN servers send in responses to clients. 
cors | **[StringsListOption](#StringsListOption3)**<br>Parameter that lets browsers get access to selected resources from a domain different to a domain from which the request is received. [Read more](/docs/cdn/concepts/cors). 
stale | **[StringsListOption](#StringsListOption3)**<br>List of errors which instruct CDN servers to serve stale content to clients. <br>Possible values: `error`, `http_403`, `http_404`, `http_429`, `http_500`, `http_502`, `http_503`, `http_504`, `invalid_header`, `timeout`, `updating`. 
allowed_http_methods | **[StringsListOption](#StringsListOption3)**<br>HTTP methods for your CDN content. By default the following methods are allowed: GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS. In case some methods are not allowed to the user, they will get the 405 (Method Not Allowed) response. If the method is not supported, the user gets the 501 (Not Implemented) response. 
proxy_cache_methods_set | **[BoolOption](#BoolOption3)**<br>Allows caching for GET, HEAD and POST requests. 
disable_proxy_force_ranges | **[BoolOption](#BoolOption3)**<br>Disabling proxy force ranges. 
static_request_headers | **[StringsMapOption](#StringsMapOption3)**<br>Set up custom headers that CDN servers send in requests to origins. The Header name field can contain letters (A-Z, a-z), numbers (0-9), dashes (-) and underscores (_). The Value field can contain letters (A-Z, a-z), numbers (0-9), dashes (-), underscores (_), slashes (/), colons (:), equal (=), dots (.), and spaces. 
custom_server_name | **[StringOption](#StringOption3)**<br>Wildcard additional CNAME. If a resource has a wildcard additional CNAME, you can use your own certificate for content delivery via HTTPS. Read-only. 
ignore_cookie | **[BoolOption](#BoolOption3)**<br>Using [BoolOption](#BoolOption3) for ignoring cookie. 
rewrite | **[RewriteOption](#RewriteOption3)**<br>Changing or redirecting query paths. 


### BoolOption {#BoolOption3}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **bool**<br>Value of the option. 


### StringOption {#StringOption3}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **string**<br>Value of the option. 


### Int64Option {#Int64Option3}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **int64**<br>Value of the option. 


### StringsListOption {#StringsListOption3}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value[] | **string**<br>Value of the option. 


### StringsMapOption {#StringsMapOption3}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **map<string,string>**<br>Value of the option. 


### CachingTimes {#CachingTimes3}

Field | Description
--- | ---
simple_value | **int64**<br>Caching time for a response with codes 200, 206, 301, 302. Responses with codes 4xx, 5xx will not be cached. Use `0s` disable to caching. Use `custom_values` field to specify a custom caching time for a response with specific codes. 
custom_values | **map<string,int64>**<br>Caching time for a response with specific codes. These settings have a higher priority than the value field. Response code (`304`, `404` for example). Use `any` to specify caching time for all response codes. Caching time in seconds (`0s`, `600s` for example). Use `0s` to disable caching for a specific response code. 


### EdgeCacheSettings {#EdgeCacheSettings3}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `values_variant` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
values_variant | **oneof:** `value` or `default_value`<br>
&nbsp;&nbsp;value | **[CachingTimes](#CachingTimes3)**<br>Value of the option. 
&nbsp;&nbsp;default_value | **int64**<br>Content will be cached according to origin cache settings. The value applies for a response with codes 200, 201, 204, 206, 301, 302, 303, 304, 307, 308 if an origin server does not have caching HTTP headers. Responses with other codes will not be cached. 


### StringVariableMapOption {#StringVariableMapOption3}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `value` is applied to the resource. False - the option is disabled and its default value is used for the resource. 
value | **map<string,OneofString>**<br>Value of the option. 


### OneofString {#OneofString3}

Field | Description
--- | ---
string_option | **oneof:** `value` or `values`<br>
&nbsp;&nbsp;value | **[StringOption](#StringOption3)**<br>Using [StringOption](#StringOption3) to set value. 
&nbsp;&nbsp;values | **[StringsListOption](#StringsListOption3)**<br>Using [StringsListOption](#StringsListOption3) to set values. 


### QueryParamsOptions {#QueryParamsOptions3}

Field | Description
--- | ---
query_params_variant | **oneof:** `ignore_query_string`, `query_params_whitelist` or `query_params_blacklist`<br>
&nbsp;&nbsp;ignore_query_string | **[BoolOption](#BoolOption3)**<br>Using [BoolOption](#BoolOption3). Selected by default. Files with different query parameters are cached as objects with the same key regardless of the parameter value. 
&nbsp;&nbsp;query_params_whitelist | **[StringsListOption](#StringsListOption3)**<br>Ignore All Except. Files with the specified query parameters are cached as objects with different keys, files with other parameters are cached as objects with the same key. 
&nbsp;&nbsp;query_params_blacklist | **[StringsListOption](#StringsListOption3)**<br>Ignore only. Files with the specified query parameters are cached as objects with the same key, files with other parameters are cached as objects with different keys. 


### RedirectOptions {#RedirectOptions3}

Field | Description
--- | ---
redirect_variant | **oneof:** `redirect_http_to_https` or `redirect_https_to_http`<br>
&nbsp;&nbsp;redirect_http_to_https | **[BoolOption](#BoolOption3)**<br>Using [BoolOption](#BoolOption3). Set up a redirect from HTTPS to HTTP. 
&nbsp;&nbsp;redirect_https_to_http | **[BoolOption](#BoolOption3)**<br>Using [BoolOption](#BoolOption3). Set up a redirect from HTTP to HTTPS. 


### HostOptions {#HostOptions3}

Field | Description
--- | ---
host_variant | **oneof:** `host` or `forward_host_header`<br>
&nbsp;&nbsp;host | **[StringOption](#StringOption3)**<br>Custom value for the Host header. <br>Your server must be able to process requests with the chosen header. <br>Default value (if [StringOption.enabled](#StringOption3) is `false`) is [Resource.cname](#Resource3). 
&nbsp;&nbsp;forward_host_header | **[BoolOption](#BoolOption3)**<br>Using [BoolOption](#BoolOption3). Choose the Forward Host header option if is important to send in the request to the Origin the same Host header as was sent in the request to CDN server. 


### CompressionOptions {#CompressionOptions3}

Field | Description
--- | ---
compression_variant | **oneof:** `fetch_compressed`, `gzip_on` or `brotli_compression`<br>
&nbsp;&nbsp;fetch_compressed | **[BoolOption](#BoolOption3)**<br>The Fetch compressed option helps you to reduce the bandwidth between origin and CDN servers. Also, content delivery speed becomes higher because of reducing the time for compressing files in a CDN. 
&nbsp;&nbsp;gzip_on | **[BoolOption](#BoolOption3)**<br>Using [BoolOption](#BoolOption3). GZip compression at CDN servers reduces file size by 70% and can be as high as 90%. 
&nbsp;&nbsp;brotli_compression | **[StringsListOption](#StringsListOption3)**<br>The option allows to compress content with brotli on the CDN's end. <br>Compression is performed on the Origin Shielding. If a pre-cache server doesn't active for a resource, compression does not occur even if the option is enabled. <br>Specify the content-type for each type of content you wish to have compressed. CDN servers will request only uncompressed content from the origin. 


### RewriteOption {#RewriteOption3}

Field | Description
--- | ---
enabled | **bool**<br>True - the option is enabled and its `flag` is applied to the resource. False - the option is disabled and its default value of the `flag` is used for the resource. 
body | **string**<br>Pattern for rewrite. <br>The value must have the following format: `<source path> <destination path>`, where both paths are regular expressions which use at least one group. E.g., `/foo/(.*) /bar/$1`. 
flag | enum **RewriteFlag**<br>Break flag is applied to the option by default. It is not shown in the field. <ul><li>`LAST`: Stops processing of the current set of ngx_http_rewrite_module directives and starts a search for a new location matching changed URI.</li><li>`BREAK`: Stops processing of the current set of the Rewrite option.</li><li>`REDIRECT`: Returns a temporary redirect with the 302 code; It is used when a replacement string does not start with "http://", "https://", or "$scheme".</li><li>`PERMANENT`: Returns a permanent redirect with the 301 code.</li></ul>


### SSLTargetCertificate {#SSLTargetCertificate1}

Field | Description
--- | ---
type | enum **SSLCertificateType**<br>Type of the certificate. <ul><li>`SSL_CERTIFICATE_TYPE_UNSPECIFIED`: SSL certificate is unspecified.</li><li>`DONT_USE`: No SSL certificate is added, the requests are sent via HTTP.</li><li>`LETS_ENCRYPT_GCORE`: Works only if you have already pointed your domain name to the protected IP address in your DNS</li><li>`CM`: Add your SSL certificate by uploading the certificate in PEM format and your private key</li></ul>
data | **[SSLCertificateData](#SSLCertificateData3)**<br>Certificate data. 


### SSLCertificateData {#SSLCertificateData3}

Field | Description
--- | ---
ssl_certificate_data_variant | **oneof:** `cm`<br>
&nbsp;&nbsp;cm | **[SSLCertificateCMData](#SSLCertificateCMData3)**<br>Custom (add your SSL certificate by uploading the certificate in PEM format and your private key). 


### SSLCertificateCMData {#SSLCertificateCMData3}

Field | Description
--- | ---
id | **string**<br>ID of the custom certificate. 


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
id | **string**<br>ID of the resource. 
folder_id | **string**<br>Folder id. 
cname | **string**<br>CDN endpoint CNAME, must be unique among resources. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
active | **bool**<br>Flag to create Resource either in active or disabled state. True - the content from CDN is available to clients. False - the content from CDN isn't available to clients. 
options | **[ResourceOptions](#ResourceOptions4)**<br>Resource settings and options to tune CDN edge behavior. 
secondary_hostnames[] | **string**<br>List of secondary hostname strings. 
origin_group_id | **int64**<br>ID of the origin group. 
origin_group_name | **string**<br>Name of the origin group. 
origin_protocol | enum **OriginProtocol**<br>Specify the protocol schema to be used in communication with origin. <ul><li>`HTTP`: CDN servers will connect to your origin via HTTP.</li><li>`HTTPS`: CDN servers will connect to your origin via HTTPS.</li><li>`MATCH`: Connection protocol will be chosen automatically (content on the origin source should be available for the CDN both through HTTP and HTTPS).</li></ul>
ssl_certificate | **[SSLCertificate](#SSLCertificate3)**<br>SSL certificate options. 


### SSLCertificate {#SSLCertificate3}

Field | Description
--- | ---
type | enum **SSLCertificateType**<br>Type of the certificate. <ul><li>`SSL_CERTIFICATE_TYPE_UNSPECIFIED`: SSL certificate is unspecified.</li><li>`DONT_USE`: No SSL certificate is added, the requests are sent via HTTP.</li><li>`LETS_ENCRYPT_GCORE`: Works only if you have already pointed your domain name to the protected IP address in your DNS</li><li>`CM`: Add your SSL certificate by uploading the certificate in PEM format and your private key</li></ul>
status | enum **SSLCertificateStatus**<br>Active status. <ul><li>`SSL_CERTIFICATE_STATUS_UNSPECIFIED`: SSL certificate is unspecified.</li><li>`READY`: SSL certificate is ready to use.</li><li>`CREATING`: SSL certificate is creating.</li></ul>
data | **[SSLCertificateData](#SSLCertificateData4)**<br>Certificate data. 


## Delete {#Delete}

Deletes client's CDN resource.

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

Get Provider's CNAME (edge endpoint) bind to specified folder id. Returns UNIMPLEMENTED error, if provider doesn't support CNAME request.

**rpc GetProviderCName ([GetProviderCNameRequest](#GetProviderCNameRequest)) returns ([GetProviderCNameResponse](#GetProviderCNameResponse))**

### GetProviderCNameRequest {#GetProviderCNameRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID to get provider's CNAME. The maximum string length in characters is 50.


### GetProviderCNameResponse {#GetProviderCNameResponse}

Field | Description
--- | ---
cname | **string**<br>Provider's CNAME. 
folder_id | **string**<br>ID of the folder that the provider belongs to. 


