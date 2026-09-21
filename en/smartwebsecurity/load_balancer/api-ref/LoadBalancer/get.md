---
editable: false
apiPlayground:
  - url: https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/loadBalancers/{loadBalancerId}
    method: get
    path:
      type: object
      properties:
        loadBalancerId:
          description: |-
            **string**
            Required field. ID of the load balancer to return.
          type: string
      required:
        - loadBalancerId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Smart Web Security Load Balancer API, REST: LoadBalancer.Get

Returns the specified load balancer.

## HTTP request

```
GET https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/loadBalancers/{loadBalancerId}
```

## Path parameters

#|
||Field | Description ||
|| loadBalancerId | **string**

Required field. ID of the load balancer to return. ||
|#

## Response {#yandex.cloud.smartwebsecurity.v1.load_balancer.LoadBalancer}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "cloudId": "string",
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
  "createdAt": "string",
  "updatedAt": "string",
  "serviceAccountId": "string",
  "status": "string",
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
  "regionId": "string",
  "deletionProtection": "boolean",
  "ipAddress": "string",
  "resourceUnits": "string",
  "ddosProtectionProvider": "string",
  "logGroupId": "string",
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

A Smart Web Security load balancer resource.

#|
||Field | Description ||
|| id | **string**

ID of the load balancer. ||
|| folderId | **string**

ID of the folder that the load balancer belongs to. ||
|| cloudId | **string**

ID of the cloud that the load balancer belongs to. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| name | **string**

Required field. Name of the load balancer.

The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `. ||
|| description | **string**

Description of the load balancer.

The maximum string length in characters is 512. ||
|| domains[] | **[Domain](#yandex.cloud.smartwebsecurity.v1.load_balancer.Domain)**

Domains served by the load balancer.

The number of elements must be in the range 0-500. ||
|| createdAt | **string** (date-time)

Creation time.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Last time when the load balancer was modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| serviceAccountId | **string**

Required field. Service account for access to certificate, securityProfile and logGroup. ||
|| status | **enum** (Status)

Status of the load balancer.

- `CREATING`: The load balancer is being created.
- `ACTIVE`: The load balancer is active.
- `DELETING`: The load balancer is being deleted.
- `UPDATING`: The load balancer is being updated or started.
- `STOPPING`: The load balancer is being stopped.
- `STOPPED`: The load balancer is stopped and doesn't send traffic to the targets. ||
|| logOptions | **[LogOptions](#yandex.cloud.smartwebsecurity.v1.load_balancer.LogOptions)**

Cloud logging settings. ||
|| regionId | **string**

Required field. "ru-central1", "kz1", etc. ||
|| deletionProtection | **boolean**

Forbids Delete() calls.
NOTE: Deletion in status CREATING still allow even if deletion_protection is set. ||
|| ipAddress | **string**

IP address of resulting balancer. ||
|| resourceUnits | **string** (int64)

Number of initially allocated resource units.
Zero means the minimum configured for the service installation. ||
|| ddosProtectionProvider | **string**

L3-L4 DDoS protection provider. Currently supported: "" or "qrator". ||
|| logGroupId | **string**

Cloud logging log group ID.
If empty string was passed to log options, this field will contain ID of default log group.
If logs are disabled, this field will contain empty string. ||
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