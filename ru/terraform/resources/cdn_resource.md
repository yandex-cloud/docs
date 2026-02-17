---
subcategory: Cloud CDN
---

# yandex_cdn_resource (Resource)

Allows management of [Yandex Cloud CDN Resource](https://yandex.cloud/docs/cdn/concepts/resource).

## Example usage

```terraform
//
// Create a new CDN Resource
//
resource "yandex_cdn_resource" "my_resource" {
  cname               = "cdn1.yandex-example.ru"
  active              = false
  origin_protocol     = "https"
  secondary_hostnames = ["cdn-example-1.yandex.ru", "cdn-example-2.yandex.ru"]
  origin_group_id     = yandex_cdn_origin_group.foo_cdn_group_by_id.id

  options {
    edge_cache_settings = 345600
    ignore_cookie       = true
    static_request_headers = {
      is-from-cdn = "yes"
    }
    static_response_headers = {
      is-cdn = "yes"
    }
  }
}
```

## Arguments & Attributes Reference

- `active` (Bool). Flag to create Resource either in active or disabled state. `True` - the content from CDN is available to clients.
- `cname` (**Required**)(String). CDN endpoint CNAME, must be unique among resources.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `origin_group_id` (String). The ID of a specific origin group.
- `origin_group_name` (String). The name of a specific origin group.
- `origin_protocol` (String). Protocol of origin resource. `http` or `https`.
- `provider_cname` (*Read-Only*) (String). Provider CNAME of CDN resource, computed value for read and update operations.
- `provider_type` (String). CDN provider is a content delivery service provider. Possible values: "ourcdn" (default) or "gcore"
- `secondary_hostnames` (Set Of String). List of secondary hostname strings.
- `shielding` (String). Shielding is a Cloud CDN feature that helps reduce the load on content origins from CDN servers.
Specify location id to enable shielding. See https://yandex.cloud/en/docs/cdn/operations/resources/enable-shielding
- `updated_at` (String). Last update timestamp. Computed value for read and update operations.
- `options` [Block]. CDN Resource settings and options to tune CDN edge behavior.
  - `allowed_http_methods` (List Of String). HTTP methods for your CDN content. By default the following methods are allowed: GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS. In case some methods are not allowed to the user, they will get the 405 (Method Not Allowed) response. If the method is not supported, the user gets the 501 (Not Implemented) response.
  - `browser_cache_settings` (Number). Set up a cache period for the end-users browser. Content will be cached due to origin settings. If there are no cache settings on your origin, the content will not be cached. The list of HTTP response codes that can be cached in browsers: 200, 201, 204, 206, 301, 302, 303, 304, 307, 308. Other response codes will not be cached. The default value is 4 days.
  - `cache_http_headers` (List Of String). List HTTP headers that must be included in responses to clients.
  - `cors` (List Of String). Parameter that lets browsers get access to selected resources from a domain different to a domain from which the request is received.
  - `custom_host_header` (String). Custom value for the Host header. Your server must be able to process requests with the chosen header.
  - `custom_server_name` (String). Wildcard additional CNAME. If a resource has a wildcard additional CNAME, you can use your own certificate for content delivery via HTTPS.
  - `disable_cache` (Bool). Setup a cache status.
  - `disable_proxy_force_ranges` (Bool). Disabling proxy force ranges.
  - `edge_cache_settings` (Number). Content will be cached according to origin cache settings. The value applies for a response with codes 200, 201, 204, 206, 301, 302, 303, 304, 307, 308 if an origin server does not have caching HTTP headers. Responses with other codes will not be cached.
  - `enable_ip_url_signing` (Bool). Enable access limiting by IP addresses, option available only with setting secure_key.
  - `fetched_compressed` (Bool). Option helps you to reduce the bandwidth between origin and CDN servers. Also, content delivery speed becomes higher because of reducing the time for compressing files in a CDN.
  - `forward_host_header` (Bool). Choose the Forward Host header option if is important to send in the request to the Origin the same Host header as was sent in the request to CDN server.
  - `gzip_on` (Bool). GZip compression at CDN servers reduces file size by 70% and can be as high as 90%.
  - `ignore_cookie` (Bool). Set for ignoring cookie.
  - `ignore_query_params` (Bool). Files with different query parameters are cached as objects with the same key regardless of the parameter value. selected by default.
  - `proxy_cache_methods_set` (Bool). Allows caching for GET, HEAD and POST requests.
  - `query_params_blacklist` (List Of String). Files with the specified query parameters are cached as objects with the same key, files with other parameters are cached as objects with different keys.
  - `query_params_whitelist` (List Of String). Files with the specified query parameters are cached as objects with different keys, files with other parameters are cached as objects with the same key.
  - `redirect_http_to_https` (Bool). Set up a redirect from HTTP to HTTPS.
  - `redirect_https_to_http` (Bool). Set up a redirect from HTTPS to HTTP.
  - `rewrite_flag` (String). Defines flag for the Rewrite option (default: `BREAK`).
`LAST` - Stops processing of the current set of ngx_http_rewrite_module directives and starts a search for a new location matching changed URI.
`BREAK` - Stops processing of the current set of the Rewrite option.
`REDIRECT` - Returns a temporary redirect with the 302 code; It is used when a replacement string does not start with "http://", "https://", or "$scheme"
`PERMANENT` - Returns a permanent redirect with the 301 code.
  - `rewrite_pattern` (String). An option for changing or redirecting query paths. The value must have the following format: `<source path> <destination path>`, where both paths are regular expressions which use at least one group. E.g., `/foo/(.*) /bar/$1`.
  - `secure_key` (String). Set secure key for url encoding to protect contect and limit access by IP addresses and time limits.
  - `slice` (Bool). Files larger than 10 MB will be requested and cached in parts (no larger than 10 MB each part). It reduces time to first byte. The origin must support HTTP Range requests.
  - `stale` (List Of String). List of errors which instruct CDN servers to serve stale content to clients. Possible values: `error`, `http_403`, `http_404`, `http_429`, `http_500`, `http_502`, `http_503`, `http_504`, `invalid_header`, `timeout`, `updating`.
  - `static_request_headers` (Map Of String). Set up custom headers that CDN servers will send in requests to origins.
  - `static_response_headers` (Map Of String). Set up a static response header. The header name must be lowercase.
  - `edge_cache_settings_codes` [Block]. Set the cache expiration time for CDN servers
    - `custom_values` (Map Of Number). Caching time for a response with specific codes. These settings have a higher priority than the `value` field. Response code (`304`, `404` for example). Use `any` to specify caching time for all response codes. 
    - `value` (Number). Caching time for a response with codes 200, 206, 301, 302. Responses with codes 4xx, 5xx will not be cached. Use `0` disable to caching. Use `custom_values` field to specify a custom caching time for a response with specific codes.
  - `ip_address_acl` [Block]. IP address access control list. The list of specified IP addresses to be allowed or denied depending on acl policy type.
    - `excepted_values` (List Of String). The list of specified IP addresses to be allowed or denied depending on acl policy type.
    - `policy_type` (String). The policy type for ACL. One of `allow` or `deny` values.
- `ssl_certificate` [Block]. SSL certificate of CDN resource.
  - `certificate_manager_id` (String). Certificate Manager ID.
  - `status` (*Read-Only*) (String). SSL certificate status.
  - `type` (**Required**)(String). SSL certificate type.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_cdn_resource.<resource Name> <resource Id>
terraform import yandex_cdn_resource.my_cdn_resource ...
```
