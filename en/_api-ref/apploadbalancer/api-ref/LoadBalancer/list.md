---
editable: false
---

# Method list

 

 
## HTTP request {#https-request}
```
GET https://apploadbalancer.api.cloud.yandex.net/apploadbalancer/v1/loadBalancers
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required.
pageSize | Acceptable values are 0 to 1000, inclusive.
pageToken | The maximum string length in characters is 100.
filter | The maximum string length in characters is 1000.
 
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

          // `loadBalancers[].listeners[]` includes only one of the fields `http`, `tls`
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
              "httpHandler": {
                "httpRouterId": "string",

                // `loadBalancers[].listeners[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
                "http2Options": {
                  "maxConcurrentStreams": "string"
                },
                "allowHttp10": true,
                // end of the list of possible fields`loadBalancers[].listeners[].tls.defaultHandler.httpHandler`

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
                  "httpHandler": {
                    "httpRouterId": "string",

                    // `loadBalancers[].listeners[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
                    "http2Options": {
                      "maxConcurrentStreams": "string"
                    },
                    "allowHttp10": true,
                    // end of the list of possible fields`loadBalancers[].listeners[].tls.sniHandlers[].handler.httpHandler`

                  }
                }
              }
            ]
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
loadBalancers[] | **object**<br><p>A LoadBalancer resource.</p> 
loadBalancers[].<br>id | **string**<br><p>Output only. ID of the load balancer.</p> 
loadBalancers[].<br>name | **string**<br><p>The name is unique within the folder. 3-63 characters long.</p> 
loadBalancers[].<br>description | **string**<br><p>Description of the load balancer. 0-256 characters long.</p> 
loadBalancers[].<br>folderId | **string**<br><p>ID of the folder that the load balancer belongs to.</p> 
loadBalancers[].<br>labels | **object**<br><p>Resource labels as `key:value` pairs. Maximum of 64 per resource.</p> 
loadBalancers[].<br>status | **string**<br><p>Status of the application load balancer.</p> <ul> <li>CREATING: Application load balancer is being created.</li> <li>STARTING: Application load balancer is being started.</li> <li>ACTIVE: Application load balancer is active and sends traffic to the targets.</li> <li>STOPPING: Application load balancer is being stopped.</li> <li>STOPPED: Application load balancer is stopped and doesn't send traffic to the targets.</li> <li>DELETING: Application load balancer is being deleted.</li> </ul> 
loadBalancers[].<br>regionId | **string**<br><p>ID of the region that the load balancer located at.</p> 
loadBalancers[].<br>networkId | **string**<br><p>ID of the network that the load balancer located at.</p> 
loadBalancers[].<br>listeners[] | **object**<br><p>A Listener resource.</p> 
loadBalancers[].<br>listeners[].<br>name | **string**<br><p>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[] | **object**<br><p>Network endpoints (addresses and ports) of the listener.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[] | **object**<br><p>Required. Must contain at least one element.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv4Address | **object** <br>`loadBalancers[].listeners[].endpoints[].addresses[]` includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`<br><br>
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv4Address.<br>address | **string**<br>
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>internalIpv4Address | **object** <br>`loadBalancers[].listeners[].endpoints[].addresses[]` includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`<br><br>
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>internalIpv4Address.<br>address | **string**<br>
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>internalIpv4Address.<br>subnetId | **string**<br>
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv6Address | **object** <br>`loadBalancers[].listeners[].endpoints[].addresses[]` includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`<br><br>
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv6Address.<br>address | **string**<br>
loadBalancers[].<br>listeners[].<br>endpoints[].<br>ports[] | **string** (int64)<br><p>Required. Must contain at least one element. Acceptable values are 1 to 65535, inclusive.</p> 
loadBalancers[].<br>listeners[].<br>http | **object** <br>`loadBalancers[].listeners[]` includes only one of the fields `http`, `tls`<br><br>
loadBalancers[].<br>listeners[].<br>http.<br>handler | **object**<br><p>Sets plaintext HTTP router, optional.</p> 
loadBalancers[].<br>listeners[].<br>http.<br>handler.<br>httpRouterId | **string**<br>
loadBalancers[].<br>listeners[].<br>http.<br>handler.<br>http2Options | **object**<br>If set, will enable HTTP2 protocol for the handler. <br>`loadBalancers[].listeners[].http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br>
loadBalancers[].<br>listeners[].<br>http.<br>handler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br>
loadBalancers[].<br>listeners[].<br>http.<br>handler.<br>allowHttp10 | **boolean** (boolean) <br>`loadBalancers[].listeners[].http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>If set, will enable only HTTP1 protocol with HTTP1.0 support.</p> 
loadBalancers[].<br>listeners[].<br>http.<br>redirects | **object**<br><p>Shortcut for adding http -&gt; https redirects, can be used instead of the HttpHandler above.</p> 
loadBalancers[].<br>listeners[].<br>http.<br>redirects.<br>httpToHttps | **boolean** (boolean)<br><p>Adds &quot;*&quot; VirtualHost with a http -&gt; https redirect.</p> 
loadBalancers[].<br>listeners[].<br>tls | **object** <br>`loadBalancers[].listeners[]` includes only one of the fields `http`, `tls`<br><br>
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler | **object**<br><p>Required.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>certificateIds[] | **string**<br><p>Required. Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used.</p> <p>Must contain at least one element.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>httpHandler | **object**<br>
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>httpRouterId | **string**<br>
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options | **object**<br>If set, will enable HTTP2 protocol for the handler. <br>`loadBalancers[].listeners[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br>
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br>
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`loadBalancers[].listeners[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>If set, will enable only HTTP1 protocol with HTTP1.0 support.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[] | **object**<br>
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>name | **string**<br><p>Required.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>serverNames[] | **string**<br><p>Required. Must contain at least one element.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler | **object**<br><p>Required.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>certificateIds[] | **string**<br><p>Required. Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used.</p> <p>Must contain at least one element.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler | **object**<br>
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>httpRouterId | **string**<br>
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options | **object**<br>If set, will enable HTTP2 protocol for the handler. <br>`loadBalancers[].listeners[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br>
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br>
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`loadBalancers[].listeners[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>If set, will enable only HTTP1 protocol with HTTP1.0 support.</p> 
loadBalancers[].<br>allocationPolicy | **object**<br><p>Allocation sites for application load balancer instances.</p> 
loadBalancers[].<br>allocationPolicy.<br>locations[] | **object**<br><p>Required. The minimum number of elements is 1.</p> 
loadBalancers[].<br>allocationPolicy.<br>locations[].<br>zoneId | **string**<br><p>Required.</p> 
loadBalancers[].<br>allocationPolicy.<br>locations[].<br>subnetId | **string**<br>
loadBalancers[].<br>allocationPolicy.<br>locations[].<br>disableTraffic | **boolean** (boolean)<br><p>If set, will disable all L7 instances in the zone for request handling.</p> 
loadBalancers[].<br>logGroupId | **string**<br><p>Cloud log group used by the load balancer to store access logs.</p> 
loadBalancers[].<br>securityGroupIds[] | **string**<br><p>ID's of security groups attached to the load balancer.</p> 
loadBalancers[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp for the load balancer.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**<br>