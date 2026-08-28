[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Smart Web Security > Resources > sws_domain

# yandex_sws_domain (Resource)

A domain served by a Smart Web Security load balancer.


## Arguments & Attributes Reference

- `description` (String). Domain description.
- `http_backend` [Block]. Backend settings.
  - `idle_timeout` (String). Specifies the idle timeout for the route. If not specified, there is no per-route idle timeout.
  - `session_affinity` [Block]. Session affinity.
    - `connection` [Block]. Session affinity based on source IP address.
      - `source_ip` (Bool). IP address.
    - `cookie` [Block]. Session affinity based on a cookie.
      - `name` (String). Cookie name.
      - `path` (String). Optional cookie path.
      - `ttl` (String). If not set, session cookie will be used (not persisted between browser restarts).
    - `header` [Block]. Session affinity based on an HTTP header.
      - `header_name` (String). Header name.
  - `sni` (String). SNI string for TLS connections.
 Applicable only if use_tls enabled.
  - `target` [Block]. List of targets.
    - `description` (String). Target description.
    - `ip_address` (String). IPv4 address.
    - `port` (Number). Target port.
  - `timeout` (String). Backend timeout. If not set, default is 300 seconds.
  - `trusted_ca_bytes` (String). Trusted certificate authority certificates bundle (PEM text).
 Applicable only if use_tls enabled.
  - `use_http2` (Bool). Enables HTTP2 for upstream requests.
 If not set, HTTP 1.1 will be used by default.
  - `use_tls` (Bool). Enable TLS for upstream requests.
- `http_listener` [Block]. Optional plaintext listener settings.
  - `enabled` (Bool). Enable http (plaintext) listener.
  - `port` (Number). Listener port. If value is not set, used 80 by default.
  - `redirect_to_https` (Bool). Automatically redirect from HTTP to HTTPS.
 If TlsListener's port is 443 or not set, redirect URL will be "https://<host><path>" and "https://<host>:<port><path>" in other case.
- `load_balancer_id` (**Required**)(String). ID of the Load balancer that the domain belongs to.
- `name` (String). Name of the Domain resource to return.
- `rate_limit` [Block]. Optional rate limit settings.
  - `all_requests_per_second` (Number). Rate limit for all requests.
 Defaults:
 - with SolidWaf enabled: 20000 RPS
 - without SolidWaf enabled: unlimited
  - `requests_per_ip_per_second` (Number). Rate limit for individual IP addresses.
 Defaults:
 - with SolidWaf enabled: 1000 RPS
 - without SolidWaf enabled: unlimited
- `security_profile_id` (String). Security Profile ID of SmartWebSecurity service.
- `server_name` (**Required**)(String). Server name or wildcard to be matched against SNI in a TLS connection and authority(host) header.
 Wildcards are in the form of "*.s.o.m.e".
 Allowed: "example.com", "*.example.com".
 Not allowed: "*.*.example.com", "*-sub.example.com".
- `solid_waf_settings` [Block]. Optional Solid WAF settings.
  - `session_affinity` [Block]. Session affinity to analyzers. If not set, ConnectionSessionAffinity will be used.
    - `connection` [Block]. Session affinity based on source IP address.
      - `source_ip` (Bool). IP address.
    - `cookie` [Block]. Session affinity based on a cookie.
      - `name` (String). Cookie name.
      - `path` (String). Optional cookie path.
      - `ttl` (String). If not set, session cookie will be used (not persisted between browser restarts).
    - `header` [Block]. Session affinity based on an HTTP header.
      - `header_name` (String). Header name.
  - `solid_waf_profile_id` (String). ID of the Solid WAF profile.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `tls_listener` [Block]. Optional TLS listener settings.
  - `certificate_id` (String). Certificate ID in the Certificate Manager.
  - `enable_http1` (Bool). Enables HTTP/1.0 and HTTP/1.1 support and disables HTTP/2.
  - `enabled` (Bool). Enable TLS listener.
  - `port` (Number). Listener port. If value is not set, used 443 by default.