---
editable: false
---

# yc application-load-balancer backend-group add-stream-backend

Add Stream backend to the backend group

#### Command Usage

Syntax:

`yc application-load-balancer backend-group add-stream-backend <BACKEND_GROUP-NAME>|<BACKEND_GROUP-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--backend-group-id` | `string`

Backend group id. ||
|| `--backend-group-name` | `string`

Backend group name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--name` | `string`

A name of the Stream backend to add. ||
|| `--weight` | `int`

Weight of the Stream backend. ||
|| `--port` | `int`

Port of the Stream backend. ||
|| `--target-group-id` | `value[,value]`

Target groups for the backend, --target-group-id id1 --target-group-id=id2 ||
|| `--target-group-name` | `value[,value]`

Target groups for the backend, --target-group-name name1 --target-group-name=name2 ||
|| `--panic-threshold` | `int`

Panic threshold of the Stream backend. ||
|| `--locality-aware-routing-percent` | `int`

Percent of requests to route to the same location for the Stream backend. ||
|| `--strict-locality` | Enables strict locality routing for the Stream backend. ||
|| `--enable-tls` | Enables TLS for the Stream backend. ||
|| `--tls-sni` | `string`

SNI for the backend, --tls-sni=backend.local ||
|| `--tls-trusted-ca-from-file` | `string`

Path to file with trusted CA for the backend ||
|| `--http-healthcheck` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

List of HTTP health checks for backend.

Possible property names:

- `port`: Port of the health check.

- `healthy-threshold`: Healthy threshold of the health check.

- `unhealthy-threshold`: Unhealthy threshold of the health check.

- `timeout`: Timeout of the health check.

- `interval`: Interval of the health check.

- `host`: Host header to use for HTTP health check.

- `path`: Request path to use for HTTP health check.

- `use-http2`: Enables HTTP2 protocol for HTTP health check.

- `expected-statuses`: A list of HTTP response statuses considered healthy. ||
|| `--grpc-healthcheck` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

List of gRPC health checks for backend.

Possible property names:

- `port`: Port of the health check.

- `healthy-threshold`: Healthy threshold of the health check.

- `unhealthy-threshold`: Unhealthy threshold of the health check.

- `timeout`: Timeout of the health check.

- `interval`: Interval of the health check.

- `service-name`: Service name of the gRPC health check. ||
|| `--stream-healthcheck` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

List of stream (TCP) health checks for backend.

Possible property names:

- `port`: Port of the health check.

- `healthy-threshold`: Healthy threshold of the health check.

- `unhealthy-threshold`: Unhealthy threshold of the health check.

- `timeout`: Timeout of the health check.

- `interval`: Interval of the health check.

- `send-text`: Text to send for stream (TCP) health check.

- `receive-text`: Text to receive for stream (TCP) health check. ||
|| `--enable-proxy-protocol` | Enables Proxy protocol for the Stream backend. ||
|| `--keep-connections-on-host-health-failure` | Enables keeping connections on host health failure. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#