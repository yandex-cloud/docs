---
editable: false
sourcePath: en/_api-ref/cdn/v1/api-ref/ResourceRules/update.md
---

# Cloud CDN API, REST: ResourceRules.Update

Update specified by id resource rule.

## HTTP request

```
PATCH https://cdn.{{ api-host }}/cdn/v1/rules/{ruleId}
```

## Path parameters

#|
||Field | Description ||
|| ruleId | **string** (int64)

Required field. ID of updated resource rule. ||
|#

## Body parameters {#yandex.cloud.cdn.v1.UpdateResourceRuleRequest}

```json
{
  "resourceId": "string",
  "name": "string",
  "rulePattern": "string",
  "options": {
    "disableCache": {
      "enabled": "boolean",
      "value": "boolean"
    },
    "edgeCacheSettings": {
      "enabled": "boolean",
      // Includes only one of the fields `value`, `defaultValue`
      "value": {
        "simpleValue": "string",
        "customValues": "object"
      },
      "defaultValue": "string"
      // end of the list of possible fields
    },
    "browserCacheSettings": {
      "enabled": "boolean",
      "value": "string"
    },
    "cacheHttpHeaders": {
      "enabled": "boolean",
      "value": [
        "string"
      ]
    },
    "queryParamsOptions": {
      // Includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`
      "ignoreQueryString": {
        "enabled": "boolean",
        "value": "boolean"
      },
      "queryParamsWhitelist": {
        "enabled": "boolean",
        "value": [
          "string"
        ]
      },
      "queryParamsBlacklist": {
        "enabled": "boolean",
        "value": [
          "string"
        ]
      }
      // end of the list of possible fields
    },
    "slice": {
      "enabled": "boolean",
      "value": "boolean"
    },
    "compressionOptions": {
      // Includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`
      "fetchCompressed": {
        "enabled": "boolean",
        "value": "boolean"
      },
      "gzipOn": {
        "enabled": "boolean",
        "value": "boolean"
      },
      "brotliCompression": {
        "enabled": "boolean",
        "value": [
          "string"
        ]
      }
      // end of the list of possible fields
    },
    "redirectOptions": {
      // Includes only one of the fields `redirectHttpToHttps`, `redirectHttpsToHttp`
      "redirectHttpToHttps": {
        "enabled": "boolean",
        "value": "boolean"
      },
      "redirectHttpsToHttp": {
        "enabled": "boolean",
        "value": "boolean"
      }
      // end of the list of possible fields
    },
    "hostOptions": {
      // Includes only one of the fields `host`, `forwardHostHeader`
      "host": {
        "enabled": "boolean",
        "value": "string"
      },
      "forwardHostHeader": {
        "enabled": "boolean",
        "value": "boolean"
      }
      // end of the list of possible fields
    },
    "staticHeaders": {
      "enabled": "boolean",
      "value": "object"
    },
    "cors": {
      "enabled": "boolean",
      "value": [
        "string"
      ]
    },
    "stale": {
      "enabled": "boolean",
      "value": [
        "string"
      ]
    },
    "allowedHttpMethods": {
      "enabled": "boolean",
      "value": [
        "string"
      ]
    },
    "proxyCacheMethodsSet": {
      "enabled": "boolean",
      "value": "boolean"
    },
    "disableProxyForceRanges": {
      "enabled": "boolean",
      "value": "boolean"
    },
    "staticRequestHeaders": {
      "enabled": "boolean",
      "value": "object"
    },
    "customServerName": {
      "enabled": "boolean",
      "value": "string"
    },
    "ignoreCookie": {
      "enabled": "boolean",
      "value": "boolean"
    },
    "rewrite": {
      "enabled": "boolean",
      "body": "string",
      "flag": "string"
    },
    "secureKey": {
      "enabled": "boolean",
      "key": "string",
      "type": "string"
    },
    "ipAddressAcl": {
      "enabled": "boolean",
      "policyType": "string",
      "exceptedValues": [
        "string"
      ]
    }
  }
}
```

#|
||Field | Description ||
|| resourceId | **string**

Required field. ID of resource. ||
|| name | **string**

Name of updated resource rule. ||
|| rulePattern | **string**

Resource rule pattern. ||
|| options | **[ResourceOptions](#yandex.cloud.cdn.v1.ResourceOptions)** ||
|#

## ResourceOptions {#yandex.cloud.cdn.v1.ResourceOptions}

A major set of various resource options.

#|
||Field | Description ||
|| disableCache | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Set up a cache status. ||
|| edgeCacheSettings | **[EdgeCacheSettings](#yandex.cloud.cdn.v1.ResourceOptions.EdgeCacheSettings)**

Set up [EdgeCacheSettings](#yandex.cloud.cdn.v1.ResourceOptions.EdgeCacheSettings). ||
|| browserCacheSettings | **[Int64Option](#yandex.cloud.cdn.v1.ResourceOptions.Int64Option)**

Using [Int64Option](#yandex.cloud.cdn.v1.ResourceOptions.Int64Option). Set up a cache period for the end-users browser.
Content will be cached due to origin settings.
If there are no cache settings on your origin, the content will not be cached.
The list of HTTP response codes that can be cached in browsers: 200, 201, 204, 206, 301, 302, 303, 304, 307, 308.
Other response codes will not be cached.
The default value is 4 days. ||
|| cacheHttpHeaders | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption)**

List HTTP headers that must be included in responses to clients. ||
|| queryParamsOptions | **[QueryParamsOptions](#yandex.cloud.cdn.v1.ResourceOptions.QueryParamsOptions)**

Set up [QueryParamsOptions](#yandex.cloud.cdn.v1.ResourceOptions.QueryParamsOptions). ||
|| slice | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Files larger than 10 MB will be requested and cached in parts (no larger than 10 MB each part). It reduces time to first byte.

The origin must support HTTP Range requests.

By default the option is disabled. ||
|| compressionOptions | **[CompressionOptions](#yandex.cloud.cdn.v1.ResourceOptions.CompressionOptions)**

Set up compression variant. ||
|| redirectOptions | **[RedirectOptions](#yandex.cloud.cdn.v1.ResourceOptions.RedirectOptions)**

Set up redirects. ||
|| hostOptions | **[HostOptions](#yandex.cloud.cdn.v1.ResourceOptions.HostOptions)**

Set up host parameters. ||
|| staticHeaders | **[StringsMapOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsMapOption)**

Set up static headers that CDN servers send in responses to clients. ||
|| cors | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption)**

Parameter that lets browsers get access to selected resources from a domain
different to a domain from which the request is received.
[Read more](/docs/cdn/concepts/cors). ||
|| stale | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption)**

List of errors which instruct CDN servers to serve stale content to clients.

Possible values: `error`, `http_403`, `http_404`, `http_429`, `http_500`, `http_502`, `http_503`, `http_504`, `invalid_header`, `timeout`, `updating`. ||
|| allowedHttpMethods | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption)**

HTTP methods for your CDN content. By default the following methods
are allowed: GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS.
In case some methods are not allowed to the user, they will get the 405
(Method Not Allowed) response. If the method is not supported,
the user gets the 501 (Not Implemented) response. ||
|| proxyCacheMethodsSet | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Allows caching for GET, HEAD and POST requests. ||
|| disableProxyForceRanges | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Disabling proxy force ranges. ||
|| staticRequestHeaders | **[StringsMapOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsMapOption)**

Set up custom headers that CDN servers send in requests to origins.
The Header name field can contain letters (A-Z, a-z), numbers (0-9), dashes (-) and underscores (_).
The Value field can contain letters (A-Z, a-z), numbers (0-9), dashes (-),
underscores (_), slashes (/), colons (:), equal (=), dots (.), and spaces. ||
|| customServerName | **[StringOption](#yandex.cloud.cdn.v1.ResourceOptions.StringOption)**

Wildcard additional CNAME.
If a resource has a wildcard additional CNAME, you can use your own certificate for content delivery via HTTPS. Read-only. ||
|| ignoreCookie | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption) for ignoring cookie. ||
|| rewrite | **[RewriteOption](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption)**

Changing or redirecting query paths. ||
|| secureKey | **[SecureKeyOption](#yandex.cloud.cdn.v1.ResourceOptions.SecureKeyOption)**

Secure token to protect contect and limit access by IP addresses and time limits. ||
|| ipAddressAcl | **[IPAddressACLOption](#yandex.cloud.cdn.v1.ResourceOptions.IPAddressACLOption)**

Manage the state of the IP access policy option.
The option controls access to content from the specified IP addresses. ||
|#

## BoolOption {#yandex.cloud.cdn.v1.ResourceOptions.BoolOption}

Set up bool values.

#|
||Field | Description ||
|| enabled | **boolean**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **boolean**

Value of the option. ||
|#

## EdgeCacheSettings {#yandex.cloud.cdn.v1.ResourceOptions.EdgeCacheSettings}

A set of the edge cache parameters.

#|
||Field | Description ||
|| enabled | **boolean**

True - the option is enabled and its `values_variant` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **[CachingTimes](#yandex.cloud.cdn.v1.ResourceOptions.CachingTimes)**

Value of the option.

Includes only one of the fields `value`, `defaultValue`. ||
|| defaultValue | **string** (int64)

Content will be cached according to origin cache settings.
The value applies for a response with codes 200, 201, 204, 206, 301, 302, 303, 304, 307, 308
if an origin server does not have caching HTTP headers.
Responses with other codes will not be cached.

Includes only one of the fields `value`, `defaultValue`. ||
|#

## CachingTimes {#yandex.cloud.cdn.v1.ResourceOptions.CachingTimes}

A set of the caching response time parameters.

#|
||Field | Description ||
|| simpleValue | **string** (int64)

Caching time for a response with codes 200, 206, 301, 302.
Responses with codes 4xx, 5xx will not be cached. Use `0s` disable to caching.
Use `customValues` field to specify a custom caching time for a response with specific codes. ||
|| customValues | **object** (map<**string**, **string** (int64)>)

Caching time for a response with specific codes. These settings have a higher priority than the value field.
Response code (`304`, `404` for example). Use `any` to specify caching time for all response codes.
Caching time in seconds (`0s`, `600s` for example). Use `0s` to disable caching for a specific response code. ||
|#

## Int64Option {#yandex.cloud.cdn.v1.ResourceOptions.Int64Option}

A set of the numeric parameters.

#|
||Field | Description ||
|| enabled | **boolean**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **string** (int64)

Value of the option. ||
|#

## StringsListOption {#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption}

A set of the string list parameters.

#|
||Field | Description ||
|| enabled | **boolean**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value[] | **string**

Value of the option. ||
|#

## QueryParamsOptions {#yandex.cloud.cdn.v1.ResourceOptions.QueryParamsOptions}

A set of the query parameters.

#|
||Field | Description ||
|| ignoreQueryString | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption). Selected by default. Files with different query parameters are cached as objects with the same key regardless of the parameter value.

Includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`. ||
|| queryParamsWhitelist | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption)**

