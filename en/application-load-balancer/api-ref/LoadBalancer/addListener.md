---
editable: false
apiPlayground:
  - url: https://alb.{{ api-host }}/apploadbalancer/v1/loadBalancers/{loadBalancerId}:addListener
    method: post
    path:
      type: object
      properties:
        loadBalancerId:
          description: |-
            **string**
            Required field. ID of the application load balancer to add a listener to.
          type: string
      required:
        - loadBalancerId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        listenerSpec:
          description: |-
            **[ListenerSpec](#yandex.cloud.apploadbalancer.v1.ListenerSpec)**
            Required field. Listener to add to the application load balancer.
          $ref: '#/definitions/ListenerSpec'
      required:
        - listenerSpec
      additionalProperties: false
    definitions:
      ExternalIpv4AddressSpec:
        type: object
        properties:
          address:
            description: |-
              **string**
              IPv4 address.
            type: string
      InternalIpv4AddressSpec:
        type: object
        properties:
          address:
            description: |-
              **string**
              IPv4 address.
            type: string
          subnetId:
            description: |-
              **string**
              Required field. ID of the subnet that the address belongs to.
            type: string
        required:
          - subnetId
      ExternalIpv6AddressSpec:
        type: object
        properties:
          address:
            description: |-
              **string**
              IPv6 address.
            type: string
      AddressSpec:
        type: object
        properties:
          externalIpv4AddressSpec:
            description: |-
              **[ExternalIpv4AddressSpec](#yandex.cloud.apploadbalancer.v1.ExternalIpv4AddressSpec)**
              Public IPv4 endpoint address.
              Includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`.
              Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address.
            $ref: '#/definitions/ExternalIpv4AddressSpec'
          internalIpv4AddressSpec:
            description: |-
              **[InternalIpv4AddressSpec](#yandex.cloud.apploadbalancer.v1.InternalIpv4AddressSpec)**
              Internal IPv4 endpoint address.
              To enable the use of listeners with internal addresses, [contact support](/docs/support/overview#response-time).
              Includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`.
              Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address.
            $ref: '#/definitions/InternalIpv4AddressSpec'
          externalIpv6AddressSpec:
            description: |-
              **[ExternalIpv6AddressSpec](#yandex.cloud.apploadbalancer.v1.ExternalIpv6AddressSpec)**
              Public IPv6 endpoint address.
              Includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`.
              Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address.
            $ref: '#/definitions/ExternalIpv6AddressSpec'
        oneOf:
          - required:
              - externalIpv4AddressSpec
          - required:
              - internalIpv4AddressSpec
          - required:
              - externalIpv6AddressSpec
      EndpointSpec:
        type: object
        properties:
          addressSpecs:
            description: |-
              **[AddressSpec](#yandex.cloud.apploadbalancer.v1.AddressSpec)**
              Endpoint public (external) and internal addresses.
              The number of elements must be greater than 0.
            type: array
            items:
              $ref: '#/definitions/AddressSpec'
          ports:
            description: |-
              **string** (int64)
              Endpoint ports.
              The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive.
            type: array
            items:
              type: string
              format: int64
      StreamHandler:
        type: object
        properties:
          backendGroupId:
            description: |-
              **string**
              Required field. ID of the backend group processing requests. For details about the concept, see
              [documentation](/docs/application-load-balancer/concepts/backend-group).
              The backend group type, specified via [BackendGroup.backend](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.BackendGroup.backend), must be `stream`.
              To get the list of all available backend groups, make a [BackendGroupService.List](/docs/application-load-balancer/api-ref/BackendGroup/list#List) request.
            type: string
          idleTimeout:
            description: |-
              **string** (duration)
              The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection.
              If not configured, the default idle timeout is 1 hour. Setting it to 0 disables the timeout.
            type: string
            format: duration
        required:
          - backendGroupId
      StreamListener:
        type: object
        properties:
          handler:
            description: |-
              **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler)**
              Required field. Settings for handling stream (TCP) requests.
            $ref: '#/definitions/StreamHandler'
        required:
          - handler
      Http2Options:
        type: object
        properties:
          maxConcurrentStreams:
            description: |-
              **string** (int64)
              Maximum number of concurrent HTTP/2 streams in a connection.
            type: string
            format: int64
      HttpHandler:
        type: object
        properties:
          httpRouterId:
            description: |-
              **string**
              ID of the HTTP router processing requests. For details about the concept, see
              [documentation](/docs/application-load-balancer/concepts/http-router).
              To get the list of all available HTTP routers, make a [HttpRouterService.List](/docs/application-load-balancer/api-ref/HttpRouter/list#List) request.
            type: string
          rewriteRequestId:
            description: |-
              **boolean**
              When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value.
            type: boolean
          http2Options:
            description: |-
              **[Http2Options](#yandex.cloud.apploadbalancer.v1.Http2Options)**
              HTTP/2 settings.
              If specified, incoming HTTP/2 requests are supported by the listener.
              Includes only one of the fields `http2Options`, `allowHttp10`.
              Protocol settings.
              For HTTPS (HTTP over TLS) connections, settings are applied to the protocol
              negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
            $ref: '#/definitions/Http2Options'
          allowHttp10:
            description: |-
              **boolean**
              Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.
              Includes only one of the fields `http2Options`, `allowHttp10`.
              Protocol settings.
              For HTTPS (HTTP over TLS) connections, settings are applied to the protocol
              negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension.
            type: boolean
          preserveHttp1HeaderCasing:
            description: |-
              **boolean**
              When enabled, preserves the original casing of HTTP/1.1 header names (e.g. "CONTENT-Type" -> "CONTENT-Type").
              Has no effect on HTTP/2 connections where headers are always lowercase per RFC 7540.
            type: boolean
        oneOf:
          - required:
              - http2Options
          - required:
              - allowHttp10
      Redirects:
        type: object
        properties:
          httpToHttps:
            description: |-
              **boolean**
              Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`.
              The setting has the same effect as a single, catch-all [HttpRoute](/docs/application-load-balancer/api-ref/HttpRouter/get#yandex.cloud.apploadbalancer.v1.HttpRoute)
              with [RedirectAction.replaceScheme](/docs/application-load-balancer/api-ref/HttpRouter/get#yandex.cloud.apploadbalancer.v1.RedirectAction) set to `https`.
            type: boolean
      HttpListener:
        type: object
        properties:
          handler:
            description: |-
              **[HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler)**
              Settings for handling HTTP requests.
              Only one of `handler` and [redirects](#yandex.cloud.apploadbalancer.v1.HttpListener) can be specified.
            $ref: '#/definitions/HttpHandler'
          redirects:
            description: |-
              **[Redirects](#yandex.cloud.apploadbalancer.v1.Redirects)**
              Redirects settings.
              Only one of `redirects` and [handler](/docs/application-load-balancer/api-ref/LoadBalancer/addSniMatch#yandex.cloud.apploadbalancer.v1.AddSniMatchRequest) can be specified.
            $ref: '#/definitions/Redirects'
      ClientCertificatesVerification:
        type: object
        properties:
          requireClientCertificate:
            description: |-
              **boolean**
              If true, ALB will reject connections without a valid client certificate.
            type: boolean
          bytes:
            description: |-
              **string**
              Trusted certificate authority certificates bundle (PEM text).
              Includes only one of the fields `bytes`.
            type: string
        oneOf:
          - required:
              - bytes
      TlsHandler:
        type: object
        properties:
          streamHandler:
            description: |-
              **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler)**
              Stream (TCP) handler.
              Includes only one of the fields `streamHandler`, `httpHandler`.
              Settings for handling requests.
            $ref: '#/definitions/StreamHandler'
          httpHandler:
            description: |-
              **[HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler)**
              HTTP handler.
              Includes only one of the fields `streamHandler`, `httpHandler`.
              Settings for handling requests.
            $ref: '#/definitions/HttpHandler'
          certificateIds:
            description: |-
              **string**
              ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/).
              RSA and ECDSA certificates are supported, and only the first certificate of each type is used.
              The string length in characters for each value must be greater than 1. The maximum number of elements is 1.
            type: array
            items:
              type: string
          clientCertificatesVerification:
            description: |-
              **[ClientCertificatesVerification](#yandex.cloud.apploadbalancer.v1.ClientCertificatesVerification)**
              Client certificates verification settings.
            $ref: '#/definitions/ClientCertificatesVerification'
        oneOf:
          - required:
              - streamHandler
          - required:
              - httpHandler
      SniMatch:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the SNI handler.
            type: string
          serverNames:
            description: |-
              **string**
              Server names that are matched by the SNI handler.
              The string length in characters for each value must be 1-255. Each value must match the regular expression ` ([*].)?[-.a-z0-9]+ `. The number of elements must be greater than 0.
            pattern: ([*].)?[-.a-z0-9]+
            uniqueItems: true
            type: array
            items:
              type: string
          handler:
            description: |-
              **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler)**
              Required field. Settings for handling requests with Server Name Indication (SNI) matching one of [serverNames](/docs/application-load-balancer/api-ref/LoadBalancer/addSniMatch#yandex.cloud.apploadbalancer.v1.AddSniMatchRequest) values.
            $ref: '#/definitions/TlsHandler'
        required:
          - name
          - handler
      TlsListener:
        type: object
        properties:
          defaultHandler:
            description: |-
              **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler)**
              Required field. Settings for handling requests by default, with Server Name
              Indication (SNI) not matching any of the [sniHandlers](#yandex.cloud.apploadbalancer.v1.TlsListener).
            $ref: '#/definitions/TlsHandler'
          sniHandlers:
            description: |-
              **[SniMatch](#yandex.cloud.apploadbalancer.v1.SniMatch)**
              Settings for handling requests with Server Name Indication (SNI)
              matching one of [SniMatch.serverNames](#yandex.cloud.apploadbalancer.v1.SniMatch) values.
            type: array
            items:
              $ref: '#/definitions/SniMatch'
        required:
          - defaultHandler
      ListenerSpec:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the listener. The name is unique within the application load balancer.
              Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
            pattern: '[a-z][-a-z0-9]{1,61}[a-z0-9]'
            type: string
          endpointSpecs:
            description: |-
              **[EndpointSpec](#yandex.cloud.apploadbalancer.v1.EndpointSpec)**
              Endpoints of the listener.
              Endpoints are defined by their IP addresses and ports.
            type: array
            items:
              $ref: '#/definitions/EndpointSpec'
          stream:
            description: |-
              **[StreamListener](#yandex.cloud.apploadbalancer.v1.StreamListener)**
              Unencrypted stream (TCP) listener settings.
              Includes only one of the fields `stream`, `http`, `tls`.
              Listener type and settings.
            $ref: '#/definitions/StreamListener'
          http:
            description: |-
              **[HttpListener](#yandex.cloud.apploadbalancer.v1.HttpListener)**
              Unencrypted HTTP listener settings.
              Includes only one of the fields `stream`, `http`, `tls`.
              Listener type and settings.
            $ref: '#/definitions/HttpListener'
          tls:
            description: |-
              **[TlsListener](#yandex.cloud.apploadbalancer.v1.TlsListener)**
              TLS-encrypted HTTP or TCP stream listener settings.
              All handlers within a listener ([TlsListener.defaultHandler](#yandex.cloud.apploadbalancer.v1.TlsListener) and [TlsListener.sniHandlers](#yandex.cloud.apploadbalancer.v1.TlsListener)) must be of one
              type, [HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler) or [StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler). Mixing HTTP and TCP stream traffic in a TLS-encrypted listener is not
              supported.
              Includes only one of the fields `stream`, `http`, `tls`.
              Listener type and settings.
            $ref: '#/definitions/TlsListener'
        required:
          - name
        oneOf:
          - required:
              - stream
          - required:
              - http
          - required:
              - tls
---

# Application Load Balancer API, REST: LoadBalancer.AddListener

Adds a listener to the specified application load balancer.

## HTTP request

```
POST https://alb.{{ api-host }}/apploadbalancer/v1/loadBalancers/{loadBalancerId}:addListener
```

## Path parameters

#|
||Field | Description ||
|| loadBalancerId | **string**

Required field. ID of the application load balancer to add a listener to. ||
|#

## Body parameters {#yandex.cloud.apploadbalancer.v1.AddListenerRequest}

```json
{
  "listenerSpec": {
    "name": "string",
    "endpointSpecs": [
      {
        "addressSpecs": [
          {
            // Includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`
            "externalIpv4AddressSpec": {
              "address": "string"
            },
            "internalIpv4AddressSpec": {
              "address": "string",
              "subnetId": "string"
            },
            "externalIpv6AddressSpec": {
              "address": "string"
            }
            // end of the list of possible fields
          }
        ],
        "ports": [
          "string"
        ]
      }
    ],
    // Includes only one of the fields `stream`, `http`, `tls`
    "stream": {
      "handler": {
        "backendGroupId": "string",
        "idleTimeout": "string"
      }
    },
    "http": {
      "handler": {
        "httpRouterId": "string",
        "rewriteRequestId": "boolean",
        // Includes only one of the fields `http2Options`, `allowHttp10`
        "http2Options": {
          "maxConcurrentStreams": "string"
        },
        "allowHttp10": "boolean",
        // end of the list of possible fields
        "preserveHttp1HeaderCasing": "boolean"
      },
      "redirects": {
        "httpToHttps": "boolean"
      }
    },
    "tls": {
      "defaultHandler": {
        // Includes only one of the fields `streamHandler`, `httpHandler`
        "streamHandler": {
          "backendGroupId": "string",
          "idleTimeout": "string"
        },
        "httpHandler": {
          "httpRouterId": "string",
          "rewriteRequestId": "boolean",
          // Includes only one of the fields `http2Options`, `allowHttp10`
          "http2Options": {
            "maxConcurrentStreams": "string"
          },
          "allowHttp10": "boolean",
          // end of the list of possible fields
          "preserveHttp1HeaderCasing": "boolean"
        },
        // end of the list of possible fields
        "certificateIds": [
          "string"
        ],
        "clientCertificatesVerification": {
          "requireClientCertificate": "boolean",
          // Includes only one of the fields `bytes`
          "bytes": "string"
          // end of the list of possible fields
        }
      },
      "sniHandlers": [
        {
          "name": "string",
          "serverNames": [
            "string"
          ],
          "handler": {
            // Includes only one of the fields `streamHandler`, `httpHandler`
            "streamHandler": {
              "backendGroupId": "string",
              "idleTimeout": "string"
            },
            "httpHandler": {
              "httpRouterId": "string",
              "rewriteRequestId": "boolean",
              // Includes only one of the fields `http2Options`, `allowHttp10`
              "http2Options": {
                "maxConcurrentStreams": "string"
              },
              "allowHttp10": "boolean",
              // end of the list of possible fields
              "preserveHttp1HeaderCasing": "boolean"
            },
            // end of the list of possible fields
            "certificateIds": [
              "string"
            ],
            "clientCertificatesVerification": {
              "requireClientCertificate": "boolean",
              // Includes only one of the fields `bytes`
              "bytes": "string"
              // end of the list of possible fields
            }
          }
        }
      ]
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| listenerSpec | **[ListenerSpec](#yandex.cloud.apploadbalancer.v1.ListenerSpec)**

Required field. Listener to add to the application load balancer. ||
|#

## ListenerSpec {#yandex.cloud.apploadbalancer.v1.ListenerSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the listener. The name is unique within the application load balancer.

Value must match the regular expression ` [a-z][-a-z0-9]{1,61}[a-z0-9] `. ||
|| endpointSpecs[] | **[EndpointSpec](#yandex.cloud.apploadbalancer.v1.EndpointSpec)**

Endpoints of the listener.
Endpoints are defined by their IP addresses and ports. ||
|| stream | **[StreamListener](#yandex.cloud.apploadbalancer.v1.StreamListener)**

Unencrypted stream (TCP) listener settings.

Includes only one of the fields `stream`, `http`, `tls`.

Listener type and settings. ||
|| http | **[HttpListener](#yandex.cloud.apploadbalancer.v1.HttpListener)**

Unencrypted HTTP listener settings.

Includes only one of the fields `stream`, `http`, `tls`.

Listener type and settings. ||
|| tls | **[TlsListener](#yandex.cloud.apploadbalancer.v1.TlsListener)**

TLS-encrypted HTTP or TCP stream listener settings.
All handlers within a listener ([TlsListener.defaultHandler](#yandex.cloud.apploadbalancer.v1.TlsListener) and [TlsListener.sniHandlers](#yandex.cloud.apploadbalancer.v1.TlsListener)) must be of one
type, [HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler) or [StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler). Mixing HTTP and TCP stream traffic in a TLS-encrypted listener is not
supported.

Includes only one of the fields `stream`, `http`, `tls`.

Listener type and settings. ||
|#

## EndpointSpec {#yandex.cloud.apploadbalancer.v1.EndpointSpec}

#|
||Field | Description ||
|| addressSpecs[] | **[AddressSpec](#yandex.cloud.apploadbalancer.v1.AddressSpec)**

Endpoint public (external) and internal addresses.

The number of elements must be greater than 0. ||
|| ports[] | **string** (int64)

Endpoint ports.

The number of elements must be greater than 0. Acceptable values are 1 to 65535, inclusive. ||
|#

## AddressSpec {#yandex.cloud.apploadbalancer.v1.AddressSpec}

#|
||Field | Description ||
|| externalIpv4AddressSpec | **[ExternalIpv4AddressSpec](#yandex.cloud.apploadbalancer.v1.ExternalIpv4AddressSpec)**

Public IPv4 endpoint address.

Includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`.

Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address. ||
|| internalIpv4AddressSpec | **[InternalIpv4AddressSpec](#yandex.cloud.apploadbalancer.v1.InternalIpv4AddressSpec)**

Internal IPv4 endpoint address.
To enable the use of listeners with internal addresses, [contact support](/docs/support/overview#response-time).

Includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`.

Endpoint address of one of the types: public (external) IPv4 address, internal IPv4 address, public IPv6 address. ||
|| externalIpv6AddressSpec | **[ExternalIpv6AddressSpec](#yandex.cloud.apploadbalancer.v1.ExternalIpv6AddressSpec)**

Public IPv6 endpoint address.

Includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`, `externalIpv6AddressSpec`.

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
|| subnetId | **string**

Required field. ID of the subnet that the address belongs to. ||
|#

## ExternalIpv6AddressSpec {#yandex.cloud.apploadbalancer.v1.ExternalIpv6AddressSpec}

#|
||Field | Description ||
|| address | **string**

IPv6 address. ||
|#

## StreamListener {#yandex.cloud.apploadbalancer.v1.StreamListener}

A stream (TCP) listener resource.

#|
||Field | Description ||
|| handler | **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler)**

Required field. Settings for handling stream (TCP) requests. ||
|#

## StreamHandler {#yandex.cloud.apploadbalancer.v1.StreamHandler}

A stream (TCP) handler resource.

#|
||Field | Description ||
|| backendGroupId | **string**

Required field. ID of the backend group processing requests. For details about the concept, see
[documentation](/docs/application-load-balancer/concepts/backend-group).
The backend group type, specified via [BackendGroup.backend](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.BackendGroup.backend), must be `stream`.
To get the list of all available backend groups, make a [BackendGroupService.List](/docs/application-load-balancer/api-ref/BackendGroup/list#List) request. ||
|| idleTimeout | **string** (duration)

The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection.
If not configured, the default idle timeout is 1 hour. Setting it to 0 disables the timeout. ||
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
To get the list of all available HTTP routers, make a [HttpRouterService.List](/docs/application-load-balancer/api-ref/HttpRouter/list#List) request. ||
|| rewriteRequestId | **boolean**

When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value. ||
|| http2Options | **[Http2Options](#yandex.cloud.apploadbalancer.v1.Http2Options)**

HTTP/2 settings.
If specified, incoming HTTP/2 requests are supported by the listener.

Includes only one of the fields `http2Options`, `allowHttp10`.

Protocol settings.
For HTTPS (HTTP over TLS) connections, settings are applied to the protocol
negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension. ||
|| allowHttp10 | **boolean**

Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.

Includes only one of the fields `http2Options`, `allowHttp10`.

Protocol settings.
For HTTPS (HTTP over TLS) connections, settings are applied to the protocol
negotiated using TLS [ALPN](https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation) extension. ||
|| preserveHttp1HeaderCasing | **boolean**

When enabled, preserves the original casing of HTTP/1.1 header names (e.g. "CONTENT-Type" -> "CONTENT-Type").
Has no effect on HTTP/2 connections where headers are always lowercase per RFC 7540. ||
|#

## Http2Options {#yandex.cloud.apploadbalancer.v1.Http2Options}

An HTTP/2 options resource.

#|
||Field | Description ||
|| maxConcurrentStreams | **string** (int64)

Maximum number of concurrent HTTP/2 streams in a connection. ||
|#

## Redirects {#yandex.cloud.apploadbalancer.v1.Redirects}

A listener redirects resource.

#|
||Field | Description ||
|| httpToHttps | **boolean**

Redirects all unencrypted HTTP requests to the same URI with scheme changed to `https`.
The setting has the same effect as a single, catch-all [HttpRoute](/docs/application-load-balancer/api-ref/HttpRouter/get#yandex.cloud.apploadbalancer.v1.HttpRoute)
with [RedirectAction.replaceScheme](/docs/application-load-balancer/api-ref/HttpRouter/get#yandex.cloud.apploadbalancer.v1.RedirectAction) set to `https`. ||
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
|| streamHandler | **[StreamHandler](#yandex.cloud.apploadbalancer.v1.StreamHandler)**

Stream (TCP) handler.

Includes only one of the fields `streamHandler`, `httpHandler`.

Settings for handling requests. ||
|| httpHandler | **[HttpHandler](#yandex.cloud.apploadbalancer.v1.HttpHandler)**

HTTP handler.

Includes only one of the fields `streamHandler`, `httpHandler`.

Settings for handling requests. ||
|| certificateIds[] | **string**

ID's of the TLS server certificates from [Certificate Manager](/docs/certificate-manager/).
RSA and ECDSA certificates are supported, and only the first certificate of each type is used.

The string length in characters for each value must be greater than 1. The maximum number of elements is 1. ||
|| clientCertificatesVerification | **[ClientCertificatesVerification](#yandex.cloud.apploadbalancer.v1.ClientCertificatesVerification)**

Client certificates verification settings. ||
|#

## ClientCertificatesVerification {#yandex.cloud.apploadbalancer.v1.ClientCertificatesVerification}

Client certificates verification settings.

#|
||Field | Description ||
|| requireClientCertificate | **boolean**

If true, ALB will reject connections without a valid client certificate. ||
|| bytes | **string**

Trusted certificate authority certificates bundle (PEM text).

Includes only one of the fields `bytes`. ||
|#

## SniMatch {#yandex.cloud.apploadbalancer.v1.SniMatch}

A SNI handler resource.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the SNI handler. ||
|| serverNames[] | **string**

Server names that are matched by the SNI handler.

The string length in characters for each value must be 1-255. Each value must match the regular expression ` ([*].)?[-.a-z0-9]+ `. The number of elements must be greater than 0. ||
|| handler | **[TlsHandler](#yandex.cloud.apploadbalancer.v1.TlsHandler)**

Required field. Settings for handling requests with Server Name Indication (SNI) matching one of `serverNames` values. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#