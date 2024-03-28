The name of the metric is written in the `name` label.

Common labels for all {{ cdn-name }} metrics:

| Label | Value |
| ---- | ---- |
| service | Service ID: `cdn` |
| resource_id | [CDN resource](../../../cdn/concepts/resource.md) ID |
| resource_name | Origin domain name |
| resource_type | Resource type: `cdn_resource` |

Service metrics:

| Name<br>Type, units | Description |
| ---- | ---- |
| `edge_bandwidth`<br/>`DGAUGE`, bps | Speed of client connections to CDN servers |
| `edge_requests`<br/>`DGAUGE`, requests | Number of CDN server requests per second |
| `edge_requests_total`<br/>`DGAUGE`, number | Total number of CDN server requests |
| `edge_requests_waf_passed`<br/>`DGAUGE`, number | Total number of CDN server requests allowed by the CDN provider's WAF |
| `edge_requests_waf_blocked`<br/>`DGAUGE`, number | Total number of CDN server requests blocked by the CDN provider's WAF |
| `edge_status_1xx`<br/>`DGAUGE`, number | Number of CDN server responses with `1xx` HTTP status codes |
| `edge_status_2xx`<br/>`DGAUGE`, number | Number of CDN server responses with `2xx` HTTP status codes |
| `edge_status_3xx`<br/>`DGAUGE`, number | Number of CDN server responses with `3xx` HTTP status codes |
| `edge_status_4xx`<br/>`DGAUGE`, number | Number of CDN server responses with `4xx` HTTP status codes |
| `edge_status_5xx`<br/>`DGAUGE`, number | Number of CDN server responses with `5xx` HTTP status codes |
| `edge_hit_ratio`<br/>`DGAUGE` | Cached traffic ratio calculated as:<br/><br/>`1 - Torigin/Ttotal`<br/><br/>Where:<br/><ul><li>`Torigin`: Traffic received from origins.</li><li>`Ttotal`: Total traffic, in bytes, transmitted by a CDN server.</li></ul>The amount of uncached traffic is deducted from the total amount of traffic transmitted by CDN servers. |
| `edge_hit_bytes`<br/>`DGAUGE`, bytes | Amount of cached traffic |
| `origin_bandwidth`<br/>`DGAUGE`, bps | Speed of CDN server connections to [origins](../../../cdn/concepts/origins.md) |
| `origin_requests`<br/>`DGAUGE`, requests/s | Number of origin requests per second |
| `origin_status_1xx`<br/>`DGAUGE`, number | Number of origin responses with `1xx` HTTP status codes |
| `origin_status_2xx`<br/>`DGAUGE`, number | Number of origin responses with `2xx` HTTP status codes |
| `origin_status_3xx`<br/>`DGAUGE`, number | Number of origin responses with `3xx` HTTP status codes |
| `origin_status_4xx`<br/>`DGAUGE`, number | Number of origin responses with `4xx` HTTP status codes |
| `origin_status_5xx`<br/>`DGAUGE`, number | Number of origin responses with `5xx` HTTP status codes |