Ignore All Except.
Files with the specified query parameters are cached as objects with different keys,
files with other parameters are cached as objects with the same key.

Includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`. ||
|| queryParamsBlacklist | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption)**

Ignore only. Files with the specified query parameters are cached as objects with the same key,
files with other parameters are cached as objects with different keys.

Includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`. ||
|#

## CompressionOptions {#yandex.cloud.cdn.v1.ResourceOptions.CompressionOptions}

A set of the compression variant parameters.

#|
||Field | Description ||
|| fetchCompressed | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

The Fetch compressed option helps you to reduce
the bandwidth between origin and CDN servers.
Also, content delivery speed becomes higher because of reducing the time
for compressing files in a CDN.

Includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`. ||
|| gzipOn | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption). GZip compression at CDN servers reduces file size by 70% and can be as high as 90%.

Includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`. ||
|| brotliCompression | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption)**

The option allows to compress content with brotli on the CDN's end.

Compression is performed on the Origin Shielding. If a pre-cache server doesn't active for a resource, compression does not occur even if the option is enabled.

Specify the content-type for each type of content you wish to have compressed. CDN servers will request only uncompressed content from the origin.

Includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`. ||
|#

## RedirectOptions {#yandex.cloud.cdn.v1.ResourceOptions.RedirectOptions}

A set of the redirect parameters.

#|
||Field | Description ||
|| redirectHttpToHttps | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption). Set up a redirect from HTTPS to HTTP.

Includes only one of the fields `redirectHttpToHttps`, `redirectHttpsToHttp`. ||
|| redirectHttpsToHttp | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption). Set up a redirect from HTTP to HTTPS.

Includes only one of the fields `redirectHttpToHttps`, `redirectHttpsToHttp`. ||
|#

## HostOptions {#yandex.cloud.cdn.v1.ResourceOptions.HostOptions}

A set of the host parameters.

#|
||Field | Description ||
|| host | **[StringOption](#yandex.cloud.cdn.v1.ResourceOptions.StringOption)**

Custom value for the Host header.

Your server must be able to process requests with the chosen header.

Default value (if [StringOption.enabled](#yandex.cloud.cdn.v1.ResourceOptions.StringOption) is `false`) is [Resource.cname](/docs/cdn/api-ref/Resource/get#yandex.cloud.cdn.v1.Resource).

Includes only one of the fields `host`, `forwardHostHeader`. ||
|| forwardHostHeader | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption). Choose the Forward Host header option if is important to send in the request to the Origin
the same Host header as was sent in the request to CDN server.

Includes only one of the fields `host`, `forwardHostHeader`. ||
|#

## StringOption {#yandex.cloud.cdn.v1.ResourceOptions.StringOption}

A set of the string parameters.

#|
||Field | Description ||
|| enabled | **boolean**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **string**

Value of the option. ||
|#

## StringsMapOption {#yandex.cloud.cdn.v1.ResourceOptions.StringsMapOption}

A set of the strings map parameters.

#|
||Field | Description ||
|| enabled | **boolean**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **object** (map<**string**, **string**>)

Value of the option. ||
|#

## RewriteOption {#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption}

An option for changing or redirecting query paths.

#|
||Field | Description ||
|| enabled | **boolean**

True - the option is enabled and its `flag` is applied to the resource.
False - the option is disabled and its default value of the `flag` is used for the resource. ||
|| body | **string**

Pattern for rewrite.

The value must have the following format: `<source path> <destination path>`, where both paths are regular expressions which use at least one group. E.g., `/foo/(.*) /bar/$1`. ||
|| flag | **enum** (RewriteFlag)

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
|| enabled | **boolean**

True - the option is enabled and its [flag](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption) is applied to the resource.
False - the option is disabled and its default value of the [flag](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption) is used for the resource. ||
|| key | **string**

The key for the URL signing. ||
|| type | **enum** (SecureKeyURLType)

The type of the URL signing. The URL could be available for all IP addresses or for the only one IP.

- `SECURE_KEY_URL_TYPE_UNSPECIFIED`
- `ENABLE_IP_SIGNING`: Use scpecific IP address in URL signing. URL will be availible only for this IP.
- `DISABLE_IP_SIGNING`: Sign URL without using IP address. URL will be available for all IP addresses. ||
|#

## IPAddressACLOption {#yandex.cloud.cdn.v1.ResourceOptions.IPAddressACLOption}

#|
||Field | Description ||
|| enabled | **boolean**

True - the option is enabled and its [flag](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption) is applied to the resource.
False - the option is disabled and its default value of the [flag](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption) is used for the resource. ||
|| policyType | **enum** (PolicyType)

The policy type. One of allow or deny value.

- `POLICY_TYPE_UNSPECIFIED`
- `POLICY_TYPE_ALLOW`: Allow access to all IP addresses except the ones specified in the excepted_values field.
- `POLICY_TYPE_DENY`: Block access to all IP addresses except the ones specified in the excepted_values field. ||
|| exceptedValues[] | **string**

The list of IP addresses to be allowed or denied. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "resourceId": "string",
    "ruleId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "name": "string",
    "rulePattern": "string",
    "options": {
      "disableCache": {
        "enabled": "boolean",
        "value": "boolean"
      },
      "edgeCacheSettings": {
        "enabled": "boolean",
        // Includes only one of the fields `value`, `defaultValue`
        "value": {
          "simpleValue": "string",
          "customValues": "object"
        },
        "defaultValue": "string"
        // end of the list of possible fields
      },
      "browserCacheSettings": {
        "enabled": "boolean",
        "value": "string"
      },
      "cacheHttpHeaders": {
        "enabled": "boolean",
        "value": [
          "string"
        ]
      },
      "queryParamsOptions": {
        // Includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`
        "ignoreQueryString": {
          "enabled": "boolean",
          "value": "boolean"
        },
        "queryParamsWhitelist": {
          "enabled": "boolean",
          "value": [
            "string"
          ]
        },
        "queryParamsBlacklist": {
          "enabled": "boolean",
          "value": [
            "string"
          ]
        }
        // end of the list of possible fields
      },
      "slice": {
        "enabled": "boolean",
        "value": "boolean"
      },
      "compressionOptions": {
        // Includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`
        "fetchCompressed": {
          "enabled": "boolean",
          "value": "boolean"
        },
        "gzipOn": {
          "enabled": "boolean",
          "value": "boolean"
        },
        "brotliCompression": {
          "enabled": "boolean",
          "value": [
            "string"
          ]
        }
        // end of the list of possible fields
      },
      "redirectOptions": {
        // Includes only one of the fields `redirectHttpToHttps`, `redirectHttpsToHttp`
        "redirectHttpToHttps": {
          "enabled": "boolean",
          "value": "boolean"
        },
        "redirectHttpsToHttp": {
          "enabled": "boolean",
          "value": "boolean"
        }
        // end of the list of possible fields
      },
      "hostOptions": {
        // Includes only one of the fields `host`, `forwardHostHeader`
        "host": {
          "enabled": "boolean",
          "value": "string"
        },
        "forwardHostHeader": {
          "enabled": "boolean",
          "value": "boolean"
        }
        // end of the list of possible fields
      },
      "staticHeaders": {
        "enabled": "boolean",
        "value": "object"
      },
      "cors": {
        "enabled": "boolean",
        "value": [
          "string"
        ]
      },
      "stale": {
        "enabled": "boolean",
        "value": [
          "string"
        ]
      },
      "allowedHttpMethods": {
        "enabled": "boolean",
        "value": [
          "string"
        ]
      },
      "proxyCacheMethodsSet": {
        "enabled": "boolean",
        "value": "boolean"
      },
      "disableProxyForceRanges": {
        "enabled": "boolean",
        "value": "boolean"
      },
      "staticRequestHeaders": {
        "enabled": "boolean",
        "value": "object"
      },
      "customServerName": {
        "enabled": "boolean",
        "value": "string"
      },
      "ignoreCookie": {
        "enabled": "boolean",
        "value": "boolean"
      },
      "rewrite": {
        "enabled": "boolean",
        "body": "string",
        "flag": "string"
      },
      "secureKey": {
        "enabled": "boolean",
        "key": "string",
        "type": "string"
      },
      "ipAddressAcl": {
        "enabled": "boolean",
        "policyType": "string",
        "exceptedValues": [
          "string"
        ]
      }
    }
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateResourceRuleMetadata](#yandex.cloud.cdn.v1.UpdateResourceRuleMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Rule](#yandex.cloud.cdn.v1.Rule)**

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

## UpdateResourceRuleMetadata {#yandex.cloud.cdn.v1.UpdateResourceRuleMetadata}

#|
||Field | Description ||
|| resourceId | **string**

Required field. ID of resource. ||
|| ruleId | **string** (int64)

ID of updated resource rule. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Rule {#yandex.cloud.cdn.v1.Rule}

Resource rule.

#|
||Field | Description ||
|| id | **string** (int64)

Rule ID. ||
|| name | **string**

Required field. Rule name. ||
|| rulePattern | **string**

Required field. Rule pattern.
Must be a valid regular expression. ||
|| options | **[ResourceOptions](#yandex.cloud.cdn.v1.ResourceOptions2)** ||
|#

## ResourceOptions {#yandex.cloud.cdn.v1.ResourceOptions2}

A major set of various resource options.

#|
||Field | Description ||
|| disableCache | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Set up a cache status. ||
|| edgeCacheSettings | **[EdgeCacheSettings](#yandex.cloud.cdn.v1.ResourceOptions.EdgeCacheSettings2)**

Set up [EdgeCacheSettings](#yandex.cloud.cdn.v1.ResourceOptions.EdgeCacheSettings2). ||
|| browserCacheSettings | **[Int64Option](#yandex.cloud.cdn.v1.ResourceOptions.Int64Option2)**

Using [Int64Option](#yandex.cloud.cdn.v1.ResourceOptions.Int64Option2). Set up a cache period for the end-users browser.
Content will be cached due to origin settings.
If there are no cache settings on your origin, the content will not be cached.
The list of HTTP response codes that can be cached in browsers: 200, 201, 204, 206, 301, 302, 303, 304, 307, 308.
Other response codes will not be cached.
The default value is 4 days. ||
|| cacheHttpHeaders | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption2)**

List HTTP headers that must be included in responses to clients. ||
|| queryParamsOptions | **[QueryParamsOptions](#yandex.cloud.cdn.v1.ResourceOptions.QueryParamsOptions2)**

Set up [QueryParamsOptions](#yandex.cloud.cdn.v1.ResourceOptions.QueryParamsOptions2). ||
|| slice | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Files larger than 10 MB will be requested and cached in parts (no larger than 10 MB each part). It reduces time to first byte.

The origin must support HTTP Range requests.

By default the option is disabled. ||
|| compressionOptions | **[CompressionOptions](#yandex.cloud.cdn.v1.ResourceOptions.CompressionOptions2)**

Set up compression variant. ||
|| redirectOptions | **[RedirectOptions](#yandex.cloud.cdn.v1.ResourceOptions.RedirectOptions2)**

Set up redirects. ||
|| hostOptions | **[HostOptions](#yandex.cloud.cdn.v1.ResourceOptions.HostOptions2)**

Set up host parameters. ||
|| staticHeaders | **[StringsMapOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsMapOption2)**

Set up static headers that CDN servers send in responses to clients. ||
|| cors | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption2)**

Parameter that lets browsers get access to selected resources from a domain
different to a domain from which the request is received.
[Read more](/docs/cdn/concepts/cors). ||
|| stale | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption2)**

List of errors which instruct CDN servers to serve stale content to clients.

Possible values: `error`, `http_403`, `http_404`, `http_429`, `http_500`, `http_502`, `http_503`, `http_504`, `invalid_header`, `timeout`, `updating`. ||
|| allowedHttpMethods | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption2)**

HTTP methods for your CDN content. By default the following methods
are allowed: GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS.
In case some methods are not allowed to the user, they will get the 405
(Method Not Allowed) response. If the method is not supported,
the user gets the 501 (Not Implemented) response. ||
|| proxyCacheMethodsSet | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Allows caching for GET, HEAD and POST requests. ||
|| disableProxyForceRanges | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Disabling proxy force ranges. ||
|| staticRequestHeaders | **[StringsMapOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsMapOption2)**

Set up custom headers that CDN servers send in requests to origins.
The Header name field can contain letters (A-Z, a-z), numbers (0-9), dashes (-) and underscores (_).
The Value field can contain letters (A-Z, a-z), numbers (0-9), dashes (-),
underscores (_), slashes (/), colons (:), equal (=), dots (.), and spaces. ||
|| customServerName | **[StringOption](#yandex.cloud.cdn.v1.ResourceOptions.StringOption2)**

Wildcard additional CNAME.
If a resource has a wildcard additional CNAME, you can use your own certificate for content delivery via HTTPS. Read-only. ||
|| ignoreCookie | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2) for ignoring cookie. ||
|| rewrite | **[RewriteOption](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption2)**

Changing or redirecting query paths. ||
|| secureKey | **[SecureKeyOption](#yandex.cloud.cdn.v1.ResourceOptions.SecureKeyOption2)**

Secure token to protect contect and limit access by IP addresses and time limits. ||
|| ipAddressAcl | **[IPAddressACLOption](#yandex.cloud.cdn.v1.ResourceOptions.IPAddressACLOption2)**

Manage the state of the IP access policy option.
The option controls access to content from the specified IP addresses. ||
|#

## BoolOption {#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2}

Set up bool values.

#|
||Field | Description ||
|| enabled | **boolean**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **boolean**

Value of the option. ||
|#

## EdgeCacheSettings {#yandex.cloud.cdn.v1.ResourceOptions.EdgeCacheSettings2}

A set of the edge cache parameters.

#|
||Field | Description ||
|| enabled | **boolean**

True - the option is enabled and its `values_variant` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **[CachingTimes](#yandex.cloud.cdn.v1.ResourceOptions.CachingTimes2)**

Value of the option.

Includes only one of the fields `value`, `defaultValue`. ||
|| defaultValue | **string** (int64)

Content will be cached according to origin cache settings.
The value applies for a response with codes 200, 201, 204, 206, 301, 302, 303, 304, 307, 308
if an origin server does not have caching HTTP headers.
Responses with other codes will not be cached.

Includes only one of the fields `value`, `defaultValue`. ||
|#

## CachingTimes {#yandex.cloud.cdn.v1.ResourceOptions.CachingTimes2}

A set of the caching response time parameters.

#|
||Field | Description ||
|| simpleValue | **string** (int64)

Caching time for a response with codes 200, 206, 301, 302.
Responses with codes 4xx, 5xx will not be cached. Use `0s` disable to caching.
Use `customValues` field to specify a custom caching time for a response with specific codes. ||
|| customValues | **object** (map<**string**, **string** (int64)>)

Caching time for a response with specific codes. These settings have a higher priority than the value field.
Response code (`304`, `404` for example). Use `any` to specify caching time for all response codes.
Caching time in seconds (`0s`, `600s` for example). Use `0s` to disable caching for a specific response code. ||
|#

## Int64Option {#yandex.cloud.cdn.v1.ResourceOptions.Int64Option2}

A set of the numeric parameters.

#|
||Field | Description ||
|| enabled | **boolean**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **string** (int64)

Value of the option. ||
|#

## StringsListOption {#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption2}

A set of the string list parameters.

#|
||Field | Description ||
|| enabled | **boolean**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value[] | **string**

Value of the option. ||
|#

## QueryParamsOptions {#yandex.cloud.cdn.v1.ResourceOptions.QueryParamsOptions2}

A set of the query parameters.

#|
||Field | Description ||
|| ignoreQueryString | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2). Selected by default. Files with different query parameters are cached as objects with the same key regardless of the parameter value.

Includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`. ||
|| queryParamsWhitelist | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption2)**

Ignore All Except.
Files with the specified query parameters are cached as objects with different keys,
files with other parameters are cached as objects with the same key.

Includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`. ||
|| queryParamsBlacklist | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption2)**

Ignore only. Files with the specified query parameters are cached as objects with the same key,
files with other parameters are cached as objects with different keys.

Includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`. ||
|#

## CompressionOptions {#yandex.cloud.cdn.v1.ResourceOptions.CompressionOptions2}

A set of the compression variant parameters.

#|
||Field | Description ||
|| fetchCompressed | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

The Fetch compressed option helps you to reduce
the bandwidth between origin and CDN servers.
Also, content delivery speed becomes higher because of reducing the time
for compressing files in a CDN.

Includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`. ||
|| gzipOn | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2). GZip compression at CDN servers reduces file size by 70% and can be as high as 90%.

Includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`. ||
|| brotliCompression | **[StringsListOption](#yandex.cloud.cdn.v1.ResourceOptions.StringsListOption2)**

The option allows to compress content with brotli on the CDN's end.

Compression is performed on the Origin Shielding. If a pre-cache server doesn't active for a resource, compression does not occur even if the option is enabled.

Specify the content-type for each type of content you wish to have compressed. CDN servers will request only uncompressed content from the origin.

Includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`. ||
|#

## RedirectOptions {#yandex.cloud.cdn.v1.ResourceOptions.RedirectOptions2}

A set of the redirect parameters.

#|
||Field | Description ||
|| redirectHttpToHttps | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2). Set up a redirect from HTTPS to HTTP.

Includes only one of the fields `redirectHttpToHttps`, `redirectHttpsToHttp`. ||
|| redirectHttpsToHttp | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2). Set up a redirect from HTTP to HTTPS.

Includes only one of the fields `redirectHttpToHttps`, `redirectHttpsToHttp`. ||
|#

## HostOptions {#yandex.cloud.cdn.v1.ResourceOptions.HostOptions2}

A set of the host parameters.

#|
||Field | Description ||
|| host | **[StringOption](#yandex.cloud.cdn.v1.ResourceOptions.StringOption2)**

Custom value for the Host header.

Your server must be able to process requests with the chosen header.

Default value (if [StringOption.enabled](#yandex.cloud.cdn.v1.ResourceOptions.StringOption2) is `false`) is [Resource.cname](/docs/cdn/api-ref/Resource/get#yandex.cloud.cdn.v1.Resource).

Includes only one of the fields `host`, `forwardHostHeader`. ||
|| forwardHostHeader | **[BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2)**

Using [BoolOption](#yandex.cloud.cdn.v1.ResourceOptions.BoolOption2). Choose the Forward Host header option if is important to send in the request to the Origin
the same Host header as was sent in the request to CDN server.

Includes only one of the fields `host`, `forwardHostHeader`. ||
|#

## StringOption {#yandex.cloud.cdn.v1.ResourceOptions.StringOption2}

A set of the string parameters.

#|
||Field | Description ||
|| enabled | **boolean**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **string**

Value of the option. ||
|#

## StringsMapOption {#yandex.cloud.cdn.v1.ResourceOptions.StringsMapOption2}

A set of the strings map parameters.

#|
||Field | Description ||
|| enabled | **boolean**

True - the option is enabled and its `value` is applied to the resource.
False - the option is disabled and its default value is used for the resource. ||
|| value | **object** (map<**string**, **string**>)

Value of the option. ||
|#

## RewriteOption {#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption2}

An option for changing or redirecting query paths.

#|
||Field | Description ||
|| enabled | **boolean**

True - the option is enabled and its `flag` is applied to the resource.
False - the option is disabled and its default value of the `flag` is used for the resource. ||
|| body | **string**

Pattern for rewrite.

The value must have the following format: `<source path> <destination path>`, where both paths are regular expressions which use at least one group. E.g., `/foo/(.*) /bar/$1`. ||
|| flag | **enum** (RewriteFlag)

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
|| enabled | **boolean**

True - the option is enabled and its [flag](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption2) is applied to the resource.
False - the option is disabled and its default value of the [flag](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption2) is used for the resource. ||
|| key | **string**

The key for the URL signing. ||
|| type | **enum** (SecureKeyURLType)

The type of the URL signing. The URL could be available for all IP addresses or for the only one IP.

- `SECURE_KEY_URL_TYPE_UNSPECIFIED`
- `ENABLE_IP_SIGNING`: Use scpecific IP address in URL signing. URL will be availible only for this IP.
- `DISABLE_IP_SIGNING`: Sign URL without using IP address. URL will be available for all IP addresses. ||
|#

## IPAddressACLOption {#yandex.cloud.cdn.v1.ResourceOptions.IPAddressACLOption2}

#|
||Field | Description ||
|| enabled | **boolean**

True - the option is enabled and its [flag](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption2) is applied to the resource.
False - the option is disabled and its default value of the [flag](#yandex.cloud.cdn.v1.ResourceOptions.RewriteOption2) is used for the resource. ||
|| policyType | **enum** (PolicyType)

The policy type. One of allow or deny value.

- `POLICY_TYPE_UNSPECIFIED`
- `POLICY_TYPE_ALLOW`: Allow access to all IP addresses except the ones specified in the excepted_values field.
- `POLICY_TYPE_DENY`: Block access to all IP addresses except the ones specified in the excepted_values field. ||
|| exceptedValues[] | **string**

The list of IP addresses to be allowed or denied. ||
|#