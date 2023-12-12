---
editable: false
sourcePath: en/_api-ref/cdn/v1/api-ref/ResourceRules/list.md
---

# Cloud CDN API, REST: ResourceRules.list
List all rules for specified resource.
 

 
## HTTP request {#https-request}
```
GET https://cdn.{{ api-host }}/cdn/v1/rules
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
resourceId | <p>Required. ID of resource.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "rules": [
    {
      "id": "string",
      "name": "string",
      "rulePattern": "string",
      "options": {
        "disableCache": {
          "enabled": true,
          "value": true
        },
        "edgeCacheSettings": {
          "enabled": true,

          // `rules[].options.edgeCacheSettings` includes only one of the fields `value`, `defaultValue`
          "value": {
            "simpleValue": "string",
            "customValues": "object"
          },
          "defaultValue": "string",
          // end of the list of possible fields`rules[].options.edgeCacheSettings`

        },
        "browserCacheSettings": {
          "enabled": true,
          "value": "string"
        },
        "cacheHttpHeaders": {
          "enabled": true,
          "value": [
            "string"
          ]
        },
        "queryParamsOptions": {

          // `rules[].options.queryParamsOptions` includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`
          "ignoreQueryString": {
            "enabled": true,
            "value": true
          },
          "queryParamsWhitelist": {
            "enabled": true,
            "value": [
              "string"
            ]
          },
          "queryParamsBlacklist": {
            "enabled": true,
            "value": [
              "string"
            ]
          },
          // end of the list of possible fields`rules[].options.queryParamsOptions`

        },
        "slice": {
          "enabled": true,
          "value": true
        },
        "compressionOptions": {

          // `rules[].options.compressionOptions` includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`
          "fetchCompressed": {
            "enabled": true,
            "value": true
          },
          "gzipOn": {
            "enabled": true,
            "value": true
          },
          "brotliCompression": {
            "enabled": true,
            "value": [
              "string"
            ]
          },
          // end of the list of possible fields`rules[].options.compressionOptions`

        },
        "redirectOptions": {

          // `rules[].options.redirectOptions` includes only one of the fields `redirectHttpToHttps`, `redirectHttpsToHttp`
          "redirectHttpToHttps": {
            "enabled": true,
            "value": true
          },
          "redirectHttpsToHttp": {
            "enabled": true,
            "value": true
          },
          // end of the list of possible fields`rules[].options.redirectOptions`

        },
        "hostOptions": {

          // `rules[].options.hostOptions` includes only one of the fields `host`, `forwardHostHeader`
          "host": {
            "enabled": true,
            "value": "string"
          },
          "forwardHostHeader": {
            "enabled": true,
            "value": true
          },
          // end of the list of possible fields`rules[].options.hostOptions`

        },
        "staticHeaders": {
          "enabled": true,
          "value": "object"
        },
        "cors": {
          "enabled": true,
          "value": [
            "string"
          ]
        },
        "stale": {
          "enabled": true,
          "value": [
            "string"
          ]
        },
        "allowedHttpMethods": {
          "enabled": true,
          "value": [
            "string"
          ]
        },
        "proxyCacheMethodsSet": {
          "enabled": true,
          "value": true
        },
        "disableProxyForceRanges": {
          "enabled": true,
          "value": true
        },
        "staticRequestHeaders": {
          "enabled": true,
          "value": "object"
        },
        "customServerName": {
          "enabled": true,
          "value": "string"
        },
        "ignoreCookie": {
          "enabled": true,
          "value": true
        },
        "rewrite": {
          "enabled": true,
          "body": "string",
          "flag": "string"
        },
        "secureKey": {
          "enabled": true,
          "key": "string",
          "type": "string"
        },
        "ipAddressAcl": {
          "enabled": true,
          "policyType": "string",
          "exceptedValues": {
            "enabled": true,
            "value": [
              "string"
            ]
          }
        }
      }
    }
  ]
}
```

 
Field | Description
--- | ---
rules[] | **object**<br><p>List of the resource rules.</p> 
rules[].<br>id | **string** (int64)<br><p>Rule ID.</p> <p>Value must be greater than 0.</p> 
rules[].<br>name | **string**<br><p>Required. Rule name.</p> <p>The maximum string length in characters is 50.</p> 
rules[].<br>rulePattern | **string**<br><p>Required. Rule pattern. Must be a valid regular expression.</p> <p>The maximum string length in characters is 100.</p> 
rules[].<br>options | **object**<br><p>A major set of various resource options.</p> 
rules[].<br>options.<br>disableCache | **object**<br><p>Set up a cache status.</p> <p>Set up bool values.</p> 
rules[].<br>options.<br>disableCache.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>disableCache.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
rules[].<br>options.<br>edgeCacheSettings | **object**<br><p>Set up ``ResourceOptionsEdgeCacheSettings``.</p> <p>A set of the edge cache parameters.</p> 
rules[].<br>options.<br>edgeCacheSettings.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``values_variant`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>edgeCacheSettings.<br>value | **object**<br>Value of the option. <br>`rules[].options.edgeCacheSettings` includes only one of the fields `value`, `defaultValue`<br>
rules[].<br>options.<br>edgeCacheSettings.<br>value.<br>simpleValue | **string** (int64)<br><p>Caching time for a response with codes 200, 206, 301, 302. Responses with codes 4xx, 5xx will not be cached. Use ``0s`` disable to caching. Use ``customValues`` field to specify a custom caching time for a response with specific codes.</p> 
rules[].<br>options.<br>edgeCacheSettings.<br>value.<br>customValues | **object**<br><p>Caching time for a response with specific codes. These settings have a higher priority than the value field. Response code (``304``, ``404`` for example). Use ``any`` to specify caching time for all response codes. Caching time in seconds (``0s``, ``600s`` for example). Use ``0s`` to disable caching for a specific response code.</p> 
rules[].<br>options.<br>edgeCacheSettings.<br>defaultValue | **string** (int64) <br>`rules[].options.edgeCacheSettings` includes only one of the fields `value`, `defaultValue`<br><br><p>Content will be cached according to origin cache settings. The value applies for a response with codes 200, 201, 204, 206, 301, 302, 303, 304, 307, 308 if an origin server does not have caching HTTP headers. Responses with other codes will not be cached.</p> 
rules[].<br>options.<br>browserCacheSettings | **object**<br><p>Using ``ResourceOptionsInt64Option``. Set up a cache period for the end-users browser. Content will be cached due to origin settings. If there are no cache settings on your origin, the content will not be cached. The list of HTTP response codes that can be cached in browsers: 200, 201, 204, 206, 301, 302, 303, 304, 307, 308. Other response codes will not be cached. The default value is 4 days.</p> <p>A set of the numeric parameters.</p> 
rules[].<br>options.<br>browserCacheSettings.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>browserCacheSettings.<br>value | **string** (int64)<br><p>Value of the option.</p> 
rules[].<br>options.<br>cacheHttpHeaders | **object**<br><p>List HTTP headers that must be included in responses to clients.</p> <p>A set of the string list parameters.</p> 
rules[].<br>options.<br>cacheHttpHeaders.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>cacheHttpHeaders.<br>value[] | **string**<br><p>Value of the option.</p> 
rules[].<br>options.<br>queryParamsOptions | **object**<br><p>Set up ``ResourceOptionsQueryParamsOptions``.</p> <p>A set of the query parameters.</p> 
rules[].<br>options.<br>queryParamsOptions.<br>ignoreQueryString | **object**<br>Using `ResourceOptionsBoolOption`. Choose the Forward Host header option if is important to send in the request to the Origin the same Host header as was sent in the request to CDN server. <br>`rules[].options.queryParamsOptions` includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`<br>
rules[].<br>options.<br>queryParamsOptions.<br>ignoreQueryString.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>queryParamsOptions.<br>ignoreQueryString.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
rules[].<br>options.<br>queryParamsOptions.<br>queryParamsWhitelist | **object**<br>The option allows to compress content with brotli on the CDN's end.  Compression is performed on the Origin Shielding. If a pre-cache server doesn't active for a resource, compression does not occur even if the option is enabled.  Specify the content-type for each type of content you wish to have compressed. CDN servers will request only uncompressed content from the origin. <br>`rules[].options.queryParamsOptions` includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`<br>
rules[].<br>options.<br>queryParamsOptions.<br>queryParamsWhitelist.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>queryParamsOptions.<br>queryParamsWhitelist.<br>value[] | **string**<br><p>Value of the option.</p> 
rules[].<br>options.<br>queryParamsOptions.<br>queryParamsBlacklist | **object**<br>Ignore All Except. Files with the specified query parameters are cached as objects with different keys, files with other parameters are cached as objects with the same key. <br>`rules[].options.queryParamsOptions` includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`<br>
rules[].<br>options.<br>queryParamsOptions.<br>queryParamsBlacklist.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>queryParamsOptions.<br>queryParamsBlacklist.<br>value[] | **string**<br><p>Value of the option.</p> 
rules[].<br>options.<br>slice | **object**<br><p>Files larger than 10 MB will be requested and cached in parts (no larger than 10 MB each part). It reduces time to first byte.</p> <p>The origin must support HTTP Range requests.</p> <p>By default the option is disabled.</p> <p>Set up bool values.</p> 
rules[].<br>options.<br>slice.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>slice.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
rules[].<br>options.<br>compressionOptions | **object**<br><p>Set up compression variant.</p> <p>A set of the compression variant parameters.</p> 
rules[].<br>options.<br>compressionOptions.<br>fetchCompressed | **object**<br>Using `ResourceOptionsBoolOption`. Selected by default. Files with different query parameters are cached as objects with the same key regardless of the parameter value. <br>`rules[].options.compressionOptions` includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`<br>
rules[].<br>options.<br>compressionOptions.<br>fetchCompressed.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>compressionOptions.<br>fetchCompressed.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
rules[].<br>options.<br>compressionOptions.<br>gzipOn | **object**<br>The Fetch compressed option helps you to reduce the bandwidth between origin and CDN servers. Also, content delivery speed becomes higher because of reducing the time for compressing files in a CDN. <br>`rules[].options.compressionOptions` includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`<br>
rules[].<br>options.<br>compressionOptions.<br>gzipOn.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>compressionOptions.<br>gzipOn.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
rules[].<br>options.<br>compressionOptions.<br>brotliCompression | **object**<br>Ignore only. Files with the specified query parameters are cached as objects with the same key, files with other parameters are cached as objects with different keys. <br>`rules[].options.compressionOptions` includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`<br>
rules[].<br>options.<br>compressionOptions.<br>brotliCompression.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>compressionOptions.<br>brotliCompression.<br>value[] | **string**<br><p>Value of the option.</p> 
rules[].<br>options.<br>redirectOptions | **object**<br><p>Set up redirects.</p> <p>A set of the redirect parameters.</p> 
rules[].<br>options.<br>redirectOptions.<br>redirectHttpToHttps | **object**<br>Using `ResourceOptionsBoolOption`. GZip compression at CDN servers reduces file size by 70% and can be as high as 90%. <br>`rules[].options.redirectOptions` includes only one of the fields `redirectHttpToHttps`, `redirectHttpsToHttp`<br>
rules[].<br>options.<br>redirectOptions.<br>redirectHttpToHttps.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>redirectOptions.<br>redirectHttpToHttps.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
rules[].<br>options.<br>redirectOptions.<br>redirectHttpsToHttp | **object**<br>Using `ResourceOptionsBoolOption`. Set up a redirect from HTTPS to HTTP. <br>`rules[].options.redirectOptions` includes only one of the fields `redirectHttpToHttps`, `redirectHttpsToHttp`<br>
rules[].<br>options.<br>redirectOptions.<br>redirectHttpsToHttp.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>redirectOptions.<br>redirectHttpsToHttp.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
rules[].<br>options.<br>hostOptions | **object**<br><p>Set up host parameters.</p> <p>A set of the host parameters.</p> 
rules[].<br>options.<br>hostOptions.<br>host | **object**<br>Custom value for the Host header.  Your server must be able to process requests with the chosen header.  Default value (if `enabled` is `false`) is [Resource.cname](/docs/cdn/api-ref/Resource#representation). <br>`rules[].options.hostOptions` includes only one of the fields `host`, `forwardHostHeader`<br>
rules[].<br>options.<br>hostOptions.<br>host.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>hostOptions.<br>host.<br>value | **string**<br><p>Value of the option.</p> 
rules[].<br>options.<br>hostOptions.<br>forwardHostHeader | **object**<br>Using `ResourceOptionsBoolOption`. Set up a redirect from HTTP to HTTPS. <br>`rules[].options.hostOptions` includes only one of the fields `host`, `forwardHostHeader`<br>
rules[].<br>options.<br>hostOptions.<br>forwardHostHeader.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>hostOptions.<br>forwardHostHeader.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
rules[].<br>options.<br>staticHeaders | **object**<br><p>Set up static headers that CDN servers send in responses to clients.</p> <p>A set of the strings map parameters.</p> 
rules[].<br>options.<br>staticHeaders.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>staticHeaders.<br>value | **object**<br><p>Value of the option.</p> 
rules[].<br>options.<br>cors | **object**<br><p>Parameter that lets browsers get access to selected resources from a domain different to a domain from which the request is received. <a href="/docs/cdn/concepts/cors">Read more</a>.</p> <p>A set of the string list parameters.</p> 
rules[].<br>options.<br>cors.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>cors.<br>value[] | **string**<br><p>Value of the option.</p> 
rules[].<br>options.<br>stale | **object**<br><p>List of errors which instruct CDN servers to serve stale content to clients.</p> <p>Possible values: ``error``, ``http_403``, ``http_404``, ``http_429``, ``http_500``, ``http_502``, ``http_503``, ``http_504``, ``invalid_header``, ``timeout``, ``updating``.</p> <p>A set of the string list parameters.</p> 
rules[].<br>options.<br>stale.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>stale.<br>value[] | **string**<br><p>Value of the option.</p> 
rules[].<br>options.<br>allowedHttpMethods | **object**<br><p>HTTP methods for your CDN content. By default the following methods are allowed: GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS. In case some methods are not allowed to the user, they will get the 405 (Method Not Allowed) response. If the method is not supported, the user gets the 501 (Not Implemented) response.</p> <p>A set of the string list parameters.</p> 
rules[].<br>options.<br>allowedHttpMethods.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>allowedHttpMethods.<br>value[] | **string**<br><p>Value of the option.</p> 
rules[].<br>options.<br>proxyCacheMethodsSet | **object**<br><p>Allows caching for GET, HEAD and POST requests.</p> <p>Set up bool values.</p> 
rules[].<br>options.<br>proxyCacheMethodsSet.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>proxyCacheMethodsSet.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
rules[].<br>options.<br>disableProxyForceRanges | **object**<br><p>Disabling proxy force ranges.</p> <p>Set up bool values.</p> 
rules[].<br>options.<br>disableProxyForceRanges.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>disableProxyForceRanges.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
rules[].<br>options.<br>staticRequestHeaders | **object**<br><p>Set up custom headers that CDN servers send in requests to origins. The Header name field can contain letters (A-Z, a-z), numbers (0-9), dashes (-) and underscores (<em>). The Value field can contain letters (A-Z, a-z), numbers (0-9), dashes (-), underscores (</em>), slashes (/), colons (:), equal (=), dots (.), and spaces.</p> <p>A set of the strings map parameters.</p> 
rules[].<br>options.<br>staticRequestHeaders.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>staticRequestHeaders.<br>value | **object**<br><p>Value of the option.</p> 
rules[].<br>options.<br>customServerName | **object**<br><p>Wildcard additional CNAME. If a resource has a wildcard additional CNAME, you can use your own certificate for content delivery via HTTPS. Read-only.</p> <p>A set of the string parameters.</p> 
rules[].<br>options.<br>customServerName.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>customServerName.<br>value | **string**<br><p>Value of the option.</p> 
rules[].<br>options.<br>ignoreCookie | **object**<br><p>Using ``ResourceOptionsBoolOption`` for ignoring cookie.</p> <p>Set up bool values.</p> 
rules[].<br>options.<br>ignoreCookie.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>ignoreCookie.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
rules[].<br>options.<br>rewrite | **object**<br><p>Changing or redirecting query paths.</p> <p>An option for changing or redirecting query paths.</p> 
rules[].<br>options.<br>rewrite.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``flag`` is applied to the resource. False - the option is disabled and its default value of the ``flag`` is used for the resource.</p> 
rules[].<br>options.<br>rewrite.<br>body | **string**<br><p>Pattern for rewrite.</p> <p>The value must have the following format: ``<source path> <destination path>``, where both paths are regular expressions which use at least one group. E.g., ``/foo/(.*) /bar/$1``.</p> 
rules[].<br>options.<br>rewrite.<br>flag | **string**<br><p>Break flag is applied to the option by default. It is not shown in the field.</p> <p>RewriteFlag defines flag for the Rewrite option.</p> <ul> <li>LAST: Stops processing of the current set of ngx_http_rewrite_module directives and starts a search for a new location matching changed URI.</li> <li>BREAK: Stops processing of the current set of the Rewrite option.</li> <li>REDIRECT: Returns a temporary redirect with the 302 code; It is used when a replacement string does not start with "http://", "https://", or "$scheme".</li> <li>PERMANENT: Returns a permanent redirect with the 301 code.</li> </ul> 
rules[].<br>options.<br>secureKey | **object**<br><p>Secure token to protect contect and limit access by IP addresses and time limits.</p> 
rules[].<br>options.<br>secureKey.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its [flag] is applied to the resource. False - the option is disabled and its default value of the [flag] is used for the resource.</p> 
rules[].<br>options.<br>secureKey.<br>key | **string**<br><p>The key for the URL signing.</p> 
rules[].<br>options.<br>secureKey.<br>type | **string**<br><p>The type of the URL signing. The URL could be available for all IP addresses or for the only one IP.</p> <p>SecureKeyURLType defines type of the URL signing.</p> <ul> <li>ENABLE_IP_SIGNING: Use scpecific IP address in URL signing. URL will be availible only for this IP.</li> <li>DISABLE_IP_SIGNING: Sign URL without using IP address. URL will be available for all IP addresses.</li> </ul> 
rules[].<br>options.<br>ipAddressAcl | **object**<br><p>Manage the state of the IP access policy option. The option controls access to content from the specified IP addresses.</p> 
rules[].<br>options.<br>ipAddressAcl.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its [flag] is applied to the resource. False - the option is disabled and its default value of the [flag] is used for the resource.</p> 
rules[].<br>options.<br>ipAddressAcl.<br>policyType | **string**<br><p>The policy type. One of allow or deny value.</p> <p>PolicyType defines type of the policy in IP address acl rules.</p> <ul> <li>POLICY_TYPE_ALLOW: Allow access to all IP addresses except the ones specified in the excepted_values field.</li> <li>POLICY_TYPE_DENY: Block access to all IP addresses except the ones specified in the excepted_values field.</li> </ul> 
rules[].<br>options.<br>ipAddressAcl.<br>exceptedValues | **object**<br><p>The list of IP addresses to be allowed or denied.</p> <p>A set of the string list parameters.</p> 
rules[].<br>options.<br>ipAddressAcl.<br>exceptedValues.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
rules[].<br>options.<br>ipAddressAcl.<br>exceptedValues.<br>value[] | **string**<br><p>Value of the option.</p> 