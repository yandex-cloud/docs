---
editable: false
sourcePath: en/_api-ref-grpc/apploadbalancer/v1/api-ref/grpc/LoadBalancer/list.md
---

# Application Load Balancer API, gRPC: LoadBalancerService.List {#List}

Lists application load balancers in the specified folder.

## gRPC request

**rpc List ([ListLoadBalancersRequest](#yandex.cloud.apploadbalancer.v1.ListLoadBalancersRequest)) returns ([ListLoadBalancersResponse](#yandex.cloud.apploadbalancer.v1.ListLoadBalancersResponse))**

## ListLoadBalancersRequest {#yandex.cloud.apploadbalancer.v1.ListLoadBalancersRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list application load balancers in.

To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListLoadBalancersResponse.nextPageToken](#yandex.cloud.apploadbalancer.v1.ListLoadBalancersResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListLoadBalancersResponse.nextPageToken](#yandex.cloud.apploadbalancer.v1.ListLoadBalancersResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters application load balancers listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [LoadBalancer.name](#yandex.cloud.apploadbalancer.v1.LoadBalancer) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name=my-load-balancer`. ||
|#

## ListLoadBalancersResponse {#yandex.cloud.apploadbalancer.v1.ListLoadBalancersResponse}

```json
{
  "loadBalancers": [
    {
      "id": "string",
      "name": "string",
      "description": "string",
      "folderId": "string",
      "labels": "string",
      "status": "Status",
      "regionId": "string",
      "networkId": "string",
      "listeners": [
        {
          "name": "string",
          "endpoints": [
            {
              "addresses": [
                {
                  // Includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`
                  "externalIpv4Address": {
                    "address": "string"
                  },
                  "internalIpv4Address": {
                    "address": "string",
                    "subnetId": "string"
                  },
                  "externalIpv6Address": {
                    "address": "string"
                  }
                  // end of the list of possible fields
                }
              ],
              "ports": [
                "int64"
              ]
            }
          ],
          // Includes only one of the fields `http`, `tls`, `stream`
          "http": {
            "handler": {
              "httpRouterId": "string",
              // Includes only one of the fields `http2Options`, `allowHttp10`
              "http2Options": {
                "maxConcurrentStreams": "int64"
              },
              "allowHttp10": "bool",
              // end of the list of possible fields
              "rewriteRequestId": "bool"
            },
            "redirects": {
              "httpToHttps": "bool"
            }
          },
          "tls": {
            "defaultHandler": {
              // Includes only one of the fields `httpHandler`, `streamHandler`
              "httpHandler": {
                "httpRouterId": "string",
                // Includes only one of the fields `http2Options`, `allowHttp10`
                "http2Options": {
                  "maxConcurrentStreams": "int64"
                },
                "allowHttp10": "bool",
                // end of the list of possible fields
                "rewriteRequestId": "bool"
              },
              "streamHandler": {
                "backendGroupId": "string",
                "idleTimeout": "google.protobuf.Duration"
              },
              // end of the list of possible fields
              "certificateIds": [
                "string"
              ]
            },
            "sniHandlers": [
              {
                "name": "string",
                "serverNames": [
                  "string"
                ],
                "handler": {
                  // Includes only one of the fields `httpHandler`, `streamHandler`
                  "httpHandler": {
                    "httpRouterId": "string",
                    // Includes only one of the fields `http2Options`, `allowHttp10`
                    "http2Options": {
                      "maxConcurrentStreams": "int64"
                    },
                    "allowHttp10": "bool",
                    // end of the list of possible fields
                    "rewriteRequestId": "bool"
                  },
                  "streamHandler": {
                    "backendGroupId": "string",
                    "idleTimeout": "google.protobuf.Duration"
                  },
                  // end of the list of possible fields
                  "certificateIds": [
                    "string"
                  ]
                }
              }
            ]
          },
          "stream": {
            "handler": {
              "backendGroupId": "string",
              "idleTimeout": "google.protobuf.Duration"
            }
          }
          // end of the list of possible fields
        }
      ],
      "allocationPolicy": {
        "locations": [
          {
            "zoneId": "string",
            "subnetId": "string",
            "disableTraffic": "bool"
          }
        ]
      },
      "logGroupId": "string",
      "securityGroupIds": [
        "string"
      ],
      "createdAt": "google.protobuf.Timestamp",
      "autoScalePolicy": {
        "minZoneSize": "int64",
        "maxSize": "int64"
      },
      "logOptions": {
        "logGroupId": "string",
        "discardRules": [
          {
            "httpCodes": [
              "int64"
            ],
            "httpCodeIntervals": [
              "HttpCodeInterval"
            ],
            "grpcCodes": [
              "google.rpc.Code"
            ],
            "discardPercent": "google.protobuf.Int64Value"
          }
        ],
        "disable": "bool"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| loadBalancers[] | **[LoadBalancer](#yandex.cloud.apploadbalancer.v1.LoadBalancer)**

List of application load balancers in the specified folder. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListLoadBalancersRequest.pageSize](#yandex.cloud.apploadbalancer.v1.ListLoadBalancersRequest), use `next_page_token` as the value
for the [ListLoadBalancersRequest.pageToken](#yandex.cloud.apploadbalancer.v1.ListLoadBalancersRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## LoadBalancer {#yandex.cloud.apploadbalancer.v1.LoadBalancer}

An application load balancer resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer).

#|
||Field | Description ||
|| id | **string**

ID of the application load balancer. Generated at creation time. ||
|| name | **string**

Name of the application load balancer. The name is unique within the folder. ||
|| description | **string**

Description of the application load balancer. ||
|| folderId | **string**

ID of the folder that the application load balancer belongs to. ||
|| labels | **string**

Application load balancer labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels). ||
|| status | enum **Status**

Status of the application load balancer.

- `STATUS_UNSPECIFIED`
- `CREATING`: The application load balancer is being created.
- `STARTING`: The application load balancer is being started.
- `ACTIVE`: The application load balancer is active and sends traffic to the targets.
- `STOPPING`: The application load balancer is being stopped.
- `STOPPED`: The application load balancer is stopped and doesn't send traffic to the targets.
- `DELETING`: The application load balancer is being deleted. ||
|| regionId | **string**

ID of the region that the application load balancer is located at. ||
|| networkId | **string**

ID of the network that the application load balancer belongs to. ||
|| listeners[] | **[Listener](#yandex.cloud.apploadbalancer.v1.Listener)**

Listeners that belong to the application load balancer.

For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener). ||
|| allocationPolicy | **[AllocationPolicy](#yandex.cloud.apploadbalancer.v1.AllocationPolicy)**

Locality settings of the application load balancer.

For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location). ||
|| logGroupId | **string**

ID of the log group that stores access logs of the application load balancer.

The logs can be accessed using a Cloud Functions [trigger for Cloud Logs](/docs/functions/operations/trigger/cloudlogs-trigger-create). ||
|| securityGroupIds[] | **string**

ID's of the security groups attributed to the application load balancer.

For details about the concept,
see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#security-groups). ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| autoScalePolicy | **[AutoScalePolicy](#yandex.cloud.apploadbalancer.v1.AutoScalePolicy)**

Scaling settings of the application load balancer.

The scaling settings relate to a special internal instance group which facilitates the balancer's work.
Instances in this group are called _resource units_. The group is scaled automatically based on incoming load
and within limitations specified in these settings.

For details about the concept,
see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lcu-scaling). ||
|| logOptions | **[LogOptions](#yandex.cloud.apploadbalancer.v1.LogOptions)**

Cloud logging settings of the application load balancer. ||
|#

## Listener {#yandex.cloud.apploadbalancer.v1.Listener}

A listener resource.

For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the listener. The name is unique within the application load balancer.
The string length in characters is 3-63. ||
|| endpoints[] | **[Endpoint](#yandex.cloud.apploadbalancer.v1.Endpoint)**

Endpoints of the listener.

Endpoints are defined by their IP addresses and ports. ||
|| http | **[HttpListener](#yandex.cloud.apploadbalancer.v1.HttpListener)**

Unencrypted HTTP listener settings.

Includes only one of the fields `http`, `tls`, `stream`.

Listener type and settings. ||
|| tls | **[TlsListener](#yandex.cloud.apploadbalancer.v1.TlsListener)**

TLS-encrypted HTTP or TCP stream listener settings.

All handlers within a listener ([TlsListener.defaultHandler](#yandex.cloud.apploadbalancer.v1.TlsListener) and [TlsListener.sniHandlers](#yandex.cloud.apploadbalancer.v1.TlsListener)) must be of one
type, [HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler) or [StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler). Mixing HTTP and TCP stream traffic in a TLS-encrypted listener is not
supported.

Includes only one of the fields `http`, `tls`, `stream`.

Listener type and settings. ||
|| stream | **[StreamListener](#yandex.cloud.apploadbalancer.v1.StreamListener)**

Unencrypted stream (TCP) listener settings.

Includes only one of the fields `http`, `tls`, `stream`.

Listener type and settings. ||
|#

## Endpoint {#yandex.cloud.apploadbalancer.v1.Endpoint}

An endpoint resource.

#|
||Field | Description ||
|| addresses[] | **[Address](#yandex.cloud.apploadbalancer.v1.Address)**

Endpoint public (external) and internal addresses. ||
|| ports[] | **int64**

Endpoint ports. ||
|#

## Address {#yandex.cloud.apploadbalancer.v1.Address}

An endpoint address resource.

#|
||Field | Description ||
|| externalIpv4Address | **[ExternalIpv4Address](#yandex.cloud.apploadbalancer.v1.ExternalIpv4Address)**

Public IPv4 endpoint address.

Includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`.

Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address. ||
|| internalIpv4Address | **[InternalIpv4Address](#yandex.cloud.apploadbalancer.v1.InternalIpv4Address)**

Internal IPv4 endpoint address.

To enable the use of listeners with internal addresses, [contact support](/docs/support/overview#response-time).

Includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`.

Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address. ||
|| externalIpv6Address | **[ExternalIpv6Address](#yandex.cloud.apploadbalancer.v1.ExternalIpv6Address)**

Public IPv6 endpoint address.

Includes only one of the fields `externalIpv4Address`, `internalIpv4Address`, `externalIpv6Address`.

Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address. ||
|#

## ExternalIpv4Address {#yandex.cloud.apploadbalancer.v1.ExternalIpv4Address}

A public (external) IPv4 endpoint address resource.

#|
||Field | Description ||
|| address | **string**

IPv4 address. ||
|#

## InternalIpv4Address {#yandex.cloud.apploadbalancer.v1.InternalIpv4Address}

An internal IPv4 endpoint address resource.

#|
||Field | Description ||
|| address | **string**

IPv4 address. ||
|| subnetId | **string**

ID of the subnet that the address belongs to. ||
|#

## ExternalIpv6Address {#yandex.cloud.apploadbalancer.v1.ExternalIpv6Address}

A public (external) IPv4 endpoint address resource.

#|
||Field | Description ||
|| address | **string**

IPv6 address. ||
|#

## HttpListener {#yandex.cloud.apploadbalancer.v1.HttpListener}

An HTTP listener resource.

#|
||Field | Description ||
|| handler | **[HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler)**

Settings for handling HTTP requests.

Only one of `handler` and `redirects` can be specified. ||
|| redirects | **[Redirects](#yandex.cloud.apploadbalancer.v1.Redirects)**

Redirects settings.

Only one of `redirects` and `handler` can be specified. ||
|#

## HttpHandler {#yandex.cloud.apploadbalancer.v1.HttpHandler}

An HTTP handler resource.

#|
||Field | Description ||
|| httpRouterId | **string**

ID of the HTTP router processing requests. For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/http-router).

To get the list of all available HTTP routers, make a [HttpRouterService.List](/docs/application-load-balancer/api-ref/grpc/HttpRouter/list#List) request. ||
|| http2Options | **[Http2Options](#yandex.cloud.apploadbalancer.v1.Http2Options)**

HTTP/2 settings.

If specified, incoming HTTP/2 requests are supported by the listener.

Includes only one of the fields `http2Options`, `allowHttp10`.

Protocol settings.

For HTTPS (HTTP over TLS) connections, settings are applied to the protocol
negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension. ||
|| allowHttp10 | **bool**

Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.

Includes only one of the fields `http2Options`, `allowHttp10`.

Protocol settings.

For HTTPS (HTTP over TLS) connections, settings are applied to the protocol
negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension. ||
|| rewriteRequestId | **bool**

When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value. ||
|#

## Http2Options {#yandex.cloud.apploadbalancer.v1.Http2Options}

An HTTP/2 options resource.

#|
||Field | Description ||
|| maxConcurrentStreams | **int64**

Maximum number of concurrent HTTP/2 streams in a connection. ||
|#

## Redirects {#yandex.cloud.apploadbalancer.v1.Redirects}

A listener redirects resource.

#|
||Field | Description ||
|| httpToHttps | **bool**

Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`.

The setting has the same effect as a single, catch-all [HttpRoute](/docs/application-load-balancer/api-ref/grpc/HttpRouter/get#yandex.cloud.apploadbalancer.v1.HttpRoute)
with [RedirectAction.replaceScheme](/docs/application-load-balancer/api-ref/grpc/HttpRouter/get#yandex.cloud.apploadbalancer.v1.RedirectAction) set to `https`. ||
|#

## TlsListener {#yandex.cloud.apploadbalancer.v1.TlsListener}

TLS-encrypted (HTTP or TCP stream) listener resource.

#|
||Field | Description ||
|| defaultHandler | **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler)**

Required field. Settings for handling requests by default, with Server Name
Indication (SNI) not matching any of the `sniHandlers`. ||
|| sniHandlers[] | **[SniMatch](#yandex.cloud.apploadbalancer.v1.SniMatch)**

Settings for handling requests with Server Name Indication (SNI)
matching one of [SniMatch.serverNames](#yandex.cloud.apploadbalancer.v1.SniMatch) values. ||
|#

## TlsHandler {#yandex.cloud.apploadbalancer.v1.TlsHandler}

A TLS-encrypted (HTTP or TCP stream) handler resource.

#|
||Field | Description ||
|| httpHandler | **[HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler)**

HTTP handler.

Includes only one of the fields `httpHandler`, `streamHandler`.

Settings for handling requests. ||
|| streamHandler | **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler)**

Stream (TCP) handler.

Includes only one of the fields `httpHandler`, `streamHandler`.

Settings for handling requests. ||
|| certificateIds[] | **string**

ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/).

RSA and ECDSA certificates are supported, and only the first certificate of each type is used. ||
|#

## StreamHandler {#yandex.cloud.apploadbalancer.v1.StreamHandler}

A stream (TCP) handler resource.

#|
||Field | Description ||
|| backendGroupId | **string**

Required field. ID of the backend group processing requests. For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group).

The backend group type, specified via [BackendGroup.backend](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.BackendGroup.backend), must be `stream`.

To get the list of all available backend groups, make a [BackendGroupService.List](/docs/application-load-balancer/api-ref/grpc/BackendGroup/list#List) request. ||
|| idleTimeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection.
If not configured, the default idle timeout is 1 hour. Setting it to 0 disables the timeout. ||
|#

## SniMatch {#yandex.cloud.apploadbalancer.v1.SniMatch}

A SNI handler resource.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the SNI handler. ||
|| serverNames[] | **string**

Server names that are matched by the SNI handler. ||
|| handler | **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler)**

Required field. Settings for handling requests with Server Name Indication (SNI) matching one of `serverNames` values. ||
|#

## StreamListener {#yandex.cloud.apploadbalancer.v1.StreamListener}

A stream (TCP) listener resource.

#|
||Field | Description ||
|| handler | **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler)**

Required field. Settings for handling stream (TCP) requests. ||
|#

## AllocationPolicy {#yandex.cloud.apploadbalancer.v1.AllocationPolicy}

A locality settings (allocation policy) resource.

#|
||Field | Description ||
|| locations[] | **[Location](#yandex.cloud.apploadbalancer.v1.Location)**

Availability zones and subnets that the application load balancer resides. ||
|#

## Location {#yandex.cloud.apploadbalancer.v1.Location}

An application load balancer location resource.

For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location).

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the availability zone where the application load balancer resides.

Each availability zone can only be specified once. ||
|| subnetId | **string**

ID of the subnet that the application load balancer belongs to. ||
|| disableTraffic | **bool**

Disables the load balancer node in the specified availability zone.

Backends in the availability zone are not directly affected by this setting.
They still may receive traffic from the load balancer nodes in other availability zones,
subject to [LoadBalancingConfig.localityAwareRoutingPercent](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig) and [LoadBalancingConfig.strictLocality](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig) settings. ||
|#

## AutoScalePolicy {#yandex.cloud.apploadbalancer.v1.AutoScalePolicy}

A resource for scaling settings of an application load balancer.

#|
||Field | Description ||
|| minZoneSize | **int64**

Lower limit for the number of resource units in each availability zone.

If not specified previously (using other instruments such as management console), the default value is 2.
To revert to it, specify it explicitly.

The minimum value is 2. ||
|| maxSize | **int64**

Upper limit for the total number of resource units across all availability zones.

If a positive value is specified, it must be at least `minZoneSize` multiplied by the size of
[AllocationPolicy.locations](#yandex.cloud.apploadbalancer.v1.AllocationPolicy).

If the value is 0, there is no upper limit. ||
|#

## LogOptions {#yandex.cloud.apploadbalancer.v1.LogOptions}

#|
||Field | Description ||
|| logGroupId | **string**

Cloud Logging log group ID to store access logs.
If not set then logs will be stored in default log group for the folder
where load balancer located. ||
|| discardRules[] | **[LogDiscardRule](#yandex.cloud.apploadbalancer.v1.LogDiscardRule)**

ordered list of rules, first matching rule applies ||
|| disable | **bool**

Do not send logs to Cloud Logging log group. ||
|#

## LogDiscardRule {#yandex.cloud.apploadbalancer.v1.LogDiscardRule}

LogDiscardRule discards a fraction of logs with certain codes.
If neither codes or intervals are provided, rule applies to all logs.

#|
||Field | Description ||
|| httpCodes[] | **int64**

HTTP codes that should be discarded. ||
|| httpCodeIntervals[] | enum **HttpCodeInterval**

Groups of HTTP codes like 4xx that should be discarded.

- `HTTP_CODE_INTERVAL_UNSPECIFIED`
- `HTTP_1XX`
- `HTTP_2XX`
- `HTTP_3XX`
- `HTTP_4XX`
- `HTTP_5XX`
- `HTTP_ALL` ||
|| grpcCodes[] | **[google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto)**

GRPC codes that should be discarded ||
|| discardPercent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Percent of logs to be discarded: 0 - keep all, 100 or unset - discard all ||
|#