`--rate-limit`: Request rate limit. Available properties:

* `rps` or `rpm`: Number of incoming requests per second or per minute.
* `all-requests`: Limits all incoming requests.
* `requests-per-ip`: Limits requests per client IP address.

You can configure only one type of rate limit per route, either `all-requests` or `requests-per-ip`.

This is an optional parameter; if not specified, no rate limiting is applied.