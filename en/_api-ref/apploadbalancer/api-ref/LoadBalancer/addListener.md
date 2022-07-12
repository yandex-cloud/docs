---
editable: false
---

# Method addListener
Adds a listener to the specified application load balancer.
 

 
## HTTP request {#https-request}
```
POST https://alb.{{ api-host }}/apploadbalancer/v1/loadBalancers/{loadBalancerId}:addListener
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
loadBalancerId | <p>Required. ID of the application load balancer to add a listener to.</p> 
 
## Body parameters {#body_params}
 
```json 
{
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

    // `listenerSpec` includes only one of the fields `http`, `tls`, `stream`
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

        // `listenerSpec.tls.defaultHandler` includes only one of the fields `httpHandler`, `streamHandler`
        "httpHandler": {
          "httpRouterId": "string",

          // `listenerSpec.tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
          "http2Options": {
            "maxConcurrentStreams": "string"
          },
          "allowHttp10": true,
          // end of the list of possible fields`listenerSpec.tls.defaultHandler.httpHandler`

        },
        "streamHandler": {
          "backendGroupId": "string"
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
            "certificateIds": [
              "string"
            ],

            // `listenerSpec.tls.sniHandlers[].handler` includes only one of the fields `httpHandler`, `streamHandler`
            "httpHandler": {
              "httpRouterId": "string",

              // `listenerSpec.tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
              "http2Options": {
                "maxConcurrentStreams": "string"
              },
              "allowHttp10": true,
              // end of the list of possible fields`listenerSpec.tls.sniHandlers[].handler.httpHandler`

            },
            "streamHandler": {
              "backendGroupId": "string"
            },
            // end of the list of possible fields`listenerSpec.tls.sniHandlers[].handler`

          }
        }
      ]
    },
    "stream": {
      "handler": {
        "backendGroupId": "string"
      }
    },
    // end of the list of possible fields`listenerSpec`

  }
}
```

 
Field | Description
--- | ---
listenerSpec | **object**<br><p>Required. Listener to add to the application load balancer.</p> 
listenerSpec.<br>name | **string**<br><p>Required. Name of the listener. The name is unique within the application load balancer.</p> <p>Value must match the regular expression ``[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
listenerSpec.<br>endpointSpecs[] | **object**<br><p>Required. Endpoints of the listener.</p> <p>Endpoints are defined by their IP addresses and ports.</p> <p>Must contain at least one element.</p> 
listenerSpec.<br>endpointSpecs[].<br>addressSpecs[] | **object**<br><p>Required. Endpoint public (external) and internal addresses.</p> <p>Must contain at least one element.</p> 
listenerSpec.<br>endpointSpecs[].<br>addressSpecs[].<br>externalIpv4AddressSpec | **object**<br>Public IPv4 endpoint address. <br>`listenerSpec.endpointSpecs[].addressSpecs[]` includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`<br><br>
listenerSpec.<br>endpointSpecs[].<br>addressSpecs[].<br>externalIpv4AddressSpec.<br>address | **string**<br><p>IPv4 address.</p> 
listenerSpec.<br>endpointSpecs[].<br>addressSpecs[].<br>internalIpv4AddressSpec | **object**<br>Internal IPv4 endpoint address.  To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). <br>`listenerSpec.endpointSpecs[].addressSpecs[]` includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`<br><br>
listenerSpec.<br>endpointSpecs[].<br>addressSpecs[].<br>internalIpv4AddressSpec.<br>address | **string**<br><p>IPv4 address.</p> 
listenerSpec.<br>endpointSpecs[].<br>addressSpecs[].<br>internalIpv4AddressSpec.<br>subnetId | **string**<br><p>ID of the subnet that the address belongs to.</p> 
listenerSpec.<br>endpointSpecs[].<br>addressSpecs[].<br>externalIpv6AddressSpec | **object**<br>Public IPv6 endpoint address. <br>`listenerSpec.endpointSpecs[].addressSpecs[]` includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`<br><br>
listenerSpec.<br>endpointSpecs[].<br>addressSpecs[].<br>externalIpv6AddressSpec.<br>address | **string**<br><p>IPv6 address.</p> 
listenerSpec.<br>endpointSpecs[].<br>ports[] | **string** (int64)<br><p>Required. Endpoint ports.</p> <p>Must contain at least one element. Acceptable values are 1 to 65535, inclusive.</p> 
listenerSpec.<br>http | **object**<br>Unencrypted HTTP listener settings. <br>`listenerSpec` includes only one of the fields `http`, `tls`, `stream`<br><br><p>An HTTP listener resource.</p> 
listenerSpec.<br>http.<br>handler | **object**<br><p>Settings for handling HTTP requests.</p> <p>Only one of ``handler`` and ``redirects`` can be specified.</p> <p>An HTTP handler resource.</p> 
listenerSpec.<br>http.<br>handler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> <p>To get the list of all available HTTP routers, make a <a href="/docs/application-load-balancer/api-ref/HttpRouter/list">list</a> request.</p> 
listenerSpec.<br>http.<br>handler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`listenerSpec.http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>An HTTP/2 options resource.</p> 
listenerSpec.<br>http.<br>handler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
listenerSpec.<br>http.<br>handler.<br>allowHttp10 | **boolean** (boolean) <br>`listenerSpec.http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
listenerSpec.<br>http.<br>redirects | **object**<br><p>Redirects settings.</p> <p>Only one of ``redirects`` and ``handler`` can be specified.</p> <p>A listener redirects resource.</p> 
listenerSpec.<br>http.<br>redirects.<br>httpToHttps | **boolean** (boolean)<br><p>Redirects all unencrypted HTTP requests to the same URI with scheme changed to ``https``.</p> <p>The setting has the same effect as a single, catch-all ``HttpRoute`` with ``replaceScheme`` set to ``https``.</p> 
listenerSpec.<br>tls | **object**<br>TLS-encrypted HTTP or TCP stream listener settings.  All handlers within a listener (`defaultHandler` and `sniHandlers`) must be of one type, `HttpHandler` or `StreamHandler`. Mixing HTTP and TCP stream traffic in a TLS-encrypted listener is not supported. <br>`listenerSpec` includes only one of the fields `http`, `tls`, `stream`<br><br><p>TLS-encrypted (HTTP or TCP stream) listener resource.</p> 
listenerSpec.<br>tls.<br>defaultHandler | **object**<br><p>Required. Settings for handling requests by default, with Server Name Indication (SNI) not matching any of the ``sniHandlers``.</p> <p>A TLS-encrypted (HTTP or TCP stream) handler resource.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>certificateIds[] | **string**<br><p>Required. ID's of the TLS server certificates from <a href="/docs/certificate-manager/">Certificate Manager</a>.</p> <p>RSA and ECDSA certificates are supported, and only the first certificate of each type is used.</p> <p>Must contain at least one element.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>httpHandler | **object**<br>HTTP handler. <br>`listenerSpec.tls.defaultHandler` includes only one of the fields `httpHandler`, `streamHandler`<br><br><p>An HTTP handler resource.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>httpHandler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> <p>To get the list of all available HTTP routers, make a <a href="/docs/application-load-balancer/api-ref/HttpRouter/list">list</a> request.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`listenerSpec.tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>An HTTP/2 options resource.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`listenerSpec.tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>streamHandler | **object**<br>Stream (TCP) handler. <br>`listenerSpec.tls.defaultHandler` includes only one of the fields `httpHandler`, `streamHandler`<br><br><p>A stream (TCP) handler resource.</p> 
listenerSpec.<br>tls.<br>defaultHandler.<br>streamHandler.<br>backendGroupId | **string**<br><p>Required. ID of the backend group processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group">documentation</a>.</p> <p>The backend group type, specified via [BackendGroup.backend], must be ``stream``.</p> <p>To get the list of all available backend groups, make a <a href="/docs/application-load-balancer/api-ref/BackendGroup/list">list</a> request.</p> 
listenerSpec.<br>tls.<br>sniHandlers[] | **object**<br><p>Settings for handling requests with Server Name Indication (SNI) matching one of ``serverNames`` values.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>name | **string**<br><p>Required. Name of the SNI handler.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>serverNames[] | **string**<br><p>Required. Server names that are matched by the SNI handler.</p> <p>Must contain at least one element.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler | **object**<br><p>Required. Settings for handling requests with Server Name Indication (SNI) matching one of ``serverNames`` values.</p> <p>A TLS-encrypted (HTTP or TCP stream) handler resource.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>certificateIds[] | **string**<br><p>Required. ID's of the TLS server certificates from <a href="/docs/certificate-manager/">Certificate Manager</a>.</p> <p>RSA and ECDSA certificates are supported, and only the first certificate of each type is used.</p> <p>Must contain at least one element.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler | **object**<br>HTTP handler. <br>`listenerSpec.tls.sniHandlers[].handler` includes only one of the fields `httpHandler`, `streamHandler`<br><br><p>An HTTP handler resource.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> <p>To get the list of all available HTTP routers, make a <a href="/docs/application-load-balancer/api-ref/HttpRouter/list">list</a> request.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`listenerSpec.tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>An HTTP/2 options resource.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`listenerSpec.tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>streamHandler | **object**<br>Stream (TCP) handler. <br>`listenerSpec.tls.sniHandlers[].handler` includes only one of the fields `httpHandler`, `streamHandler`<br><br><p>A stream (TCP) handler resource.</p> 
listenerSpec.<br>tls.<br>sniHandlers[].<br>handler.<br>streamHandler.<br>backendGroupId | **string**<br><p>Required. ID of the backend group processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group">documentation</a>.</p> <p>The backend group type, specified via [BackendGroup.backend], must be ``stream``.</p> <p>To get the list of all available backend groups, make a <a href="/docs/application-load-balancer/api-ref/BackendGroup/list">list</a> request.</p> 
listenerSpec.<br>stream | **object**<br>Unencrypted stream (TCP) listener settings. <br>`listenerSpec` includes only one of the fields `http`, `tls`, `stream`<br><br><p>A stream (TCP) listener resource.</p> 
listenerSpec.<br>stream.<br>handler | **object**<br><p>Required. Settings for handling stream (TCP) requests.</p> <p>A stream (TCP) handler resource.</p> 
listenerSpec.<br>stream.<br>handler.<br>backendGroupId | **string**<br><p>Required. ID of the backend group processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group">documentation</a>.</p> <p>The backend group type, specified via [BackendGroup.backend], must be ``stream``.</p> <p>To get the list of all available backend groups, make a <a href="/docs/application-load-balancer/api-ref/BackendGroup/list">list</a> request.</p> 
 
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