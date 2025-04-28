The `name` label contains the metric name.

Labels shared by all {{ cdn-name }} metrics:

Label | Value
----|----
service | Service ID: `cdn`
resource_id | [CDN resource](../../../cdn/concepts/resource.md) ID
resource_name | Origin domain name
resource_type | Resource type: `cdn_resource`

Service metrics:

| Name<br>Type, units | Description |
----|----
`edge_bandwidth`<br/>`DGAUGE`, bits per second | Speed of client connections to CDN servers
`edge_hit_bytes`<br/>`DGAUGE`, bytes | Size of cached traffic
`edge_hit_ratio`<br/>`DGAUGE` | Cached traffic ratio calculated as:<br/><br/>`1 - Torigin/Ttotal`<br/><br/>Where:<br/><ul><li>`Torigin`: Traffic received from origins.</li><li>`Ttotal`: Total traffic transmitted by a CDN server, in bytes.</li></ul>The size of uncached traffic is subtracted from the total traffic transmitted by CDN servers.
`edge_requests`<br/>`DGAUGE`, requests per second | Number of CDN server requests per second
`edge_requests_total`<br/>`DGAUGE`, count | Total CDN server requests
`edge_requests_waf_blocked`<br/>`DGAUGE`, count | Total CDN server requests blocked by the CDN provider's WAF
`edge_requests_waf_passed`<br/>`DGAUGE`, count | Total CDN server requests allowed by the CDN provider's WAF
`edge_status_1xx`<br/>`DGAUGE`, count | Number of CDN server responses with the `1xx` HTTP status code
`edge_status_2xx`<br/>`DGAUGE`, count | Number of CDN server responses with the `2xx` HTTP status code
`edge_status_3xx`<br/>`DGAUGE`, count | Number of CDN server responses with the `3xx` HTTP status code
`edge_status_4xx`<br/>`DGAUGE`, count | Number of CDN server responses with the `4xx` HTTP status code
`edge_status_5xx`<br/>`DGAUGE`, count | Number of CDN server responses with the `5xx` HTTP status code
`origin_bandwidth`<br/>`DGAUGE`, bits per second | Speed of CDN server connections to the [origin](../../../cdn/concepts/origins.md)
`origin_requests`<br/>`DGAUGE`, requests per second | Number of origin requests per second
`origin_status_1xx`<br/>`DGAUGE`, count | Number of origin responses with the `1xx` HTTP status code
`origin_status_2xx`<br/>`DGAUGE`, count | Number of origin responses with the `2xx` HTTP status code
`origin_status_3xx`<br/>`DGAUGE`, count | Number of origin responses with the `3xx` HTTP status code
`origin_status_4xx`<br/>`DGAUGE`, count | Number of origin responses with the `4xx` HTTP status code
`origin_status_5xx`<br/>`DGAUGE`, count | Number of origin responses with the `5xx` HTTP status code