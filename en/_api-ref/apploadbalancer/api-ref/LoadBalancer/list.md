---
editable: false
---

# Method list
Lists application load balancers in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://alb.api.cloud.yandex.net/apploadbalancer/v1/loadBalancers
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list application load balancers in.  To get the folder ID, make a [list](/docs/resource-manager/api-ref/Folder/list) request.
pageSize | The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/application-load-balancer/api-ref/LoadBalancer/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/application-load-balancer/api-ref/LoadBalancer/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters application load balancers listed in the response.  The expression must specify: 1. The field name. Currently you can use filtering only on [LoadBalancer.name](/docs/application-load-balancer/api-ref/LoadBalancer#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. Example of a filter: `name=my-load-balancer`.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "loadBalancers": [
    {
      "id": "string",
      "name": "string",
      "description": "string",
      "folderId": "string",
      "labels": "object",
      "status": "string",
      "regionId": "string",
      "networkId": "string",
      "listeners": [
        {
          "name": "string",
          "endpoints": [
            {
              "addresses": [
                {

                  // `loadBalancers[].listeners[].endpoints[].addresses[]` includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`
                  "externalIpv4Address": {
                    "address": "string"
                  },
                  "internalIpv4Address": {
                    "address": "string",
                    "subnetId": "string"
                  },
                  "externalIpv6Address": {
                    "address": "string"
                  },
                  // end of the list of possible fields`loadBalancers[].listeners[].endpoints[].addresses[]`

                }
              ],
              "ports": [
                "string"
              ]
            }
          ],

          // `loadBalancers[].listeners[]` includes only one of the fields `http`, `tls`, `tcp`
          "http": {
            "handler": {
              "httpRouterId": "string",

              // `loadBalancers[].listeners[].http.handler` includes only one of the fields `http2Options`, `allowHttp10`
              "http2Options": {
                "maxConcurrentStreams": "string"
              },
              "allowHttp10": true,
              // end of the list of possible fields`loadBalancers[].listeners[].http.handler`

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

              // `loadBalancers[].listeners[].tls.defaultHandler` includes only one of the fields `httpHandler`, `streamHandler`
              "httpHandler": {
                "httpRouterId": "string",

                // `loadBalancers[].listeners[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
                "http2Options": {
                  "maxConcurrentStreams": "string"
                },
                "allowHttp10": true,
                // end of the list of possible fields`loadBalancers[].listeners[].tls.defaultHandler.httpHandler`

              },
              "streamHandler": {
                "backendGroupId": "string"
              },
              // end of the list of possible fields`loadBalancers[].listeners[].tls.defaultHandler`

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

                  // `loadBalancers[].listeners[].tls.sniHandlers[].handler` includes only one of the fields `httpHandler`, `streamHandler`
                  "httpHandler": {
                    "httpRouterId": "string",

                    // `loadBalancers[].listeners[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
                    "http2Options": {
                      "maxConcurrentStreams": "string"
                    },
                    "allowHttp10": true,
                    // end of the list of possible fields`loadBalancers[].listeners[].tls.sniHandlers[].handler.httpHandler`

                  },
                  "streamHandler": {
                    "backendGroupId": "string"
                  },
                  // end of the list of possible fields`loadBalancers[].listeners[].tls.sniHandlers[].handler`

                }
              }
            ]
          },
          "tcp": {
            "handler": {
              "backendGroupId": "string"
            }
          },
          // end of the list of possible fields`loadBalancers[].listeners[]`

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
      "logGroupId": "string",
      "securityGroupIds": [
        "string"
      ],
      "createdAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
loadBalancers[] | **object**<br><p>An application load balancer resource. For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer">documentation</a>.</p> 
loadBalancers[].<br>id | **string**<br><p>ID of the application load balancer. Generated at creation time.</p> 
loadBalancers[].<br>name | **string**<br><p>Name of the application load balancer. The name is unique within the folder.</p> 
loadBalancers[].<br>description | **string**<br><p>Description of the application load balancer.</p> 
loadBalancers[].<br>folderId | **string**<br><p>ID of the folder that the application load balancer belongs to.</p> 
loadBalancers[].<br>labels | **object**<br><p>Application load balancer labels as ``key:value`` pairs. For details about the concept, see <a href="/docs/overview/concepts/services#labels">documentation</a>.</p> 
loadBalancers[].<br>status | **string**<br><p>Status of the application load balancer.</p> <ul> <li>CREATING: The application load balancer is being created.</li> <li>STARTING: The application load balancer is being started.</li> <li>ACTIVE: The application load balancer is active and sends traffic to the targets.</li> <li>STOPPING: The application load balancer is being stopped.</li> <li>STOPPED: The application load balancer is stopped and doesn't send traffic to the targets.</li> <li>DELETING: The application load balancer is being deleted.</li> </ul> 
loadBalancers[].<br>regionId | **string**<br><p>ID of the region that the application load balancer is located at.</p> <p>Currently Yandex Cloud supports only ``ru-central1`` region.</p> 
loadBalancers[].<br>networkId | **string**<br><p>ID of the network that the application load balancer belongs to.</p> 
loadBalancers[].<br>listeners[] | **object**<br><p>A listener resource.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#listener">documentation</a>.</p> 
loadBalancers[].<br>listeners[].<br>name | **string**<br><p>Required. Name of the listener. The name is unique within the application load balancer. The string length in characters is 3-63.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[] | **object**<br><p>An endpoint resource.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[] | **object**<br><p>An endpoint address resource.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv4Address | **object**<br>Public IPv4 endpoint address. <br>`loadBalancers[].listeners[].endpoints[].addresses[]` includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`<br><br><p>A public (external) IPv4 endpoint address resource.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv4Address.<br>address | **string**<br><p>IPv4 address.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>internalIpv4Address | **object**<br>Internal IPv4 endpoint address.  To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). <br>`loadBalancers[].listeners[].endpoints[].addresses[]` includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`<br><br><p>An internal IPv4 endpoint address resource.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>internalIpv4Address.<br>address | **string**<br><p>IPv4 address.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>internalIpv4Address.<br>subnetId | **string**<br><p>ID of the subnet that the address belongs to.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv6Address | **object**<br>Public IPv6 endpoint address. <br>`loadBalancers[].listeners[].endpoints[].addresses[]` includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`<br><br><p>A public (external) IPv4 endpoint address resource.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv6Address.<br>address | **string**<br><p>IPv6 address.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[].<br>ports[] | **string** (int64)<br><p>Required. Endpoint ports.</p> <p>Must contain at least one element. Acceptable values are 1 to 65535, inclusive.</p> 
loadBalancers[].<br>listeners[].<br>http | **object**<br>HTTP listener settings. <br>`loadBalancers[].listeners[]` includes only one of the fields `http`, `tls`, `tcp`<br><br><p>An HTTP listener resource.</p> 
loadBalancers[].<br>listeners[].<br>http.<br>handler | **object**<br><p>Settings for handling HTTP requests.</p> <p>Only one of ``handler`` and ``redirects`` can be specified.</p> <p>An HTTP handler resource.</p> 
loadBalancers[].<br>listeners[].<br>http.<br>handler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> 
loadBalancers[].<br>listeners[].<br>http.<br>handler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`loadBalancers[].listeners[].http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>An HTTP/2 options resource.</p> 
loadBalancers[].<br>listeners[].<br>http.<br>handler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
loadBalancers[].<br>listeners[].<br>http.<br>handler.<br>allowHttp10 | **boolean** (boolean) <br>`loadBalancers[].listeners[].http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
loadBalancers[].<br>listeners[].<br>http.<br>redirects | **object**<br><p>Redirects settings.</p> <p>Only one of ``redirects`` and ``handler`` can be specified.</p> <p>A listener redirects resource.</p> 
loadBalancers[].<br>listeners[].<br>http.<br>redirects.<br>httpToHttps | **boolean** (boolean)<br><p>Redirects all unencrypted HTTP requests to the same URI with scheme changed to ``https``.</p> <p>The setting has the same effect as a single, catch-all ``HttpRoute`` with ``replaceScheme`` set to ``https``.</p> 
loadBalancers[].<br>listeners[].<br>tls | **object**<br>HTTPS (HTTP over TLS) listener settings. <br>`loadBalancers[].listeners[]` includes only one of the fields `http`, `tls`, `tcp`<br><br><p>An HTTPS (HTTP over TLS) listener resource.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler | **object**<br><p>Required. Settings for handling HTTPS requests by default, with Server Name Indication (SNI) not matching any of the ``sniHandlers``.</p> <p>An HTTPS (HTTP over TLS) handler resource.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>certificateIds[] | **string**<br><p>Required. ID's of the TLS server certificates from <a href="/docs/certificate-manager/">Certificate Manager</a>.</p> <p>RSA and ECDSA certificates are supported, and only the first certificate of each type is used.</p> <p>Must contain at least one element.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>httpHandler | **object**<br>HTTP handler. <br>`loadBalancers[].listeners[].tls.defaultHandler` includes only one of the fields `httpHandler`, `streamHandler`<br><br><p>An HTTP handler resource.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`loadBalancers[].listeners[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>An HTTP/2 options resource.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`loadBalancers[].listeners[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>streamHandler | **object**<br>Stream handler <br>`loadBalancers[].listeners[].tls.defaultHandler` includes only one of the fields `httpHandler`, `streamHandler`<br><br><p>A stream handler resource.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>streamHandler.<br>backendGroupId | **string**<br><p>Required.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[] | **object**<br><p>A SNI handler resource.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>name | **string**<br><p>Required. Name of the SNI handler.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>serverNames[] | **string**<br><p>Required. Server names that are matched by the SNI handler.</p> <p>Must contain at least one element.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler | **object**<br><p>Required. Settings for handling requests with Server Name Indication (SNI) matching one of ``serverNames`` values.</p> <p>An HTTPS (HTTP over TLS) handler resource.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>certificateIds[] | **string**<br><p>Required. ID's of the TLS server certificates from <a href="/docs/certificate-manager/">Certificate Manager</a>.</p> <p>RSA and ECDSA certificates are supported, and only the first certificate of each type is used.</p> <p>Must contain at least one element.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler | **object**<br>HTTP handler. <br>`loadBalancers[].listeners[].tls.sniHandlers[].handler` includes only one of the fields `httpHandler`, `streamHandler`<br><br><p>An HTTP handler resource.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`loadBalancers[].listeners[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>An HTTP/2 options resource.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`loadBalancers[].listeners[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>streamHandler | **object**<br>Stream handler <br>`loadBalancers[].listeners[].tls.sniHandlers[].handler` includes only one of the fields `httpHandler`, `streamHandler`<br><br><p>A stream handler resource.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>streamHandler.<br>backendGroupId | **string**<br><p>Required.</p> 
loadBalancers[].<br>listeners[].<br>tcp | **object**<br>TCP listener settings. <br>`loadBalancers[].listeners[]` includes only one of the fields `http`, `tls`, `tcp`<br><br><p>A TCP listener resource.</p> 
loadBalancers[].<br>listeners[].<br>tcp.<br>handler | **object**<br><p>A stream handler resource.</p> 
loadBalancers[].<br>listeners[].<br>tcp.<br>handler.<br>backendGroupId | **string**<br><p>Required.</p> 
loadBalancers[].<br>allocationPolicy | **object**<br><p>Locality settings of the application load balancer.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#lb-location">documentation</a>.</p> <p>A locality settings (allocation policy) resource.</p> 
loadBalancers[].<br>allocationPolicy.<br>locations[] | **object**<br><p>An application load balancer location resource.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#lb-location">documentation</a>.</p> 
loadBalancers[].<br>allocationPolicy.<br>locations[].<br>zoneId | **string**<br><p>Required. ID of the availability zone where the application load balancer resides.</p> <p>Each Yandex Cloud availability zone can only be specified once.</p> 
loadBalancers[].<br>allocationPolicy.<br>locations[].<br>subnetId | **string**<br><p>ID of the subnet that the application load balancer belongs to.</p> 
loadBalancers[].<br>allocationPolicy.<br>locations[].<br>disableTraffic | **boolean** (boolean)<br><p>Disables the load balancer node in the specified availability zone.</p> <p>Backends in the availability zone are not directly affected by this setting. They still may receive traffic from the load balancer nodes in other availability zones, subject to ``localityAwareRoutingPercent`` and ``strictLocality`` settings.</p> 
loadBalancers[].<br>logGroupId | **string**<br><p>ID of the log group that stores access logs of the application load balancer.</p> <p>The logs can be accessed using a Cloud Functions <a href="/docs/functions/operations/trigger/cloudlogs-trigger-create">trigger for Cloud Logs</a>.</p> 
loadBalancers[].<br>securityGroupIds[] | **string**<br><p>ID's of the security groups attributed to the application load balancer.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#security-groups">documentation</a>.</p> 
loadBalancers[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/application-load-balancer/api-ref/LoadBalancer/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/application-load-balancer/api-ref/LoadBalancer/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 