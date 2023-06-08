---
editable: false
sourcePath: en/_api-ref/cdn/v1/api-ref/Resource/list.md
---

# Cloud CDN API, REST: Resource.list
Lists CDN resources.
 

 
## HTTP request {#https-request}
```
GET https://cdn.{{ api-host }}/cdn/v1/resources
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to request listing for.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/cdn/api-ref/Resource/list#query_params">pageSize</a>, the service returns a <a href="/docs/cdn/api-ref/Resource/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/cdn/api-ref/Resource/list#query_params">pageToken</a> to the <a href="/docs/cdn/api-ref/Resource/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "resources": [
    {
      "id": "string",
      "folderId": "string",
      "cname": "string",
      "createdAt": "string",
      "updatedAt": "string",
      "active": true,
      "options": {
        "disableCache": {
          "enabled": true,
          "value": true
        },
        "edgeCacheSettings": {
          "enabled": true,

          // `resources[].options.edgeCacheSettings` includes only one of the fields `value`, `defaultValue`
          "value": {
            "simpleValue": "string",
            "customValues": "object"
          },
          "defaultValue": "string",
          // end of the list of possible fields`resources[].options.edgeCacheSettings`

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

          // `resources[].options.queryParamsOptions` includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`
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
          // end of the list of possible fields`resources[].options.queryParamsOptions`

        },
        "slice": {
          "enabled": true,
          "value": true
        },
        "compressionOptions": {

          // `resources[].options.compressionOptions` includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`
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
          // end of the list of possible fields`resources[].options.compressionOptions`

        },
        "redirectOptions": {

          // `resources[].options.redirectOptions` includes only one of the fields `redirectHttpToHttps`, `redirectHttpsToHttp`
          "redirectHttpToHttps": {
            "enabled": true,
            "value": true
          },
          "redirectHttpsToHttp": {
            "enabled": true,
            "value": true
          },
          // end of the list of possible fields`resources[].options.redirectOptions`

        },
        "hostOptions": {

          // `resources[].options.hostOptions` includes only one of the fields `host`, `forwardHostHeader`
          "host": {
            "enabled": true,
            "value": "string"
          },
          "forwardHostHeader": {
            "enabled": true,
            "value": true
          },
          // end of the list of possible fields`resources[].options.hostOptions`

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
        }
      },
      "secondaryHostnames": [
        "string"
      ],
      "originGroupId": "string",
      "originGroupName": "string",
      "originProtocol": "string",
      "sslCertificate": {
        "type": "string",
        "status": "string",
        "data": {
          "cm": {
            "id": "string"
          }
        }
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
resources[] | **object**<br><p>List of the resources</p> 
resources[].<br>id | **string**<br><p>ID of the resource.</p> 
resources[].<br>folderId | **string**<br><p>Folder id.</p> 
resources[].<br>cname | **string**<br><p>CDN endpoint CNAME, must be unique among resources.</p> 
resources[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
resources[].<br>updatedAt | **string** (date-time)<br><p>Update timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
resources[].<br>active | **boolean** (boolean)<br><p>Flag to create Resource either in active or disabled state. True - the content from CDN is available to clients. False - the content from CDN isn't available to clients.</p> 
resources[].<br>options | **object**<br><p>Resource settings and options to tune CDN edge behavior.</p> <p>A major set of various resource options.</p> 
resources[].<br>options.<br>disableCache | **object**<br><p>Set up a cache status.</p> <p>Set up bool values.</p> 
resources[].<br>options.<br>disableCache.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>disableCache.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
resources[].<br>options.<br>edgeCacheSettings | **object**<br><p>Set up ``ResourceOptionsEdgeCacheSettings``.</p> <p>A set of the edge cache parameters.</p> 
resources[].<br>options.<br>edgeCacheSettings.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``values_variant`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>edgeCacheSettings.<br>value | **object**<br>Value of the option. <br>`resources[].options.edgeCacheSettings` includes only one of the fields `value`, `defaultValue`<br>
resources[].<br>options.<br>edgeCacheSettings.<br>value.<br>simpleValue | **string** (int64)<br><p>Caching time for a response with codes 200, 206, 301, 302. Responses with codes 4xx, 5xx will not be cached. Use ``0s`` disable to caching. Use ``customValues`` field to specify a custom caching time for a response with specific codes.</p> 
resources[].<br>options.<br>edgeCacheSettings.<br>value.<br>customValues | **object**<br><p>Caching time for a response with specific codes. These settings have a higher priority than the value field. Response code (``304``, ``404`` for example). Use ``any`` to specify caching time for all response codes. Caching time in seconds (``0s``, ``600s`` for example). Use ``0s`` to disable caching for a specific response code.</p> 
resources[].<br>options.<br>edgeCacheSettings.<br>defaultValue | **string** (int64) <br>`resources[].options.edgeCacheSettings` includes only one of the fields `value`, `defaultValue`<br><br><p>Content will be cached according to origin cache settings. The value applies for a response with codes 200, 201, 204, 206, 301, 302, 303, 304, 307, 308 if an origin server does not have caching HTTP headers. Responses with other codes will not be cached.</p> 
resources[].<br>options.<br>browserCacheSettings | **object**<br><p>Using ``ResourceOptionsInt64Option``. Set up a cache period for the end-users browser. Content will be cached due to origin settings. If there are no cache settings on your origin, the content will not be cached. The list of HTTP response codes that can be cached in browsers: 200, 201, 204, 206, 301, 302, 303, 304, 307, 308. Other response codes will not be cached. The default value is 4 days.</p> <p>A set of the numeric parameters.</p> 
resources[].<br>options.<br>browserCacheSettings.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>browserCacheSettings.<br>value | **string** (int64)<br><p>Value of the option.</p> 
resources[].<br>options.<br>cacheHttpHeaders | **object**<br><p>List HTTP headers that must be included in responses to clients.</p> <p>A set of the string list parameters.</p> 
resources[].<br>options.<br>cacheHttpHeaders.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>cacheHttpHeaders.<br>value[] | **string**<br><p>Value of the option.</p> 
resources[].<br>options.<br>queryParamsOptions | **object**<br><p>Set up ``ResourceOptionsQueryParamsOptions``.</p> <p>A set of the query parameters.</p> 
resources[].<br>options.<br>queryParamsOptions.<br>ignoreQueryString | **object**<br>Using `ResourceOptionsBoolOption`. Choose the Forward Host header option if is important to send in the request to the Origin the same Host header as was sent in the request to CDN server. <br>`resources[].options.queryParamsOptions` includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`<br>
resources[].<br>options.<br>queryParamsOptions.<br>ignoreQueryString.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>queryParamsOptions.<br>ignoreQueryString.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
resources[].<br>options.<br>queryParamsOptions.<br>queryParamsWhitelist | **object**<br>The option allows to compress content with brotli on the CDN's end.  Compression is performed on the Origin Shielding. If a pre-cache server doesn't active for a resource, compression does not occur even if the option is enabled.  Specify the content-type for each type of content you wish to have compressed. CDN servers will request only uncompressed content from the origin. <br>`resources[].options.queryParamsOptions` includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`<br>
resources[].<br>options.<br>queryParamsOptions.<br>queryParamsWhitelist.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>queryParamsOptions.<br>queryParamsWhitelist.<br>value[] | **string**<br><p>Value of the option.</p> 
resources[].<br>options.<br>queryParamsOptions.<br>queryParamsBlacklist | **object**<br>Ignore All Except. Files with the specified query parameters are cached as objects with different keys, files with other parameters are cached as objects with the same key. <br>`resources[].options.queryParamsOptions` includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`<br>
resources[].<br>options.<br>queryParamsOptions.<br>queryParamsBlacklist.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>queryParamsOptions.<br>queryParamsBlacklist.<br>value[] | **string**<br><p>Value of the option.</p> 
resources[].<br>options.<br>slice | **object**<br><p>Files larger than 10 MB will be requested and cached in parts (no larger than 10 MB each part). It reduces time to first byte.</p> <p>The origin must support HTTP Range requests.</p> <p>By default the option is disabled.</p> <p>Set up bool values.</p> 
resources[].<br>options.<br>slice.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>slice.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
resources[].<br>options.<br>compressionOptions | **object**<br><p>Set up compression variant.</p> <p>A set of the compression variant parameters.</p> 
resources[].<br>options.<br>compressionOptions.<br>fetchCompressed | **object**<br>Using `ResourceOptionsBoolOption`. Selected by default. Files with different query parameters are cached as objects with the same key regardless of the parameter value. <br>`resources[].options.compressionOptions` includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`<br>
resources[].<br>options.<br>compressionOptions.<br>fetchCompressed.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>compressionOptions.<br>fetchCompressed.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
resources[].<br>options.<br>compressionOptions.<br>gzipOn | **object**<br>The Fetch compressed option helps you to reduce the bandwidth between origin and CDN servers. Also, content delivery speed becomes higher because of reducing the time for compressing files in a CDN. <br>`resources[].options.compressionOptions` includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`<br>
resources[].<br>options.<br>compressionOptions.<br>gzipOn.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>compressionOptions.<br>gzipOn.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
resources[].<br>options.<br>compressionOptions.<br>brotliCompression | **object**<br>Ignore only. Files with the specified query parameters are cached as objects with the same key, files with other parameters are cached as objects with different keys. <br>`resources[].options.compressionOptions` includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`<br>
resources[].<br>options.<br>compressionOptions.<br>brotliCompression.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>compressionOptions.<br>brotliCompression.<br>value[] | **string**<br><p>Value of the option.</p> 
resources[].<br>options.<br>redirectOptions | **object**<br><p>Set up redirects.</p> <p>A set of the redirect parameters.</p> 
resources[].<br>options.<br>redirectOptions.<br>redirectHttpToHttps | **object**<br>Using `ResourceOptionsBoolOption`. GZip compression at CDN servers reduces file size by 70% and can be as high as 90%. <br>`resources[].options.redirectOptions` includes only one of the fields `redirectHttpToHttps`, `redirectHttpsToHttp`<br>
resources[].<br>options.<br>redirectOptions.<br>redirectHttpToHttps.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>redirectOptions.<br>redirectHttpToHttps.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
resources[].<br>options.<br>redirectOptions.<br>redirectHttpsToHttp | **object**<br>Using `ResourceOptionsBoolOption`. Set up a redirect from HTTPS to HTTP. <br>`resources[].options.redirectOptions` includes only one of the fields `redirectHttpToHttps`, `redirectHttpsToHttp`<br>
resources[].<br>options.<br>redirectOptions.<br>redirectHttpsToHttp.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>redirectOptions.<br>redirectHttpsToHttp.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
resources[].<br>options.<br>hostOptions | **object**<br><p>Set up host parameters.</p> <p>A set of the host parameters.</p> 
resources[].<br>options.<br>hostOptions.<br>host | **object**<br>Custom value for the Host header.  Your server must be able to process requests with the chosen header.  Default value (if `enabled` is `false`) is [Resource.cname](/docs/cdn/api-ref/Resource#representation). <br>`resources[].options.hostOptions` includes only one of the fields `host`, `forwardHostHeader`<br>
resources[].<br>options.<br>hostOptions.<br>host.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>hostOptions.<br>host.<br>value | **string**<br><p>Value of the option.</p> 
resources[].<br>options.<br>hostOptions.<br>forwardHostHeader | **object**<br>Using `ResourceOptionsBoolOption`. Set up a redirect from HTTP to HTTPS. <br>`resources[].options.hostOptions` includes only one of the fields `host`, `forwardHostHeader`<br>
resources[].<br>options.<br>hostOptions.<br>forwardHostHeader.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>hostOptions.<br>forwardHostHeader.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
resources[].<br>options.<br>staticHeaders | **object**<br><p>Set up static headers that CDN servers send in responses to clients.</p> <p>A set of the strings map parameters.</p> 
resources[].<br>options.<br>staticHeaders.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>staticHeaders.<br>value | **object**<br><p>Value of the option.</p> 
resources[].<br>options.<br>cors | **object**<br><p>Parameter that lets browsers get access to selected resources from a domain different to a domain from which the request is received. <a href="/docs/cdn/concepts/cors">Read more</a>.</p> <p>A set of the string list parameters.</p> 
resources[].<br>options.<br>cors.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>cors.<br>value[] | **string**<br><p>Value of the option.</p> 
resources[].<br>options.<br>stale | **object**<br><p>List of errors which instruct CDN servers to serve stale content to clients.</p> <p>Possible values: ``error``, ``http_403``, ``http_404``, ``http_429``, ``http_500``, ``http_502``, ``http_503``, ``http_504``, ``invalid_header``, ``timeout``, ``updating``.</p> <p>A set of the string list parameters.</p> 
resources[].<br>options.<br>stale.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>stale.<br>value[] | **string**<br><p>Value of the option.</p> 
resources[].<br>options.<br>allowedHttpMethods | **object**<br><p>HTTP methods for your CDN content. By default the following methods are allowed: GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS. In case some methods are not allowed to the user, they will get the 405 (Method Not Allowed) response. If the method is not supported, the user gets the 501 (Not Implemented) response.</p> <p>A set of the string list parameters.</p> 
resources[].<br>options.<br>allowedHttpMethods.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>allowedHttpMethods.<br>value[] | **string**<br><p>Value of the option.</p> 
resources[].<br>options.<br>proxyCacheMethodsSet | **object**<br><p>Allows caching for GET, HEAD and POST requests.</p> <p>Set up bool values.</p> 
resources[].<br>options.<br>proxyCacheMethodsSet.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>proxyCacheMethodsSet.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
resources[].<br>options.<br>disableProxyForceRanges | **object**<br><p>Disabling proxy force ranges.</p> <p>Set up bool values.</p> 
resources[].<br>options.<br>disableProxyForceRanges.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>disableProxyForceRanges.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
resources[].<br>options.<br>staticRequestHeaders | **object**<br><p>Set up custom headers that CDN servers send in requests to origins. The Header name field can contain letters (A-Z, a-z), numbers (0-9), dashes (-) and underscores (<em>). The Value field can contain letters (A-Z, a-z), numbers (0-9), dashes (-), underscores (</em>), slashes (/), colons (:), equal (=), dots (.), and spaces.</p> <p>A set of the strings map parameters.</p> 
resources[].<br>options.<br>staticRequestHeaders.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>staticRequestHeaders.<br>value | **object**<br><p>Value of the option.</p> 
resources[].<br>options.<br>customServerName | **object**<br><p>Wildcard additional CNAME. If a resource has a wildcard additional CNAME, you can use your own certificate for content delivery via HTTPS. Read-only.</p> <p>A set of the string parameters.</p> 
resources[].<br>options.<br>customServerName.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>customServerName.<br>value | **string**<br><p>Value of the option.</p> 
resources[].<br>options.<br>ignoreCookie | **object**<br><p>Using ``ResourceOptionsBoolOption`` for ignoring cookie.</p> <p>Set up bool values.</p> 
resources[].<br>options.<br>ignoreCookie.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``value`` is applied to the resource. False - the option is disabled and its default value is used for the resource.</p> 
resources[].<br>options.<br>ignoreCookie.<br>value | **boolean** (boolean)<br><p>Value of the option.</p> 
resources[].<br>options.<br>rewrite | **object**<br><p>Changing or redirecting query paths.</p> <p>An option for changing or redirecting query paths.</p> 
resources[].<br>options.<br>rewrite.<br>enabled | **boolean** (boolean)<br><p>True - the option is enabled and its ``flag`` is applied to the resource. False - the option is disabled and its default value of the ``flag`` is used for the resource.</p> 
resources[].<br>options.<br>rewrite.<br>body | **string**<br><p>Pattern for rewrite.</p> <p>The value must have the following format: ``<source path> <destination path>``, where both paths are regular expressions which use at least one group. E.g., ``/foo/(.*) /bar/$1``.</p> 
resources[].<br>options.<br>rewrite.<br>flag | **string**<br><p>Break flag is applied to the option by default. It is not shown in the field.</p> <p>RewriteFlag defines flag for the Rewrite option.</p> <ul> <li>LAST: Stops processing of the current set of ngx_http_rewrite_module directives and starts a search for a new location matching changed URI.</li> <li>BREAK: Stops processing of the current set of the Rewrite option.</li> <li>REDIRECT: Returns a temporary redirect with the 302 code; It is used when a replacement string does not start with "http://", "https://", or "$scheme".</li> <li>PERMANENT: Returns a permanent redirect with the 301 code.</li> </ul> 
resources[].<br>secondaryHostnames[] | **string**<br><p>List of secondary hostname strings.</p> 
resources[].<br>originGroupId | **string** (int64)<br><p>ID of the origin group.</p> 
resources[].<br>originGroupName | **string**<br><p>Name of the origin group.</p> 
resources[].<br>originProtocol | **string**<br><p>Specify the protocol schema to be used in communication with origin.</p> <p>This option defines the protocol that will be used by CDN servers to request content from an origin source. If not specified, we will use HTTP to connect to an origin server.</p> <ul> <li>HTTP: CDN servers will connect to your origin via HTTP.</li> <li>HTTPS: CDN servers will connect to your origin via HTTPS.</li> <li>MATCH: Connection protocol will be chosen automatically (content on the origin source should be available for the CDN both through HTTP and HTTPS).</li> </ul> 
resources[].<br>sslCertificate | **object**<br><p>SSL certificate options.</p> <p>A SSL certificate parameters.</p> 
resources[].<br>sslCertificate.<br>type | **string**<br><p>Type of the certificate.</p> <p>A certificate type parameters.</p> <ul> <li>SSL_CERTIFICATE_TYPE_UNSPECIFIED: SSL certificate is unspecified. - DONT_USE: No SSL certificate is added, the requests are sent via HTTP.</li> <li>LETS_ENCRYPT_GCORE: Works only if you have already pointed your domain name to the protected IP address in your DNS</li> <li>CM: Add your SSL certificate by uploading the certificate in PEM format and your private key</li> </ul> 
resources[].<br>sslCertificate.<br>status | **string**<br><p>Active status.</p> <p>A certificate status parameters.</p> <ul> <li>SSL_CERTIFICATE_STATUS_UNSPECIFIED: SSL certificate is unspecified. - READY: SSL certificate is ready to use.</li> <li>CREATING: SSL certificate is creating.</li> </ul> 
resources[].<br>sslCertificate.<br>data | **object**<br><p>Certificate data.</p> <p>A certificate data parameters.</p> 
resources[].<br>sslCertificate.<br>data.<br>cm | **object**<br>Custom (add your SSL certificate by uploading the certificate in PEM format and your private key).
resources[].<br>sslCertificate.<br>data.<br>cm.<br>id | **string**<br><p>ID of the custom certificate.</p> 
nextPageToken | **string**<br><p><a href="/docs/cdn/api-ref/Resource/list#responses">nextPageToken</a> token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/cdn/api-ref/Resource/list#query_params">pageSize</a>, use the <a href="/docs/cdn/api-ref/Resource/list#responses">nextPageToken</a> as the value for the <a href="/docs/cdn/api-ref/Resource/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/cdn/api-ref/Resource/list#responses">nextPageToken</a> to continue paging through the results.</p> 