---
editable: false
---

# Method get
Get client's CDN resource by resource id.
 

 
## HTTP request {#https-request}
```
GET https://cdn.api.cloud.yandex.net/cdn/v1/resources/{resourceId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
resourceId | Required. Requested resourc  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
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

      // `options.edgeCacheSettings` includes only one of the fields `value`, `defaultValue`
      "value": {
        "simpleValue": "string",
        "customValues": "object"
      },
      "defaultValue": "string",
      // end of the list of possible fields`options.edgeCacheSettings`

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

      // `options.queryParamsOptions` includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`
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
      // end of the list of possible fields`options.queryParamsOptions`

    },
    "slice": {
      "enabled": true,
      "value": true
    },
    "compressionOptions": {

      // `options.compressionOptions` includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`
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
      // end of the list of possible fields`options.compressionOptions`

    },
    "redirectOptions": {

      // `options.redirectOptions` includes only one of the fields `redirectHttpToHttps`, `redirectHttpsToHttp`
      "redirectHttpToHttps": {
        "enabled": true,
        "value": true
      },
      "redirectHttpsToHttp": {
        "enabled": true,
        "value": true
      },
      // end of the list of possible fields`options.redirectOptions`

    },
    "hostOptions": {

      // `options.hostOptions` includes only one of the fields `host`, `forwardHostHeader`
      "host": {
        "enabled": true,
        "value": "string"
      },
      "forwardHostHeader": {
        "enabled": true,
        "value": true
      },
      // end of the list of possible fields`options.hostOptions`

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
```
Resource - representation of providers resource.
 
Field | Description
--- | ---
id | **string**<br><p>Resource id.</p> 
folderId | **string**<br><p>Folder id.</p> 
cname | **string**<br><p>CDN endpoint CNAME, must be unique among resources.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
updatedAt | **string** (date-time)<br><p>Update timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
active | **boolean** (boolean)<br><p>Resource state.</p> 
options | **object**<br><p>ResourceOptions major set of various Resource options.</p> 
options.<br>disableCache | **object**<br>
options.<br>disableCache.<br>enabled | **boolean** (boolean)<br>
options.<br>disableCache.<br>value | **boolean** (boolean)<br>
options.<br>edgeCacheSettings | **object**<br>
options.<br>edgeCacheSettings.<br>enabled | **boolean** (boolean)<br>
options.<br>edgeCacheSettings.<br>value | **object** <br>`options.edgeCacheSettings` includes only one of the fields `value`, `defaultValue`<br><br>
options.<br>edgeCacheSettings.<br>value.<br>simpleValue | **string** (int64)<br>
options.<br>edgeCacheSettings.<br>value.<br>customValues | **object**<br>
options.<br>edgeCacheSettings.<br>defaultValue | **string** (int64) <br>`options.edgeCacheSettings` includes only one of the fields `value`, `defaultValue`<br><br>
options.<br>browserCacheSettings | **object**<br>
options.<br>browserCacheSettings.<br>enabled | **boolean** (boolean)<br>
options.<br>browserCacheSettings.<br>value | **string** (int64)<br>
options.<br>cacheHttpHeaders | **object**<br>
options.<br>cacheHttpHeaders.<br>enabled | **boolean** (boolean)<br>
options.<br>cacheHttpHeaders.<br>value[] | **string**<br>
options.<br>queryParamsOptions | **object**<br>
options.<br>queryParamsOptions.<br>ignoreQueryString | **object** <br>`options.queryParamsOptions` includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`<br><br>
options.<br>queryParamsOptions.<br>ignoreQueryString.<br>enabled | **boolean** (boolean)<br>
options.<br>queryParamsOptions.<br>ignoreQueryString.<br>value | **boolean** (boolean)<br>
options.<br>queryParamsOptions.<br>queryParamsWhitelist | **object** <br>`options.queryParamsOptions` includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`<br><br>
options.<br>queryParamsOptions.<br>queryParamsWhitelist.<br>enabled | **boolean** (boolean)<br>
options.<br>queryParamsOptions.<br>queryParamsWhitelist.<br>value[] | **string**<br>
options.<br>queryParamsOptions.<br>queryParamsBlacklist | **object** <br>`options.queryParamsOptions` includes only one of the fields `ignoreQueryString`, `queryParamsWhitelist`, `queryParamsBlacklist`<br><br>
options.<br>queryParamsOptions.<br>queryParamsBlacklist.<br>enabled | **boolean** (boolean)<br>
options.<br>queryParamsOptions.<br>queryParamsBlacklist.<br>value[] | **string**<br>
options.<br>slice | **object**<br>
options.<br>slice.<br>enabled | **boolean** (boolean)<br>
options.<br>slice.<br>value | **boolean** (boolean)<br>
options.<br>compressionOptions | **object**<br>
options.<br>compressionOptions.<br>fetchCompressed | **object** <br>`options.compressionOptions` includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`<br><br>
options.<br>compressionOptions.<br>fetchCompressed.<br>enabled | **boolean** (boolean)<br>
options.<br>compressionOptions.<br>fetchCompressed.<br>value | **boolean** (boolean)<br>
options.<br>compressionOptions.<br>gzipOn | **object** <br>`options.compressionOptions` includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`<br><br>
options.<br>compressionOptions.<br>gzipOn.<br>enabled | **boolean** (boolean)<br>
options.<br>compressionOptions.<br>gzipOn.<br>value | **boolean** (boolean)<br>
options.<br>compressionOptions.<br>brotliCompression | **object** <br>`options.compressionOptions` includes only one of the fields `fetchCompressed`, `gzipOn`, `brotliCompression`<br><br>
options.<br>compressionOptions.<br>brotliCompression.<br>enabled | **boolean** (boolean)<br>
options.<br>compressionOptions.<br>brotliCompression.<br>value[] | **string**<br>
options.<br>redirectOptions | **object**<br>
options.<br>redirectOptions.<br>redirectHttpToHttps | **object** <br>`options.redirectOptions` includes only one of the fields `redirectHttpToHttps`, `redirectHttpsToHttp`<br><br>
options.<br>redirectOptions.<br>redirectHttpToHttps.<br>enabled | **boolean** (boolean)<br>
options.<br>redirectOptions.<br>redirectHttpToHttps.<br>value | **boolean** (boolean)<br>
options.<br>redirectOptions.<br>redirectHttpsToHttp | **object** <br>`options.redirectOptions` includes only one of the fields `redirectHttpToHttps`, `redirectHttpsToHttp`<br><br>
options.<br>redirectOptions.<br>redirectHttpsToHttp.<br>enabled | **boolean** (boolean)<br>
options.<br>redirectOptions.<br>redirectHttpsToHttp.<br>value | **boolean** (boolean)<br>
options.<br>hostOptions | **object**<br>
options.<br>hostOptions.<br>host | **object** <br>`options.hostOptions` includes only one of the fields `host`, `forwardHostHeader`<br><br>
options.<br>hostOptions.<br>host.<br>enabled | **boolean** (boolean)<br>
options.<br>hostOptions.<br>host.<br>value | **string**<br>
options.<br>hostOptions.<br>forwardHostHeader | **object** <br>`options.hostOptions` includes only one of the fields `host`, `forwardHostHeader`<br><br>
options.<br>hostOptions.<br>forwardHostHeader.<br>enabled | **boolean** (boolean)<br>
options.<br>hostOptions.<br>forwardHostHeader.<br>value | **boolean** (boolean)<br>
options.<br>staticHeaders | **object**<br>
options.<br>staticHeaders.<br>enabled | **boolean** (boolean)<br>
options.<br>staticHeaders.<br>value | **object**<br>
options.<br>cors | **object**<br>
options.<br>cors.<br>enabled | **boolean** (boolean)<br>
options.<br>cors.<br>value[] | **string**<br>
options.<br>stale | **object**<br>
options.<br>stale.<br>enabled | **boolean** (boolean)<br>
options.<br>stale.<br>value[] | **string**<br>
options.<br>allowedHttpMethods | **object**<br>
options.<br>allowedHttpMethods.<br>enabled | **boolean** (boolean)<br>
options.<br>allowedHttpMethods.<br>value[] | **string**<br>
options.<br>proxyCacheMethodsSet | **object**<br>
options.<br>proxyCacheMethodsSet.<br>enabled | **boolean** (boolean)<br>
options.<br>proxyCacheMethodsSet.<br>value | **boolean** (boolean)<br>
options.<br>disableProxyForceRanges | **object**<br>
options.<br>disableProxyForceRanges.<br>enabled | **boolean** (boolean)<br>
options.<br>disableProxyForceRanges.<br>value | **boolean** (boolean)<br>
options.<br>staticRequestHeaders | **object**<br>
options.<br>staticRequestHeaders.<br>enabled | **boolean** (boolean)<br>
options.<br>staticRequestHeaders.<br>value | **object**<br>
options.<br>customServerName | **object**<br>
options.<br>customServerName.<br>enabled | **boolean** (boolean)<br>
options.<br>customServerName.<br>value | **string**<br>
options.<br>ignoreCookie | **object**<br>
options.<br>ignoreCookie.<br>enabled | **boolean** (boolean)<br>
options.<br>ignoreCookie.<br>value | **boolean** (boolean)<br>
options.<br>rewrite | **object**<br>
options.<br>rewrite.<br>enabled | **boolean** (boolean)<br>
options.<br>rewrite.<br>body | **string**<br>
options.<br>rewrite.<br>flag | **string**<br><p>RewriteFlag defines flag for the Rewrite option. Possible values are: last - stops processing of the current set of ngx_http_rewrite_module directives and starts a search for a new location matching changed URI. break - stops processing of the current set of the Rewrite option. redirect - returns a temporary redirect with the 302 code; It is used when a replacement string does not start with &quot;http://&quot;, &quot;https://&quot;, or &quot;$scheme&quot;. permanent - returns a permanent redirect with the 301 code.</p> 
secondaryHostnames[] | **string**<br>
originGroupId | **string** (int64)<br>
originGroupName | **string**<br>
originProtocol | **string**<br><p>This option defines the protocol that will be used by CDN servers to request content from an origin source. If not specified, we will use HTTP to connect to an origin server.</p> <p>Possible values are:</p> <pre>``HTTPS - CDN servers will connect to your origin via HTTPS. HTTP  - CDN servers will connect to your origin via HTTP. MATCH - Connection protocol will be chosen automatically (content on the         origin source should be available for the CDN both through HTTP and HTTPS).``</pre> 
sslCertificate | **object**<br>
sslCertificate.<br>type | **string**<br>
sslCertificate.<br>status | **string**<br>
sslCertificate.<br>data | **object**<br>
sslCertificate.<br>data.<br>cm | **object**<br>
sslCertificate.<br>data.<br>cm.<br>id | **string**<br>