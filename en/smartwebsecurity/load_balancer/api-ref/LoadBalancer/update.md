---
editable: false
apiPlayground:
  - url: https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/loadBalancers/{loadBalancerId}
    method: patch
    path:
      type: object
      properties:
        loadBalancerId:
          description: |-
            **string**
            Required field. ID of the load balancer to update.
          type: string
      required:
        - loadBalancerId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `key:value` pairs.
          type: object
          additionalProperties:
            type: string
        name:
          description: |-
            **string**
            Name of the load balancer.
          type: string
        description:
          description: |-
            **string**
            Description of the load balancer.
          type: string
        domains:
          description: |-
            **[Domain](#yandex.cloud.smartwebsecurity.v1.load_balancer.Domain)**
            Domains served by the load balancer.
          type: array
          items:
            $ref: '#/definitions/Domain'
        serviceAccountId:
          description: |-
            **string**
            ID of the service account used to access dependent resources.
          type: string
        deletionProtection:
          description: |-
            **boolean**
            Protects the load balancer from accidental deletion.
          type: boolean
        logOptions:
          description: |-
            **[LogOptions](#yandex.cloud.smartwebsecurity.v1.load_balancer.LogOptions)**
            Cloud Logging settings.
          $ref: '#/definitions/LogOptions'
        resourceUnits:
          description: |-
            **string** (int64)
            Number of initially allocated resource units.
          type: string
          format: int64
        routeOptions:
          description: |-
            **[RouteOptions](#yandex.cloud.smartwebsecurity.v1.load_balancer.RouteOptions)**
            Options that apply to all domains.
          $ref: '#/definitions/RouteOptions'
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
      Domain:
        type: object
        properties:
          name:
            description: |-
              **string**
              Unique name of domain within the balancer.
              Will be used for monitoring naming and error messages.
              Value must match the regular expression ` [a-z][-a-z0-9]{1,56}[a-z0-9] `.
            pattern: '[a-z][-a-z0-9]{1,56}[a-z0-9]'
            type: string
          serverName:
            description: |-
              **string**
              Required field. Server name or wildcard to be matched against SNI in a TLS connection and authority(host) header.
              Wildcards are in the form of "*.s.o.m.e".
              Allowed: "example.com", "*.example.com".
              Not allowed: "*.*.example.com", "*-sub.example.com".
              The string length in characters must be 1-255. Value must match the regular expression ` ([*][.])?([a-z0-9]([-a-z0-9]*[a-z0-9])?[.])+[-a-z0-9]{2,} `.
            pattern: ([*][.])?([a-z0-9]([-a-z0-9]*[a-z0-9])?[.])+[-a-z0-9]{2,}
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
      LogDiscardRule:
        type: object
        properties:
          httpCodes:
            description: |-
              **string** (int64)
              HTTP codes that should be discarded.
              The maximum number of elements is 500. Acceptable values are 100 to 599, inclusive.
            type: array
            items:
              type: string
              format: int64
          httpCodeIntervals:
            description: |-
              **enum** (HttpCodeInterval)
              Groups of HTTP codes like 4xx that should be discarded.
              The maximum number of elements is 10.
              - `HTTP_1XX`: Informational responses (100-199).
              - `HTTP_2XX`: Successful responses (200-299).
              - `HTTP_3XX`: Redirection messages (300-399).
              - `HTTP_4XX`: Client error responses (400-499).
              - `HTTP_5XX`: Server error responses (500-599).
              - `HTTP_ALL`: All HTTP response status codes.
            type: array
            items:
              type: string
              enum:
                - HTTP_CODE_INTERVAL_UNSPECIFIED
                - HTTP_1XX
                - HTTP_2XX
                - HTTP_3XX
                - HTTP_4XX
                - HTTP_5XX
                - HTTP_ALL
          discardPercent:
            description: |-
              **string** (int64)
              Percent of logs to be discarded: 0 - keep all, 100 or unset - discard all.
              Acceptable values are 0 to 100, inclusive.
            type: string
            format: int64
      LogOptions:
        type: object
        properties:
          logGroupId:
            description: |-
              **string**
              ID of Cloud Logging log group.
              Keep empty to use default log group.
              Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
            pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
            type: string
          disable:
            description: |-
              **boolean**
              Do not send logs to Cloud Logging log group.
            type: boolean
          discardRules:
            description: |-
              **[LogDiscardRule](#yandex.cloud.smartwebsecurity.v1.load_balancer.LogDiscardRule)**
              Ordered list of rules, first matching rule applies.
              The maximum number of elements is 30.
            type: array
            items:
              $ref: '#/definitions/LogDiscardRule'
      HeaderModification:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the header.
            type: string
          append:
            description: |-
              **string**
              Append string to the header value.
              Includes only one of the fields `append`, `replace`, `remove`, `rename`.
              Header values support the following formatters:
              https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers
            type: string
          replace:
            description: |-
              **string**
              New value for a header.
              Includes only one of the fields `append`, `replace`, `remove`, `rename`.
              Header values support the following formatters:
              https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers
            type: string
          remove:
            description: |-
              **boolean**
              Remove the header.
              Includes only one of the fields `append`, `replace`, `remove`, `rename`.
              Header values support the following formatters:
              https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers
            type: boolean
          rename:
            description: |-
              **string**
              New name for a header.
              Includes only one of the fields `append`, `replace`, `remove`, `rename`.
              Header values support the following formatters:
              https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers
            type: string
        required:
          - name
        oneOf:
          - required:
              - append
          - required:
              - replace
          - required:
              - remove
          - required:
              - rename
      RouteOptions:
        type: object
        properties:
          modifyRequestHeaders:
            description: |-
              **[HeaderModification](#yandex.cloud.smartwebsecurity.v1.load_balancer.HeaderModification)**
              Apply the following modifications to the request headers.
            type: array
            items:
              $ref: '#/definitions/HeaderModification'
          modifyResponseHeaders:
            description: |-
              **[HeaderModification](#yandex.cloud.smartwebsecurity.v1.load_balancer.HeaderModification)**
              Apply the following modifications to the response headers.
            type: array
            items:
              $ref: '#/definitions/HeaderModification'
---

# Smart Web Security Load Balancer API, REST: LoadBalancer.Update

Updates the specified load balancer.

## HTTP request

```
PATCH https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/loadBalancers/{loadBalancerId}
```

## Path parameters

#|
||Field | Description ||
|| loadBalancerId | **string**

Required field. ID of the load balancer to update. ||
|#

## Body parameters {#yandex.cloud.smartwebsecurity.v1.load_balancer.UpdateLoadBalancerRequest}

```json
{
  "updateMask": "string",
  "labels": "object",
  "name": "string",
  "description": "string",
  "domains": [
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
  ],
  "serviceAccountId": "string",
  "deletionProtection": "boolean",
  "logOptions": {
    "logGroupId": "string",
    "disable": "boolean",
    "discardRules": [
      {
        "httpCodes": [
          "string"
        ],
        "httpCodeIntervals": [
          "string"
        ],
        "discardPercent": "string"
      }
    ]
  },
  "resourceUnits": "string",
  "routeOptions": {
    "modifyRequestHeaders": [
      {
        "name": "string",
        // Includes only one of the fields `append`, `replace`, `remove`, `rename`
        "append": "string",
        "replace": "string",
        "remove": "boolean",
        "rename": "string"
        // end of the list of possible fields
      }
    ],
    "modifyResponseHeaders": [
      {
        "name": "string",
        // Includes only one of the fields `append`, `replace`, `remove`, `rename`
        "append": "string",
        "replace": "string",
        "remove": "boolean",
        "rename": "string"
        // end of the list of possible fields
      }
    ]
  }
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| name | **string**

Name of the load balancer. ||
|| description | **string**

Description of the load balancer. ||
|| domains[] | **[Domain](#yandex.cloud.smartwebsecurity.v1.load_balancer.Domain)**

Domains served by the load balancer. ||
|| serviceAccountId | **string**

ID of the service account used to access dependent resources. ||
|| deletionProtection | **boolean**

Protects the load balancer from accidental deletion. ||
|| logOptions | **[LogOptions](#yandex.cloud.smartwebsecurity.v1.load_balancer.LogOptions)**

Cloud Logging settings. ||
|| resourceUnits | **string** (int64)

Number of initially allocated resource units. ||
|| routeOptions | **[RouteOptions](#yandex.cloud.smartwebsecurity.v1.load_balancer.RouteOptions)**

Options that apply to all domains. ||
|#

## Domain {#yandex.cloud.smartwebsecurity.v1.load_balancer.Domain}

A domain served by a Smart Web Security load balancer.

#|
||Field | Description ||
|| name | **string**

Unique name of domain within the balancer.
Will be used for monitoring naming and error messages.

Value must match the regular expression ` [a-z][-a-z0-9]{1,56}[a-z0-9] `. ||
|| serverName | **string**

Required field. Server name or wildcard to be matched against SNI in a TLS connection and authority(host) header.
Wildcards are in the form of "*.s.o.m.e".
Allowed: "example.com", "*.example.com".
Not allowed: "*.*.example.com", "*-sub.example.com".

The string length in characters must be 1-255. Value must match the regular expression ` ([*][.])?([a-z0-9]([-a-z0-9]*[a-z0-9])?[.])+[-a-z0-9]{2,} `. ||
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

## LogOptions {#yandex.cloud.smartwebsecurity.v1.load_balancer.LogOptions}

#|
||Field | Description ||
|| logGroupId | **string**

ID of Cloud Logging log group.
Keep empty to use default log group.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `. ||
|| disable | **boolean**

Do not send logs to Cloud Logging log group. ||
|| discardRules[] | **[LogDiscardRule](#yandex.cloud.smartwebsecurity.v1.load_balancer.LogDiscardRule)**

Ordered list of rules, first matching rule applies.

The maximum number of elements is 30. ||
|#

## LogDiscardRule {#yandex.cloud.smartwebsecurity.v1.load_balancer.LogDiscardRule}

LogDiscardRule discards a fraction of logs with certain codes.
If neither codes or intervals are provided, rule applies to all logs.

#|
||Field | Description ||
|| httpCodes[] | **string** (int64)

HTTP codes that should be discarded.

The maximum number of elements is 500. Acceptable values are 100 to 599, inclusive. ||
|| httpCodeIntervals[] | **enum** (HttpCodeInterval)

Groups of HTTP codes like 4xx that should be discarded.

The maximum number of elements is 10.

- `HTTP_1XX`: Informational responses (100-199).
- `HTTP_2XX`: Successful responses (200-299).
- `HTTP_3XX`: Redirection messages (300-399).
- `HTTP_4XX`: Client error responses (400-499).
- `HTTP_5XX`: Server error responses (500-599).
- `HTTP_ALL`: All HTTP response status codes. ||
|| discardPercent | **string** (int64)

Percent of logs to be discarded: 0 - keep all, 100 or unset - discard all.

Acceptable values are 0 to 100, inclusive. ||
|#

## RouteOptions {#yandex.cloud.smartwebsecurity.v1.load_balancer.RouteOptions}

#|
||Field | Description ||
|| modifyRequestHeaders[] | **[HeaderModification](#yandex.cloud.smartwebsecurity.v1.load_balancer.HeaderModification)**

Apply the following modifications to the request headers. ||
|| modifyResponseHeaders[] | **[HeaderModification](#yandex.cloud.smartwebsecurity.v1.load_balancer.HeaderModification)**

Apply the following modifications to the response headers. ||
|#

## HeaderModification {#yandex.cloud.smartwebsecurity.v1.load_balancer.HeaderModification}

This is similar to the proposal for Envoy API v3, see
https://github.com/envoyproxy/envoy/issues/8947#issuecomment-551973469

#|
||Field | Description ||
|| name | **string**

Required field. Name of the header. ||
|| append | **string**

Append string to the header value.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Header values support the following formatters:
https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers ||
|| replace | **string**

New value for a header.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Header values support the following formatters:
https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers ||
|| remove | **boolean**

Remove the header.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Header values support the following formatters:
https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers ||
|| rename | **string**

New name for a header.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Header values support the following formatters:
https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers ||
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