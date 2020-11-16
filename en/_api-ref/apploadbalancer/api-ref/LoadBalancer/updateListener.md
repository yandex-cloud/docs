---
editable: false
---

# Method updateListener

 

 
## HTTP request {#https-request}
```
POST https://apploadbalancer.api.cloud.yandex.net/apploadbalancer/v1/loadBalancers/{loadBalancerId}:updateListener
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
loadBalancerId | Required.
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "listenerSpec": {
    "name": "string",
    "endpointSpecs": [
      {
        "addressSpecs": [
          {

            // `listenerSpec.endpointSpecs[].addressSpecs[]` includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`
            "externalIpv4AddressSpec": {
              "address": "string"
            },
            "internalIpv4AddressSpec": {
              "address": "string",
              "subnetId": "string"
            },
            "externalIpv6AddressSpec": {
              "address": "string"
            },
            // end of the list of possible fields`listenerSpec.endpointSpecs[].addressSpecs[]`

          }
        ],
        "ports": [
          "string"
        ]
      }
    ],

    // `listenerSpec` includes only one of the fields `http`, `tls`
    "http": {
      "handler": {
        "httpRouterId": "string",

        // `listenerSpec.http.handler` includes only one of the fields `http2Options`, `allowHttp10`
        "http2Options": {
          "maxConcurrentStreams": "string"
        },
        "allowHttp10": true,
        // end of the list of possible fields`listenerSpec.http.handler`

      },
      "redirects": {
        "httpToHttps": true
      }
    },
    "tls": {
      "defaultHandler": {
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
        },
        "httpHandler": {
          "httpRouterId": "string",

          // `listenerSpec.tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
          "http2Options": {
            "maxConcurrentStreams": "string"
          },
          "allowHttp10": true,
          // end of the list of possible fields`listenerSpec.tls.defaultHandler.httpHandler`

        }
      },
      "sniHandlers": [
        {
          "name": "string",
          "serverNames": [
            "string"
          ],
          "handler": {
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
            },
            "httpHandler": {
              "httpRouterId": "string",

              // `listenerSpec.tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
              "http2Options": {
                "maxConcurrentStreams": "string"
              },
              "allowHttp10": true,
              // end of the list of possible fields`listenerSpec.tls.sniHandlers[].handler.httpHandler`

            }
          }
        }
      ]
    },
    // end of the list of possible fields`listenerSpec`

  }
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in <code>updateMask</code> and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If <code>updateMask</code> is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
listenerSpec | **object**<br><p>Required.</p> 
listenerSpec.<br>name | **string**<br><p>Required. Value must match the regular expression <code>[a-z]([-a-z0-9]{0,61}[a-z0-9])?</code>.</p> 
listenerSpec.<br>endpointSpecs[] | **object**<br><p>Required. Must contain at least one element.</p> 
listenerSpec.<br>endpointSpecs[].<br>addressSpecs[] | **object**<br><p>Required. Must contain at least one element.</p> 
listenerSpec.<br>endpointSpecs[].<br>addressSpecs[].<br>externalIpv4AddressSpec | **object** <br>`listenerSpec.endpointSpecs[].addressSpecs[]` includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`<br><br>
listenerSpec.<br>endpointSpecs[].<br>addressSpecs[].<br>externalIpv4AddressSpec.<br>address | **string**<br>
listenerSpec.<br>endpointSpecs[].<br>addressSpecs[].<br>internalIpv4AddressSpec | **object** <br>`listenerSpec.endpointSpecs[].addressSpecs[]` includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`<br><br>
listenerSpec.<br>endpointSpecs[].<br>addressSpecs[].<br>internalIpv4AddressSpec.<br>address | **string**<br>
listenerSpec.<br>endpointSpecs[].<br>addressSpecs[].<br>internalIpv4AddressSpec.<br>subnetId | **string**<br>
listenerSpec.<br>endpointSpecs[].<br>addressSpecs[].<br>externalIpv6AddressSpec | **object** <br>`listenerSpec.endpointSpecs[].addressSpecs[]` includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`<br><br>
listenerSpec.<br>endpointSpecs[].<br>addressSpecs[].<br>externalIpv6AddressSpec.<br>address | **string**<br>
listenerSpec.<br>endpointSpecs[].<br>ports[] | **string** (int64)<br><p>Required. Must contain at least one element. Acceptable values are 1 to 65535, inclusive.</p> 
listenerSpec.<br>http | **object** <br>`listenerSpec` includes only one of the fields `http`, `tls`<br><br>
listenerSpec.<br>http.<br>handler | **object**<br><p>Sets plaintext HTTP router, optional.</p> 
listenerSpec.<br>http.<br>handler.<br>httpRouterId | **string**<br>
listenerSpec.<br>http.<br>handler.<br>http2Options | **object**<br>If set, will enable HTTP2 protocol for the handler. <br>`listenerSpec.http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br>
listenerSpec.<br>http.<br>handler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br>
listenerSpec.<br>http.<br>handler.<br>allowHttp10 | **boolean** (boolean) <br>`listenerSpec.http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>If set, will enable only HTTP1 protocol with HTTP1.0 support.</p> 
listenerSpec.<br>http.<br>redirects | **object**<br><p>Shortcut for adding http -&gt; https redirects, can be used instead of the HttpHandler above.</p> 
listenerSpec.<br>http.<br>redirects.<br>httpToHttps | **boolean** (boolean)<br><p>Adds &quot;*&quot; VirtualHost with a http -&gt; https redirect.</p> 
listenerSpec.<br>tls | **object** <br>`listenerSpec` includes only one of the fields `http`, `tls`<br><br>
listenerSpec.<br>tls.<br>defaultHandler | **object**<br><p>Required.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>certificateIds[] | **string**<br><p>Required. Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used.</p> <p>Must contain at least one element.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>tlsOptions | **object**<br>
listenerSpec.<br>tls.<br>defaultHandler.<br>tlsOptions.<br>tlsMinVersion | **string**<br><p>Minimum TLS protocol version.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>tlsOptions.<br>tlsMaxVersion | **string**<br><p>Maximum TLS protocol version.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>tlsOptions.<br>cipherSuites[] | **string**<br><p>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>tlsOptions.<br>ecdhCurves[] | **string**<br><p>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>httpHandler | **object**<br>
listenerSpec.<br>tls.<br>defaultHandler.<br>httpHandler.<br>httpRouterId | **string**<br>
listenerSpec.<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options | **object**<br>If set, will enable HTTP2 protocol for the handler. <br>`listenerSpec.tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br>
listenerSpec.<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br>
listenerSpec.<br>tls.<br>defaultHandler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`listenerSpec.tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>If set, will enable only HTTP1 protocol with HTTP1.0 support.</p> 
listenerSpec.<br>tls.<br>sniHandlers[] | **object**<br>
listenerSpec.<br>tls.<br>sniHandlers[].<br>name | **string**<br><p>Required.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>serverNames[] | **string**<br><p>Required. Must contain at least one element.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler | **object**<br><p>Required.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>certificateIds[] | **string**<br><p>Required. Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used.</p> <p>Must contain at least one element.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>tlsOptions | **object**<br>
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>tlsOptions.<br>tlsMinVersion | **string**<br><p>Minimum TLS protocol version.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>tlsOptions.<br>tlsMaxVersion | **string**<br><p>Maximum TLS protocol version.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>tlsOptions.<br>cipherSuites[] | **string**<br><p>If specified, the TLS listener will only support the specified cipher list when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not specified, the default list will be used.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>tlsOptions.<br>ecdhCurves[] | **string**<br><p>If specified, the TLS connection will only support the specified ECDH curves. If not specified, the default curves will be used.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler | **object**<br>
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>httpRouterId | **string**<br>
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options | **object**<br>If set, will enable HTTP2 protocol for the handler. <br>`listenerSpec.tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br>
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br>
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`listenerSpec.tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>If set, will enable only HTTP1 protocol with HTTP1.0 support.</p> 
 
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