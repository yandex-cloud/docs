[Документация Yandex Cloud](../../../index.md) > [Yandex Application Load Balancer](../../index.md) > [Справочник CLI (англ.)](../index.md) > [backend-group](index.md) > add-http-backend

# yc application-load-balancer backend-group add-http-backend

Add HTTP backend to the backend group

#### Command Usage

Syntax:

`yc application-load-balancer backend-group add-http-backend <BACKEND_GROUP-NAME>|<BACKEND_GROUP-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--backend-group-id` | `string`

Backend group id. ||
|| `--backend-group-name` | `string`

Backend group name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--name` | `string`

A name of the gRPC backend to add. ||
|| `--weight` | `int`

Weight of the gRPC backend. ||
|| `--port` | `int`

Port of the gRPC backend. ||
|| `--target-group-id` | `[]string`

Target groups for the backend, --target-group-id id1 --target-group-id=id2 ||
|| `--target-group-name` | `[]string`

Target groups for the backend, --target-group-name name1 --target-group-name=name2 ||
|| `--panic-threshold` | `int`

Panic threshold of the gRPC backend. ||
|| `--locality-aware-routing-percent` | `int`

Percent of requests to route to the same location for the gRPC backend. ||
|| `--strict-locality` | Enables strict locality routing for the gRPC backend. ||
|| `--enable-tls` | Enables TLS for the gRPC backend. ||
|| `--tls-sni` | `string`

SNI for the backend, --tls-sni=backend.local ||
|| `--tls-trusted-ca-from-file` | `string`

Path to file with trusted CA for the backend ||
|| `--tls-client-certificate-id` | `string`

Client certificate ID for the backend ||
|| `--http-healthcheck` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

List of HTTP health checks for backend.

Possible property names:

- `port`: Port of the health check.

- `healthy-threshold`: Healthy threshold of the health check.

- `unhealthy-threshold`: Unhealthy threshold of the health check.

- `timeout`: Timeout of the health check.

- `interval`: Interval of the health check.

- `tls-sni`: SNI for the health check TLS transport settings.

- `tls-trusted-ca-from-file`: Path to file with trusted CA for the health check TLS transport settings.

- `tls-client-certificate-id`: Client certificate ID for the health check TLS transport settings.

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

- `tls-sni`: SNI for the health check TLS transport settings.

- `tls-trusted-ca-from-file`: Path to file with trusted CA for the health check TLS transport settings.

- `tls-client-certificate-id`: Client certificate ID for the health check TLS transport settings.

- `service-name`: Service name of the gRPC health check. ||
|| `--stream-healthcheck` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

List of stream (TCP) health checks for backend.

Possible property names:

- `port`: Port of the health check.

- `healthy-threshold`: Healthy threshold of the health check.

- `unhealthy-threshold`: Unhealthy threshold of the health check.

- `timeout`: Timeout of the health check.

- `interval`: Interval of the health check.

- `tls-sni`: SNI for the health check TLS transport settings.

- `tls-trusted-ca-from-file`: Path to file with trusted CA for the health check TLS transport settings.

- `tls-client-certificate-id`: Client certificate ID for the health check TLS transport settings.

- `send-text`: Text to send for stream (TCP) health check.

- `receive-text`: Text to receive for stream (TCP) health check. ||
|| `--use-http2` | Enables HTTP2 for the HTTP backend. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#