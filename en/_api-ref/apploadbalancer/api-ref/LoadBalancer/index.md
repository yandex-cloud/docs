---
editable: false
---

# LoadBalancer
A set of methods for managing application load balancers.
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

      // `listeners[]` includes only one of the fields `http`, `tls`, `stream`
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

          // `listeners[].tls.defaultHandler` includes only one of the fields `httpHandler`, `streamHandler`
          "httpHandler": {
            "httpRouterId": "string",

            // `listeners[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
            "http2Options": {
              "maxConcurrentStreams": "string"
            },
            "allowHttp10": true,
            // end of the list of possible fields`listeners[].tls.defaultHandler.httpHandler`

          },
          "streamHandler": {
            "backendGroupId": "string"
          },
          // end of the list of possible fields`listeners[].tls.defaultHandler`

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

              // `listeners[].tls.sniHandlers[].handler` includes only one of the fields `httpHandler`, `streamHandler`
              "httpHandler": {
                "httpRouterId": "string",

                // `listeners[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`
                "http2Options": {
                  "maxConcurrentStreams": "string"
                },
                "allowHttp10": true,
                // end of the list of possible fields`listeners[].tls.sniHandlers[].handler.httpHandler`

              },
              "streamHandler": {
                "backendGroupId": "string"
              },
              // end of the list of possible fields`listeners[].tls.sniHandlers[].handler`

            }
          }
        ]
      },
      "stream": {
        "handler": {
          "backendGroupId": "string"
        }
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
  "createdAt": "string",
  "autoScalePolicy": {
    "minZoneSize": "string",
    "maxSize": "string"
  },
  "logOptions": {
    "logGroupId": "string",
    "discardRules": [
      {
        "codes": [
          "string"
        ],
        "intervals": [
          "string"
        ],
        "percent": "string"
      }
    ],
    "disable": true
  }
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the application load balancer. Generated at creation time.</p> 
name | **string**<br><p>Name of the application load balancer. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the application load balancer.</p> 
folderId | **string**<br><p>ID of the folder that the application load balancer belongs to.</p> 
labels | **object**<br><p>Application load balancer labels as ``key:value`` pairs. For details about the concept, see <a href="/docs/overview/concepts/services#labels">documentation</a>.</p> 
status | **string**<br><p>Status of the application load balancer.</p> <ul> <li>CREATING: The application load balancer is being created.</li> <li>STARTING: The application load balancer is being started.</li> <li>ACTIVE: The application load balancer is active and sends traffic to the targets.</li> <li>STOPPING: The application load balancer is being stopped.</li> <li>STOPPED: The application load balancer is stopped and doesn't send traffic to the targets.</li> <li>DELETING: The application load balancer is being deleted.</li> </ul> 
regionId | **string**<br><p>ID of the region that the application load balancer is located at.</p> 
networkId | **string**<br><p>ID of the network that the application load balancer belongs to.</p> 
listeners[] | **object**<br><p>Listeners that belong to the application load balancer.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#listener">documentation</a>.</p> 
listeners[].<br>name | **string**<br><p>Required. Name of the listener. The name is unique within the application load balancer. The string length in characters is 3-63.</p> 
listeners[].<br>endpoints[] | **object**<br><p>Endpoints of the listener.</p> <p>Endpoints are defined by their IP addresses and ports.</p> 
listeners[].<br>endpoints[].<br>addresses[] | **object**<br><p>Required. Endpoint public (external) and internal addresses.</p> <p>Must contain at least one element.</p> 
listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv4Address | **object** <br>`listeners[].endpoints[].addresses[]` includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`<br><br><p>A public (external) IPv4 endpoint address resource.</p> 
listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv4Address.<br>address | **string**<br><p>IPv4 address.</p> 
listeners[].<br>endpoints[].<br>addresses[].<br>internalIpv4Address | **object** <br>`listeners[].endpoints[].addresses[]` includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`<br><br><p>An internal IPv4 endpoint address resource.</p> 
listeners[].<br>endpoints[].<br>addresses[].<br>internalIpv4Address.<br>address | **string**<br><p>IPv4 address.</p> 
listeners[].<br>endpoints[].<br>addresses[].<br>internalIpv4Address.<br>subnetId | **string**<br><p>ID of the subnet that the address belongs to.</p> 
listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv6Address | **object** <br>`listeners[].endpoints[].addresses[]` includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`<br><br><p>A public (external) IPv4 endpoint address resource.</p> 
listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv6Address.<br>address | **string**<br><p>IPv6 address.</p> 
listeners[].<br>endpoints[].<br>ports[] | **string** (int64)<br><p>Required. Endpoint ports.</p> <p>Must contain at least one element. Acceptable values are 1 to 65535, inclusive.</p> 
listeners[].<br>http | **object** <br>`listeners[]` includes only one of the fields `http`, `tls`, `stream`<br><br><p>An HTTP listener resource.</p> 
listeners[].<br>http.<br>handler | **object**<br><p>Settings for handling HTTP requests.</p> <p>Only one of ``handler`` and ``redirects`` can be specified.</p> <p>An HTTP handler resource.</p> 
listeners[].<br>http.<br>handler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> <p>To get the list of all available HTTP routers, make a <a href="/docs/application-load-balancer/api-ref/HttpRouter/list">list</a> request.</p> 
listeners[].<br>http.<br>handler.<br>http2Options | **object** <br>`listeners[].http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>An HTTP/2 options resource.</p> 
listeners[].<br>http.<br>handler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
listeners[].<br>http.<br>handler.<br>allowHttp10 | **boolean** (boolean) <br>`listeners[].http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
listeners[].<br>http.<br>redirects | **object**<br><p>Redirects settings.</p> <p>Only one of ``redirects`` and ``handler`` can be specified.</p> <p>A listener redirects resource.</p> 
listeners[].<br>http.<br>redirects.<br>httpToHttps | **boolean** (boolean)<br><p>Redirects all unencrypted HTTP requests to the same URI with scheme changed to ``https``.</p> <p>The setting has the same effect as a single, catch-all ``HttpRoute`` with ``replaceScheme`` set to ``https``.</p> 
listeners[].<br>tls | **object** <br>`listeners[]` includes only one of the fields `http`, `tls`, `stream`<br><br><p>TLS-encrypted (HTTP or TCP stream) listener resource.</p> 
listeners[].<br>tls.<br>defaultHandler | **object**<br><p>Required. Settings for handling requests by default, with Server Name Indication (SNI) not matching any of the ``sniHandlers``.</p> <p>A TLS-encrypted (HTTP or TCP stream) handler resource.</p> 
listeners[].<br>tls.<br>defaultHandler.<br>certificateIds[] | **string**<br><p>Required. ID's of the TLS server certificates from <a href="/docs/certificate-manager/">Certificate Manager</a>.</p> <p>RSA and ECDSA certificates are supported, and only the first certificate of each type is used.</p> <p>Must contain at least one element.</p> 
listeners[].<br>tls.<br>defaultHandler.<br>httpHandler | **object** <br>`listeners[].tls.defaultHandler` includes only one of the fields `httpHandler`, `streamHandler`<br><br><p>An HTTP handler resource.</p> 
listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> <p>To get the list of all available HTTP routers, make a <a href="/docs/application-load-balancer/api-ref/HttpRouter/list">list</a> request.</p> 
listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`listeners[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br>
listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`listeners[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
listeners[].<br>tls.<br>defaultHandler.<br>streamHandler | **object** <br>`listeners[].tls.defaultHandler` includes only one of the fields `httpHandler`, `streamHandler`<br><br><p>A stream (TCP) handler resource.</p> 
listeners[].<br>tls.<br>defaultHandler.<br>streamHandler.<br>backendGroupId | **string**<br><p>Required. ID of the backend group processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group">documentation</a>.</p> <p>The backend group type, specified via [BackendGroup.backend], must be ``stream``.</p> <p>To get the list of all available backend groups, make a <a href="/docs/application-load-balancer/api-ref/BackendGroup/list">list</a> request.</p> 
listeners[].<br>tls.<br>sniHandlers[] | **object**<br><p>Settings for handling requests with Server Name Indication (SNI) matching one of ``serverNames`` values.</p> 
listeners[].<br>tls.<br>sniHandlers[].<br>name | **string**<br><p>Required. Name of the SNI handler.</p> 
listeners[].<br>tls.<br>sniHandlers[].<br>serverNames[] | **string**<br><p>Required. Server names that are matched by the SNI handler.</p> <p>Must contain at least one element.</p> 
listeners[].<br>tls.<br>sniHandlers[].<br>handler | **object**<br><p>Required. Settings for handling requests with Server Name Indication (SNI) matching one of ``serverNames`` values.</p> <p>A TLS-encrypted (HTTP or TCP stream) handler resource.</p> 
listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>certificateIds[] | **string**<br><p>Required. ID's of the TLS server certificates from <a href="/docs/certificate-manager/">Certificate Manager</a>.</p> <p>RSA and ECDSA certificates are supported, and only the first certificate of each type is used.</p> <p>Must contain at least one element.</p> 
listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler | **object**<br>HTTP handler. <br>`listeners[].tls.sniHandlers[].handler` includes only one of the fields `httpHandler`, `streamHandler`<br>
listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> <p>To get the list of all available HTTP routers, make a <a href="/docs/application-load-balancer/api-ref/HttpRouter/list">list</a> request.</p> 
listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`listeners[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br>
listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`listeners[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>streamHandler | **object**<br>Stream (TCP) handler. <br>`listeners[].tls.sniHandlers[].handler` includes only one of the fields `httpHandler`, `streamHandler`<br>
listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>streamHandler.<br>backendGroupId | **string**<br><p>Required. ID of the backend group processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group">documentation</a>.</p> <p>The backend group type, specified via [BackendGroup.backend], must be ``stream``.</p> <p>To get the list of all available backend groups, make a <a href="/docs/application-load-balancer/api-ref/BackendGroup/list">list</a> request.</p> 
listeners[].<br>stream | **object** <br>`listeners[]` includes only one of the fields `http`, `tls`, `stream`<br><br><p>A stream (TCP) listener resource.</p> 
listeners[].<br>stream.<br>handler | **object**<br><p>Required. Settings for handling stream (TCP) requests.</p> <p>A stream (TCP) handler resource.</p> 
listeners[].<br>stream.<br>handler.<br>backendGroupId | **string**<br><p>Required. ID of the backend group processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group">documentation</a>.</p> <p>The backend group type, specified via [BackendGroup.backend], must be ``stream``.</p> <p>To get the list of all available backend groups, make a <a href="/docs/application-load-balancer/api-ref/BackendGroup/list">list</a> request.</p> 
allocationPolicy | **object**<br><p>Locality settings of the application load balancer.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#lb-location">documentation</a>.</p> <p>A locality settings (allocation policy) resource.</p> 
allocationPolicy.<br>locations[] | **object**<br><p>Required. Availability zones and subnets that the application load balancer resides.</p> <p>The minimum number of elements is 1.</p> 
allocationPolicy.<br>locations[].<br>zoneId | **string**<br><p>Required. ID of the availability zone where the application load balancer resides.</p> <p>Each availability zone can only be specified once.</p> 
allocationPolicy.<br>locations[].<br>subnetId | **string**<br><p>ID of the subnet that the application load balancer belongs to.</p> 
allocationPolicy.<br>locations[].<br>disableTraffic | **boolean** (boolean)<br><p>Disables the load balancer node in the specified availability zone.</p> <p>Backends in the availability zone are not directly affected by this setting. They still may receive traffic from the load balancer nodes in other availability zones, subject to ``localityAwareRoutingPercent`` and ``strictLocality`` settings.</p> 
logGroupId | **string**<br><p>ID of the log group that stores access logs of the application load balancer.</p> <p>The logs can be accessed using a Cloud Functions <a href="/docs/functions/operations/trigger/cloudlogs-trigger-create">trigger for Cloud Logs</a>.</p> 
securityGroupIds[] | **string**<br><p>ID's of the security groups attributed to the application load balancer.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#security-groups">documentation</a>.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
autoScalePolicy | **object**<br><p>Autoscale settings of the application load balancer.</p> 
autoScalePolicy.<br>minZoneSize | **string** (int64)<br><p>Lower limit for the number of resource units in each zone.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
autoScalePolicy.<br>maxSize | **string** (int64)<br><p>Upper limit for the total number of resource units across all zones.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
logOptions | **object**<br><p>Cloud logging settings of the application load balancer.</p> 
logOptions.<br>logGroupId | **string**<br><p>Cloud Logging log group ID to store access logs. If not set then logs will be stored in default log group for the folder where load balancer located.</p> 
logOptions.<br>discardRules[] | **object**<br><p>LogDiscardRule discards a fraction of logs with certain codes. If neither codes or intervals are provided, rule applies to all logs.</p> 
logOptions.<br>discardRules[].<br>codes[] | **string** (int64)<br><p>HTTP codes that should be discarded.</p> <p>Acceptable values are 100 to 599, inclusive.</p> 
logOptions.<br>discardRules[].<br>intervals[] | **string**<br><p>Groups of HTTP codes like 4xx that should be discarded.</p> 
logOptions.<br>discardRules[].<br>percent | **string** (int64)<br><p>Percent of logs to be discarded: 0 - keep all, 100 - keep none.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
logOptions.<br>disable | **boolean** (boolean)<br><p>Do not send logs to Cloud Logging log group.</p> 

## Methods {#methods}
Method | Description
--- | ---
[addListener](addListener.md) | Adds a listener to the specified application load balancer.
[addSniMatch](addSniMatch.md) | Adds a SNI handler to the specified listener.
[create](create.md) | Creates an application load balancer in the specified folder.
[delete](delete.md) | Deletes the specified application load balancer.
[get](get.md) | Returns the specified application load balancer.
[getTargetStates](getTargetStates.md) | Returns the statuses of all targets of the specified backend group in all their availability zones.
[list](list.md) | Lists application load balancers in the specified folder.
[listOperations](listOperations.md) | Lists operations for the specified application load balancer.
[removeListener](removeListener.md) | Deletes the specified listener.
[removeSniMatch](removeSniMatch.md) | Deletes the specified SNI handler.
[start](start.md) | Starts the specified application load balancer.
[stop](stop.md) | Stops the specified application load balancer.
[update](update.md) | Updates the specified application load balancer.
[updateListener](updateListener.md) | Updates the specified listener of the specified application load balancer.
[updateSniMatch](updateSniMatch.md) | Updates the specified SNI handler of the specified listener.