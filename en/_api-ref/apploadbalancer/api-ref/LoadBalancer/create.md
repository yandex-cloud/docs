---
editable: false
---

# Method create
Creates an application load balancer in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://alb.api.cloud.yandex.net/apploadbalancer/v1/loadBalancers
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "regionId": "string",
  "networkId": "string",
  "listenerSpecs": [
    {
      "name": "string",
      "endpointSpecs": [
        {
          "addressSpecs": [
            {

              // `listenerSpecs[].endpointSpecs[].addressSpecs[]` includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`
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
              // end of the list of possible fields`listenerSpecs[].endpointSpecs[].addressSpecs[]`

            }
          ],
          "ports": [
            "string"
          ]
        }
      ],

      // `listenerSpecs[]` includes only one of the fields `http`, `tls`
      "http": {
        "handler": {
          "httpRouterId": "string",

          // `listenerSpecs[].http.handler` includes only one of the fields `http2Options`, `allowHttp10`
          "http2Options": {
            "maxConcurrentStreams": "string"
          },
          "allowHttp10": true,
          // end of the list of possible fields`listenerSpecs[].http.handler`

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

          // `listenerSpecs[].tls.defaultHandler` includes only one of the fields `httpHandler`, `streamHandler`
          "httpHandler": {
            "httpRouterId": "string",

            // `listenerSpecs[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
            "http2Options": {
              "maxConcurrentStreams": "string"
            },
            "allowHttp10": true,
            // end of the list of possible fields`listenerSpecs[].tls.defaultHandler.httpHandler`

          },
          "streamHandler": {
            "backendGroupId": "string"
          },
          // end of the list of possible fields`listenerSpecs[].tls.defaultHandler`

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

              // `listenerSpecs[].tls.sniHandlers[].handler` includes only one of the fields `httpHandler`, `streamHandler`
              "httpHandler": {
                "httpRouterId": "string",

                // `listenerSpecs[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
                "http2Options": {
                  "maxConcurrentStreams": "string"
                },
                "allowHttp10": true,
                // end of the list of possible fields`listenerSpecs[].tls.sniHandlers[].handler.httpHandler`

              },
              "streamHandler": {
                "backendGroupId": "string"
              },
              // end of the list of possible fields`listenerSpecs[].tls.sniHandlers[].handler`

            }
          }
        ]
      },
      // end of the list of possible fields`listenerSpecs[]`

    }
  ],
  "allocationPolicy": {
    "locations": [
      {
        "zoneId": "string",
        "subnetId": "string",
        "disableTraffic": true
      }
    ]
  },
  "securityGroupIds": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create an application load balancer in.</p> <p>To get the folder ID, make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
