[Документация Yandex Cloud](../../../../../index.md) > [Yandex Smart Web Security](../../../../index.md) > Справочник API > gRPC (англ.) > [Smart Web Security Load Balancer API](../index.md) > [Domain](index.md) > List

# Smart Web Security Load Balancer API, gRPC: DomainService.List

Lists domains of the specified load balancer.

## gRPC request

**rpc List ([ListDomainsRequest](#yandex.cloud.smartwebsecurity.v1.load_balancer.ListDomainsRequest)) returns ([ListDomainsResponse](#yandex.cloud.smartwebsecurity.v1.load_balancer.ListDomainsResponse))**

## ListDomainsRequest {#yandex.cloud.smartwebsecurity.v1.load_balancer.ListDomainsRequest}

```json
{
  "load_balancer_id": "string"
}
```

#|
||Field | Description ||
|| load_balancer_id | **string**

Required field. ID of the Load balancer that the domain belongs to. ||
|#

## ListDomainsResponse {#yandex.cloud.smartwebsecurity.v1.load_balancer.ListDomainsResponse}

```json
{
  "domains": [
    {
      "name": "string",
      "server_name": "string",
      "description": "string",
      "security_profile_id": "string",
      "http_backend": {
        "targets": [
          {
            "ip_address": "string",
            "description": "string",
            "port": "int64"
          }
        ],
        "use_http2": "bool",
        "use_tls": "bool",
        "sni": "string",
        "trusted_ca_bytes": "string",
        "timeout": "google.protobuf.Duration",
        "idle_timeout": "google.protobuf.Duration",
        "session_affinity": {
          // Includes only one of the fields `connection`, `header`, `cookie`
          "connection": {
            "source_ip": "bool"
          },
          "header": {
            "header_name": "string"
          },
          "cookie": {
            "name": "string",
            "ttl": "google.protobuf.Duration",
            "path": "string"
          }
          // end of the list of possible fields
        }
      },
      "tls_listener": {
        "enabled": "bool",
        "certificate_id": "string",
        "port": "int64",
        "enable_http1": "bool"
      },
      "http_listener": {
        "enabled": "bool",
        "redirect_to_https": "bool",
        "port": "int64"
      },
      "solid_waf_settings": {
        "solid_waf_profile_id": "string",
        "session_affinity": {
          // Includes only one of the fields `connection`, `header`, `cookie`
          "connection": {
            "source_ip": "bool"
          },
          "header": {
            "header_name": "string"
          },
          "cookie": {
            "name": "string",
            "ttl": "google.protobuf.Duration",
            "path": "string"
          }
          // end of the list of possible fields
        },
        "web_app_id": "string"
      },
      "rate_limit": {
        "all_requests_per_second": "int64",
        "requests_per_ip_per_second": "int64"
      }
    }
  ]
}
```

#|
||Field | Description ||
|| domains[] | **[Domain](#yandex.cloud.smartwebsecurity.v1.load_balancer.Domain)**

List of domains. ||
|#

## Domain {#yandex.cloud.smartwebsecurity.v1.load_balancer.Domain}

A domain served by a Smart Web Security load balancer.

#|
||Field | Description ||
|| name | **string**

Unique name of domain within the balancer.
Will be used for monitoring naming and error messages.

Value must match the regular expression ` [a-z][-a-z0-9]{1,56}[a-z0-9] `. ||
|| server_name | **string**

Required field. Server name or wildcard to be matched against SNI in a TLS connection and authority(host) header.
Wildcards are in the form of "*.s.o.m.e".
Allowed: "example.com", "*.example.com".
Not allowed: "*.*.example.com", "*-sub.example.com".

The string length in characters must be 1-255. Value must match the regular expression ` ([*][.])?([a-z0-9]([-a-z0-9]*[a-z0-9])?[.])+[-a-z0-9]{2,} `. ||
|| description | **string**

Domain description.

The maximum string length in characters is 512. ||
|| security_profile_id | **string**

Security Profile ID of SmartWebSecurity service. ||
|| http_backend | **[HttpBackend](#yandex.cloud.smartwebsecurity.v1.load_balancer.HttpBackend)**

Backend settings. ||
|| tls_listener | **[TlsListener](#yandex.cloud.smartwebsecurity.v1.load_balancer.TlsListener)**

Optional TLS listener settings. ||
|| http_listener | **[HttpListener](#yandex.cloud.smartwebsecurity.v1.load_balancer.HttpListener)**

Optional plaintext listener settings. ||
|| solid_waf_settings | **[SolidWafSettings](#yandex.cloud.smartwebsecurity.v1.load_balancer.SolidWafSettings)**

Optional Solid WAF settings. ||
|| rate_limit | **[RateLimit](#yandex.cloud.smartwebsecurity.v1.load_balancer.RateLimit)**

Optional rate limit settings. ||
|#

## HttpBackend {#yandex.cloud.smartwebsecurity.v1.load_balancer.HttpBackend}

#|
||Field | Description ||
|| targets[] | **[Target](#yandex.cloud.smartwebsecurity.v1.load_balancer.Target)**

List of targets.

The number of elements must be in the range 1-20. ||
|| use_http2 | **bool**

Enables HTTP2 for upstream requests.
If not set, HTTP 1.1 will be used by default. ||
|| use_tls | **bool**

Enable TLS for upstream requests. ||
|| sni | **string**

SNI string for TLS connections.
Applicable only if use_tls enabled.

The maximum string length in characters is 255. Value must match the regular expression ` [-.a-z0-9]* `. ||
|| trusted_ca_bytes | **string**

Trusted certificate authority certificates bundle (PEM text).
Applicable only if use_tls enabled. ||
|| timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Backend timeout. If not set, default is 300 seconds. ||
|| idle_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Specifies the idle timeout for the route. If not specified, there is no per-route idle timeout. ||
|| session_affinity | **[SessionAffinity](#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity)**

Session affinity. ||
|#

## Target {#yandex.cloud.smartwebsecurity.v1.load_balancer.Target}

#|
||Field | Description ||
|| ip_address | **string**

IPv4 address.

The string length in characters must be 1-40. ||
|| description | **string**

Target description.

The maximum string length in characters is 128. ||
|| port | **int64**

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
|| source_ip | **bool**

IP address. ||
|#

## HeaderSessionAffinity {#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity.HeaderSessionAffinity}

#|
||Field | Description ||
|| header_name | **string**

Header name.

The string length in characters must be 1-256. ||
|#

## CookieSessionAffinity {#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity.CookieSessionAffinity}

#|
||Field | Description ||
|| name | **string**

Cookie name.

The string length in characters must be 1-256. ||
|| ttl | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

If not set, session cookie will be used (not persisted between browser restarts). ||
|| path | **string**

Optional cookie path.

The string length in characters must be 0-256. ||
|#

## TlsListener {#yandex.cloud.smartwebsecurity.v1.load_balancer.TlsListener}

#|
||Field | Description ||
|| enabled | **bool**

Enable TLS listener. ||
|| certificate_id | **string**

Certificate ID in the Certificate Manager. ||
|| port | **int64**

Listener port. If value is not set, used 443 by default.

Acceptable values are 0 to 65535, inclusive. ||
|| enable_http1 | **bool**

Enables HTTP/1.0 and HTTP/1.1 support and disables HTTP/2. ||
|#

## HttpListener {#yandex.cloud.smartwebsecurity.v1.load_balancer.HttpListener}

#|
||Field | Description ||
|| enabled | **bool**

Enable http (plaintext) listener. ||
|| redirect_to_https | **bool**

Automatically redirect from HTTP to HTTPS.
If TlsListener's port is 443 or not set, redirect URL will be "https://&lt;host&gt;&lt;path&gt;" and "https://&lt;host&gt;:&lt;port&gt;&lt;path&gt;" in other case. ||
|| port | **int64**

Listener port. If value is not set, used 80 by default.

Acceptable values are 0 to 65535, inclusive. ||
|#

## SolidWafSettings {#yandex.cloud.smartwebsecurity.v1.load_balancer.SolidWafSettings}

#|
||Field | Description ||
|| solid_waf_profile_id | **string**

ID of the Solid WAF profile. ||
|| session_affinity | **[SessionAffinity](#yandex.cloud.smartwebsecurity.v1.load_balancer.SessionAffinity)**

Session affinity to analyzers. If not set, ConnectionSessionAffinity will be used. ||
|| web_app_id | **string**

ID of the Solid WAF web app. ||
|#

## RateLimit {#yandex.cloud.smartwebsecurity.v1.load_balancer.RateLimit}

#|
||Field | Description ||
|| all_requests_per_second | **int64**

Rate limit for all requests.
Defaults:
- with SolidWaf enabled: 20000 RPS
- without SolidWaf enabled: unlimited

The minimum value is 0. ||
|| requests_per_ip_per_second | **int64**

Rate limit for individual IP addresses.
Defaults:
- with SolidWaf enabled: 1000 RPS
- without SolidWaf enabled: unlimited

The minimum value is 0. ||
|#