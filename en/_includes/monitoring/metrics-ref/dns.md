{{ dns-name }} service metrics:

| Name<br>Type, unit | Description |
| --- | --- |
| `zone_requests`<br/>`GAUGE`, requests/s | Total requests to zone records per second (RPS) for all clients. For public zones, this applies to all users; for private zones, this applies to users from peered networks.<br/>Labels: <ul><li>`resource_type`: Resource type, always set to `zone`.</li><li>`zone`: Zone ID or name.</li><li>`response_status`: Response status. Possible values: `noerror`, `servfail`, `nxdomain`, etc.</li></ul> |
| `network_requests`<br/>`GAUGE`, requests/s | Total requests from a network per second (RPS) for each request type.<br/>Labels: <ul><li>`resource_type`: Resource type, always set to `network`.</li><li>`zone`: Network ID or name.</li><li>`request_type`: Request type. Possible values include `authoritative` (for requests with a response from {{ dns-name }}) or `forward` (for requests redirected to an external resolver).<li>`response_status`: Response status. Possible values: `noerror`, `servfail`, `nxdomain`, etc.</li></ul> |
