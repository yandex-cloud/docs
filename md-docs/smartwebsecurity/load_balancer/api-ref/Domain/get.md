[Документация Yandex Cloud](../../../../index.md) > [Yandex Smart Web Security](../../../index.md) > Справочник API > REST (англ.) > [Smart Web Security Load Balancer API](../index.md) > [Domain](index.md) > Get

# Smart Web Security Load Balancer API, REST: Domain.Get

Returns the specified domain.

## HTTP request

```
GET https://smartwebsecurity.api.cloud.yandex.net/smartwebsecurity/v1/loadBalancers/{loadBalancerId}/domains/{domainName}
```

## Path parameters

#|
||Field | Description ||
|| loadBalancerId | **string**

Required field. ID of the Load balancer that the domain belongs to. ||
|| domainName | **string**

Required field. Name of the Domain resource to return. ||
|#

## Response {#yandex.cloud.smartwebsecurity.v1.load_balancer.Domain}

**HTTP Code: 200 - OK**

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