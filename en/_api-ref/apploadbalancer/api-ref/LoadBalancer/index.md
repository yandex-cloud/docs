---
editable: false
---

# LoadBalancer

## JSON Representation {#representation}
```json 
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

              // `listeners[].endpoints[].addresses[]` includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`
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
              // end of the list of possible fields`listeners[].endpoints[].addresses[]`

            }
          ],
          "ports": [
            "string"
          ]
        }
      ],

      // `listeners[]` includes only one of the fields `http`, `tls`
      "http": {
        "handler": {
          "httpRouterId": "string",

          // `listeners[].http.handler` includes only one of the fields `http2Options`, `allowHttp10`
          "http2Options": {
            "maxConcurrentStreams": "string"
          },
          "allowHttp10": true,
          // end of the list of possible fields`listeners[].http.handler`

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

            // `listeners[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
            "http2Options": {
              "maxConcurrentStreams": "string"
            },
            "allowHttp10": true,
            // end of the list of possible fields`listeners[].tls.defaultHandler.httpHandler`

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

                // `listeners[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
                "http2Options": {
                  "maxConcurrentStreams": "string"
                },
                "allowHttp10": true,
                // end of the list of possible fields`listeners[].tls.sniHandlers[].handler.httpHandler`

              }
            }
          }
        ]
      },
      // end of the list of possible fields`listeners[]`

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
```
 
Field | Description
--- | ---
id | **string**<br><p>Output only. ID of the load balancer.</p> 
name | **string**<br><p>The name is unique within the folder. 3-63 characters long.</p> 
description | **string**<br><p>Description of the load balancer. 0-256 characters long.</p> 
folderId | **string**<br><p>ID of the folder that the load balancer belongs to.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
status | **string**<br><p>Status of the application load balancer.</p> <ul> <li>CREATING: Application load balancer is being created.</li> <li>STARTING: Application load balancer is being started.</li> <li>ACTIVE: Application load balancer is active and sends traffic to the targets.</li> <li>STOPPING: Application load balancer is being stopped.</li> <li>STOPPED: Application load balancer is stopped and doesn't send traffic to the targets.</li> <li>DELETING: Application load balancer is being deleted.</li> </ul> 
regionId | **string**<br><p>ID of the region that the load balancer located at.</p> 
networkId | **string**<br><p>ID of the network that the load balancer located at.</p> 
listeners[] | **object**<br><p>A Listener resource.</p> 
listeners[].<br>name | **string**<br><p>Required. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long.</p> 
listeners[].<br>endpoints[] | **object**<br><p>Network endpoints (addresses and ports) of the listener.</p> 
listeners[].<br>endpoints[].<br>addresses[] | **object**<br><p>Required. Must contain at least one element.</p> 
listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv4Address | **object** <br>`listeners[].endpoints[].addresses[]` includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`<br><br>
listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv4Address.<br>address | **string**<br>
listeners[].<br>endpoints[].<br>addresses[].<br>internalIpv4Address | **object** <br>`listeners[].endpoints[].addresses[]` includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`<br><br>
listeners[].<br>endpoints[].<br>addresses[].<br>internalIpv4Address.<br>address | **string**<br>
listeners[].<br>endpoints[].<br>addresses[].<br>internalIpv4Address.<br>subnetId | **string**<br>
listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv6Address | **object** <br>`listeners[].endpoints[].addresses[]` includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`<br><br>
listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv6Address.<br>address | **string**<br>
listeners[].<br>endpoints[].<br>ports[] | **string** (int64)<br><p>Required. Must contain at least one element. Acceptable values are 1 to 65535, inclusive.</p> 
listeners[].<br>http | **object** <br>`listeners[]` includes only one of the fields `http`, `tls`<br><br>
listeners[].<br>http.<br>handler | **object**<br><p>Sets plaintext HTTP router, optional.</p> 
listeners[].<br>http.<br>handler.<br>httpRouterId | **string**<br>
listeners[].<br>http.<br>handler.<br>http2Options | **object** <br>`listeners[].http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br>
listeners[].<br>http.<br>handler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br>
listeners[].<br>http.<br>handler.<br>allowHttp10 | **boolean** (boolean) <br>`listeners[].http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>If set, will enable only HTTP1 protocol with HTTP1.0 support.</p> 
listeners[].<br>http.<br>redirects | **object**<br><p>Shortcut for adding http -&gt; https redirects, can be used instead of the HttpHandler above.</p> 
listeners[].<br>http.<br>redirects.<br>httpToHttps | **boolean** (boolean)<br><p>Adds &quot;*&quot; VirtualHost with a http -&gt; https redirect.</p> 
listeners[].<br>tls | **object** <br>`listeners[]` includes only one of the fields `http`, `tls`<br><br>
listeners[].<br>tls.<br>defaultHandler | **object**<br><p>Required.</p> 
listeners[].<br>tls.<br>defaultHandler.<br>certificateIds[] | **string**<br><p>Required. Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used.</p> <p>Must contain at least one element.</p> 
listeners[].<br>tls.<br>defaultHandler.<br>httpHandler | **object**<br>
listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>httpRouterId | **string**<br>
listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options | **object**<br>If set, will enable HTTP2 protocol for the handler. <br>`listeners[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br>
listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br>
listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`listeners[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>If set, will enable only HTTP1 protocol with HTTP1.0 support.</p> 
listeners[].<br>tls.<br>sniHandlers[] | **object**<br>
listeners[].<br>tls.<br>sniHandlers[].<br>name | **string**<br><p>Required.</p> 
listeners[].<br>tls.<br>sniHandlers[].<br>serverNames[] | **string**<br><p>Required. Must contain at least one element.</p> 
listeners[].<br>tls.<br>sniHandlers[].<br>handler | **object**<br><p>Required.</p> 
listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>certificateIds[] | **string**<br><p>Required. Certificate IDs in the Certificate Manager. Multiple TLS certificates can be associated with the same context to allow both RSA and ECDSA certificates. Only the first certificate of each type will be used.</p> <p>Must contain at least one element.</p> 
listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler | **object**<br>
listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>httpRouterId | **string**<br>
listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options | **object**<br>If set, will enable HTTP2 protocol for the handler. <br>`listeners[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br>
listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br>
listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`listeners[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>If set, will enable only HTTP1 protocol with HTTP1.0 support.</p> 
allocationPolicy | **object**<br><p>Allocation sites for application load balancer instances.</p> 
allocationPolicy.<br>locations[] | **object**<br><p>Required. The minimum number of elements is 1.</p> 
allocationPolicy.<br>locations[].<br>zoneId | **string**<br><p>Required.</p> 
allocationPolicy.<br>locations[].<br>subnetId | **string**<br>
allocationPolicy.<br>locations[].<br>disableTraffic | **boolean** (boolean)<br><p>If set, will disable all L7 instances in the zone for request handling.</p> 
logGroupId | **string**<br><p>Cloud log group used by the load balancer to store access logs.</p> 
securityGroupIds[] | **string**<br><p>ID's of security groups attached to the load balancer.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp for the load balancer.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 

## Methods {#methods}
Method | Description
--- | ---
[addListener](addListener.md) | AddListener/UpdateListener technically do the same, but have different semantics.
[addSniMatch](addSniMatch.md) | 
[create](create.md) | 
[delete](delete.md) | 
[get](get.md) | 
[getTargetStates](getTargetStates.md) | Returns zonal state of each target within target group for a given backend group and load balancer.
[list](list.md) | 
[listOperations](listOperations.md) | Lists operations for the specified load balancer.
[removeListener](removeListener.md) | 
[removeSniMatch](removeSniMatch.md) | 
[start](start.md) | 
[stop](stop.md) | 
[update](update.md) | 
[updateListener](updateListener.md) | 
[updateSniMatch](updateSniMatch.md) | 