name | **string**<br><p>Name of the application load balancer. The name must be unique within the folder.</p> <p>Value must match the regular expression ``([a-z]([-a-z0-9]{0,61}[a-z0-9])?)?``.</p> 
description | **string**<br><p>Description of the application load balancer.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Application load balancer labels as ``key:value`` pairs. For details about the concept, see <a href="/docs/overview/concepts/services#labels">documentation</a>.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
regionId | **string**<br><p>Required. ID of the region that the application load balancer is located at.</p> <p>The only supported value is ``ru-central1``.</p> 
networkId | **string**<br><p>Required. ID of the network that the application load balancer belongs to.</p> 
listenerSpecs[] | **object**<br><p>Listeners that belong to the application load balancer.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#listener">documentation</a>.</p> 
listenerSpecs[].<br>name | **string**<br><p>Required. Name of the listener. The name is unique within the application load balancer.</p> <p>Value must match the regular expression ``[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
listenerSpecs[].<br>endpointSpecs[] | **object**<br><p>Required. Endpoints of the listener.</p> <p>Endpoints are defined by their IP addresses and ports.</p> <p>Must contain at least one element.</p> 
listenerSpecs[].<br>endpointSpecs[].<br>addressSpecs[] | **object**<br><p>Required. Endpoint public (external) and internal addresses.</p> <p>Must contain at least one element.</p> 
listenerSpecs[].<br>endpointSpecs[].<br>addressSpecs[].<br>externalIpv4AddressSpec | **object**<br>Public IPv4 endpoint address. <br>`listenerSpecs[].endpointSpecs[].addressSpecs[]` includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`<br><br>
listenerSpecs[].<br>endpointSpecs[].<br>addressSpecs[].<br>externalIpv4AddressSpec.<br>address | **string**<br><p>IPv4 address.</p> 
listenerSpecs[].<br>endpointSpecs[].<br>addressSpecs[].<br>internalIpv4AddressSpec | **object**<br>Internal IPv4 endpoint address.  To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). <br>`listenerSpecs[].endpointSpecs[].addressSpecs[]` includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`<br><br>
listenerSpecs[].<br>endpointSpecs[].<br>addressSpecs[].<br>internalIpv4AddressSpec.<br>address | **string**<br><p>IPv4 address.</p> 
listenerSpecs[].<br>endpointSpecs[].<br>addressSpecs[].<br>internalIpv4AddressSpec.<br>subnetId | **string**<br><p>ID of the subnet that the address belongs to.</p> 
listenerSpecs[].<br>endpointSpecs[].<br>addressSpecs[].<br>externalIpv6AddressSpec | **object**<br>Public IPv6 endpoint address. <br>`listenerSpecs[].endpointSpecs[].addressSpecs[]` includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`<br><br>
listenerSpecs[].<br>endpointSpecs[].<br>addressSpecs[].<br>externalIpv6AddressSpec.<br>address | **string**<br><p>IPv6 address.</p> 
listenerSpecs[].<br>endpointSpecs[].<br>ports[] | **string** (int64)<br><p>Required. Endpoint ports.</p> <p>Must contain at least one element. Acceptable values are 1 to 65535, inclusive.</p> 
listenerSpecs[].<br>http | **object**<br>HTTP listener settings. <br>`listenerSpecs[]` includes only one of the fields `http`, `tls`<br><br><p>An HTTP listener resource.</p> 
listenerSpecs[].<br>http.<br>handler | **object**<br><p>Settings for handling HTTP requests.</p> <p>Only one of ``handler`` and ``redirects`` can be specified.</p> <p>An HTTP handler resource.</p> 
listenerSpecs[].<br>http.<br>handler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> 
listenerSpecs[].<br>http.<br>handler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`listenerSpecs[].http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>An HTTP/2 options resource.</p> 
listenerSpecs[].<br>http.<br>handler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
listenerSpecs[].<br>http.<br>handler.<br>allowHttp10 | **boolean** (boolean) <br>`listenerSpecs[].http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
listenerSpecs[].<br>http.<br>redirects | **object**<br><p>Redirects settings.</p> <p>Only one of ``redirects`` and ``handler`` can be specified.</p> <p>A listener redirects resource.</p> 
listenerSpecs[].<br>http.<br>redirects.<br>httpToHttps | **boolean** (boolean)<br><p>Redirects all unencrypted HTTP requests to the same URI with scheme changed to ``https``.</p> <p>The setting has the same effect as a single, catch-all ``HttpRoute`` with ``replaceScheme`` set to ``https``.</p> 
listenerSpecs[].<br>tls | **object**<br>HTTPS (HTTP over TLS) listener settings. <br>`listenerSpecs[]` includes only one of the fields `http`, `tls`<br><br><p>An HTTPS (HTTP over TLS) listener resource.</p> 
listenerSpecs[].<br>tls.<br>defaultHandler | **object**<br><p>Required. Settings for handling HTTPS requests by default, with Server Name Indication (SNI) not matching any of the ``sniHandlers``.</p> <p>An HTTPS (HTTP over TLS) handler resource.</p> 
listenerSpecs[].<br>tls.<br>defaultHandler.<br>certificateIds[] | **string**<br><p>Required. ID's of the TLS server certificates from <a href="/docs/certificate-manager/">Certificate Manager</a>.</p> <p>RSA and ECDSA certificates are supported, and only the first certificate of each type is used.</p> <p>Must contain at least one element.</p> 
listenerSpecs[].<br>tls.<br>defaultHandler.<br>httpHandler | **object**<br>HTTP handler. <br>`listenerSpecs[].tls.defaultHandler` includes only one of the fields `httpHandler`, `streamHandler`<br><br><p>An HTTP handler resource.</p> 
listenerSpecs[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> 
listenerSpecs[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`listenerSpecs[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>An HTTP/2 options resource.</p> 
listenerSpecs[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
listenerSpecs[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`listenerSpecs[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
listenerSpecs[].<br>tls.<br>defaultHandler.<br>streamHandler | **object**<br>Stream handler <br>`listenerSpecs[].tls.defaultHandler` includes only one of the fields `httpHandler`, `streamHandler`<br><br><p>A stream handler resource.</p> 
listenerSpecs[].<br>tls.<br>defaultHandler.<br>streamHandler.<br>backendGroupId | **string**<br><p>Required.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[] | **object**<br><p>A SNI handler resource.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>name | **string**<br><p>Required. Name of the SNI handler.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>serverNames[] | **string**<br><p>Required. Server names that are matched by the SNI handler.</p> <p>Must contain at least one element.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler | **object**<br><p>Required. Settings for handling requests with Server Name Indication (SNI) matching one of ``serverNames`` values.</p> <p>An HTTPS (HTTP over TLS) handler resource.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler.<br>certificateIds[] | **string**<br><p>Required. ID's of the TLS server certificates from <a href="/docs/certificate-manager/">Certificate Manager</a>.</p> <p>RSA and ECDSA certificates are supported, and only the first certificate of each type is used.</p> <p>Must contain at least one element.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler | **object**<br>HTTP handler. <br>`listenerSpecs[].tls.sniHandlers[].handler` includes only one of the fields `httpHandler`, `streamHandler`<br><br><p>An HTTP handler resource.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`listenerSpecs[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>An HTTP/2 options resource.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`listenerSpecs[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler.<br>streamHandler | **object**<br>Stream handler <br>`listenerSpecs[].tls.sniHandlers[].handler` includes only one of the fields `httpHandler`, `streamHandler`<br><br><p>A stream handler resource.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler.<br>streamHandler.<br>backendGroupId | **string**<br><p>Required.</p> 
allocationPolicy | **object**<br><p>Locality settings of the application load balancer.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#lb-location">documentation</a>.</p> <p>A locality settings (allocation policy) resource.</p> 
allocationPolicy.<br>locations[] | **object**<br><p>An application load balancer location resource.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#lb-location">documentation</a>.</p> 
allocationPolicy.<br>locations[].<br>zoneId | **string**<br><p>Required. ID of the availability zone where the application load balancer resides.</p> <p>Each Yandex Cloud availability zone can only be specified once.</p> 
allocationPolicy.<br>locations[].<br>subnetId | **string**<br><p>ID of the subnet that the application load balancer belongs to.</p> 
allocationPolicy.<br>locations[].<br>disableTraffic | **boolean** (boolean)<br><p>Disables the load balancer node in the specified availability zone.</p> <p>Backends in the availability zone are not directly affected by this setting. They still may receive traffic from the load balancer nodes in other availability zones, subject to ``localityAwareRoutingPercent`` and ``strictLocality`` settings.</p> 
securityGroupIds[] | **string**<br><p>ID's of the security groups attributed to the application load balancer.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#security-groups">documentation</a>.</p> 
 
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