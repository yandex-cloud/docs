---
editable: false
---

# Application Load Balancer API, REST: LoadBalancer.update
Updates the specified application load balancer.
 

 
## HTTP request {#https-request}
```
PATCH https://alb.{{ api-host }}/apploadbalancer/v1/loadBalancers/{loadBalancerId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
loadBalancerId | <p>Required. ID of the application load balancer to update.</p> <p>To get the application load balancer ID, make a <a href="/docs/application-load-balancer/api-ref/LoadBalancer/list">list</a> request.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
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

      // `listenerSpecs[]` includes only one of the fields `http`, `tls`, `stream`
      "http": {
        "handler": {
          "httpRouterId": "string",
          "rewriteRequestId": true,

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
            "rewriteRequestId": true,

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
                "rewriteRequestId": true,

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
      "stream": {
        "handler": {
          "backendGroupId": "string"
        }
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
  ],
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
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which attributes of the application load balancer should be updated.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
name | **string**<br><p>New name for the application load balancer. The name must be unique within the folder.</p> <p>Value must match the regular expression ``([a-z]([-a-z0-9]{0,61}[a-z0-9])?)?``.</p> 
description | **string**<br><p>New description of the application load balancer.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>New application load balancer labels as ``key:value`` pairs. For details about the concept, see <a href="/docs/overview/concepts/services#labels">documentation</a>.</p> <p>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label:</p> <ol> <li>Get the current set of labels with a <a href="/docs/application-load-balancer/api-ref/LoadBalancer/get">get</a> request.</li> <li>Add or remove a label in this set.</li> <li>Send the new set in this field.</li> </ol> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
listenerSpecs[] | **object**<br><p>New listeners for the application load balancer.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#listener">documentation</a>.</p> <p>Existing list of listeners is completely replaced by the specified list, so if you just want to add, update, or remove a listener, make a <a href="/docs/application-load-balancer/api-ref/LoadBalancer/addListener">addListener</a> request, a <a href="/docs/application-load-balancer/api-ref/LoadBalancer/updateListener">updateListener</a> request, or a <a href="/docs/application-load-balancer/api-ref/LoadBalancer/removeListener">removeListener</a> request.</p> 
listenerSpecs[].<br>name | **string**<br><p>Required. Name of the listener. The name is unique within the application load balancer.</p> <p>Value must match the regular expression ``[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
listenerSpecs[].<br>endpointSpecs[] | **object**<br><p>Required. Endpoints of the listener.</p> <p>Endpoints are defined by their IP addresses and ports.</p> <p>Must contain at least one element.</p> 
listenerSpecs[].<br>endpointSpecs[].<br>addressSpecs[] | **object**<br><p>Required. Endpoint public (external) and internal addresses.</p> <p>Must contain at least one element.</p> 
listenerSpecs[].<br>endpointSpecs[].<br>addressSpecs[].<br>externalIpv4AddressSpec | **object**<br>Public IPv4 endpoint address. <br>`listenerSpecs[].endpointSpecs[].addressSpecs[]` includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`<br>
listenerSpecs[].<br>endpointSpecs[].<br>addressSpecs[].<br>externalIpv4AddressSpec.<br>address | **string**<br><p>IPv4 address.</p> 
listenerSpecs[].<br>endpointSpecs[].<br>addressSpecs[].<br>internalIpv4AddressSpec | **object**<br>Internal IPv4 endpoint address.  To enable the use of listeners with internal addresses, [contact support](https://console.cloud.yandex.ru/support). <br>`listenerSpecs[].endpointSpecs[].addressSpecs[]` includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`<br>
listenerSpecs[].<br>endpointSpecs[].<br>addressSpecs[].<br>internalIpv4AddressSpec.<br>address | **string**<br><p>IPv4 address.</p> 
listenerSpecs[].<br>endpointSpecs[].<br>addressSpecs[].<br>internalIpv4AddressSpec.<br>subnetId | **string**<br><p>ID of the subnet that the address belongs to.</p> 
listenerSpecs[].<br>endpointSpecs[].<br>addressSpecs[].<br>externalIpv6AddressSpec | **object**<br>Public IPv6 endpoint address. <br>`listenerSpecs[].endpointSpecs[].addressSpecs[]` includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`<br>
listenerSpecs[].<br>endpointSpecs[].<br>addressSpecs[].<br>externalIpv6AddressSpec.<br>address | **string**<br><p>IPv6 address.</p> 
listenerSpecs[].<br>endpointSpecs[].<br>ports[] | **string** (int64)<br><p>Required. Endpoint ports.</p> <p>Must contain at least one element. Acceptable values are 1 to 65535, inclusive.</p> 
listenerSpecs[].<br>http | **object**<br>Unencrypted HTTP listener settings. <br>`listenerSpecs[]` includes only one of the fields `http`, `tls`, `stream`<br>
listenerSpecs[].<br>http.<br>handler | **object**<br><p>Settings for handling HTTP requests.</p> <p>Only one of ``handler`` and ``redirects`` can be specified.</p> <p>An HTTP handler resource.</p> 
listenerSpecs[].<br>http.<br>handler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> <p>To get the list of all available HTTP routers, make a <a href="/docs/application-load-balancer/api-ref/HttpRouter/list">list</a> request.</p> 
listenerSpecs[].<br>http.<br>handler.<br>rewriteRequestId | **boolean** (boolean)<br><p>When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value.</p> 
listenerSpecs[].<br>http.<br>handler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`listenerSpecs[].http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br>
listenerSpecs[].<br>http.<br>handler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
listenerSpecs[].<br>http.<br>handler.<br>allowHttp10 | **boolean** (boolean) <br>`listenerSpecs[].http.handler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
listenerSpecs[].<br>http.<br>redirects | **object**<br><p>Redirects settings.</p> <p>Only one of ``redirects`` and ``handler`` can be specified.</p> <p>A listener redirects resource.</p> 
listenerSpecs[].<br>http.<br>redirects.<br>httpToHttps | **boolean** (boolean)<br><p>Redirects all unencrypted HTTP requests to the same URI with scheme changed to ``https``.</p> <p>The setting has the same effect as a single, catch-all ``HttpRoute`` with ``replaceScheme`` set to ``https``.</p> 
listenerSpecs[].<br>tls | **object**<br>TLS-encrypted HTTP or TCP stream listener settings.  All handlers within a listener (`defaultHandler` and `sniHandlers`) must be of one type, `HttpHandler` or `StreamHandler`. Mixing HTTP and TCP stream traffic in a TLS-encrypted listener is not supported. <br>`listenerSpecs[]` includes only one of the fields `http`, `tls`, `stream`<br>
listenerSpecs[].<br>tls.<br>defaultHandler | **object**<br><p>Required. Settings for handling requests by default, with Server Name Indication (SNI) not matching any of the ``sniHandlers``.</p> <p>A TLS-encrypted (HTTP or TCP stream) handler resource.</p> 
listenerSpecs[].<br>tls.<br>defaultHandler.<br>certificateIds[] | **string**<br><p>Required. ID's of the TLS server certificates from <a href="/docs/certificate-manager/">Certificate Manager</a>.</p> <p>RSA and ECDSA certificates are supported, and only the first certificate of each type is used.</p> <p>Must contain at least one element.</p> 
listenerSpecs[].<br>tls.<br>defaultHandler.<br>httpHandler | **object**<br>HTTP handler. <br>`listenerSpecs[].tls.defaultHandler` includes only one of the fields `httpHandler`, `streamHandler`<br>
listenerSpecs[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> <p>To get the list of all available HTTP routers, make a <a href="/docs/application-load-balancer/api-ref/HttpRouter/list">list</a> request.</p> 
listenerSpecs[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>rewriteRequestId | **boolean** (boolean)<br><p>When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value.</p> 
listenerSpecs[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`listenerSpecs[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br>
listenerSpecs[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
listenerSpecs[].<br>tls.<br>defaultHandler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`listenerSpecs[].tls.defaultHandler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
listenerSpecs[].<br>tls.<br>defaultHandler.<br>streamHandler | **object**<br>Stream (TCP) handler. <br>`listenerSpecs[].tls.defaultHandler` includes only one of the fields `httpHandler`, `streamHandler`<br>
listenerSpecs[].<br>tls.<br>defaultHandler.<br>streamHandler.<br>backendGroupId | **string**<br><p>Required. ID of the backend group processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group">documentation</a>.</p> <p>The backend group type, specified via [BackendGroup.backend], must be ``stream``.</p> <p>To get the list of all available backend groups, make a <a href="/docs/application-load-balancer/api-ref/BackendGroup/list">list</a> request.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[] | **object**<br><p>Settings for handling requests with Server Name Indication (SNI) matching one of ``serverNames`` values.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>name | **string**<br><p>Required. Name of the SNI handler.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>serverNames[] | **string**<br><p>Required. Server names that are matched by the SNI handler.</p> <p>Must contain at least one element.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler | **object**<br><p>Required. Settings for handling requests with Server Name Indication (SNI) matching one of ``serverNames`` values.</p> <p>A TLS-encrypted (HTTP or TCP stream) handler resource.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler.<br>certificateIds[] | **string**<br><p>Required. ID's of the TLS server certificates from <a href="/docs/certificate-manager/">Certificate Manager</a>.</p> <p>RSA and ECDSA certificates are supported, and only the first certificate of each type is used.</p> <p>Must contain at least one element.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler | **object**<br>HTTP handler. <br>`listenerSpecs[].tls.sniHandlers[].handler` includes only one of the fields `httpHandler`, `streamHandler`<br>
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>httpRouterId | **string**<br><p>ID of the HTTP router processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/http-router">documentation</a>.</p> <p>To get the list of all available HTTP routers, make a <a href="/docs/application-load-balancer/api-ref/HttpRouter/list">list</a> request.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>rewriteRequestId | **boolean** (boolean)<br><p>When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options | **object**<br>HTTP/2 settings.  If specified, incoming HTTP/2 requests are supported by the listener. <br>`listenerSpecs[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br>
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>http2Options.<br>maxConcurrentStreams | **string** (int64)<br><p>Maximum number of concurrent HTTP/2 streams in a connection.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler.<br>httpHandler.<br>allowHttp10 | **boolean** (boolean) <br>`listenerSpecs[].tls.sniHandlers[].handler.httpHandler` includes only one of the fields `http2Options`, `allowHttp10`<br><br><p>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.</p> 
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler.<br>streamHandler | **object**<br>Stream (TCP) handler. <br>`listenerSpecs[].tls.sniHandlers[].handler` includes only one of the fields `httpHandler`, `streamHandler`<br>
listenerSpecs[].<br>tls.<br>sniHandlers[].<br>handler.<br>streamHandler.<br>backendGroupId | **string**<br><p>Required. ID of the backend group processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group">documentation</a>.</p> <p>The backend group type, specified via [BackendGroup.backend], must be ``stream``.</p> <p>To get the list of all available backend groups, make a <a href="/docs/application-load-balancer/api-ref/BackendGroup/list">list</a> request.</p> 
listenerSpecs[].<br>stream | **object**<br>Unencrypted stream (TCP) listener settings. <br>`listenerSpecs[]` includes only one of the fields `http`, `tls`, `stream`<br>
listenerSpecs[].<br>stream.<br>handler | **object**<br><p>Required. Settings for handling stream (TCP) requests.</p> <p>A stream (TCP) handler resource.</p> 
listenerSpecs[].<br>stream.<br>handler.<br>backendGroupId | **string**<br><p>Required. ID of the backend group processing requests. For details about the concept, see <a href="/docs/application-load-balancer/concepts/backend-group">documentation</a>.</p> <p>The backend group type, specified via [BackendGroup.backend], must be ``stream``.</p> <p>To get the list of all available backend groups, make a <a href="/docs/application-load-balancer/api-ref/BackendGroup/list">list</a> request.</p> 
allocationPolicy | **object**<br><p>New locality settings of the application load balancer.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#lb-location">documentation</a>.</p> <p>Existing locality settings are completely replaced by the specified settings, so if you just want to add or remove an allocation policy:</p> <ol> <li>Get the current settings with a <a href="/docs/application-load-balancer/api-ref/LoadBalancer/get">get</a> request.</li> <li>Add or remove a policy in this set.</li> <li>Send the new set in this field.</li> </ol> <p>A locality settings (allocation policy) resource.</p> 
allocationPolicy.<br>locations[] | **object**<br><p>Required. Availability zones and subnets that the application load balancer resides.</p> <p>The minimum number of elements is 1.</p> 
allocationPolicy.<br>locations[].<br>zoneId | **string**<br><p>Required. ID of the availability zone where the application load balancer resides.</p> <p>Each availability zone can only be specified once.</p> 
allocationPolicy.<br>locations[].<br>subnetId | **string**<br><p>ID of the subnet that the application load balancer belongs to.</p> 
allocationPolicy.<br>locations[].<br>disableTraffic | **boolean** (boolean)<br><p>Disables the load balancer node in the specified availability zone.</p> <p>Backends in the availability zone are not directly affected by this setting. They still may receive traffic from the load balancer nodes in other availability zones, subject to ``localityAwareRoutingPercent`` and ``strictLocality`` settings.</p> 
securityGroupIds[] | **string**<br><p>ID's of new security groups attributed to the application load balancer.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#security-groups">documentation</a>.</p> <p>Existing list of security groups is completely replaced by the specified list, so if you just want to add or remove an allocation policy:</p> <ol> <li>Get the current set of security groups with a <a href="/docs/application-load-balancer/api-ref/LoadBalancer/get">get</a> request.</li> <li>Add or remove a group in this set.</li> <li>Send the new set in this field.</li> </ol> 
autoScalePolicy | **object**<br><p>New scaling settings of the application load balancer.</p> <p>The scaling settings relate to a special internal instance group which facilitates the balancer's work. Instances in this group are called <em>resource units</em>. The group is scaled automatically based on incoming load and within limitations specified in these settings.</p> <p>For details about the concept, see <a href="/docs/application-load-balancer/concepts/application-load-balancer#lcu-scaling">documentation</a>.</p> <p>A resource for scaling settings of an application load balancer.</p> 
autoScalePolicy.<br>minZoneSize | **string** (int64)<br><p>Lower limit for the number of resource units in each availability zone.</p> <p>If not specified previously (using other instruments such as management console), the default value is 2. To revert to it, specify it explicitly.</p> <p>The minimum value is 2.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
autoScalePolicy.<br>maxSize | **string** (int64)<br><p>Upper limit for the total number of resource units across all availability zones.</p> <p>If a positive value is specified, it must be at least ``minZoneSize`` multiplied by the size of ``locations``.</p> <p>If the value is 0, there is no upper limit.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
logOptions | **object**<br><p>Cloud logging settings of the application load balancer.</p> 
logOptions.<br>logGroupId | **string**<br><p>Cloud Logging log group ID to store access logs. If not set then logs will be stored in default log group for the folder where load balancer located.</p> 
logOptions.<br>discardRules[] | **object**<br><p>ordered list of rules, first matching rule applies</p> 
logOptions.<br>discardRules[].<br>httpCodes[] | **string** (int64)<br><p>HTTP codes that should be discarded.</p> <p>Acceptable values are 100 to 599, inclusive.</p> 
logOptions.<br>discardRules[].<br>httpCodeIntervals[] | **string**<br><p>Groups of HTTP codes like 4xx that should be discarded.</p> 
logOptions.<br>discardRules[].<br>grpcCodes[] | **string**<br><p>GRPC codes that should be discarded</p> <ul> <li> <p>OK: Not an error; returned on success</p> <p>HTTP Mapping: 200 OK</p> </li> <li> <p>CANCELLED: The operation was cancelled, typically by the caller.</p> <p>HTTP Mapping: 499 Client Closed Request</p> </li> <li> <p>UNKNOWN: Unknown error.  For example, this error may be returned when a ``Status`` value received from another address space belongs to an error space that is not known in this address space.  Also errors raised by APIs that do not return enough error information may be converted to this error.</p> <p>HTTP Mapping: 500 Internal Server Error</p> </li> <li> <p>INVALID_ARGUMENT: The client specified an invalid argument.  Note that this differs from ``FAILED_PRECONDITION``.  ``INVALID_ARGUMENT`` indicates arguments that are problematic regardless of the state of the system (e.g., a malformed file name).</p> <p>HTTP Mapping: 400 Bad Request</p> </li> <li> <p>DEADLINE_EXCEEDED: The deadline expired before the operation could complete. For operations that change the state of the system, this error may be returned even if the operation has completed successfully.  For example, a successful response from a server could have been delayed long enough for the deadline to expire.</p> <p>HTTP Mapping: 504 Gateway Timeout</p> </li> <li> <p>NOT_FOUND: Some requested entity (e.g., file or directory) was not found.</p> <p>Note to server developers: if a request is denied for an entire class of users, such as gradual feature rollout or undocumented whitelist, ``NOT_FOUND`` may be used. If a request is denied for some users within a class of users, such as user-based access control, ``PERMISSION_DENIED`` must be used.</p> <p>HTTP Mapping: 404 Not Found</p> </li> <li> <p>ALREADY_EXISTS: The entity that a client attempted to create (e.g., file or directory) already exists.</p> <p>HTTP Mapping: 409 Conflict</p> </li> <li> <p>PERMISSION_DENIED: The caller does not have permission to execute the specified operation. ``PERMISSION_DENIED`` must not be used for rejections caused by exhausting some resource (use ``RESOURCE_EXHAUSTED`` instead for those errors). ``PERMISSION_DENIED`` must not be used if the caller can not be identified (use ``UNAUTHENTICATED`` instead for those errors). This error code does not imply the request is valid or the requested entity exists or satisfies other pre-conditions.</p> <p>HTTP Mapping: 403 Forbidden</p> </li> <li> <p>UNAUTHENTICATED: The request does not have valid authentication credentials for the operation.</p> <p>HTTP Mapping: 401 Unauthorized</p> </li> <li> <p>RESOURCE_EXHAUSTED: Some resource has been exhausted, perhaps a per-user quota, or perhaps the entire file system is out of space.</p> <p>HTTP Mapping: 429 Too Many Requests</p> </li> <li> <p>FAILED_PRECONDITION: The operation was rejected because the system is not in a state required for the operation's execution.  For example, the directory to be deleted is non-empty, an rmdir operation is applied to a non-directory, etc.</p> <p>Service implementors can use the following guidelines to decide between ``FAILED_PRECONDITION``, ``ABORTED``, and ``UNAVAILABLE``: (a) Use ``UNAVAILABLE`` if the client can retry just the failing call. (b) Use ``ABORTED`` if the client should retry at a higher level (e.g., when a client-specified test-and-set fails, indicating the client should restart a read-modify-write sequence). (c) Use ``FAILED_PRECONDITION`` if the client should not retry until the system state has been explicitly fixed.  E.g., if an "rmdir" fails because the directory is non-empty, ``FAILED_PRECONDITION`` should be returned since the client should not retry unless the files are deleted from the directory.</p> <p>HTTP Mapping: 400 Bad Request</p> </li> <li> <p>ABORTED: The operation was aborted, typically due to a concurrency issue such as a sequencer check failure or transaction abort.</p> <p>See the guidelines above for deciding between ``FAILED_PRECONDITION``, ``ABORTED``, and ``UNAVAILABLE``.</p> <p>HTTP Mapping: 409 Conflict</p> </li> <li> <p>OUT_OF_RANGE: The operation was attempted past the valid range.  E.g., seeking or reading past end-of-file.</p> <p>Unlike ``INVALID_ARGUMENT``, this error indicates a problem that may be fixed if the system state changes. For example, a 32-bit file system will generate ``INVALID_ARGUMENT`` if asked to read at an offset that is not in the range [0,2^32-1], but it will generate ``OUT_OF_RANGE`` if asked to read from an offset past the current file size.</p> <p>There is a fair bit of overlap between ``FAILED_PRECONDITION`` and ``OUT_OF_RANGE``.  We recommend using ``OUT_OF_RANGE`` (the more specific error) when it applies so that callers who are iterating through a space can easily look for an ``OUT_OF_RANGE`` error to detect when they are done.</p> <p>HTTP Mapping: 400 Bad Request</p> </li> <li> <p>UNIMPLEMENTED: The operation is not implemented or is not supported/enabled in this service.</p> <p>HTTP Mapping: 501 Not Implemented</p> </li> <li> <p>INTERNAL: Internal errors.  This means that some invariants expected by the underlying system have been broken.  This error code is reserved for serious errors.</p> <p>HTTP Mapping: 500 Internal Server Error</p> </li> <li> <p>UNAVAILABLE: The service is currently unavailable.  This is most likely a transient condition, which can be corrected by retrying with a backoff.</p> <p>See the guidelines above for deciding between ``FAILED_PRECONDITION``, ``ABORTED``, and ``UNAVAILABLE``.</p> <p>HTTP Mapping: 503 Service Unavailable</p> </li> <li> <p>DATA_LOSS: Unrecoverable data loss or corruption.</p> <p>HTTP Mapping: 500 Internal Server Error</p> </li> </ul> 
logOptions.<br>discardRules[].<br>discardPercent | **integer** (int64)<br><p>Percent of logs to be discarded: 0 - keep all, 100 or unset - discard all</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
logOptions.<br>disable | **boolean** (boolean)<br><p>Do not send logs to Cloud Logging log group.</p> 
 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 