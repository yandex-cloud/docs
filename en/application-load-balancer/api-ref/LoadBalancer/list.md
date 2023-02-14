---
editable: false
sourcePath: en/_api-ref/apploadbalancer/api-ref/LoadBalancer/list.md
---

# Application Load Balancer API, REST: LoadBalancer.list
Lists application load balancers in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://alb.{{ api-host }}/apploadbalancer/v1/loadBalancers
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list application load balancers in.</p> <p>To get the folder ID, make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/application-load-balancer/api-ref/LoadBalancer/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/application-load-balancer/api-ref/LoadBalancer/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters application load balancers listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/application-load-balancer/api-ref/LoadBalancer#representation">LoadBalancer.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name=my-load-balancer``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
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

          // `loadBalancers[].listeners[]` includes only one of the fields `http`, `tls`, `stream`
          "http": {
            "handler": {
              "httpRouterId": "string",
              "rewriteRequestId": true,

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
                "rewriteRequestId": true,

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
                    "rewriteRequestId": true,

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
          "stream": {
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
      "createdAt": "string",
      "autoScalePolicy": {
        "minZoneSize": "string",
        "maxSize": "string"
      },
      "logOptions": {
        "logGroupId": "string",
        "discardRules": [
          {
            "httpCodes": [
              "string"
            ],
            "httpCodeIntervals": [
              "string"
            ],
            "grpcCodes": [
              "string"
            ],
            "discardPercent": "integer"
          }
        ],
        "disable": true
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
loadBalancers[] | **object**<br><p>List of application load balancers in the specified folder.</p> 
loadBalancers[].<br>id | **string**<br><p>ID of the application load balancer. Generated at creation time.</p> 
loadBalancers[].<br>name | **string**<br><p>Name of the application load balancer. The name is unique within the folder.</p> 
loadBalancers[].<br>description | **string**<br><p>Description of the application load balancer.</p> 
loadBalancers[].<br>folderId | **string**<br><p>ID of the folder that the application load balancer belongs to.</p> 
loadBalancers[].<br>labels | **object**<br><p>Application load balancer labels as ``key:value`` pairs. For details about the concept, see <a href="/docs/overview/concepts/services#labels">documentation</a>.</p> 
loadBalancers[].<br>status | **string**<br><p>Status of the application load balancer.</p> <ul> <li>CREATING: The application load balancer is being created.</li> <li>STARTING: The application load balancer is being started.</li> <li>ACTIVE: The application load balancer is active and sends traffic to the targets.</li> <li>STOPPING: The application load balancer is being stopped.</li> <li>STOPPED: The application load balancer is stopped and doesn't send traffic to the targets.</li> <li>DELETING: The application load balancer is being deleted.</li> </ul> 
loadBalancers[].<br>regionId | **string**<br><p>ID of the region that the application load balancer is located at.</p> 
loadBalancers[].<br>networkId | **string**<br><p>ID of the network that the application load balancer belongs to.</p> 
loadBalancers[].<br>listeners[] | **object**<br><p>Listeners that belong to the application load balancer.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#listener">documentation</a>.</p> 
loadBalancers[].<br>listeners[].<br>name | **string**<br><p>Required. Name of the listener. The name is unique within the application load balancer. The string length in characters is 3-63.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[] | **object**<br><p>Endpoints of the listener.</p> <p>Endpoints are defined by their IP addresses and ports.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[] | **object**<br><p>Required. Endpoint public (external) and internal addresses.</p> <p>Must contain at least one element.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv4Address | **object**<br>Public IPv4 endpoint address. <br>`loadBalancers[].listeners[].endpoints[].addresses[]` includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`<br>
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv4Address.<br>address | **string**<br><p>IPv4 address.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>internalIpv4Address | **object**<br>Internal IPv4 endpoint address.  To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). <br>`loadBalancers[].listeners[].endpoints[].addresses[]` includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`<br>
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>internalIpv4Address.<br>address | **string**<br><p>IPv4 address.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>internalIpv4Address.<br>subnetId | **string**<br><p>ID of the subnet that the address belongs to.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv6Address | **object**<br>Public IPv6 endpoint address. <br>`loadBalancers[].listeners[].endpoints[].addresses[]` includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`<br>
loadBalancers[].<br>listeners[].<br>endpoints[].<br>addresses[].<br>externalIpv6Address.<br>address | **string**<br><p>IPv6 address.</p> 
loadBalancers[].<br>listeners[].<br>endpoints[].<br>ports[] | **string** (int64)<br><p>Required. Endpoint ports.</p> <p>Must contain at least one element. Acceptable values are 1 to 65535, inclusive.</p> 
loadBalancers[].<br>listeners[].<br>http | **object**<br>Unencrypted HTTP listener settings. <br>`loadBalancers[].listeners[]` includes only one of the fields `http`, `tls`, `stream`<br>
loadBalancers[].<br>listeners[].<br>http.<br>handler | **object**<br><p>Settings for handling HTTP requests.</p> <p>Only one of ``handler`` and ``redirects`` can be specified.</p> <p>An HTTP handler resource.</p> 
loadBalancers[].<br>listeners[].<br>http.<br>handler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> <p>To get the list of all available HTTP routers, make a <a href="/docs/application-load-balancer/api-ref/HttpRouter/list">list</a> request.</p> 
loadBalancers[].<br>listeners[].<br>http.<br>handler.<br>rewriteRequestId | **boolean** (boolean)<br><p>When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value.</p> 
loadBalancers[].<br>listeners[].<br>http.<br>handler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`loadBalancers[].listeners[].http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br>
loadBalancers[].<br>listeners[].<br>http.<br>handler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
loadBalancers[].<br>listeners[].<br>http.<br>handler.<br>allowHttp10 | **boolean** (boolean) <br>`loadBalancers[].listeners[].http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
loadBalancers[].<br>listeners[].<br>http.<br>redirects | **object**<br><p>Redirects settings.</p> <p>Only one of ``redirects`` and ``handler`` can be specified.</p> <p>A listener redirects resource.</p> 
loadBalancers[].<br>listeners[].<br>http.<br>redirects.<br>httpToHttps | **boolean** (boolean)<br><p>Redirects all unencrypted HTTP requests to the same URI with scheme changed to ``https``.</p> <p>The setting has the same effect as a single, catch-all ``HttpRoute`` with ``replaceScheme`` set to ``https``.</p> 
loadBalancers[].<br>listeners[].<br>tls | **object**<br>TLS-encrypted HTTP or TCP stream listener settings.  All handlers within a listener (`defaultHandler` and `sniHandlers`) must be of one type, `HttpHandler` or `StreamHandler`. Mixing HTTP and TCP stream traffic in a TLS-encrypted listener is not supported. <br>`loadBalancers[].listeners[]` includes only one of the fields `http`, `tls`, `stream`<br>
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler | **object**<br><p>Required. Settings for handling requests by default, with Server Name Indication (SNI) not matching any of the ``sniHandlers``.</p> <p>A TLS-encrypted (HTTP or TCP stream) handler resource.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>certificateIds[] | **string**<br><p>Required. ID's of the TLS server certificates from <a href="/docs/certificate-manager/">Certificate Manager</a>.</p> <p>RSA and ECDSA certificates are supported, and only the first certificate of each type is used.</p> <p>Must contain at least one element.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>httpHandler | **object**<br>HTTP handler. <br>`loadBalancers[].listeners[].tls.defaultHandler` includes only one of the fields `httpHandler`, `streamHandler`<br>
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> <p>To get the list of all available HTTP routers, make a <a href="/docs/application-load-balancer/api-ref/HttpRouter/list">list</a> request.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>rewriteRequestId | **boolean** (boolean)<br><p>When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`loadBalancers[].listeners[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br>
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`loadBalancers[].listeners[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>streamHandler | **object**<br>Stream (TCP) handler. <br>`loadBalancers[].listeners[].tls.defaultHandler` includes only one of the fields `httpHandler`, `streamHandler`<br>
loadBalancers[].<br>listeners[].<br>tls.<br>defaultHandler.<br>streamHandler.<br>backendGroupId | **string**<br><p>Required. ID of the backend group processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group">documentation</a>.</p> <p>The backend group type, specified via [BackendGroup.backend], must be ``stream``.</p> <p>To get the list of all available backend groups, make a <a href="/docs/application-load-balancer/api-ref/BackendGroup/list">list</a> request.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[] | **object**<br><p>Settings for handling requests with Server Name Indication (SNI) matching one of ``serverNames`` values.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>name | **string**<br><p>Required. Name of the SNI handler.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>serverNames[] | **string**<br><p>Required. Server names that are matched by the SNI handler.</p> <p>Must contain at least one element.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler | **object**<br><p>Required. Settings for handling requests with Server Name Indication (SNI) matching one of ``serverNames`` values.</p> <p>A TLS-encrypted (HTTP or TCP stream) handler resource.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>certificateIds[] | **string**<br><p>Required. ID's of the TLS server certificates from <a href="/docs/certificate-manager/">Certificate Manager</a>.</p> <p>RSA and ECDSA certificates are supported, and only the first certificate of each type is used.</p> <p>Must contain at least one element.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler | **object**<br>HTTP handler. <br>`loadBalancers[].listeners[].tls.sniHandlers[].handler` includes only one of the fields `httpHandler`, `streamHandler`<br>
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> <p>To get the list of all available HTTP routers, make a <a href="/docs/application-load-balancer/api-ref/HttpRouter/list">list</a> request.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>rewriteRequestId | **boolean** (boolean)<br><p>When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`loadBalancers[].listeners[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br>
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`loadBalancers[].listeners[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>streamHandler | **object**<br>Stream (TCP) handler. <br>`loadBalancers[].listeners[].tls.sniHandlers[].handler` includes only one of the fields `httpHandler`, `streamHandler`<br>
loadBalancers[].<br>listeners[].<br>tls.<br>sniHandlers[].<br>handler.<br>streamHandler.<br>backendGroupId | **string**<br><p>Required. ID of the backend group processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group">documentation</a>.</p> <p>The backend group type, specified via [BackendGroup.backend], must be ``stream``.</p> <p>To get the list of all available backend groups, make a <a href="/docs/application-load-balancer/api-ref/BackendGroup/list">list</a> request.</p> 
loadBalancers[].<br>listeners[].<br>stream | **object**<br>Unencrypted stream (TCP) listener settings. <br>`loadBalancers[].listeners[]` includes only one of the fields `http`, `tls`, `stream`<br>
loadBalancers[].<br>listeners[].<br>stream.<br>handler | **object**<br><p>Required. Settings for handling stream (TCP) requests.</p> <p>A stream (TCP) handler resource.</p> 
loadBalancers[].<br>listeners[].<br>stream.<br>handler.<br>backendGroupId | **string**<br><p>Required. ID of the backend group processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group">documentation</a>.</p> <p>The backend group type, specified via [BackendGroup.backend], must be ``stream``.</p> <p>To get the list of all available backend groups, make a <a href="/docs/application-load-balancer/api-ref/BackendGroup/list">list</a> request.</p> 
loadBalancers[].<br>allocationPolicy | **object**<br><p>Locality settings of the application load balancer.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#lb-location">documentation</a>.</p> <p>A locality settings (allocation policy) resource.</p> 
loadBalancers[].<br>allocationPolicy.<br>locations[] | **object**<br><p>Required. Availability zones and subnets that the application load balancer resides.</p> <p>The minimum number of elements is 1.</p> 
loadBalancers[].<br>allocationPolicy.<br>locations[].<br>zoneId | **string**<br><p>Required. ID of the availability zone where the application load balancer resides.</p> <p>Each availability zone can only be specified once.</p> 
loadBalancers[].<br>allocationPolicy.<br>locations[].<br>subnetId | **string**<br><p>ID of the subnet that the application load balancer belongs to.</p> 
loadBalancers[].<br>allocationPolicy.<br>locations[].<br>disableTraffic | **boolean** (boolean)<br><p>Disables the load balancer node in the specified availability zone.</p> <p>Backends in the availability zone are not directly affected by this setting. They still may receive traffic from the load balancer nodes in other availability zones, subject to ``localityAwareRoutingPercent`` and ``strictLocality`` settings.</p> 
loadBalancers[].<br>logGroupId | **string**<br><p>ID of the log group that stores access logs of the application load balancer.</p> <p>The logs can be accessed using a Cloud Functions <a href="/docs/functions/operations/trigger/cloudlogs-trigger-create">trigger for Cloud Logs</a>.</p> 
loadBalancers[].<br>securityGroupIds[] | **string**<br><p>ID's of the security groups attributed to the application load balancer.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#security-groups">documentation</a>.</p> 
loadBalancers[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
loadBalancers[].<br>autoScalePolicy | **object**<br><p>Scaling settings of the application load balancer.</p> <p>The scaling settings relate to a special internal instance group which facilitates the balancer's work. Instances in this group are called <em>resource units</em>. The group is scaled automatically based on incoming load and within limitations specified in these settings.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#lcu-scaling">documentation</a>.</p> <p>A resource for scaling settings of an application load balancer.</p> 
loadBalancers[].<br>autoScalePolicy.<br>minZoneSize | **string** (int64)<br><p>Lower limit for the number of resource units in each availability zone.</p> <p>If not specified previously (using other instruments such as management console), the default value is 2. To revert to it, specify it explicitly.</p> <p>The minimum value is 2.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
loadBalancers[].<br>autoScalePolicy.<br>maxSize | **string** (int64)<br><p>Upper limit for the total number of resource units across all availability zones.</p> <p>If a positive value is specified, it must be at least ``minZoneSize`` multiplied by the size of ``locations``.</p> <p>If the value is 0, there is no upper limit.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
loadBalancers[].<br>logOptions | **object**<br><p>Cloud logging settings of the application load balancer.</p> 
loadBalancers[].<br>logOptions.<br>logGroupId | **string**<br><p>Cloud Logging log group ID to store access logs. If not set then logs will be stored in default log group for the folder where load balancer located.</p> 
loadBalancers[].<br>logOptions.<br>discardRules[] | **object**<br><p>ordered list of rules, first matching rule applies</p> 
loadBalancers[].<br>logOptions.<br>discardRules[].<br>httpCodes[] | **string** (int64)<br><p>HTTP codes that should be discarded.</p> <p>Acceptable values are 100 to 599, inclusive.</p> 
loadBalancers[].<br>logOptions.<br>discardRules[].<br>httpCodeIntervals[] | **string**<br><p>Groups of HTTP codes like 4xx that should be discarded.</p> 
loadBalancers[].<br>logOptions.<br>discardRules[].<br>grpcCodes[] | **string**<br><p>GRPC codes that should be discarded</p> <ul> <li> <p>OK: Not an error; returned on success</p> <p>HTTP Mapping: 200 OK</p> </li> <li> <p>CANCELLED: The operation was cancelled, typically by the caller.</p> <p>HTTP Mapping: 499 Client Closed Request</p> </li> <li> <p>UNKNOWN: Unknown error.  For example, this error may be returned when a ``Status`` value received from another address space belongs to an error space that is not known in this address space.  Also errors raised by APIs that do not return enough error information may be converted to this error.</p> <p>HTTP Mapping: 500 Internal Server Error</p> </li> <li> <p>INVALID_ARGUMENT: The client specified an invalid argument.  Note that this differs from ``FAILED_PRECONDITION``.  ``INVALID_ARGUMENT`` indicates arguments that are problematic regardless of the state of the system (e.g., a malformed file name).</p> <p>HTTP Mapping: 400 Bad Request</p> </li> <li> <p>DEADLINE_EXCEEDED: The deadline expired before the operation could complete. For operations that change the state of the system, this error may be returned even if the operation has completed successfully.  For example, a successful response from a server could have been delayed long enough for the deadline to expire.</p> <p>HTTP Mapping: 504 Gateway Timeout</p> </li> <li> <p>NOT_FOUND: Some requested entity (e.g., file or directory) was not found.</p> <p>Note to server developers: if a request is denied for an entire class of users, such as gradual feature rollout or undocumented whitelist, ``NOT_FOUND`` may be used. If a request is denied for some users within a class of users, such as user-based access control, ``PERMISSION_DENIED`` must be used.</p> <p>HTTP Mapping: 404 Not Found</p> </li> <li> <p>ALREADY_EXISTS: The entity that a client attempted to create (e.g., file or directory) already exists.</p> <p>HTTP Mapping: 409 Conflict</p> </li> <li> <p>PERMISSION_DENIED: The caller does not have permission to execute the specified operation. ``PERMISSION_DENIED`` must not be used for rejections caused by exhausting some resource (use ``RESOURCE_EXHAUSTED`` instead for those errors). ``PERMISSION_DENIED`` must not be used if the caller can not be identified (use ``UNAUTHENTICATED`` instead for those errors). This error code does not imply the request is valid or the requested entity exists or satisfies other pre-conditions.</p> <p>HTTP Mapping: 403 Forbidden</p> </li> <li> <p>UNAUTHENTICATED: The request does not have valid authentication credentials for the operation.</p> <p>HTTP Mapping: 401 Unauthorized</p> </li> <li> <p>RESOURCE_EXHAUSTED: Some resource has been exhausted, perhaps a per-user quota, or perhaps the entire file system is out of space.</p> <p>HTTP Mapping: 429 Too Many Requests</p> </li> <li> <p>FAILED_PRECONDITION: The operation was rejected because the system is not in a state required for the operation's execution.  For example, the directory to be deleted is non-empty, an rmdir operation is applied to a non-directory, etc.</p> <p>Service implementors can use the following guidelines to decide between ``FAILED_PRECONDITION``, ``ABORTED``, and ``UNAVAILABLE``: (a) Use ``UNAVAILABLE`` if the client can retry just the failing call. (b) Use ``ABORTED`` if the client should retry at a higher level (e.g., when a client-specified test-and-set fails, indicating the client should restart a read-modify-write sequence). (c) Use ``FAILED_PRECONDITION`` if the client should not retry until the system state has been explicitly fixed.  E.g., if an "rmdir" fails because the directory is non-empty, ``FAILED_PRECONDITION`` should be returned since the client should not retry unless the files are deleted from the directory.</p> <p>HTTP Mapping: 400 Bad Request</p> </li> <li> <p>ABORTED: The operation was aborted, typically due to a concurrency issue such as a sequencer check failure or transaction abort.</p> <p>See the guidelines above for deciding between ``FAILED_PRECONDITION``, ``ABORTED``, and ``UNAVAILABLE``.</p> <p>HTTP Mapping: 409 Conflict</p> </li> <li> <p>OUT_OF_RANGE: The operation was attempted past the valid range.  E.g., seeking or reading past end-of-file.</p> <p>Unlike ``INVALID_ARGUMENT``, this error indicates a problem that may be fixed if the system state changes. For example, a 32-bit file system will generate ``INVALID_ARGUMENT`` if asked to read at an offset that is not in the range [0,2^32-1], but it will generate ``OUT_OF_RANGE`` if asked to read from an offset past the current file size.</p> <p>There is a fair bit of overlap between ``FAILED_PRECONDITION`` and ``OUT_OF_RANGE``.  We recommend using ``OUT_OF_RANGE`` (the more specific error) when it applies so that callers who are iterating through a space can easily look for an ``OUT_OF_RANGE`` error to detect when they are done.</p> <p>HTTP Mapping: 400 Bad Request</p> </li> <li> <p>UNIMPLEMENTED: The operation is not implemented or is not supported/enabled in this service.</p> <p>HTTP Mapping: 501 Not Implemented</p> </li> <li> <p>INTERNAL: Internal errors.  This means that some invariants expected by the underlying system have been broken.  This error code is reserved for serious errors.</p> <p>HTTP Mapping: 500 Internal Server Error</p> </li> <li> <p>UNAVAILABLE: The service is currently unavailable.  This is most likely a transient condition, which can be corrected by retrying with a backoff.</p> <p>See the guidelines above for deciding between ``FAILED_PRECONDITION``, ``ABORTED``, and ``UNAVAILABLE``.</p> <p>HTTP Mapping: 503 Service Unavailable</p> </li> <li> <p>DATA_LOSS: Unrecoverable data loss or corruption.</p> <p>HTTP Mapping: 500 Internal Server Error</p> </li> </ul> 
loadBalancers[].<br>logOptions.<br>discardRules[].<br>discardPercent | **integer** (int64)<br><p>Percent of logs to be discarded: 0 - keep all, 100 or unset - discard all</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
loadBalancers[].<br>logOptions.<br>disable | **boolean** (boolean)<br><p>Do not send logs to Cloud Logging log group.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/application-load-balancer/api-ref/LoadBalancer/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/application-load-balancer/api-ref/LoadBalancer/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 