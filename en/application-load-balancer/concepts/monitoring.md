# Monitoring and logging

## Statistics {#stats}

{% note info %}

For **{{ ui-key.yacloud.alb.label_listener-type-stream }}** listeners, the system does not collect statistics on individual HTTP requests.

{% endnote %}

Load balancer statistics are automatically logged in the [{{ monitoring-full-name }}](../../monitoring/) metrics. The following dashboards and measures are available:

* **HTTP statistics**:

  * **RPS**: Number of load balancer requests per second.
  * **4XX**, **5XX**: Number of load balancer responses containing HTTP codes 4XX and 5XX and the [corresponding gRPC codes](../../api-design-guide/concepts/errors.md#error-list) per second.
  * **Request size**: Total volume of load balancer requests per second.
  * **Response size**: Total volume of load balancer responses per second.
  * **Latency**: Response delay (the time between the balancer receiving the first byte of a request to sending the last byte of the response), 50th to 99th percentiles.

* **Capacity statistics**:

  * **Active connections**: Number of active connections.
  * **Connections per second**: Number of connections per second.
  * **Requests per second**: Number of requests per second.
  * **Bytes per second**: Amount of data handled per second.

For a full list of metrics delivered to {{ monitoring-full-name }}, see the [reference](../metrics.md).

{{ alb-name }} has aggregate load balancer statistics available. In {{ monitoring-name }} , you can view statistics itemized by the resources associated with the load balancer (HTTP routers, virtual hosts, routes, and the like) as well as [create alerts](../../monitoring/operations/alert/create-alert.md).

For instructions on viewing statistics, see [{#T}](../operations/application-load-balancer-get-stats.md).

## Logging {#logging}

You can [configure](../operations/application-load-balancer-manage-logs.md) the delivery of load balancer logs to a {{ cloud-logging-full-name }} [log group](../../logging/concepts/log-group.md).

For more information on how to view logs, see [{#T}](../operations/application-load-balancer-get-logs.md).

The [X-Forwarded-For](https://en.wikipedia.org/wiki/X-Forwarded-For) (XFF) header value is logged as per [RFC 7239](https://datatracker.ietf.org/doc/html/rfc7239). You can find the full list of logged parameters in the [log reference](../logs-ref.md). 

You can also [send load balancer logs to a PostgreSQL DB](../tutorials/logging.md).

### Log discard rules {#discard-logs-rules}

Writing and storing logs in {{ cloud-logging-name }} is charged based on the service [pricing rules](../../logging/pricing.md#prices). To log less data, add log discard rules.

Possible rules:

#|
|| **Rule** | **Value** ||
||**HTTP codes**
|
* `100`: Continue
* `101`: Switching Protocol
* `102`: Processing
* `200`: OK
* `201`: Created
* `202`: Accepted
* `203`: Non Authoritative Information
* `204`: No Content
* `205`: Reset Content
* `206`: Partial Content
* `207`: Multi-Status
* `300`: Multiple Choices
* `301`: Moved Permanently
* `302`: Found
* `303`: See Other
* `304`: Not Modified
* `305`: Use Proxy
* `307`: Temporary Redirect
* `308`: Permanent Redirect
* `400`: Bad Request
* `401`: Unauthorized
* `402`: Payment Required
* `403`: Forbidden
* `404`: Not Found
* `405`: Method Not Allowed
* `406`: Not Acceptable
* `407`: Proxy Authentication Required
* `408`: Request Timeout
* `409`: Conflict
* `410`: Gone
* `411`: Length Required
* `412`: Precondition Failed
* `413`: Request Entity Too Large
* `414`: Request-URI Too Long
* `415`: Unsupported Media Type
* `416`: Requested Range Not Satisfiable
* `417`: Expectation Failed
* `418`: I'm a teapot
* `419`: Insufficient Space on Resource
* `420`: Method Failure
* `422`: Unprocessable Entity
* `423`: Locked
* `424`: Failed Dependency
* `428`: Precondition Required
* `429`: Too Many Requests
* `431`: Request Header Fields Too Large
* `451`: Unavailable For Legal Reasons
* `500`: Internal Server Error
* `501`: Not Implemented
* `502`: Bad Gateway
* `503`: Service Unavailable
* `504`: Gateway Timeout
* `505`: HTTP Version Not Supported
* `507`: Insufficient Storage
* `511`: Network Authentication Required||
||**HTTP code classes**
|
* `1XX`
* `2XX`
* `3XX`
* `4XX`
* `5XX`
* `ALL`||
||**gRPC codes**
|
* `GRPC_OK`
* `GRPC_CANCELLED`
* `GRPC_UNKNOWN`
* `GRPC_INVALID_ARGUMENT`
* `GRPC_DEADLINE_EXCEEDED`
* `GRPC_NOT_FOUND`
* `GRPC_ALREADY_EXISTS`
* `GRPC_PERMISSION_DENIED`
* `GRPC_UNAUTHENTICATED`
* `GRPC_RESOURCE_EXHAUSTED`
* `GRPC_FAILED_PRECONDITION`
* `GRPC_ABORTED`
* `GRPC_OUT_OF_RANGE`
* `GRPC_UNIMPLEMENTED`
* `GRPC_INTERNAL`
* `GRPC_UNAVAILABLE`||
|#

#### See also {#see-also}

* [{#T}](./function-monitoring.md)
* [{#T}](../operations/application-load-balancer-manage-alerts.md)