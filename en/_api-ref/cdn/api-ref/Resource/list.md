---
editable: false
---

# Method list
List all client's CDN resources.
 

 
## HTTP request {#https-request}
```
GET https://cdn.api.cloud.yandex.net/cdn/v1/resources
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. Folder ID to request listing for.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/cdn/api-ref/Resource/list#query_params), the service returns a [nextPageToken](/docs/cdn/api-ref/Resource/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/cdn/api-ref/Resource/list#query_params) to the [nextPageToken](/docs/cdn/api-ref/Resource/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
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
resources[] | **object**<br><p>Resource - representation of providers resource.</p> 
resources[].<br>id | **string**<br><p>Resource id.</p> 
resources[].<br>folderId | **string**<br><p>Folder id.</p> 
resources[].<br>cname | **string**<br><p>CDN endpoint CNAME, must be unique among resources.</p> 
resources[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resources[].<br>updatedAt | **string** (date-time)<br><p>Update timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
resources[].<br>active | **boolean** (boolean)<br><p>Resource state.</p> 
resources[].<br>options | **object**<br><p>ResourceOptions major set of various Resource options.</p> 
resources[].<br>options.<br>disableCache | **object**<br>
resources[].<br>options.<br>disableCache.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>disableCache.<br>value | **boolean** (boolean)<br>
resources[].<br>options.<br>edgeCacheSettings | **object**<br>
resources[].<br>options.<br>edgeCacheSettings.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>edgeCacheSettings.<br>value | **object** <br>`resources[].options.edgeCacheSettings` includes only one of the fields `value`, `defaultValue`<br><br>
resources[].<br>options.<br>edgeCacheSettings.<br>value.<br>simpleValue | **string** (int64)<br>
resources[].<br>options.<br>edgeCacheSettings.<br>value.<br>customValues | **object**<br>
resources[].<br>options.<br>edgeCacheSettings.<br>defaultValue | **string** (int64) <br>`resources[].options.edgeCacheSettings` includes only one of the fields `value`, `defaultValue`<br><br>
resources[].<br>options.<br>browserCacheSettings | **object**<br>
resources[].<br>options.<br>browserCacheSettings.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>browserCacheSettings.<br>value | **string** (int64)<br>
resources[].<br>options.<br>cacheHttpHeaders | **object**<br>
resources[].<br>options.<br>cacheHttpHeaders.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>cacheHttpHeaders.<br>value[] | **string**<br>
resources[].<br>options.<br>queryParamsOptions | **object**<br>
resources[].<br>options.<br>queryParamsOptions.<br>ignoreQueryString | **object** <br>`resources[].options.queryParamsOptions` includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`<br><br>
resources[].<br>options.<br>queryParamsOptions.<br>ignoreQueryString.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>queryParamsOptions.<br>ignoreQueryString.<br>value | **boolean** (boolean)<br>
resources[].<br>options.<br>queryParamsOptions.<br>queryParamsWhitelist | **object** <br>`resources[].options.queryParamsOptions` includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`<br><br>
resources[].<br>options.<br>queryParamsOptions.<br>queryParamsWhitelist.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>queryParamsOptions.<br>queryParamsWhitelist.<br>value[] | **string**<br>
resources[].<br>options.<br>queryParamsOptions.<br>queryParamsBlacklist | **object** <br>`resources[].options.queryParamsOptions` includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`<br><br>
resources[].<br>options.<br>queryParamsOptions.<br>queryParamsBlacklist.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>queryParamsOptions.<br>queryParamsBlacklist.<br>value[] | **string**<br>
resources[].<br>options.<br>slice | **object**<br>
resources[].<br>options.<br>slice.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>slice.<br>value | **boolean** (boolean)<br>
resources[].<br>options.<br>compressionOptions | **object**<br>
resources[].<br>options.<br>compressionOptions.<br>fetchCompressed | **object** <br>`resources[].options.compressionOptions` includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`<br><br>
resources[].<br>options.<br>compressionOptions.<br>fetchCompressed.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>compressionOptions.<br>fetchCompressed.<br>value | **boolean** (boolean)<br>
resources[].<br>options.<br>compressionOptions.<br>gzipOn | **object** <br>`resources[].options.compressionOptions` includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`<br><br>
resources[].<br>options.<br>compressionOptions.<br>gzipOn.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>compressionOptions.<br>gzipOn.<br>value | **boolean** (boolean)<br>
resources[].<br>options.<br>compressionOptions.<br>brotliCompression | **object** <br>`resources[].options.compressionOptions` includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`<br><br>
resources[].<br>options.<br>compressionOptions.<br>brotliCompression.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>compressionOptions.<br>brotliCompression.<br>value[] | **string**<br>
resources[].<br>options.<br>redirectOptions | **object**<br>
resources[].<br>options.<br>redirectOptions.<br>redirectHttpToHttps | **object** <br>`resources[].options.redirectOptions` includes only one of the fields `redirectHttpToHttps`, `redirectHttpsToHttp`<br><br>
resources[].<br>options.<br>redirectOptions.<br>redirectHttpToHttps.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>redirectOptions.<br>redirectHttpToHttps.<br>value | **boolean** (boolean)<br>
resources[].<br>options.<br>redirectOptions.<br>redirectHttpsToHttp | **object** <br>`resources[].options.redirectOptions` includes only one of the fields `redirectHttpToHttps`, `redirectHttpsToHttp`<br><br>
resources[].<br>options.<br>redirectOptions.<br>redirectHttpsToHttp.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>redirectOptions.<br>redirectHttpsToHttp.<br>value | **boolean** (boolean)<br>
resources[].<br>options.<br>hostOptions | **object**<br>
resources[].<br>options.<br>hostOptions.<br>host | **object** <br>`resources[].options.hostOptions` includes only one of the fields `host`, `forwardHostHeader`<br><br>
resources[].<br>options.<br>hostOptions.<br>host.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>hostOptions.<br>host.<br>value | **string**<br>
resources[].<br>options.<br>hostOptions.<br>forwardHostHeader | **object** <br>`resources[].options.hostOptions` includes only one of the fields `host`, `forwardHostHeader`<br><br>
resources[].<br>options.<br>hostOptions.<br>forwardHostHeader.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>hostOptions.<br>forwardHostHeader.<br>value | **boolean** (boolean)<br>
resources[].<br>options.<br>staticHeaders | **object**<br>
resources[].<br>options.<br>staticHeaders.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>staticHeaders.<br>value | **object**<br>
resources[].<br>options.<br>cors | **object**<br>
resources[].<br>options.<br>cors.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>cors.<br>value[] | **string**<br>
resources[].<br>options.<br>stale | **object**<br>
resources[].<br>options.<br>stale.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>stale.<br>value[] | **string**<br>
resources[].<br>options.<br>allowedHttpMethods | **object**<br>
resources[].<br>options.<br>allowedHttpMethods.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>allowedHttpMethods.<br>value[] | **string**<br>
resources[].<br>options.<br>proxyCacheMethodsSet | **object**<br>
resources[].<br>options.<br>proxyCacheMethodsSet.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>proxyCacheMethodsSet.<br>value | **boolean** (boolean)<br>
resources[].<br>options.<br>disableProxyForceRanges | **object**<br>
resources[].<br>options.<br>disableProxyForceRanges.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>disableProxyForceRanges.<br>value | **boolean** (boolean)<br>
resources[].<br>options.<br>staticRequestHeaders | **object**<br>
resources[].<br>options.<br>staticRequestHeaders.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>staticRequestHeaders.<br>value | **object**<br>
resources[].<br>options.<br>customServerName | **object**<br>
resources[].<br>options.<br>customServerName.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>customServerName.<br>value | **string**<br>
resources[].<br>options.<br>ignoreCookie | **object**<br>
resources[].<br>options.<br>ignoreCookie.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>ignoreCookie.<br>value | **boolean** (boolean)<br>
resources[].<br>options.<br>rewrite | **object**<br>
resources[].<br>options.<br>rewrite.<br>enabled | **boolean** (boolean)<br>
resources[].<br>options.<br>rewrite.<br>body | **string**<br>
resources[].<br>options.<br>rewrite.<br>flag | **string**<br><p>RewriteFlag defines flag for the Rewrite option. Possible values are: last - stops processing of the current set of ngx_http_rewrite_module directives and starts a search for a new location matching changed URI. break - stops processing of the current set of the Rewrite option. redirect - returns a temporary redirect with the 302 code; It is used when a replacement string does not start with &quot;http://&quot;, &quot;https://&quot;, or &quot;$scheme&quot;. permanent - returns a permanent redirect with the 301 code.</p> 
resources[].<br>secondaryHostnames[] | **string**<br>
resources[].<br>originGroupId | **string** (int64)<br>
resources[].<br>originGroupName | **string**<br>
resources[].<br>originProtocol | **string**<br><p>This option defines the protocol that will be used by CDN servers to request content from an origin source. If not specified, we will use HTTP to connect to an origin server.</p> <p>Possible values are:</p> <pre>``HTTPS - CDN servers will connect to your origin via HTTPS. HTTP  - CDN servers will connect to your origin via HTTP. MATCH - Connection protocol will be chosen automatically (content on the         origin source should be available for the CDN both through HTTP and HTTPS).``</pre> 
resources[].<br>sslCertificate | **object**<br>
resources[].<br>sslCertificate.<br>type | **string**<br>
resources[].<br>sslCertificate.<br>status | **string**<br>
resources[].<br>sslCertificate.<br>data | **object**<br>
resources[].<br>sslCertificate.<br>data.<br>cm | **object**<br>
resources[].<br>sslCertificate.<br>data.<br>cm.<br>id | **string**<br>
nextPageToken | **string**<br><p><a href="/docs/cdn/api-ref/Resource/list#responses">nextPageToken</a> token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/cdn/api-ref/Resource/list#query_params">pageSize</a>, use the <a href="/docs/cdn/api-ref/Resource/list#responses">nextPageToken</a> as the value for the <a href="/docs/cdn/api-ref/Resource/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/cdn/api-ref/Resource/list#responses">nextPageToken</a> to continue paging through the results.</p> 