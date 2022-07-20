---
sourcePath: en/_cli-ref/cli-ref/managed-services/cdn/resource/create.md
---
# yc cdn resource create

Create resource

#### Command Usage

Syntax: 

`yc cdn resource create <СNAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cname`|<b>`string`</b><br/>CNAME|
|`--origin-group-id`|<b>`int`</b><br/>Origin group ID.<br/>Specify one of --origin-group-id, --origin-custom-source, --origin-bucket-source, --origin-balancer-source|
|`--origin-custom-source`|<b>`string`</b><br/>Origin custom source.<br/>Specify one of --origin-group-id, --origin-custom-source, --origin-bucket-source, --origin-balancer-source|
|`--origin-bucket-source`|<b>`string`</b><br/>Origin bucket source.<br/>Specify one of --origin-group-id, --origin-custom-source, --origin-bucket-source, --origin-balancer-source|
|`--origin-bucket-name`|<b>`string`</b><br/>Origin bucket name.<br/>Mandatory argument for --origin-bucket-source|
|`--origin-balancer-source`|<b>`string`</b><br/>Origin balancer source.<br/>Specify one of --origin-group-id, --origin-custom-source, --origin-bucket-source, --origin-balancer-source|
|`--origin-balancer-id`|<b>`string`</b><br/>Origin balancer id.<br/>Mandatory argument for --origin-balancer-source|
|`--secondary-hostnames`|<b>`value[,value]`</b><br/>List of secondary hostnames.|
|`--origin-protocol`|<b>`string`</b><br/>Origin protocol. Valid values: HTTP, HTTPS, MATCH. Values: 'http', 'https', 'match'|
|`--active`|Specifies if create resource in active state. True by default|
|`--dont-use-ssl-cert`|Don't use SSL certificate.<br/>Mutually exclusive with --lets-encrypt-gcore-ssl-cert, --cert-manager-ssl-cert-id|
|`--lets-encrypt-gcore-ssl-cert`|Use Lets Encrypt GCore certificate.<br/>Mutually exclusive with --dont-use-ssl-cert, --cert-manager-ssl-cert-id|
|`--cert-manager-ssl-cert-id`|<b>`string`</b><br/>Certificate Manager certificate id.<br/>Mutually exclusive with --dont-use-ssl-cert, --lets-encrypt-gcore-ssl-cert|
|`--disable-cache`|Disable cache|
|`--cache-expiration-time`|<b>`int`</b><br/>Caching time for a response with codes 200, 206, 301, 302 in seconds.<br/>Responses with codes 4xx, 5xx will not be cached.<br/>Use cache-expiration-time-custom to specify a custom caching time for a response with specific codes.<br/>Mutually exclusive with --cache-expiration-time-default|
|`--cache-expiration-time-custom`|<b>`key=value[,key=value...]`</b><br/>List of pairs code=caching_time.<br/>Caching time for a response with specific codes.<br/>These settings have a higher priority than the cache-expiration-time value.<br/>Response code ('304', '404' for example) to caching time in seconds ('0s', '600s' for example).|
|`--cache-expiration-time-default`|<b>`int`</b><br/>Content will be cached according to origin cache settings.<br/>The value (in seconds) applies for a response with codes 200, 201, 204, 206, 301, 302, 303, 304, 307, 308<br/>if an origin server does not have caching HTTP headers.<br/>Responses with other codes will not be cached.<br/>Mutually exclusive with --cache-expiration-time|
|`--browser-cache-expiration-time`|<b>`int`</b><br/>Cache expiration time for customers' browsers in seconds.|
|`--cache-http-headers`|<b>`value[,value]`</b><br/>List of HTTP Headers that must be included in the response.|
|`--ignore-query-string`|Files with different query strings will be cached as one object.<br/>Mutually exclusive with --query-params-whitelist and --query-params-blacklist|
|`--query-params-whitelist`|<b>`value[,value]`</b><br/>Files with these query strings will be cached as different objects.<br/>Mutually exclusive with --query-params-blacklist and --ignore-query-string|
|`--query-params-blacklist`|<b>`value[,value]`</b><br/>Files with these query strings will be cached as one object.<br/>Mutually exclusive with --query-params-whitelist and --ignore-query-string|
|`--slice`|Files larger than 10 MB will be requested and cached in parts (no larger than 10 MB each part).<br/>It reduces time to first byte. The origin must support HTTP Range requests.|
|`--fetch-compressed`|A CDN request and cache already compressed content.<br/>Your server should support compression.<br/>CDN servers won't ungzip your content even if a user's browser doesn't accept compression (nowadays almost all browsers support it).<br/>Mutually exclusive with --gzip-on and --brotli-compression.|
|`--gzip-on`|The option allows to compress content with gzip on the CDN`s end.<br/>CDN servers will request only uncompressed content from the origin.<br/>Mutually exclusive with --fetch-compressed and --brotli-compression.|
|`--brotli-compression`|<b>`value[,value]`</b><br/>The option allows to compress content with brotli on the CDN's end.<br/>Specify the content-type for each type of content you wish to have compressed.<br/>CDN servers will request only uncompressed content from the origin. Compression is performed on the Origin Shielding.<br/>If a pre-cache server doesn't active for a resource, compression does not occur even if the option is enabled.<br/>Mutually exclusive with --fetch-compressed and --gzip-on|
|`--redirect-http-to-https`|Redirects HTTP requests to HTTPS.<br/>Mutually exclusive with --redirect-https-to-http.|
|`--redirect-https-to-http`|Redirects HTTPS requests to HTTP.<br/>Mutually exclusive with --redirect-http-to-https.|
|`--host-header`|<b>`string`</b><br/>Specify the Host header that CDN servers use when request content from an origin server.<br/>Your server must be able to process requests with the chosen header.<br/>If the option is in NULL state Host Header value is taken from the CNAME field.<br/>Mutually exclusive with --forward-host-header.|
|`--forward-host-header`|When a CDN requests content from an origin server the option allows forwarding<br/>the Host header used in the request made to a CDN.<br/>Mutually exclusive with --host-header.|
|`--static-headers`|<b>`key=value[,key=value...]`</b><br/>Specify up to 50 custom HTTP Headers that a CDN server adds to response.<br/>You can add header with multiple values if these values are different.|
|`--cors`|<b>`value[,value]`</b><br/>The option adds the Access-Control-Allow-Origin header to responses from CDN servers. It has 3 parameters:<br/>1. Adds * as the Access-Control-Allow-Origin header value, "value": ["*"]<br/>2. Adds "$http_origin" as the Access-Control-Allow-Origin header value if the origin matches one of the listed domains<br/>"value": ["domain.com", "second.dom.com"]<br/>3. Adds "$http_origin" as the Access-Control-Allow-Origin header value, "value": ["$http_origin"]|
|`--stale`|<b>`value[,value]`</b><br/>The list of errors which the option is applied for. Possible values:<br/>'error', 'http_403', 'http_404', 'http_429', 'http_500', 'http_502', 'http_503', 'http_504', 'invalid_header', 'timeout', 'updating'|
|`--allowed-http-methods`|<b>`value[,value]`</b><br/>The list of allowed HTTP methods. Available methods:<br/>GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS.|
|`--proxy-cache-methods-set`|Allows caching for GET, HEAD and POST requests.|
|`--disable-proxy-force-ranges`|The option is enabled by default. It allows getting 206 responses regardless settings of an origin source.|
|`--static-request-headers`|<b>`key=value[,key=value...]`</b><br/>Specify up to 50 custom HTTP Headers for a CDN server to add to request.<br/>Header name ('Header-One', 'Header-Two' in the example) is restricted to 255 symbols and can contain<br/>latin letters (A-Z, a-z), numbers (0-9), dashes, and underscores.<br/>Header value ('Value 1', 'Value 2' in the example) is restricted to 512 symbols and can contain<br/>latin letters (a-z), numbers (0-9), spaces, underscores and symbols (-/.:). Space can be used only between words.|
|`--custom-server-name`|<b>`string`</b><br/>Wildcard additional CNAME. If a resource has a wildcard additional CNAME,<br/>you can use your own certificate for content delivery via HTTPS.|
|`--ignore-cookie`|By default, files pulled from an origin source with cookies are not cached in a CDN.<br/>Enable this option to cache such objects.|
|`--rewrite-flag`|<b>`string`</b><br/>Defines flag for the Rewrite option. Possible values:<br/>last — stops processing of the current set of ngx_http_rewrite_module directives and starts a search<br/>for a new location matching changed URI.<br/>break — stops processing of the current set of the Rewrite option.<br/>redirect — returns a temporary redirect with the 302 code; It is used when a replacement string<br/>does not start with "http://", "https://", or "$scheme".<br/>permanent — returns a permanent redirect with the 301 code.|
|`--rewrite-body`|<b>`string`</b><br/>The pattern for Rewrite. At least one group should be specified.<br/>For Example: /rewrite_from/(.*) /rewrite_to/$1|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
