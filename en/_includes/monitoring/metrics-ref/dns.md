The `name` label contains the metric name.

All {{ dns-name }} metrics share the `service=dns` label.

## Service metrics {#service-metrics}

| Name<br>Type, units | Description |
| --- | --- |
`network_requests`<br/>`DGAUGE`, requests per second | Total requests from a network per second (RPS) for each request type.<br/>Labels:<ul><li>`network`: Network ID or name.</li><li>`request_type`: Type of the request. It can be either `authoritative` (for requests with a response from {{ dns-name }}) or `forward` (for requests redirected to an external resolver).</li><li>`resource_type`: Resource type, which is always `network`.</li><li>`response_status`: Response status, which can be `noerror`, `servfail`, `nxdomain`, or other.</li></ul>
`zone_requests`<br/>`DGAUGE`, requests per second | Total requests to zone records per second (RPS) for all clients. For public zones, this applies to all users; for private zones, this applies to users from peered networks.<br/>Labels:<ul><li>`resource_type`: Resource type, which is always `zone`.</li><li>`response_status`: Response status, which can be `noerror`, `servfail`, `nxdomain`, or other.</li><li>`zone`: Zone ID or name.</li></ul>