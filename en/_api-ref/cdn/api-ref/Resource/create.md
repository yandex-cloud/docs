---
editable: false
---

# Method create
Create client's CDN resource.
 

 
## HTTP request {#https-request}
```
POST https://cdn.api.cloud.yandex.net/cdn/v1/resources
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "cname": "string",
  "origin": {

    // `origin` includes only one of the fields `originGroupId`, `originSource`, `originSourceParams`
    "originGroupId": "string",
    "originSource": "string",
    "originSourceParams": {
      "source": "string",
      "meta": {

        // `origin.originSourceParams.meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`
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
        },
        // end of the list of possible fields`origin.originSourceParams.meta`

      }
    },
    // end of the list of possible fields`origin`

  },
  "secondaryHostnames": {
    "values": [
      "string"
    ]
  },
  "originProtocol": "string",
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
  "sslCertificate": {
    "type": "string",
    "data": {
      "cm": {
        "id": "string"
      }
    }
  }
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. Folder ID to bind with new resource.</p> <p>The maximum string length in characters is 50.</p> 
cname | **string**<br><p>Required. CDN endpoint CNAME, must be unique among clients's resources.</p> 
origin | **object**<br><p>Required. Specify the origins to be used for CDN resources requests.</p> 
origin.<br>originGroupId | **string** (int64) <br>`origin` includes only one of the fields `originGroupId`, `originSource`, `originSourceParams`<br><br><p>ID of pre-created origin group.</p> 
origin.<br>originSource | **string** <br>`origin` includes only one of the fields `originGroupId`, `originSource`, `originSourceParams`<br><br><p>Create new Origins group with single source, it's id will be returned in result.</p> 
origin.<br>originSourceParams | **object** <br>`origin` includes only one of the fields `originGroupId`, `originSource`, `originSourceParams`<br><br>
origin.<br>originSourceParams.<br>source | **string**<br>
origin.<br>originSourceParams.<br>meta | **object**<br>
origin.<br>originSourceParams.<br>meta.<br>common | **object** <br>`origin.originSourceParams.meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br>
origin.<br>originSourceParams.<br>meta.<br>common.<br>name | **string**<br>
origin.<br>originSourceParams.<br>meta.<br>bucket | **object** <br>`origin.originSourceParams.meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br>
origin.<br>originSourceParams.<br>meta.<br>bucket.<br>name | **string**<br>
origin.<br>originSourceParams.<br>meta.<br>website | **object** <br>`origin.originSourceParams.meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br>
origin.<br>originSourceParams.<br>meta.<br>website.<br>name | **string**<br>
origin.<br>originSourceParams.<br>meta.<br>balancer | **object** <br>`origin.originSourceParams.meta` includes only one of the fields `common`, `bucket`, `website`, `balancer`<br><br>
origin.<br>originSourceParams.<br>meta.<br>balancer.<br>id | **string**<br>
secondaryHostnames | **object**<br><p>List of additional CNAMEs.</p> <p>List of secondary (alternative) CNAMEs.</p> 
secondaryHostnames.<br>values[] | **string**<br>
originProtocol | **string**<br><p>Specify the protocol schema to be used in communication with origin .</p> <p>This option defines the protocol that will be used by CDN servers to request content from an origin source. If not specified, we will use HTTP to connect to an origin server.</p> <p>Possible values are:</p> <pre>``HTTPS - CDN servers will connect to your origin via HTTPS. HTTP  - CDN servers will connect to your origin via HTTP. MATCH - Connection protocol will be chosen automatically (content on the         origin source should be available for the CDN both through HTTP and HTTPS).``</pre> 
active | **boolean** (boolean)<br><p>Flag to create Resource either in active or disabled state. In active state Origins payload could be transmitted from CDN CNAME requests. Default value: true</p> 
options | **object**<br><p>Resource settings and options to tune CDN edge behavior. Most is unset.</p> <p>ResourceOptions major set of various Resource options.</p> 
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
sslCertificate | **object**<br><p>SSL Certificate options.</p> 
sslCertificate.<br>type | **string**<br>
sslCertificate.<br>data | **object**<br>
sslCertificate.<br>data.<br>cm | **object**<br>
sslCertificate.<br>data.<br>cm.<br>id | **string**<br>
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 