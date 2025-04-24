---
editable: false
sourcePath: en/_api-ref-grpc/apploadbalancer/v1/api-ref/grpc/LoadBalancer/addListener.md
---

# Application Load Balancer API, gRPC: LoadBalancerService.AddListener

Adds a listener to the specified application load balancer.

## gRPC request

**rpc AddListener ([AddListenerRequest](#yandex.cloud.apploadbalancer.v1.AddListenerRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AddListenerRequest {#yandex.cloud.apploadbalancer.v1.AddListenerRequest}

```json
{
  "load_balancer_id": "string",
  "listener_spec": {
    "name": "string",
    "endpoint_specs": [
      {
        "address_specs": [
          {
            // Includes only one of the fields `external_ipv4_address_spec`, `internal_ipv4_address_spec`, `external_ipv6_address_spec`
            "external_ipv4_address_spec": {
              "address": "string"
            },
            "internal_ipv4_address_spec": {
              "address": "string",
              "subnet_id": "string"
            },
            "external_ipv6_address_spec": {
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
        "http_router_id": "string",
        // Includes only one of the fields `http2_options`, `allow_http10`
        "http2_options": {
          "max_concurrent_streams": "int64"
        },
        "allow_http10": "bool",
        // end of the list of possible fields
        "rewrite_request_id": "bool"
      },
      "redirects": {
        "http_to_https": "bool"
      }
    },
    "tls": {
      "default_handler": {
        // Includes only one of the fields `http_handler`, `stream_handler`
        "http_handler": {
          "http_router_id": "string",
          // Includes only one of the fields `http2_options`, `allow_http10`
          "http2_options": {
            "max_concurrent_streams": "int64"
          },
          "allow_http10": "bool",
          // end of the list of possible fields
          "rewrite_request_id": "bool"
        },
        "stream_handler": {
          "backend_group_id": "string",
          "idle_timeout": "google.protobuf.Duration"
        },
        // end of the list of possible fields
        "certificate_ids": [
          "string"
        ]
      },
      "sni_handlers": [
        {
          "name": "string",
          "server_names": [
            "string"
          ],
          "handler": {
            // Includes only one of the fields `http_handler`, `stream_handler`
            "http_handler": {
              "http_router_id": "string",
              // Includes only one of the fields `http2_options`, `allow_http10`
              "http2_options": {
                "max_concurrent_streams": "int64"
              },
              "allow_http10": "bool",
              // end of the list of possible fields
              "rewrite_request_id": "bool"
            },
            "stream_handler": {
              "backend_group_id": "string",
              "idle_timeout": "google.protobuf.Duration"
            },
            // end of the list of possible fields
            "certificate_ids": [
              "string"
            ]
          }
        }
      ]
    },
    "stream": {
      "handler": {
        "backend_group_id": "string",
        "idle_timeout": "google.protobuf.Duration"
      }
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| load_balancer_id | **string**

Required field. ID of the application load balancer to add a listener to. ||
|| listener_spec | **[ListenerSpec](#yandex.cloud.apploadbalancer.v1.ListenerSpec)**

Required field. Listener to add to the application load balancer. ||
|#

## ListenerSpec {#yandex.cloud.apploadbalancer.v1.ListenerSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the listener. The name is unique within the application load balancer. ||
|| endpoint_specs[] | **[EndpointSpec](#yandex.cloud.apploadbalancer.v1.EndpointSpec)**

Endpoints of the listener.

Endpoints are defined by their IP addresses and ports. ||
|| http | **[HttpListener](#yandex.cloud.apploadbalancer.v1.HttpListener)**

Unencrypted HTTP listener settings.

Includes only one of the fields `http`, `tls`, `stream`.

Listener type and settings. ||
|| tls | **[TlsListener](#yandex.cloud.apploadbalancer.v1.TlsListener)**

TLS-encrypted HTTP or TCP stream listener settings.

All handlers within a listener ([TlsListener.default_handler](#yandex.cloud.apploadbalancer.v1.TlsListener) and [TlsListener.sni_handlers](#yandex.cloud.apploadbalancer.v1.TlsListener)) must be of one
type, [HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler) or [StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler). Mixing HTTP and TCP stream traffic in a TLS-encrypted listener is not
supported.

Includes only one of the fields `http`, `tls`, `stream`.

Listener type and settings. ||
|| stream | **[StreamListener](#yandex.cloud.apploadbalancer.v1.StreamListener)**

Unencrypted stream (TCP) listener settings.

Includes only one of the fields `http`, `tls`, `stream`.

Listener type and settings. ||
|#

## EndpointSpec {#yandex.cloud.apploadbalancer.v1.EndpointSpec}

#|
||Field | Description ||
|| address_specs[] | **[AddressSpec](#yandex.cloud.apploadbalancer.v1.AddressSpec)**

Endpoint public (external) and internal addresses. ||
|| ports[] | **int64**

Endpoint ports. ||
|#

## AddressSpec {#yandex.cloud.apploadbalancer.v1.AddressSpec}

#|
||Field | Description ||
|| external_ipv4_address_spec | **[ExternalIpv4AddressSpec](#yandex.cloud.apploadbalancer.v1.ExternalIpv4AddressSpec)**

Public IPv4 endpoint address.

Includes only one of the fields `external_ipv4_address_spec`, `internal_ipv4_address_spec`, `external_ipv6_address_spec`.

Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address. ||
|| internal_ipv4_address_spec | **[InternalIpv4AddressSpec](#yandex.cloud.apploadbalancer.v1.InternalIpv4AddressSpec)**

Internal IPv4 endpoint address.

To enable the use of listeners with internal addresses, [contact support](/docs/support/overview#response-time).

Includes only one of the fields `external_ipv4_address_spec`, `internal_ipv4_address_spec`, `external_ipv6_address_spec`.

Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address. ||
|| external_ipv6_address_spec | **[ExternalIpv6AddressSpec](#yandex.cloud.apploadbalancer.v1.ExternalIpv6AddressSpec)**

Public IPv6 endpoint address.

Includes only one of the fields `external_ipv4_address_spec`, `internal_ipv4_address_spec`, `external_ipv6_address_spec`.

Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address. ||
|#

## ExternalIpv4AddressSpec {#yandex.cloud.apploadbalancer.v1.ExternalIpv4AddressSpec}

#|
||Field | Description ||
|| address | **string**

IPv4 address. ||
|#

## InternalIpv4AddressSpec {#yandex.cloud.apploadbalancer.v1.InternalIpv4AddressSpec}

#|
||Field | Description ||
|| address | **string**

IPv4 address. ||
|| subnet_id | **string**

ID of the subnet that the address belongs to. ||
|#

## ExternalIpv6AddressSpec {#yandex.cloud.apploadbalancer.v1.ExternalIpv6AddressSpec}

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
|| http_router_id | **string**

ID of the HTTP router processing requests. For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/http-router).

To get the list of all available HTTP routers, make a [HttpRouterService.List](/docs/application-load-balancer/api-ref/grpc/HttpRouter/list#List) request. ||
|| http2_options | **[Http2Options](#yandex.cloud.apploadbalancer.v1.Http2Options)**

HTTP/2 settings.

If specified, incoming HTTP/2 requests are supported by the listener.

Includes only one of the fields `http2_options`, `allow_http10`.

Protocol settings.

For HTTPS (HTTP over TLS) connections, settings are applied to the protocol
negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension. ||
|| allow_http10 | **bool**

Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.

Includes only one of the fields `http2_options`, `allow_http10`.

Protocol settings.

For HTTPS (HTTP over TLS) connections, settings are applied to the protocol
negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension. ||
|| rewrite_request_id | **bool**

When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value. ||
|#

## Http2Options {#yandex.cloud.apploadbalancer.v1.Http2Options}

An HTTP/2 options resource.

#|
||Field | Description ||
|| max_concurrent_streams | **int64**

Maximum number of concurrent HTTP/2 streams in a connection. ||
|#

## Redirects {#yandex.cloud.apploadbalancer.v1.Redirects}

A listener redirects resource.

#|
||Field | Description ||
|| http_to_https | **bool**

Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`.

The setting has the same effect as a single, catch-all [HttpRoute](/docs/application-load-balancer/api-ref/grpc/HttpRouter/get#yandex.cloud.apploadbalancer.v1.HttpRoute)
with [RedirectAction.replace_scheme](/docs/application-load-balancer/api-ref/grpc/HttpRouter/get#yandex.cloud.apploadbalancer.v1.RedirectAction) set to `https`. ||
|#

## TlsListener {#yandex.cloud.apploadbalancer.v1.TlsListener}

TLS-encrypted (HTTP or TCP stream) listener resource.

#|
||Field | Description ||
|| default_handler | **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler)**

Required field. Settings for handling requests by default, with Server Name
Indication (SNI) not matching any of the `sni_handlers`. ||
|| sni_handlers[] | **[SniMatch](#yandex.cloud.apploadbalancer.v1.SniMatch)**

Settings for handling requests with Server Name Indication (SNI)
matching one of [SniMatch.server_names](#yandex.cloud.apploadbalancer.v1.SniMatch) values. ||
|#

## TlsHandler {#yandex.cloud.apploadbalancer.v1.TlsHandler}

A TLS-encrypted (HTTP or TCP stream) handler resource.

#|
||Field | Description ||
|| http_handler | **[HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler)**

HTTP handler.

Includes only one of the fields `http_handler`, `stream_handler`.

Settings for handling requests. ||
|| stream_handler | **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler)**

Stream (TCP) handler.

Includes only one of the fields `http_handler`, `stream_handler`.

Settings for handling requests. ||
|| certificate_ids[] | **string**

ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/).

RSA and ECDSA certificates are supported, and only the first certificate of each type is used. ||
|#

## StreamHandler {#yandex.cloud.apploadbalancer.v1.StreamHandler}

A stream (TCP) handler resource.

#|
||Field | Description ||
|| backend_group_id | **string**

Required field. ID of the backend group processing requests. For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group).

The backend group type, specified via [BackendGroup.backend](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.BackendGroup.backend), must be `stream`.

To get the list of all available backend groups, make a [BackendGroupService.List](/docs/application-load-balancer/api-ref/grpc/BackendGroup/list#List) request. ||
|| idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection.
If not configured, the default idle timeout is 1 hour. Setting it to 0 disables the timeout. ||
|#

## SniMatch {#yandex.cloud.apploadbalancer.v1.SniMatch}

A SNI handler resource.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the SNI handler. ||
|| server_names[] | **string**

Server names that are matched by the SNI handler. ||
|| handler | **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler)**

Required field. Settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. ||
|#

## StreamListener {#yandex.cloud.apploadbalancer.v1.StreamListener}

A stream (TCP) listener resource.

#|
||Field | Description ||
|| handler | **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler)**

Required field. Settings for handling stream (TCP) requests. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "load_balancer_id": "string",
    "listener_name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "name": "string",
    "description": "string",
    "folder_id": "string",
    "labels": "map<string, string>",
    "status": "Status",
    "region_id": "string",
    "network_id": "string",
    "listeners": [
      {
        "name": "string",
        "endpoints": [
          {
            "addresses": [
              {
                // Includes only one of the fields `external_ipv4_address`, `internal_ipv4_address`, `external_ipv6_address`
                "external_ipv4_address": {
                  "address": "string"
                },
                "internal_ipv4_address": {
                  "address": "string",
                  "subnet_id": "string"
                },
                "external_ipv6_address": {
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
            "http_router_id": "string",
            // Includes only one of the fields `http2_options`, `allow_http10`
            "http2_options": {
              "max_concurrent_streams": "int64"
            },
            "allow_http10": "bool",
            // end of the list of possible fields
            "rewrite_request_id": "bool"
          },
          "redirects": {
            "http_to_https": "bool"
          }
        },
        "tls": {
          "default_handler": {
            // Includes only one of the fields `http_handler`, `stream_handler`
            "http_handler": {
              "http_router_id": "string",
              // Includes only one of the fields `http2_options`, `allow_http10`
              "http2_options": {
                "max_concurrent_streams": "int64"
              },
              "allow_http10": "bool",
              // end of the list of possible fields
              "rewrite_request_id": "bool"
            },
            "stream_handler": {
              "backend_group_id": "string",
              "idle_timeout": "google.protobuf.Duration"
            },
            // end of the list of possible fields
            "certificate_ids": [
              "string"
            ]
          },
          "sni_handlers": [
            {
              "name": "string",
              "server_names": [
                "string"
              ],
              "handler": {
                // Includes only one of the fields `http_handler`, `stream_handler`
                "http_handler": {
                  "http_router_id": "string",
                  // Includes only one of the fields `http2_options`, `allow_http10`
                  "http2_options": {
                    "max_concurrent_streams": "int64"
                  },
                  "allow_http10": "bool",
                  // end of the list of possible fields
                  "rewrite_request_id": "bool"
                },
                "stream_handler": {
                  "backend_group_id": "string",
                  "idle_timeout": "google.protobuf.Duration"
                },
                // end of the list of possible fields
                "certificate_ids": [
                  "string"
                ]
              }
            }
          ]
        },
        "stream": {
          "handler": {
            "backend_group_id": "string",
            "idle_timeout": "google.protobuf.Duration"
          }
        }
        // end of the list of possible fields
      }
    ],
    "allocation_policy": {
      "locations": [
        {
          "zone_id": "string",
          "subnet_id": "string",
          "disable_traffic": "bool",
          "zonal_shift_active": "bool"
        }
      ]
    },
    "log_group_id": "string",
    "security_group_ids": [
      "string"
    ],
    "created_at": "google.protobuf.Timestamp",
    "auto_scale_policy": {
      "min_zone_size": "int64",
      "max_size": "int64"
    },
    "log_options": {
      "log_group_id": "string",
      "discard_rules": [
        {
          "http_codes": [
            "int64"
          ],
          "http_code_intervals": [
            "HttpCodeInterval"
          ],
          "grpc_codes": [
            "google.rpc.Code"
          ],
          "discard_percent": "google.protobuf.Int64Value"
        }
      ],
      "disable": "bool"
    },
    "allow_zonal_shift": "bool"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[AddListenerMetadata](#yandex.cloud.apploadbalancer.v1.AddListenerMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[LoadBalancer](#yandex.cloud.apploadbalancer.v1.LoadBalancer)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## AddListenerMetadata {#yandex.cloud.apploadbalancer.v1.AddListenerMetadata}

#|
||Field | Description ||
|| load_balancer_id | **string**

ID of the application load balancer that the listener is being added to. ||
|| listener_name | **string**

Name of the listener that is being added to the application load balancer. ||
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
|| folder_id | **string**

ID of the folder that the application load balancer belongs to. ||
|| labels | **object** (map<**string**, **string**>)

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
|| region_id | **string**

ID of the region that the application load balancer is located at. ||
|| network_id | **string**

ID of the network that the application load balancer belongs to. ||
|| listeners[] | **[Listener](#yandex.cloud.apploadbalancer.v1.Listener)**

Listeners that belong to the application load balancer.

For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#listener). ||
|| allocation_policy | **[AllocationPolicy](#yandex.cloud.apploadbalancer.v1.AllocationPolicy)**

Locality settings of the application load balancer.

For details about the concept, see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lb-location). ||
|| log_group_id | **string**

ID of the log group that stores access logs of the application load balancer.

The logs can be accessed using a Cloud Functions [trigger for Cloud Logs](/docs/functions/operations/trigger/cloud-logging-trigger-create). ||
|| security_group_ids[] | **string**

ID's of the security groups attributed to the application load balancer.

For details about the concept,
see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#security-groups). ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| auto_scale_policy | **[AutoScalePolicy](#yandex.cloud.apploadbalancer.v1.AutoScalePolicy)**

Scaling settings of the application load balancer.

The scaling settings relate to a special internal instance group which facilitates the balancer's work.
Instances in this group are called _resource units_. The group is scaled automatically based on incoming load
and within limitations specified in these settings.

For details about the concept,
see [documentation](/docs/application-load-balancer/concepts/application-load-balancer#lcu-scaling). ||
|| log_options | **[LogOptions](#yandex.cloud.apploadbalancer.v1.LogOptions)**

Cloud logging settings of the application load balancer. ||
|| allow_zonal_shift | **bool**

Specifies whether application load balancer is available to zonal shift. ||
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
|| http | **[HttpListener](#yandex.cloud.apploadbalancer.v1.HttpListener2)**

Unencrypted HTTP listener settings.

Includes only one of the fields `http`, `tls`, `stream`.

Listener type and settings. ||
|| tls | **[TlsListener](#yandex.cloud.apploadbalancer.v1.TlsListener2)**

TLS-encrypted HTTP or TCP stream listener settings.

All handlers within a listener ([TlsListener.default_handler](#yandex.cloud.apploadbalancer.v1.TlsListener2) and [TlsListener.sni_handlers](#yandex.cloud.apploadbalancer.v1.TlsListener2)) must be of one
type, [HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler2) or [StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler2). Mixing HTTP and TCP stream traffic in a TLS-encrypted listener is not
supported.

Includes only one of the fields `http`, `tls`, `stream`.

Listener type and settings. ||
|| stream | **[StreamListener](#yandex.cloud.apploadbalancer.v1.StreamListener2)**

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
|| external_ipv4_address | **[ExternalIpv4Address](#yandex.cloud.apploadbalancer.v1.ExternalIpv4Address)**

Public IPv4 endpoint address.

Includes only one of the fields `external_ipv4_address`, `internal_ipv4_address`, `external_ipv6_address`.

Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address. ||
|| internal_ipv4_address | **[InternalIpv4Address](#yandex.cloud.apploadbalancer.v1.InternalIpv4Address)**

Internal IPv4 endpoint address.

To enable the use of listeners with internal addresses, [contact support](/docs/support/overview#response-time).

Includes only one of the fields `external_ipv4_address`, `internal_ipv4_address`, `external_ipv6_address`.

Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address. ||
|| external_ipv6_address | **[ExternalIpv6Address](#yandex.cloud.apploadbalancer.v1.ExternalIpv6Address)**

Public IPv6 endpoint address.

Includes only one of the fields `external_ipv4_address`, `internal_ipv4_address`, `external_ipv6_address`.

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
|| subnet_id | **string**

ID of the subnet that the address belongs to. ||
|#

## ExternalIpv6Address {#yandex.cloud.apploadbalancer.v1.ExternalIpv6Address}

A public (external) IPv4 endpoint address resource.

#|
||Field | Description ||
|| address | **string**

IPv6 address. ||
|#

## HttpListener {#yandex.cloud.apploadbalancer.v1.HttpListener2}

An HTTP listener resource.

#|
||Field | Description ||
|| handler | **[HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler2)**

Settings for handling HTTP requests.

Only one of `handler` and `redirects` can be specified. ||
|| redirects | **[Redirects](#yandex.cloud.apploadbalancer.v1.Redirects2)**

Redirects settings.

Only one of `redirects` and `handler` can be specified. ||
|#

## HttpHandler {#yandex.cloud.apploadbalancer.v1.HttpHandler2}

An HTTP handler resource.

#|
||Field | Description ||
|| http_router_id | **string**

ID of the HTTP router processing requests. For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/http-router).

To get the list of all available HTTP routers, make a [HttpRouterService.List](/docs/application-load-balancer/api-ref/grpc/HttpRouter/list#List) request. ||
|| http2_options | **[Http2Options](#yandex.cloud.apploadbalancer.v1.Http2Options2)**

HTTP/2 settings.

If specified, incoming HTTP/2 requests are supported by the listener.

Includes only one of the fields `http2_options`, `allow_http10`.

Protocol settings.

For HTTPS (HTTP over TLS) connections, settings are applied to the protocol
negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension. ||
|| allow_http10 | **bool**

Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.

Includes only one of the fields `http2_options`, `allow_http10`.

Protocol settings.

For HTTPS (HTTP over TLS) connections, settings are applied to the protocol
negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension. ||
|| rewrite_request_id | **bool**

When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value. ||
|#

## Http2Options {#yandex.cloud.apploadbalancer.v1.Http2Options2}

An HTTP/2 options resource.

#|
||Field | Description ||
|| max_concurrent_streams | **int64**

Maximum number of concurrent HTTP/2 streams in a connection. ||
|#

## Redirects {#yandex.cloud.apploadbalancer.v1.Redirects2}

A listener redirects resource.

#|
||Field | Description ||
|| http_to_https | **bool**

Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`.

The setting has the same effect as a single, catch-all [HttpRoute](/docs/application-load-balancer/api-ref/grpc/HttpRouter/get#yandex.cloud.apploadbalancer.v1.HttpRoute)
with [RedirectAction.replace_scheme](/docs/application-load-balancer/api-ref/grpc/HttpRouter/get#yandex.cloud.apploadbalancer.v1.RedirectAction) set to `https`. ||
|#

## TlsListener {#yandex.cloud.apploadbalancer.v1.TlsListener2}

TLS-encrypted (HTTP or TCP stream) listener resource.

#|
||Field | Description ||
|| default_handler | **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler2)**

Required field. Settings for handling requests by default, with Server Name
Indication (SNI) not matching any of the `sni_handlers`. ||
|| sni_handlers[] | **[SniMatch](#yandex.cloud.apploadbalancer.v1.SniMatch2)**

Settings for handling requests with Server Name Indication (SNI)
matching one of [SniMatch.server_names](#yandex.cloud.apploadbalancer.v1.SniMatch2) values. ||
|#

## TlsHandler {#yandex.cloud.apploadbalancer.v1.TlsHandler2}

A TLS-encrypted (HTTP or TCP stream) handler resource.

#|
||Field | Description ||
|| http_handler | **[HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler2)**

HTTP handler.

Includes only one of the fields `http_handler`, `stream_handler`.

Settings for handling requests. ||
|| stream_handler | **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler2)**

Stream (TCP) handler.

Includes only one of the fields `http_handler`, `stream_handler`.

Settings for handling requests. ||
|| certificate_ids[] | **string**

ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/).

RSA and ECDSA certificates are supported, and only the first certificate of each type is used. ||
|#

## StreamHandler {#yandex.cloud.apploadbalancer.v1.StreamHandler2}

A stream (TCP) handler resource.

#|
||Field | Description ||
|| backend_group_id | **string**

Required field. ID of the backend group processing requests. For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group).

The backend group type, specified via [BackendGroup.backend](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.BackendGroup.backend), must be `stream`.

To get the list of all available backend groups, make a [BackendGroupService.List](/docs/application-load-balancer/api-ref/grpc/BackendGroup/list#List) request. ||
|| idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection.
If not configured, the default idle timeout is 1 hour. Setting it to 0 disables the timeout. ||
|#

## SniMatch {#yandex.cloud.apploadbalancer.v1.SniMatch2}

A SNI handler resource.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the SNI handler. ||
|| server_names[] | **string**

Server names that are matched by the SNI handler. ||
|| handler | **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler2)**

Required field. Settings for handling requests with Server Name Indication (SNI) matching one of `server_names` values. ||
|#

## StreamListener {#yandex.cloud.apploadbalancer.v1.StreamListener2}

A stream (TCP) listener resource.

#|
||Field | Description ||
|| handler | **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler2)**

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
|| zone_id | **string**

Required field. ID of the availability zone where the application load balancer resides.

Each availability zone can only be specified once. ||
|| subnet_id | **string**

ID of the subnet that the application load balancer belongs to. ||
|| disable_traffic | **bool**

Disables the load balancer node in the specified availability zone.

Backends in the availability zone are not directly affected by this setting.
They still may receive traffic from the load balancer nodes in other availability zones,
subject to [LoadBalancingConfig.locality_aware_routing_percent](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig) and [LoadBalancingConfig.strict_locality](/docs/application-load-balancer/api-ref/grpc/BackendGroup/get#yandex.cloud.apploadbalancer.v1.LoadBalancingConfig) settings. ||
|| zonal_shift_active | **bool**

Show zonal shift status for the location. ||
|#

## AutoScalePolicy {#yandex.cloud.apploadbalancer.v1.AutoScalePolicy}

A resource for scaling settings of an application load balancer.

#|
||Field | Description ||
|| min_zone_size | **int64**

Lower limit for the number of resource units in each availability zone.

If not specified previously (using other instruments such as management console), the default value is 2.
To revert to it, specify it explicitly.

The minimum value is 2. ||
|| max_size | **int64**

Upper limit for the total number of resource units across all availability zones.

If a positive value is specified, it must be at least `min_zone_size` multiplied by the size of
[AllocationPolicy.locations](#yandex.cloud.apploadbalancer.v1.AllocationPolicy).

If the value is 0, there is no upper limit. ||
|#

## LogOptions {#yandex.cloud.apploadbalancer.v1.LogOptions}

#|
||Field | Description ||
|| log_group_id | **string**

Cloud Logging log group ID to store access logs.
If not set then logs will be stored in default log group for the folder
where load balancer located. ||
|| discard_rules[] | **[LogDiscardRule](#yandex.cloud.apploadbalancer.v1.LogDiscardRule)**

ordered list of rules, first matching rule applies ||
|| disable | **bool**

Do not send logs to Cloud Logging log group. ||
|#

## LogDiscardRule {#yandex.cloud.apploadbalancer.v1.LogDiscardRule}

LogDiscardRule discards a fraction of logs with certain codes.
If neither codes or intervals are provided, rule applies to all logs.

#|
||Field | Description ||
|| http_codes[] | **int64**

HTTP codes that should be discarded. ||
|| http_code_intervals[] | enum **HttpCodeInterval**

Groups of HTTP codes like 4xx that should be discarded.

- `HTTP_CODE_INTERVAL_UNSPECIFIED`
- `HTTP_1XX`
- `HTTP_2XX`
- `HTTP_3XX`
- `HTTP_4XX`
- `HTTP_5XX`
- `HTTP_ALL` ||
|| grpc_codes[] | **[google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto)**

GRPC codes that should be discarded ||
|| discard_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Percent of logs to be discarded: 0 - keep all, 100 or unset - discard all ||
|#