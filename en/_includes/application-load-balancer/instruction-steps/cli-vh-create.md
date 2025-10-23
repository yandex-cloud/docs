Create a virtual host by specifying its name and these settings:

```bash
yc alb virtual-host create <virtual_host_name> \
  --http-router-name <HTTP_router_name> \
  --authority <domain_1>,<domain_2>,...,<domain_n> \
  --modify-request-header name=Accept-Language,append=ru-RU \
  --modify-response-header name=Accept-Charset,replace=utf-8 \
  --rate-limit rps=100,all-requests \
  --security-profile-id <security_profile_ID>
```

Where:
* `--http-router-name`: HTTP router name.

    Instead of the HTTP router name, you can provide its ID in the `--http-router-id` parameter.
* `--authority`: List of domains for the `Host` header (HTTP/1.1) or the `authority` pseudo-header (HTTP/2) associated with this virtual host, comma-separated. You can use wildcards, e.g., `*.foo.com` or `*-bar.foo.com`. For gRPC traffic, you may specify the load balancer's IP address.

    This is an optional parameter. If not specified, all traffic will be routed to this virtual host.
* `--modify-request-header`: Request HTTP header modification settings in `<property>=<value>` format. Available properties:

    {% include [cli-vh-modify-header-options](./cli-vh-modify-header-options.md) %}

    To modify multiple HTTP headers in a request, include `--modify-request-header` as many times as needed.

    This is an optional parameter; if omitted, request headers go to the backend unchanged.

* `--modify-response-header`: Response HTTP header modification settings in `<property>=<value>` format. Available properties:

    {% include [cli-vh-modify-header-options](./cli-vh-modify-header-options.md) %}

    To modify multiple HTTP headers in a response, include `--modify-response-header` as many times as needed.

    This is an optional parameter; if omitted, response headers go to the client unchanged.

* `--rate-limit`: Request rate limit. Available properties:
    * `rps` or `rpm`: Number of incoming requests per second or per minute.
    * `all-requests`: Limits all incoming requests.
    * `requests-per-ip`: Limits requests per client IP address.

    You can configure only one type of rate limit per virtual host, either `all-requests` or `requests-per-ip`.

    This is an optional parameter; if not specified, no rate limiting is applied.
* `--security-profile-id`: [{{ sws-full-name }}](../../../smartwebsecurity/) [security profile](../../../smartwebsecurity/concepts/profiles.md) ID. A security profile allows you to filter incoming requests, enable [WAF](../../../smartwebsecurity/concepts/waf.md), and set limits on the number of requests for protection against malicious activities. For more information, see [{#T}](../../../smartwebsecurity/concepts/profiles.md). This is an optional parameter.


Result:

```text
name: test-virtual-host
authority:
  - example.com
  - example.org
modify_request_headers:
  - name: Accept-Language
    append: ru-RU
  - name: Accept-Charset
    replace: utf-8
route_options:
  security_profile_id: fevu5fnuk6vf********
rate_limit:
  all_requests:
    per_second: "100"
```