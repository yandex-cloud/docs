The `name` label is for the metric name.

Labels shared by all metrics in {{ cdn-name }} with an activated {{ cdn-full-name }} provider:

Label | Value
----|----
service | Service ID: `yccdn`
resource | [CDN resource](../../../cdn/concepts/resource.md) ID
cloud_id | [Cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) ID
folder_id | [Folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) ID

Service metrics:

#|
|| **Name**
**Type, units** | **Description** ||
|| `edge.bytes_sent`
`DGAUGE`, bytes per second | Speed of client connections to CDN servers. ||
|| `edge.requests`
`DGAUGE`, requests per second | Number of CDN server requests per second. ||
|| `edge.requests_cache_status`
`DGAUGE`, requests per second | Number of CDN server requests per second, broken down by response status.
Special labels:
* `HIT`
* `MISS`
* `EXPIRED`
* `NO_CACHE` ||
|| `edge.requests_method`
`DGAUGE`, requests per second | Number of CDN server requests per second, broken down by HTTP method.
Special labels:
* `GET`
* `OPTIONS`
* `HEAD`
* `PUT`
* `POST` ||
|| `edge.requests_status`
`DGAUGE`, requests per second | Number of CDN server requests per second, broken down by response code.
Special labels:
* `2xx`
* `3xx`
* `4xx`
* `5xx` ||
|| `edge.request_time_seconds`.
`DGAUGE`, s | Time to download a file from the CDN server, in percentiles.
Special labels:
* `50`
* `75`
* `90`
* `95`
* `99` ||
|| `origin.bytes_fetched`
`DGAUGE`, bytes per second | Speed of CDN server connections to [origins](../../../cdn/concepts/origins.md). ||
|| `origin.requests`
`DGAUGE`, requests per second | Number of origin requests per second. ||
|| `origin.requests_time_seconds`
`DGAUGE`, s | Time to download a file from the origin, in percentiles.
Special labels:
* `50`
* `75`
* `90`
* `95`
* `99` ||
|#