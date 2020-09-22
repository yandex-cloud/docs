---
editable: false
---

# Method addListener
AddListener/UpdateListener technically do the same, but have different semantics.
 

 
## HTTP request {#https-request}
```
POST https://apploadbalancer.api.cloud.yandex.net/apploadbalancer/v1/loadBalancers/{loadBalancerId}:addListener
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
loadBalancerId | Required.
 
## Body parameters {#body_params}
 
```json 
{
  "listenerSpec": {
    "name": "string",
    "port": "string",

    // `listenerSpec` includes only one of the fields `http`, `tls`
    "externalAddressSpec": {
      "address": "string",
      "ipVersion": "string"
    },
    "internalAddressSpec": {
      "address": "string",
      "subnetId": "string",
      "ipVersion": "string"
    },
    // end of the list of possible fields`listenerSpec`

    "http": {
      "handler": {
        "httpRouterId": "string",

        // `listenerSpec.http.handler` includes only one of the fields `http2Options`, `allowHttp10`
        "http2Options": {
          "maxConcurrentStreams": "string"
        },
        "allowHttp10": true,
        // end of the list of possible fields`listenerSpec.http.handler`

      }
    },
    "tls": {
      "defaultHandler": {
        "tls": {
          "certificateIds": [
            "string"
          ],
          "tlsOptions": {
            "tlsMinVersion": "string",
            "tlsMaxVersion": "string",
            "cipherSuites": [
              "string"
            ],
            "ecdhCurves": [
              "string"
            ]
          }
        },

        // `listenerSpec.tls.defaultHandler` includes only one of the fields `streamHandler`, `httpHandler`
        "streamHandler": {
          "backendGroupId": "string"
        },
        "httpHandler": {
          "httpRouterId": "string",

          // `listenerSpec.tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
          "http2Options": {
            "maxConcurrentStreams": "string"
          },
          "allowHttp10": true,
          // end of the list of possible fields`listenerSpec.tls.defaultHandler.httpHandler`

        },
        // end of the list of possible fields`listenerSpec.tls.defaultHandler`

      },
      "sniHandlers": [
        {
          "name": "string",
          "serverNames": [
            "string"
          ],
          "handler": {
            "tls": {
              "certificateIds": [
                "string"
              ],
              "tlsOptions": {
                "tlsMinVersion": "string",
                "tlsMaxVersion": "string",
                "cipherSuites": [
                  "string"
                ],
                "ecdhCurves": [
                  "string"
                ]
              }
            },

            // `listenerSpec.tls.sniHandlers[].handler` includes only one of the fields `streamHandler`, `httpHandler`
            "streamHandler": {
              "backendGroupId": "string"
            },
            "httpHandler": {
              "httpRouterId": "string",

              // `listenerSpec.tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
              "http2Options": {
                "maxConcurrentStreams": "string"
              },
              "allowHttp10": true,
              // end of the list of possible fields`listenerSpec.tls.sniHandlers[].handler.httpHandler`

            },
            // end of the list of possible fields`listenerSpec.tls.sniHandlers[].handler`

          }
        }
      ]
    }
  }
}
```

 
Field | Description
--- | ---
listenerSpec | **object**<br><p>Required.</p> 
listenerSpec.<br>name | **string**<br><p>Required. Value must match the regular expression <code>\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?</code>.</p> 
listenerSpec.<br>port | **string** (int64)<br><p>Acceptable values are 1 to 65535, inclusive.</p> 
listenerSpec.<br>externalAddressSpec | **object** <br>`listenerSpec` includes only one of the fields `externalAddressSpec`, `internalAddressSpec`<br><br>
listenerSpec.<br>externalAddressSpec.<br>address | **string**<br>
listenerSpec.<br>externalAddressSpec.<br>ipVersion | **string**<br><p>Required.</p> 
listenerSpec.<br>internalAddressSpec | **object** <br>`listenerSpec` includes only one of the fields `externalAddressSpec`, `internalAddressSpec`<br><br>
listenerSpec.<br>internalAddressSpec.<br>address | **string**<br>
listenerSpec.<br>internalAddressSpec.<br>subnetId | **string**<br>
listenerSpec.<br>internalAddressSpec.<br>ipVersion | **string**<br><p>Required.</p> 
listenerSpec.<br>http | **object** <br>`listenerSpec` includes only one of the fields `http`, `tls`<br><br>
listenerSpec.<br>http.<br>handler | **object**<br><p>Required.</p> 
listenerSpec.<br>http.<br>handler.<br>httpRouterId | **string**<br><p>Required.</p> 
listenerSpec.<br>http.<br>handler.<br>http2Options | **object** <br>`listenerSpec.http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br>
listenerSpec.<br>http.<br>handler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br>
listenerSpec.<br>http.<br>handler.<br>allowHttp10 | **boolean** (boolean) <br>`listenerSpec.http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br>
listenerSpec.<br>tls | **object** <br>`listenerSpec` includes only one of the fields `http`, `tls`<br><br>
listenerSpec.<br>tls.<br>defaultHandler | **object**<br><p>Required.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>tls | **object**<br>Required. <br>`listenerSpec` includes only one of the fields `http`, `tls`<br><br>
listenerSpec.<br>tls.<br>defaultHandler.<br>tls.<br>certificateIds[] | **string**<br><p>Required. Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used.</p> <p>Must contain at least one element.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>tls.<br>tlsOptions | **object**<br>
listenerSpec.<br>tls.<br>defaultHandler.<br>tls.<br>tlsOptions.<br>tlsMinVersion | **string**<br><p>Minimum TLS protocol version.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>tls.<br>tlsOptions.<br>tlsMaxVersion | **string**<br><p>Maximum TLS protocol version.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>tls.<br>tlsOptions.<br>cipherSuites[] | **string**<br><p>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>tls.<br>tlsOptions.<br>ecdhCurves[] | **string**<br><p>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>streamHandler | **object** <br>`listenerSpec.tls.defaultHandler` includes only one of the fields `streamHandler`, `httpHandler`<br><br>
listenerSpec.<br>tls.<br>defaultHandler.<br>streamHandler.<br>backendGroupId | **string**<br><p>Required.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>httpHandler | **object** <br>`listenerSpec.tls.defaultHandler` includes only one of the fields `streamHandler`, `httpHandler`<br><br>
listenerSpec.<br>tls.<br>defaultHandler.<br>httpHandler.<br>httpRouterId | **string**<br><p>Required.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options | **object** <br>`listenerSpec.tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br>
listenerSpec.<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br>
listenerSpec.<br>tls.<br>defaultHandler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`listenerSpec.tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br>
listenerSpec.<br>tls.<br>sniHandlers[] | **object**<br>
listenerSpec.<br>tls.<br>sniHandlers[].<br>name | **string**<br><p>Required.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>serverNames[] | **string**<br><p>Required. Must contain at least one element.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler | **object**<br><p>Required.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>tls | **object**<br>Required. <br>`listenerSpec` includes only one of the fields `http`, `tls`<br><br>
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>tls.<br>certificateIds[] | **string**<br><p>Required. Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used.</p> <p>Must contain at least one element.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>tls.<br>tlsOptions | **object**<br>
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>tls.<br>tlsOptions.<br>tlsMinVersion | **string**<br><p>Minimum TLS protocol version.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>tls.<br>tlsOptions.<br>tlsMaxVersion | **string**<br><p>Maximum TLS protocol version.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>tls.<br>tlsOptions.<br>cipherSuites[] | **string**<br><p>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>tls.<br>tlsOptions.<br>ecdhCurves[] | **string**<br><p>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>streamHandler | **object** <br>`listenerSpec.tls.sniHandlers[].handler` includes only one of the fields `streamHandler`, `httpHandler`<br><br>
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>streamHandler.<br>backendGroupId | **string**<br><p>Required.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler | **object** <br>`listenerSpec.tls.sniHandlers[].handler` includes only one of the fields `streamHandler`, `httpHandler`<br><br>
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>httpRouterId | **string**<br><p>Required.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options | **object** <br>`listenerSpec.tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br>
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br>
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`listenerSpec.tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br>
 
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
done | **boolean** (boolean)<br><p>If the value is <code>false</code>, it means the operation is still in progress. If <code>true</code>, the operation is completed, and either <code>error</code> or <code>response</code> is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 