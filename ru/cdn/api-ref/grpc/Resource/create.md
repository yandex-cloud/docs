---
editable: false
sourcePath: en/_api-ref-grpc/cdn/v1/api-ref/grpc/Resource/create.md
---

# Cloud CDN API, gRPC: ResourceService.Create

Creates a CDN resource in the specified folder.

Creation may take up to 15 minutes.

## gRPC request

**rpc Create ([CreateResourceRequest](#yandex.cloud.cdn.v1.CreateResourceRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateResourceRequest {#yandex.cloud.cdn.v1.CreateResourceRequest}

```json
{
  "folder_id": "string",
  "cname": "string",
  "origin": {
    // Includes only one of the fields `origin_group_id`, `origin_source`, `origin_source_params`
    "origin_group_id": "int64",
    "origin_source": "string",
    "origin_source_params": {
      "source": "string",
      "meta": {
        // Includes only one of the fields `common`, `bucket`, `website`, `balancer`
        "common": {
          "name": "string"
        },
        "bucket": {
          "name": "string"
        },
        "website": {
          "name": "string"
        },
        "balancer": {
          "id": "string"
        }
        // end of the list of possible fields
      }
    }
    // end of the list of possible fields
  },
  "secondary_hostnames": {
    "values": [
      "string"
    ]
  },
  "origin_protocol": "OriginProtocol",
  "active": "google.protobuf.BoolValue",
  "options": {
    "disable_cache": {
      "enabled": "bool",
      "value": "bool"
    },
    "edge_cache_settings": {
      "enabled": "bool",
      // Includes only one of the fields `value`, `default_value`
      "value": {
        "simple_value": "int64",
        "custom_values": "int64"
      },
      "default_value": "int64"
      // end of the list of possible fields
    },
    "browser_cache_settings": {
      "enabled": "bool",
      "value": "int64"
    },
    "cache_http_headers": {
      "enabled": "bool",
      "value": [
        "string"
      ]
    },
    "query_params_options": {
      // Includes only one of the fields `ignore_query_string`, `query_params_whitelist`, `query_params_blacklist`
      "ignore_query_string": {
        "enabled": "bool",
        "value": "bool"
      },
      "query_params_whitelist": {
        "enabled": "bool",
        "value": [
          "string"
        ]
      },
      "query_params_blacklist": {
        "enabled": "bool",
        "value": [
          "string"
        ]
      }
      // end of the list of possible fields
    },
    "slice": {
      "enabled": "bool",
      "value": "bool"
    },
    "compression_options": {
      // Includes only one of the fields `fetch_compressed`, `gzip_on`, `brotli_compression`
      "fetch_compressed": {
        "enabled": "bool",
        "value": "bool"
      },
      "gzip_on": {
        "enabled": "bool",
        "value": "bool"
      },
      "brotli_compression": {
        "enabled": "bool",
        "value": [
          "string"
        ]
      }
      // end of the list of possible fields
    },
    "redirect_options": {
      // Includes only one of the fields `redirect_http_to_https`, `redirect_https_to_http`
      "redirect_http_to_https": {
        "enabled": "bool",
        "value": "bool"
      },
      "redirect_https_to_http": {
        "enabled": "bool",
        "value": "bool"
      }
      // end of the list of possible fields
    },
    "host_options": {
      // Includes only one of the fields `host`, `forward_host_header`
      "host": {
        "enabled": "bool",
        "value": "string"
      },
      "forward_host_header": {
        "enabled": "bool",
        "value": "bool"
      }
      // end of the list of possible fields
    },
    "static_headers": {
      "enabled": "bool",
      "value": "string"
    },
    "cors": {
      "enabled": "bool",
      "value": [
        "string"
      ]
    },
    "stale": {
      "enabled": "bool",
      "value": [
        "string"
      ]
    },
    "allowed_http_methods": {
      "enabled": "bool",
      "value": [
        "string"
      ]
    },
    "proxy_cache_methods_set": {
      "enabled": "bool",
      "value": "bool"
    },
    "disable_proxy_force_ranges": {
      "enabled": "bool",
      "value": "bool"
    },
    "static_request_headers": {
      "enabled": "bool",
      "value": "string"
    },
    "custom_server_name": {
      "enabled": "bool",
      "value": "string"
    },
    "ignore_cookie": {
      "enabled": "bool",
      "value": "bool"
    },
    "rewrite": {
      "enabled": "bool",
      "body": "string",
      "flag": "RewriteFlag"
    },
    "secure_key": {
      "enabled": "bool",
      "key": "string",
      "type": "SecureKeyURLType"
    },
    "ip_address_acl": {
      "enabled": "bool",
      "policy_type": "PolicyType",
      "excepted_values": [
        "string"
      ]
    }
  },
  "ssl_certificate": {
    "type": "SSLCertificateType",
    "data": {
      // Includes only one of the fields `cm`
      "cm": {
        "id": "string"
      }
      // end of the list of possible fields
    }
  },
  "labels": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the to bind with new resource. ||
|| cname | **string**

Required field. CDN endpoint CNAME, must be unique among clients's resources. ||
|| origin | **[Origin](#yandex.cloud.cdn.v1.CreateResourceRequest.Origin)**

Required field. Specify the origins to be used for CDN resources requests. ||
|| secondary_hostnames | **[SecondaryHostnames](#yandex.cloud.cdn.v1.SecondaryHostnames)**

List of additional CNAMEs. ||
|| origin_protocol | enum **OriginProtocol**

Specify the protocol schema to be used in communication with origin.

- `ORIGIN_PROTOCOL_UNSPECIFIED`
- `HTTP`: CDN servers will connect to your origin via HTTP.
- `HTTPS`: CDN servers will connect to your origin via HTTPS.
- `MATCH`: Connection protocol will be chosen automatically (content on the
origin source should be available for the CDN both through HTTP and HTTPS). ||
|| active | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Flag to create Resource either in active or disabled state.
In active state Origins payload could be transmitted from CDN CNAME requests.
Default value: true ||
|| options | **[ResourceOptions](#yandex.cloud.cdn.v1.ResourceOptions)**

Resource settings and options to tune CDN edge behavior. Most is unset. ||
|| ssl_certificate | **[SSLTargetCertificate](#yandex.cloud.cdn.v1.SSLTargetCertificate)**

SSL Certificate options. ||
|| labels | **string**

Labels of the resource. ||
|#

## Origin {#yandex.cloud.cdn.v1.CreateResourceRequest.Origin}

#|
||Field | Description ||
|| origin_group_id | **int64**

ID of pre-created origin group.

Includes only one of the fields `origin_group_id`, `origin_source`, `origin_source_params`. ||
|| origin_source | **string**

Create new Origins group with single source, it's id will be
returned in result.

Includes only one of the fields `origin_group_id`, `origin_source`, `origin_source_params`. ||
|| origin_source_params | **[ResourceOriginParams](#yandex.cloud.cdn.v1.ResourceOriginParams)**

Set up resource origin parameters.

Includes only one of the fields `origin_group_id`, `origin_source`, `origin_source_params`. ||
|#

## ResourceOriginParams {#yandex.cloud.cdn.v1.ResourceOriginParams}

A set of resource origin parameters.

#|
||Field | Description ||
|| source | **string**

Source of the content. ||
|| meta | **[OriginMeta](#yandex.cloud.cdn.v1.OriginMeta)**

Set up type of the origin. ||
|#

## OriginMeta {#yandex.cloud.cdn.v1.OriginMeta}

Origin type. For details about the concept, see [documentation](/docs/cdn/concepts/origins).

#|
||Field | Description ||
|| common | **[OriginNamedMeta](#yandex.cloud.cdn.v1.OriginNamedMeta)**

A server with a domain name linked to it

Includes only one of the fields `common`, `bucket`, `website`, `balancer`.

Type of the origin. ||
|| bucket | **[OriginNamedMeta](#yandex.cloud.cdn.v1.OriginNamedMeta)**

An Object Storage bucket not configured as a static site hosting.

Includes only one of the fields `common`, `bucket`, `website`, `balancer`.

Type of the origin. ||
|| website | **[OriginNamedMeta](#yandex.cloud.cdn.v1.OriginNamedMeta)**

An Object Storage bucket configured as a static site hosting.

Includes only one of the fields `common`, `bucket`, `website`, `balancer`.

Type of the origin. ||
|| balancer | **[OriginBalancerMeta](#yandex.cloud.cdn.v1.OriginBalancerMeta)**

An L7 load balancer from Application Load Balancer.
CDN servers will access the load balancer at one of its IP addresses that must be selected in the origin settings.

Includes only one of the fields `common`, `bucket`, `website`, `balancer`.

Type of the origin. ||
|#

## OriginNamedMeta {#yandex.cloud.cdn.v1.OriginNamedMeta}

Origin info. For details about the concept, see [documentation](/docs/cdn/concepts/origins).

#|
||Field | Description ||
|| name | **string**

Name of the origin. ||
|#

## OriginBalancerMeta {#yandex.cloud.cdn.v1.OriginBalancerMeta}

Application Load Balancer origin info. For details about the concept, see [documentation](/docs/cdn/concepts/origins).

#|
||Field | Description ||
|| id | **string**

ID of the origin. ||
|#

## SecondaryHostnames {#yandex.cloud.cdn.v1.SecondaryHostnames}

List of secondary (alternative) CNAMEs.

#|
||Field | Description ||
|| values[] | **string**

List of secondary hostname values. ||
|#

## ResourceOptions {#yandex.cloud.cdn.v1.ResourceOptions}

A major set of various resource options.

#|
||Field | Description ||
|| disable_cache | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Set up a cache status. ||
|| edge_cache_settings | **[EdgeCacheSettings](#yandex.cloud.cdn.v1.ResourceOptions.EdgeCacheSettings)**

Set up [EdgeCacheSettings](#yandex.cloud.cdn.v1.ResourceOptions.EdgeCacheSettings). ||
|| browser_cache_settings | **[Int64Option](#yandex.cloud.cdn.v1.ResourceOptions.Int64Option)**

Using [Int64Option](#yandex.cloud.cdn.v1.ResourceOptions.Int64Option). Set up a cache period for the end-users browser.
Content will be cached due to origin settings.
If there are no cache settings on your origin, the content will not be cached.
The list of HTTP response codes that can be cached in browsers: 200, 201, 204, 206, 301, 302, 303, 304, 307, 308.
Other response codes will not be cached.
The default value is 4 days. ||
|| cache_http_headers | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption)**

List HTTP headers that must be included in responses to clients. ||
|| query_params_options | **[QueryParamsOptions](#yandex.cloud.cdn.v1.ResourceOptions.QueryParamsOptions)**

Set up [QueryParamsOptions](#yandex.cloud.cdn.v1.ResourceOptions.QueryParamsOptions). ||
|| slice | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Files larger than 10 MB will be requested and cached in parts (no larger than 10 MB each part). It reduces time to first byte.

The origin must support HTTP Range requests.

By default the option is disabled. ||
|| compression_options | **[CompressionOptions](#yandex.cloud.cdn.v1.ResourceOptions.CompressionOptions)**

Set up compression variant. ||
|| redirect_options | **[RedirectOptions](#yandex.cloud.cdn.v1.ResourceOptions.RedirectOptions)**

Set up redirects. ||
|| host_options | **[HostOptions](#yandex.cloud.cdn.v1.ResourceOptions.HostOptions)**

Set up host parameters. ||
|| static_headers | **[StringsMapOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsMapOption)**

Set up static headers that CDN servers send in responses to clients. ||
|| cors | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption)**

Parameter that lets browsers get access to selected resources from a domain
different to a domain from which the request is received.
[Read more](/docs/cdn/concepts/cors). ||
|| stale | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption)**

List of errors which instruct CDN servers to serve stale content to clients.

Possible values: `error`, `http_403`, `http_404`, `http_429`, `http_500`, `http_502`, `http_503`, `http_504`, `invalid_header`, `timeout`, `updating`. ||
|| allowed_http_methods | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption)**

HTTP methods for your CDN content. By default the following methods
are allowed: GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS.
In case some methods are not allowed to the user, they will get the 405
(Method Not Allowed) response. If the method is not supported,
the user gets the 501 (Not Implemented) response. ||
|| proxy_cache_methods_set | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Allows caching for GET, HEAD and POST requests. ||
|| disable_proxy_force_ranges | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Disabling proxy force ranges. ||
|| static_request_headers | **[StringsMapOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsMapOption)**

Set up custom headers that CDN servers send in requests to origins.
The Header name field can contain letters (A-Z, a-z), numbers (0-9), dashes (-) and underscores (_).
The Value field can contain letters (A-Z, a-z), numbers (0-9), dashes (-),
underscores (_), slashes (/), colons (:), equal (=), dots (.), and spaces. ||
|| custom_server_name | **[StringOption](#yandex.cloud.cdn.v1.ResourceOptions.StringOption)**

Wildcard additional CNAME.
If a resource has a wildcard additional CNAME, you can use your own certificate for content delivery via HTTPS. Read-only. ||
|| ignore_cookie | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption) for ignoring cookie. ||
|| rewrite | **[RewriteOption](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption)**

Changing or redirecting query paths. ||
|| secure_key | **[SecureKeyOption](#yandex.cloud.cdn.v1.ResourceOptions.SecureKeyOption)**

Secure token to protect contect and limit access by IP addresses and time limits. ||
|| ip_address_acl | **[IPAddressACLOption](#yandex.cloud.cdn.v1.ResourceOptions.IPAddressACLOption)**

Manage the state of the IP access policy option.
The option controls access to content from the specified IP addresses. ||
|#

## BoolOption {#yandex.cloud.cdn.v1.ResourceOptions.BoolOption}

Set up bool values.

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **bool**

Value of the option. ||
|#

## EdgeCacheSettings {#yandex.cloud.cdn.v1.ResourceOptions.EdgeCacheSettings}

A set of the edge cache parameters.

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its `values_variant` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **[CachingTimes](#yandex.cloud.cdn.v1.ResourceOptions.CachingTimes)**

Value of the option.

Includes only one of the fields `value`, `default_value`. ||
|| default_value | **int64**

Content will be cached according to origin cache settings.
The value applies for a response with codes 200, 201, 204, 206, 301, 302, 303, 304, 307, 308
if an origin server does not have caching HTTP headers.
Responses with other codes will not be cached.

Includes only one of the fields `value`, `default_value`. ||
|#

## CachingTimes {#yandex.cloud.cdn.v1.ResourceOptions.CachingTimes}

A set of the caching response time parameters.

#|
||Field | Description ||
|| simple_value | **int64**

Caching time for a response with codes 200, 206, 301, 302.
Responses with codes 4xx, 5xx will not be cached. Use `0s` disable to caching.
Use `custom_values` field to specify a custom caching time for a response with specific codes. ||
|| custom_values | **int64**

Caching time for a response with specific codes. These settings have a higher priority than the value field.
Response code (`304`, `404` for example). Use `any` to specify caching time for all response codes.
Caching time in seconds (`0s`, `600s` for example). Use `0s` to disable caching for a specific response code. ||
|#

## Int64Option {#yandex.cloud.cdn.v1.ResourceOptions.Int64Option}

A set of the numeric parameters.

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **int64**

Value of the option. ||
|#

## StringsListOption {#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption}

A set of the string list parameters.

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value[] | **string**

Value of the option. ||
|#

## QueryParamsOptions {#yandex.cloud.cdn.v1.ResourceOptions.QueryParamsOptions}

A set of the query parameters.

#|
||Field | Description ||
|| ignore_query_string | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption). Selected by default. Files with different query parameters are cached as objects with the same key regardless of the parameter value.

Includes only one of the fields `ignore_query_string`, `query_params_whitelist`, `query_params_blacklist`. ||
|| query_params_whitelist | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption)**

Ignore All Except.
Files with the specified query parameters are cached as objects with different keys,
files with other parameters are cached as objects with the same key.

Includes only one of the fields `ignore_query_string`, `query_params_whitelist`, `query_params_blacklist`. ||
|| query_params_blacklist | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption)**

Ignore only. Files with the specified query parameters are cached as objects with the same key,
files with other parameters are cached as objects with different keys.

Includes only one of the fields `ignore_query_string`, `query_params_whitelist`, `query_params_blacklist`. ||
|#

## CompressionOptions {#yandex.cloud.cdn.v1.ResourceOptions.CompressionOptions}

A set of the compression variant parameters.

#|
||Field | Description ||
|| fetch_compressed | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

The Fetch compressed option helps you to reduce
the bandwidth between origin and CDN servers.
Also, content delivery speed becomes higher because of reducing the time
for compressing files in a CDN.

Includes only one of the fields `fetch_compressed`, `gzip_on`, `brotli_compression`. ||
|| gzip_on | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption). GZip compression at CDN servers reduces file size by 70% and can be as high as 90%.

Includes only one of the fields `fetch_compressed`, `gzip_on`, `brotli_compression`. ||
|| brotli_compression | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption)**

The option allows to compress content with brotli on the CDN's end.

Compression is performed on the Origin Shielding. If a pre-cache server doesn't active for a resource, compression does not occur even if the option is enabled.

Specify the content-type for each type of content you wish to have compressed. CDN servers will request only uncompressed content from the origin.

Includes only one of the fields `fetch_compressed`, `gzip_on`, `brotli_compression`. ||
|#

## RedirectOptions {#yandex.cloud.cdn.v1.ResourceOptions.RedirectOptions}

A set of the redirect parameters.

#|
||Field | Description ||
|| redirect_http_to_https | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption). Set up a redirect from HTTPS to HTTP.

Includes only one of the fields `redirect_http_to_https`, `redirect_https_to_http`. ||
|| redirect_https_to_http | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption). Set up a redirect from HTTP to HTTPS.

Includes only one of the fields `redirect_http_to_https`, `redirect_https_to_http`. ||
|#

## HostOptions {#yandex.cloud.cdn.v1.ResourceOptions.HostOptions}

A set of the host parameters.

#|
||Field | Description ||
|| host | **[StringOption](#yandex.cloud.cdn.v1.ResourceOptions.StringOption)**

Custom value for the Host header.

Your server must be able to process requests with the chosen header.

Default value (if [StringOption.enabled](#yandex.cloud.cdn.v1.ResourceOptions.StringOption) is `false`) is [Resource.cname](#yandex.cloud.cdn.v1.Resource).

Includes only one of the fields `host`, `forward_host_header`. ||
|| forward_host_header | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption). Choose the Forward Host header option if is important to send in the request to the Origin
the same Host header as was sent in the request to CDN server.

Includes only one of the fields `host`, `forward_host_header`. ||
|#

## StringOption {#yandex.cloud.cdn.v1.ResourceOptions.StringOption}

A set of the string parameters.

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **string**

Value of the option. ||
|#

## StringsMapOption {#yandex.cloud.cdn.v1.ResourceOptions.StringsMapOption}

A set of the strings map parameters.

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **string**

Value of the option. ||
|#

## RewriteOption {#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption}

An option for changing or redirecting query paths.

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its `flag` is applied to the resource.
False - the option is disabled and its default value of the `flag` is used for the resource. ||
|| body | **string**

Pattern for rewrite.

The value must have the following format: `<source path> <destination path>`, where both paths are regular expressions which use at least one group. E.g., `/foo/(.*) /bar/$1`. ||
|| flag | enum **RewriteFlag**

Break flag is applied to the option by default.
It is not shown in the field.

- `REWRITE_FLAG_UNSPECIFIED`
- `LAST`: Stops processing of the current set of ngx_http_rewrite_module directives and
starts a search for a new location matching changed URI.
- `BREAK`: Stops processing of the current set of the Rewrite option.
- `REDIRECT`: Returns a temporary redirect with the 302 code; It is used when a replacement string does not start
with "http://", "https://", or "$scheme".
- `PERMANENT`: Returns a permanent redirect with the 301 code. ||
|#

## SecureKeyOption {#yandex.cloud.cdn.v1.ResourceOptions.SecureKeyOption}

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its [flag](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption) is applied to the resource.
False - the option is disabled and its default value of the [flag](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption) is used for the resource. ||
|| key | **string**

The key for the URL signing. ||
|| type | enum **SecureKeyURLType**

The type of the URL signing. The URL could be available for all IP addresses or for the only one IP.

- `SECURE_KEY_URL_TYPE_UNSPECIFIED`
- `ENABLE_IP_SIGNING`: Use scpecific IP address in URL signing. URL will be availible only for this IP.
- `DISABLE_IP_SIGNING`: Sign URL without using IP address. URL will be available for all IP addresses. ||
|#

## IPAddressACLOption {#yandex.cloud.cdn.v1.ResourceOptions.IPAddressACLOption}

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its [flag](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption) is applied to the resource.
False - the option is disabled and its default value of the [flag](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption) is used for the resource. ||
|| policy_type | enum **PolicyType**

The policy type. One of allow or deny value.

- `POLICY_TYPE_UNSPECIFIED`
- `POLICY_TYPE_ALLOW`: Allow access to all IP addresses except the ones specified in the excepted_values field.
- `POLICY_TYPE_DENY`: Block access to all IP addresses except the ones specified in the excepted_values field. ||
|| excepted_values[] | **string**

The list of IP addresses to be allowed or denied. ||
|#

## SSLTargetCertificate {#yandex.cloud.cdn.v1.SSLTargetCertificate}

A set of the personal SSL certificate parameters.

#|
||Field | Description ||
|| type | enum **SSLCertificateType**

Type of the certificate.

- `SSL_CERTIFICATE_TYPE_UNSPECIFIED`: SSL certificate is unspecified.
- `DONT_USE`: No SSL certificate is added, the requests are sent via HTTP.
- `LETS_ENCRYPT_GCORE`: The option is deprecated. Works only if you have already pointed your domain name to the protected IP address in your DNS.
- `CM`: Add your SSL certificate by uploading the certificate in PEM format and your private key. ||
|| data | **[SSLCertificateData](#yandex.cloud.cdn.v1.SSLCertificateData)**

Certificate data. ||
|#

## SSLCertificateData {#yandex.cloud.cdn.v1.SSLCertificateData}

A certificate data parameters.

#|
||Field | Description ||
|| cm | **[SSLCertificateCMData](#yandex.cloud.cdn.v1.SSLCertificateCMData)**

Custom (add your SSL certificate by uploading the certificate
in PEM format and your private key).

Includes only one of the fields `cm`. ||
|#

## SSLCertificateCMData {#yandex.cloud.cdn.v1.SSLCertificateCMData}

A certificate data custom parameters.

#|
||Field | Description ||
|| id | **string**

ID of the custom certificate. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "resource_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "cname": "string",
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp",
    "active": "bool",
    "options": {
      "disable_cache": {
        "enabled": "bool",
        "value": "bool"
      },
      "edge_cache_settings": {
        "enabled": "bool",
        // Includes only one of the fields `value`, `default_value`
        "value": {
          "simple_value": "int64",
          "custom_values": "int64"
        },
        "default_value": "int64"
        // end of the list of possible fields
      },
      "browser_cache_settings": {
        "enabled": "bool",
        "value": "int64"
      },
      "cache_http_headers": {
        "enabled": "bool",
        "value": [
          "string"
        ]
      },
      "query_params_options": {
        // Includes only one of the fields `ignore_query_string`, `query_params_whitelist`, `query_params_blacklist`
        "ignore_query_string": {
          "enabled": "bool",
          "value": "bool"
        },
        "query_params_whitelist": {
          "enabled": "bool",
          "value": [
            "string"
          ]
        },
        "query_params_blacklist": {
          "enabled": "bool",
          "value": [
            "string"
          ]
        }
        // end of the list of possible fields
      },
      "slice": {
        "enabled": "bool",
        "value": "bool"
      },
      "compression_options": {
        // Includes only one of the fields `fetch_compressed`, `gzip_on`, `brotli_compression`
        "fetch_compressed": {
          "enabled": "bool",
          "value": "bool"
        },
        "gzip_on": {
          "enabled": "bool",
          "value": "bool"
        },
        "brotli_compression": {
          "enabled": "bool",
          "value": [
            "string"
          ]
        }
        // end of the list of possible fields
      },
      "redirect_options": {
        // Includes only one of the fields `redirect_http_to_https`, `redirect_https_to_http`
        "redirect_http_to_https": {
          "enabled": "bool",
          "value": "bool"
        },
        "redirect_https_to_http": {
          "enabled": "bool",
          "value": "bool"
        }
        // end of the list of possible fields
      },
      "host_options": {
        // Includes only one of the fields `host`, `forward_host_header`
        "host": {
          "enabled": "bool",
          "value": "string"
        },
        "forward_host_header": {
          "enabled": "bool",
          "value": "bool"
        }
        // end of the list of possible fields
      },
      "static_headers": {
        "enabled": "bool",
        "value": "string"
      },
      "cors": {
        "enabled": "bool",
        "value": [
          "string"
        ]
      },
      "stale": {
        "enabled": "bool",
        "value": [
          "string"
        ]
      },
      "allowed_http_methods": {
        "enabled": "bool",
        "value": [
          "string"
        ]
      },
      "proxy_cache_methods_set": {
        "enabled": "bool",
        "value": "bool"
      },
      "disable_proxy_force_ranges": {
        "enabled": "bool",
        "value": "bool"
      },
      "static_request_headers": {
        "enabled": "bool",
        "value": "string"
      },
      "custom_server_name": {
        "enabled": "bool",
        "value": "string"
      },
      "ignore_cookie": {
        "enabled": "bool",
        "value": "bool"
      },
      "rewrite": {
        "enabled": "bool",
        "body": "string",
        "flag": "RewriteFlag"
      },
      "secure_key": {
        "enabled": "bool",
        "key": "string",
        "type": "SecureKeyURLType"
      },
      "ip_address_acl": {
        "enabled": "bool",
        "policy_type": "PolicyType",
        "excepted_values": [
          "string"
        ]
      }
    },
    "secondary_hostnames": [
      "string"
    ],
    "origin_group_id": "int64",
    "origin_group_name": "string",
    "origin_protocol": "OriginProtocol",
    "ssl_certificate": {
      "type": "SSLCertificateType",
      "status": "SSLCertificateStatus",
      "data": {
        // Includes only one of the fields `cm`
        "cm": {
          "id": "string"
        }
        // end of the list of possible fields
      }
    },
    "labels": "string"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateResourceMetadata](#yandex.cloud.cdn.v1.CreateResourceMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Resource](#yandex.cloud.cdn.v1.Resource)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateResourceMetadata {#yandex.cloud.cdn.v1.CreateResourceMetadata}

#|
||Field | Description ||
|| resource_id | **string**

Required field. ID of created resource. ||
|#

## Resource {#yandex.cloud.cdn.v1.Resource}

A CDN resource - representation of providers resource.

#|
||Field | Description ||
|| id | **string**

ID of the resource. ||
|| folder_id | **string**

Folder id. ||
|| cname | **string**

CDN endpoint CNAME, must be unique among resources. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Update timestamp. ||
|| active | **bool**

Flag to create Resource either in active or disabled state.
True - the content from CDN is available to clients.
False - the content from CDN isn't available to clients. ||
|| options | **[ResourceOptions](#yandex.cloud.cdn.v1.ResourceOptions2)**

Resource settings and options to tune CDN edge behavior. ||
|| secondary_hostnames[] | **string**

List of secondary hostname strings. ||
|| origin_group_id | **int64**

ID of the origin group. ||
|| origin_group_name | **string**

Name of the origin group. ||
|| origin_protocol | enum **OriginProtocol**

Specify the protocol schema to be used in communication with origin.

- `ORIGIN_PROTOCOL_UNSPECIFIED`
- `HTTP`: CDN servers will connect to your origin via HTTP.
- `HTTPS`: CDN servers will connect to your origin via HTTPS.
- `MATCH`: Connection protocol will be chosen automatically (content on the
origin source should be available for the CDN both through HTTP and HTTPS). ||
|| ssl_certificate | **[SSLCertificate](#yandex.cloud.cdn.v1.SSLCertificate)**

SSL certificate options. ||
|| labels | **string**

Labels of the resource. ||
|#

## ResourceOptions {#yandex.cloud.cdn.v1.ResourceOptions2}

A major set of various resource options.

#|
||Field | Description ||
|| disable_cache | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Set up a cache status. ||
|| edge_cache_settings | **[EdgeCacheSettings](#yandex.cloud.cdn.v1.ResourceOptions.EdgeCacheSettings2)**

Set up [EdgeCacheSettings](#yandex.cloud.cdn.v1.ResourceOptions.EdgeCacheSettings2). ||
|| browser_cache_settings | **[Int64Option](#yandex.cloud.cdn.v1.ResourceOptions.Int64Option2)**

Using [Int64Option](#yandex.cloud.cdn.v1.ResourceOptions.Int64Option2). Set up a cache period for the end-users browser.
Content will be cached due to origin settings.
If there are no cache settings on your origin, the content will not be cached.
The list of HTTP response codes that can be cached in browsers: 200, 201, 204, 206, 301, 302, 303, 304, 307, 308.
Other response codes will not be cached.
The default value is 4 days. ||
|| cache_http_headers | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption2)**

List HTTP headers that must be included in responses to clients. ||
|| query_params_options | **[QueryParamsOptions](#yandex.cloud.cdn.v1.ResourceOptions.QueryParamsOptions2)**

Set up [QueryParamsOptions](#yandex.cloud.cdn.v1.ResourceOptions.QueryParamsOptions2). ||
|| slice | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Files larger than 10 MB will be requested and cached in parts (no larger than 10 MB each part). It reduces time to first byte.

The origin must support HTTP Range requests.

By default the option is disabled. ||
|| compression_options | **[CompressionOptions](#yandex.cloud.cdn.v1.ResourceOptions.CompressionOptions2)**

Set up compression variant. ||
|| redirect_options | **[RedirectOptions](#yandex.cloud.cdn.v1.ResourceOptions.RedirectOptions2)**

Set up redirects. ||
|| host_options | **[HostOptions](#yandex.cloud.cdn.v1.ResourceOptions.HostOptions2)**

Set up host parameters. ||
|| static_headers | **[StringsMapOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsMapOption2)**

Set up static headers that CDN servers send in responses to clients. ||
|| cors | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption2)**

Parameter that lets browsers get access to selected resources from a domain
different to a domain from which the request is received.
[Read more](/docs/cdn/concepts/cors). ||
|| stale | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption2)**

List of errors which instruct CDN servers to serve stale content to clients.

Possible values: `error`, `http_403`, `http_404`, `http_429`, `http_500`, `http_502`, `http_503`, `http_504`, `invalid_header`, `timeout`, `updating`. ||
|| allowed_http_methods | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption2)**

HTTP methods for your CDN content. By default the following methods
are allowed: GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS.
In case some methods are not allowed to the user, they will get the 405
(Method Not Allowed) response. If the method is not supported,
the user gets the 501 (Not Implemented) response. ||
|| proxy_cache_methods_set | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Allows caching for GET, HEAD and POST requests. ||
|| disable_proxy_force_ranges | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Disabling proxy force ranges. ||
|| static_request_headers | **[StringsMapOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsMapOption2)**

Set up custom headers that CDN servers send in requests to origins.
The Header name field can contain letters (A-Z, a-z), numbers (0-9), dashes (-) and underscores (_).
The Value field can contain letters (A-Z, a-z), numbers (0-9), dashes (-),
underscores (_), slashes (/), colons (:), equal (=), dots (.), and spaces. ||
|| custom_server_name | **[StringOption](#yandex.cloud.cdn.v1.ResourceOptions.StringOption2)**

Wildcard additional CNAME.
If a resource has a wildcard additional CNAME, you can use your own certificate for content delivery via HTTPS. Read-only. ||
|| ignore_cookie | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2) for ignoring cookie. ||
|| rewrite | **[RewriteOption](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption2)**

Changing or redirecting query paths. ||
|| secure_key | **[SecureKeyOption](#yandex.cloud.cdn.v1.ResourceOptions.SecureKeyOption2)**

Secure token to protect contect and limit access by IP addresses and time limits. ||
|| ip_address_acl | **[IPAddressACLOption](#yandex.cloud.cdn.v1.ResourceOptions.IPAddressACLOption2)**

Manage the state of the IP access policy option.
The option controls access to content from the specified IP addresses. ||
|#

## BoolOption {#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2}

Set up bool values.

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **bool**

Value of the option. ||
|#

## EdgeCacheSettings {#yandex.cloud.cdn.v1.ResourceOptions.EdgeCacheSettings2}

A set of the edge cache parameters.

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its `values_variant` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **[CachingTimes](#yandex.cloud.cdn.v1.ResourceOptions.CachingTimes2)**

Value of the option.

Includes only one of the fields `value`, `default_value`. ||
|| default_value | **int64**

Content will be cached according to origin cache settings.
The value applies for a response with codes 200, 201, 204, 206, 301, 302, 303, 304, 307, 308
if an origin server does not have caching HTTP headers.
Responses with other codes will not be cached.

Includes only one of the fields `value`, `default_value`. ||
|#

## CachingTimes {#yandex.cloud.cdn.v1.ResourceOptions.CachingTimes2}

A set of the caching response time parameters.

#|
||Field | Description ||
|| simple_value | **int64**

Caching time for a response with codes 200, 206, 301, 302.
Responses with codes 4xx, 5xx will not be cached. Use `0s` disable to caching.
Use `custom_values` field to specify a custom caching time for a response with specific codes. ||
|| custom_values | **int64**

Caching time for a response with specific codes. These settings have a higher priority than the value field.
Response code (`304`, `404` for example). Use `any` to specify caching time for all response codes.
Caching time in seconds (`0s`, `600s` for example). Use `0s` to disable caching for a specific response code. ||
|#

## Int64Option {#yandex.cloud.cdn.v1.ResourceOptions.Int64Option2}

A set of the numeric parameters.

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **int64**

Value of the option. ||
|#

## StringsListOption {#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption2}

A set of the string list parameters.

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value[] | **string**

Value of the option. ||
|#

## QueryParamsOptions {#yandex.cloud.cdn.v1.ResourceOptions.QueryParamsOptions2}

A set of the query parameters.

#|
||Field | Description ||
|| ignore_query_string | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2). Selected by default. Files with different query parameters are cached as objects with the same key regardless of the parameter value.

Includes only one of the fields `ignore_query_string`, `query_params_whitelist`, `query_params_blacklist`. ||
|| query_params_whitelist | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption2)**

Ignore All Except.
Files with the specified query parameters are cached as objects with different keys,
files with other parameters are cached as objects with the same key.

Includes only one of the fields `ignore_query_string`, `query_params_whitelist`, `query_params_blacklist`. ||
|| query_params_blacklist | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption2)**

Ignore only. Files with the specified query parameters are cached as objects with the same key,
files with other parameters are cached as objects with different keys.

Includes only one of the fields `ignore_query_string`, `query_params_whitelist`, `query_params_blacklist`. ||
|#

## CompressionOptions {#yandex.cloud.cdn.v1.ResourceOptions.CompressionOptions2}

A set of the compression variant parameters.

#|
||Field | Description ||
|| fetch_compressed | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

The Fetch compressed option helps you to reduce
the bandwidth between origin and CDN servers.
Also, content delivery speed becomes higher because of reducing the time
for compressing files in a CDN.

Includes only one of the fields `fetch_compressed`, `gzip_on`, `brotli_compression`. ||
|| gzip_on | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2). GZip compression at CDN servers reduces file size by 70% and can be as high as 90%.

Includes only one of the fields `fetch_compressed`, `gzip_on`, `brotli_compression`. ||
|| brotli_compression | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption2)**

The option allows to compress content with brotli on the CDN's end.

Compression is performed on the Origin Shielding. If a pre-cache server doesn't active for a resource, compression does not occur even if the option is enabled.

Specify the content-type for each type of content you wish to have compressed. CDN servers will request only uncompressed content from the origin.

Includes only one of the fields `fetch_compressed`, `gzip_on`, `brotli_compression`. ||
|#

## RedirectOptions {#yandex.cloud.cdn.v1.ResourceOptions.RedirectOptions2}

A set of the redirect parameters.

#|
||Field | Description ||
|| redirect_http_to_https | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2). Set up a redirect from HTTPS to HTTP.

Includes only one of the fields `redirect_http_to_https`, `redirect_https_to_http`. ||
|| redirect_https_to_http | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2). Set up a redirect from HTTP to HTTPS.

Includes only one of the fields `redirect_http_to_https`, `redirect_https_to_http`. ||
|#

## HostOptions {#yandex.cloud.cdn.v1.ResourceOptions.HostOptions2}

A set of the host parameters.

#|
||Field | Description ||
|| host | **[StringOption](#yandex.cloud.cdn.v1.ResourceOptions.StringOption2)**

Custom value for the Host header.

Your server must be able to process requests with the chosen header.

Default value (if [StringOption.enabled](#yandex.cloud.cdn.v1.ResourceOptions.StringOption2) is `false`) is [Resource.cname](#yandex.cloud.cdn.v1.Resource).

Includes only one of the fields `host`, `forward_host_header`. ||
|| forward_host_header | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2). Choose the Forward Host header option if is important to send in the request to the Origin
the same Host header as was sent in the request to CDN server.

Includes only one of the fields `host`, `forward_host_header`. ||
|#

## StringOption {#yandex.cloud.cdn.v1.ResourceOptions.StringOption2}

A set of the string parameters.

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **string**

Value of the option. ||
|#

## StringsMapOption {#yandex.cloud.cdn.v1.ResourceOptions.StringsMapOption2}

A set of the strings map parameters.

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **string**

Value of the option. ||
|#

## RewriteOption {#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption2}

An option for changing or redirecting query paths.

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its `flag` is applied to the resource.
False - the option is disabled and its default value of the `flag` is used for the resource. ||
|| body | **string**

Pattern for rewrite.

The value must have the following format: `<source path> <destination path>`, where both paths are regular expressions which use at least one group. E.g., `/foo/(.*) /bar/$1`. ||
|| flag | enum **RewriteFlag**

Break flag is applied to the option by default.
It is not shown in the field.

- `REWRITE_FLAG_UNSPECIFIED`
- `LAST`: Stops processing of the current set of ngx_http_rewrite_module directives and
starts a search for a new location matching changed URI.
- `BREAK`: Stops processing of the current set of the Rewrite option.
- `REDIRECT`: Returns a temporary redirect with the 302 code; It is used when a replacement string does not start
with "http://", "https://", or "$scheme".
- `PERMANENT`: Returns a permanent redirect with the 301 code. ||
|#

## SecureKeyOption {#yandex.cloud.cdn.v1.ResourceOptions.SecureKeyOption2}

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its [flag](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption2) is applied to the resource.
False - the option is disabled and its default value of the [flag](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption2) is used for the resource. ||
|| key | **string**

The key for the URL signing. ||
|| type | enum **SecureKeyURLType**

The type of the URL signing. The URL could be available for all IP addresses or for the only one IP.

- `SECURE_KEY_URL_TYPE_UNSPECIFIED`
- `ENABLE_IP_SIGNING`: Use scpecific IP address in URL signing. URL will be availible only for this IP.
- `DISABLE_IP_SIGNING`: Sign URL without using IP address. URL will be available for all IP addresses. ||
|#

## IPAddressACLOption {#yandex.cloud.cdn.v1.ResourceOptions.IPAddressACLOption2}

#|
||Field | Description ||
|| enabled | **bool**

True - the option is enabled and its [flag](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption2) is applied to the resource.
False - the option is disabled and its default value of the [flag](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption2) is used for the resource. ||
|| policy_type | enum **PolicyType**

The policy type. One of allow or deny value.

- `POLICY_TYPE_UNSPECIFIED`
- `POLICY_TYPE_ALLOW`: Allow access to all IP addresses except the ones specified in the excepted_values field.
- `POLICY_TYPE_DENY`: Block access to all IP addresses except the ones specified in the excepted_values field. ||
|| excepted_values[] | **string**

The list of IP addresses to be allowed or denied. ||
|#

## SSLCertificate {#yandex.cloud.cdn.v1.SSLCertificate}

A SSL certificate parameters.

#|
||Field | Description ||
|| type | enum **SSLCertificateType**

Type of the certificate.

- `SSL_CERTIFICATE_TYPE_UNSPECIFIED`: SSL certificate is unspecified.
- `DONT_USE`: No SSL certificate is added, the requests are sent via HTTP.
- `LETS_ENCRYPT_GCORE`: The option is deprecated. Works only if you have already pointed your domain name to the protected IP address in your DNS.
- `CM`: Add your SSL certificate by uploading the certificate in PEM format and your private key. ||
|| status | enum **SSLCertificateStatus**

Active status.

- `SSL_CERTIFICATE_STATUS_UNSPECIFIED`: SSL certificate is unspecified.
- `READY`: SSL certificate is ready to use.
- `CREATING`: The option is deprecated. SSL certificate is creating. ||
|| data | **[SSLCertificateData](#yandex.cloud.cdn.v1.SSLCertificateData2)**

Certificate data. ||
|#

## SSLCertificateData {#yandex.cloud.cdn.v1.SSLCertificateData2}

A certificate data parameters.

#|
||Field | Description ||
|| cm | **[SSLCertificateCMData](#yandex.cloud.cdn.v1.SSLCertificateCMData2)**

Custom (add your SSL certificate by uploading the certificate
in PEM format and your private key).

Includes only one of the fields `cm`. ||
|#

## SSLCertificateCMData {#yandex.cloud.cdn.v1.SSLCertificateCMData2}

A certificate data custom parameters.

#|
||Field | Description ||
|| id | **string**

ID of the custom certificate. ||
|#