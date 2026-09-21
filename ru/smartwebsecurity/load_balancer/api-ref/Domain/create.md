---
editable: false
apiPlayground:
  - url: https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/loadBalancers/{loadBalancerId}/domains
    method: post
    path:
      type: object
      properties:
        loadBalancerId:
          description: |-
            **string**
            Required field. ID of the Load balancer that the domain belongs to.
          type: string
      required:
        - loadBalancerId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        name:
          description: |-
            **string**
            Unique name of domain within the balancer.
            Will be used for monitoring naming and error messages.
            If empty, will be generated automaticly from server_name.
            Value must match the regular expression ` |[a-z][-a-z0-9]{1,56}[a-z0-9] `.
          pattern: '|[a-z][-a-z0-9]{1,56}[a-z0-9]'
          type: string
        serverName:
          description: |-
            **string**
            Required field. Server name or wildcard to be matched against SNI in a TLS connection and authority(host) header.
            Wildcards are in the form of "*.s.o.m.e".
            Allowed: "example.com", "*.example.com".
            Not allowed: "*.*.example.com", "*-sub.example.com".
            The string length in characters must be 1-255.
          type: string
        description:
          description: |-
            **string**
            Domain description.
            The maximum string length in characters is 512.
          type: string
        securityProfileId:
          description: |-
            **string**
            Security Profile ID of SmartWebSecurity service.
          type: string
        httpBackend:
          description: |-
            **[HttpBackend](#yandex.cloud.smartwebsecurity.v1.load_balancer.HttpBackend)**
            Backend settings.
          $ref: '#/definitions/HttpBackend'
        tlsListener:
          description: |-
            **[TlsListener](#yandex.cloud.smartwebsecurity.v1.load_balancer.TlsListener)**
            Optional TLS listener settings.
          $ref: '#/definitions/TlsListener'
        httpListener:
          description: |-
            **[HttpListener](#yandex.cloud.smartwebsecurity.v1.load_balancer.HttpListener)**
            Optional plaintext listener settings.
          $ref: '#/definitions/HttpListener'
        solidWafSettings:
          description: |-
            **[SolidWafSettings](#yandex.cloud.smartwebsecurity.v1.load_balancer.SolidWafSettings)**
            Optional Solid WAF settings.
          $ref: '#/definitions/SolidWafSettings'
        rateLimit:
          description: |-
            **[RateLimit](#yandex.cloud.smartwebsecurity.v1.load_balancer.RateLimit)**
            Optional rate limit settings.
          $ref: '#/definitions/RateLimit'
      required:
        - serverName
      additionalProperties: false
    definitions:
      Target:
        type: object
        properties:
          ipAddress:
            description: |-
              **string**
              IPv4 address.
              The string length in characters must be 1-40.
            type: string
          description:
            description: |-
              **string**
              Target description.
              The maximum string length in characters is 128.
            type: string
          port:
            description: |-
              **string** (int64)
              Target port.
              Acceptable values are 1 to 65535, inclusive.
            type: string
            format: int64
      ConnectionSessionAffinity:
        type: object
        properties:
          sourceIp:
            description: |-
              **boolean**
              IP address.
            type: boolean
      HeaderSessionAffinity:
        type: object
        properties:
          headerName:
            description: |-
              **string**
              Header name.
              The string length in characters must be 1-256.
            type: string
      CookieSessionAffinity:
        type: object
        properties:
          name:
            description: |-
              **string**
              Cookie name.
              The string length in characters must be 1-256.
            type: string
          ttl:
            description: |-
              **string** (duration)
              If not set, session cookie will be used (not persisted between browser restarts).
            type: string
            format: duration
          path:
            description: |-
              **string**
              Optional cookie path.
              The string length in characters must be 0-256.
            type: string
      SessionAffinity:
        type: object
        properties:
          connection:
            description: |-
              **[ConnectionSessionAffinity](#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity.ConnectionSessionAffinity)**
              Session affinity based on source IP address.
              Includes only one of the fields `connection`, `header`, `cookie`.
            $ref: '#/definitions/ConnectionSessionAffinity'
          header:
            description: |-
              **[HeaderSessionAffinity](#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity.HeaderSessionAffinity)**
              Session affinity based on an HTTP header.
              Includes only one of the fields `connection`, `header`, `cookie`.
            $ref: '#/definitions/HeaderSessionAffinity'
          cookie:
            description: |-
              **[CookieSessionAffinity](#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity.CookieSessionAffinity)**
              Session affinity based on a cookie.
              Includes only one of the fields `connection`, `header`, `cookie`.
            $ref: '#/definitions/CookieSessionAffinity'
        oneOf:
          - required:
              - connection
          - required:
              - header
          - required:
              - cookie
      HttpBackend:
        type: object
        properties:
          targets:
            description: |-
              **[Target](#yandex.cloud.smartwebsecurity.v1.load_balancer.Target)**
              List of targets.
              The number of elements must be in the range 1-20.
            type: array
            items:
              $ref: '#/definitions/Target'
          useHttp2:
            description: |-
              **boolean**
              Enables HTTP2 for upstream requests.
              If not set, HTTP 1.1 will be used by default.
            type: boolean
          useTls:
            description: |-
              **boolean**
              Enable TLS for upstream requests.
            type: boolean
          sni:
            description: |-
              **string**
              SNI string for TLS connections.
              Applicable only if use_tls enabled.
              The maximum string length in characters is 255. Value must match the regular expression ` [-.a-z0-9]* `.
            pattern: '[-.a-z0-9]*'
            type: string
          trustedCaBytes:
            description: |-
              **string**
              Trusted certificate authority certificates bundle (PEM text).
              Applicable only if use_tls enabled.
            type: string
          timeout:
            description: |-
              **string** (duration)
              Backend timeout. If not set, default is 300 seconds.
            type: string
            format: duration
          idleTimeout:
            description: |-
              **string** (duration)
              Specifies the idle timeout for the route. If not specified, there is no per-route idle timeout.
            type: string
            format: duration
          sessionAffinity:
            description: |-
              **[SessionAffinity](#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity)**
              Session affinity.
            $ref: '#/definitions/SessionAffinity'
      TlsListener:
        type: object
        properties:
          enabled:
            description: |-
              **boolean**
              Enable TLS listener.
            type: boolean
          certificateId:
            description: |-
              **string**
              Certificate ID in the Certificate Manager.
            type: string
          port:
            description: |-
              **string** (int64)
              Listener port. If value is not set, used 443 by default.
              Acceptable values are 0 to 65535, inclusive.
            type: string
            format: int64
          enableHttp1:
            description: |-
              **boolean**
              Enables HTTP/1.0 and HTTP/1.1 support and disables HTTP/2.
            type: boolean
      HttpListener:
        type: object
        properties:
          enabled:
            description: |-
              **boolean**
              Enable http (plaintext) listener.
            type: boolean
          redirectToHttps:
            description: |-
              **boolean**
              Automatically redirect from HTTP to HTTPS.
              If TlsListener's port is 443 or not set, redirect URL will be "https://&lt;host&gt;&lt;path&gt;" and "https://&lt;host&gt;:&lt;port&gt;&lt;path&gt;" in other case.
            type: boolean
          port:
            description: |-
              **string** (int64)
              Listener port. If value is not set, used 80 by default.
              Acceptable values are 0 to 65535, inclusive.
            type: string
            format: int64
      SolidWafSettings:
        type: object
        properties:
          solidWafProfileId:
            description: |-
              **string**
              ID of the Solid WAF profile.
            type: string
          sessionAffinity:
            description: |-
              **[SessionAffinity](#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity)**
              Session affinity to analyzers. If not set, ConnectionSessionAffinity will be used.
            $ref: '#/definitions/SessionAffinity'
          webAppId:
            description: |-
              **string**
              ID of the Solid WAF web app.
            type: string
      RateLimit:
        type: object
        properties:
          allRequestsPerSecond:
            description: |-
              **string** (int64)
              Rate limit for all requests.
              Defaults:
              - with SolidWaf enabled: 20000 RPS
              - without SolidWaf enabled: unlimited
              The minimum value is 0.
            type: string
            format: int64
          requestsPerIpPerSecond:
            description: |-
              **string** (int64)
              Rate limit for individual IP addresses.
              Defaults:
              - with SolidWaf enabled: 1000 RPS
              - without SolidWaf enabled: unlimited
              The minimum value is 0.
            type: string
            format: int64
---

# Smart Web Security Load Balancer API, REST: Domain.Create

Creates a domain in the specified load balancer.

## HTTP request

```
POST https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/loadBalancers/{loadBalancerId}/domains
```

## Path parameters

#|
||Field | Description ||
|| loadBalancerId | **string**

Required field. ID of the Load balancer that the domain belongs to. ||
|#

## Body parameters {#yandex.cloud.smartwebsecurity.v1.load_balancer.CreateDomainRequest}

```json
{
  "name": "string",
  "serverName": "string",
  "description": "string",
  "securityProfileId": "string",
  "httpBackend": {
    "targets": [
      {
        "ipAddress": "string",
        "description": "string",
        "port": "string"
      }
    ],
    "useHttp2": "boolean",
    "useTls": "boolean",
    "sni": "string",
    "trustedCaBytes": "string",
    "timeout": "string",
    "idleTimeout": "string",
    "sessionAffinity": {
      // Includes only one of the fields `connection`, `header`, `cookie`
      "connection": {
        "sourceIp": "boolean"
      },
      "header": {
        "headerName": "string"
      },
      "cookie": {
        "name": "string",
        "ttl": "string",
        "path": "string"
      }
      // end of the list of possible fields
    }
  },
  "tlsListener": {
    "enabled": "boolean",
    "certificateId": "string",
    "port": "string",
    "enableHttp1": "boolean"
  },
  "httpListener": {
    "enabled": "boolean",
    "redirectToHttps": "boolean",
    "port": "string"
  },
  "solidWafSettings": {
    "solidWafProfileId": "string",
    "sessionAffinity": {
      // Includes only one of the fields `connection`, `header`, `cookie`
      "connection": {
        "sourceIp": "boolean"
      },
      "header": {
        "headerName": "string"
      },
      "cookie": {
        "name": "string",
        "ttl": "string",
        "path": "string"
      }
      // end of the list of possible fields
    },
    "webAppId": "string"
  },
  "rateLimit": {
    "allRequestsPerSecond": "string",
    "requestsPerIpPerSecond": "string"
  }
}
```

#|
||Field | Description ||
|| name | **string**

Unique name of domain within the balancer.
Will be used for monitoring naming and error messages.
If empty, will be generated automaticly from server_name.

Value must match the regular expression ``` |[a-z][-a-z0-9]{1,56}[a-z0-9] ```. ||
|| serverName | **string**

Required field. Server name or wildcard to be matched against SNI in a TLS connection and authority(host) header.
Wildcards are in the form of "*.s.o.m.e".
Allowed: "example.com", "*.example.com".
Not allowed: "*.*.example.com", "*-sub.example.com".

The string length in characters must be 1-255. ||
|| description | **string**

Domain description.

The maximum string length in characters is 512. ||
|| securityProfileId | **string**

Security Profile ID of SmartWebSecurity service. ||
|| httpBackend | **[HttpBackend](#yandex.cloud.smartwebsecurity.v1.load_balancer.HttpBackend)**

Backend settings. ||
|| tlsListener | **[TlsListener](#yandex.cloud.smartwebsecurity.v1.load_balancer.TlsListener)**

Optional TLS listener settings. ||
|| httpListener | **[HttpListener](#yandex.cloud.smartwebsecurity.v1.load_balancer.HttpListener)**

Optional plaintext listener settings. ||
|| solidWafSettings | **[SolidWafSettings](#yandex.cloud.smartwebsecurity.v1.load_balancer.SolidWafSettings)**

Optional Solid WAF settings. ||
|| rateLimit | **[RateLimit](#yandex.cloud.smartwebsecurity.v1.load_balancer.RateLimit)**

Optional rate limit settings. ||
|#

## HttpBackend {#yandex.cloud.smartwebsecurity.v1.load_balancer.HttpBackend}

#|
||Field | Description ||
|| targets[] | **[Target](#yandex.cloud.smartwebsecurity.v1.load_balancer.Target)**

List of targets.

The number of elements must be in the range 1-20. ||
|| useHttp2 | **boolean**

Enables HTTP2 for upstream requests.
If not set, HTTP 1.1 will be used by default. ||
|| useTls | **boolean**

Enable TLS for upstream requests. ||
|| sni | **string**

SNI string for TLS connections.
Applicable only if use_tls enabled.

The maximum string length in characters is 255. Value must match the regular expression ` [-.a-z0-9]* `. ||
|| trustedCaBytes | **string**

Trusted certificate authority certificates bundle (PEM text).
Applicable only if use_tls enabled. ||
|| timeout | **string** (duration)

Backend timeout. If not set, default is 300 seconds. ||
|| idleTimeout | **string** (duration)

Specifies the idle timeout for the route. If not specified, there is no per-route idle timeout. ||
|| sessionAffinity | **[SessionAffinity](#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity)**

Session affinity. ||
|#

## Target {#yandex.cloud.smartwebsecurity.v1.load_balancer.Target}

#|
||Field | Description ||
|| ipAddress | **string**

IPv4 address.

The string length in characters must be 1-40. ||
|| description | **string**

Target description.

The maximum string length in characters is 128. ||
|| port | **string** (int64)

Target port.

Acceptable values are 1 to 65535, inclusive. ||
|#

## SessionAffinity {#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity}

#|
||Field | Description ||
|| connection | **[ConnectionSessionAffinity](#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity.ConnectionSessionAffinity)**

Session affinity based on source IP address.

Includes only one of the fields `connection`, `header`, `cookie`. ||
|| header | **[HeaderSessionAffinity](#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity.HeaderSessionAffinity)**

Session affinity based on an HTTP header.

Includes only one of the fields `connection`, `header`, `cookie`. ||
|| cookie | **[CookieSessionAffinity](#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity.CookieSessionAffinity)**

Session affinity based on a cookie.

Includes only one of the fields `connection`, `header`, `cookie`. ||
|#

## ConnectionSessionAffinity {#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity.ConnectionSessionAffinity}

#|
||Field | Description ||
|| sourceIp | **boolean**

IP address. ||
|#

## HeaderSessionAffinity {#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity.HeaderSessionAffinity}

#|
||Field | Description ||
|| headerName | **string**

Header name.

The string length in characters must be 1-256. ||
|#

## CookieSessionAffinity {#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity.CookieSessionAffinity}

#|
||Field | Description ||
|| name | **string**

Cookie name.

The string length in characters must be 1-256. ||
|| ttl | **string** (duration)

If not set, session cookie will be used (not persisted between browser restarts). ||
|| path | **string**

Optional cookie path.

The string length in characters must be 0-256. ||
|#

## TlsListener {#yandex.cloud.smartwebsecurity.v1.load_balancer.TlsListener}

#|
||Field | Description ||
|| enabled | **boolean**

Enable TLS listener. ||
|| certificateId | **string**

Certificate ID in the Certificate Manager. ||
|| port | **string** (int64)

Listener port. If value is not set, used 443 by default.

Acceptable values are 0 to 65535, inclusive. ||
|| enableHttp1 | **boolean**

Enables HTTP/1.0 and HTTP/1.1 support and disables HTTP/2. ||
|#

## HttpListener {#yandex.cloud.smartwebsecurity.v1.load_balancer.HttpListener}

#|
||Field | Description ||
|| enabled | **boolean**

Enable http (plaintext) listener. ||
|| redirectToHttps | **boolean**

Automatically redirect from HTTP to HTTPS.
If TlsListener's port is 443 or not set, redirect URL will be "https://&lt;host&gt;&lt;path&gt;" and "https://&lt;host&gt;:&lt;port&gt;&lt;path&gt;" in other case. ||
|| port | **string** (int64)

Listener port. If value is not set, used 80 by default.

Acceptable values are 0 to 65535, inclusive. ||
|#

## SolidWafSettings {#yandex.cloud.smartwebsecurity.v1.load_balancer.SolidWafSettings}

#|
||Field | Description ||
|| solidWafProfileId | **string**

ID of the Solid WAF profile. ||
|| sessionAffinity | **[SessionAffinity](#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity)**

Session affinity to analyzers. If not set, ConnectionSessionAffinity will be used. ||
|| webAppId | **string**

ID of the Solid WAF web app. ||
|#

## RateLimit {#yandex.cloud.smartwebsecurity.v1.load_balancer.RateLimit}

#|
||Field | Description ||
|| allRequestsPerSecond | **string** (int64)

Rate limit for all requests.
Defaults:
- with SolidWaf enabled: 20000 RPS
- without SolidWaf enabled: unlimited

The minimum value is 0. ||
|| requestsPerIpPerSecond | **string** (int64)

Rate limit for individual IP addresses.
Defaults:
- with SolidWaf enabled: 1000 RPS
- without SolidWaf enabled: unlimited

The minimum value is 0. ||
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