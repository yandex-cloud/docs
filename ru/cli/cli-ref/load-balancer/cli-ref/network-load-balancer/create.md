---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/load-balancer/cli-ref/network-load-balancer/create/
---

# yc load-balancer network-load-balancer create

Create a network load balancer

#### Command Usage

Syntax:

`yc load-balancer network-load-balancer create <LOAD-BALANCER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

A name of the network load balancer. ||
|| `--description` | `string`

A description of the network load balancer. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--region-id` | `string`

A region id of the network load balancer. ||
|| `--type` | `string`

Specifies a type of the network load balancer. Supported option is 'external' for external network load balancer, and 'internal' for internal network load balancer. If omitted, 'external' is used as a default. ||
|| `--deletion-protection` | Specifies if network load balancer protected from deletion. ||
|| `--allow-zonal-shift` | Specifies if network load balancer available to zonal shift. ||
|| `--target-group` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Target group specification.

Possible property names:

- `target-group-id`: Specifies the target group id.

- `healthcheck-name`: Specifies the name of the health check to perform on the target group

- `healthcheck-interval`: Specifies the interval between health checks. The default is 2 seconds.

- `healthcheck-timeout`: Specifies timeout for a target to return a response for the health check. The default is 1 second.

- `healthcheck-unhealthythreshold`: Specifies the number of failed health checks before changing the status to 'UNHEALTHY'. The default is 2.

- `healthcheck-healthythreshold`: Specifies the number of successful health checks required in order to set the 'HEALTHY' status for the target. The default is 2.

- `healthcheck-tcp-port`: Specifies the port to use for TCP health checks.

- `healthcheck-http-port`: Specifies the port to use for HTTP health checks.

- `healthcheck-http-path`: Specifies URL path to set for health checking requests for every target in the target group. ||
|| `--listener` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Listener specification.

Possible property names:

- `name`: Specifies the name for listener.

- `port`: Specifies the port for incoming traffic.

- `target-port`: Specifies the port on which the targets receive traffic.

- `protocol`: Specifies the protocol for incoming traffic. Supported option is 'tcp' or 'udp'. If omitted, 'tcp' is used as a default.

- `external-address`: Specifies the External IP address for incoming traffic. Must be empty when creating a new network load balancer. Must be provided when updating an existing load balancer.

- `external-ip-version`: Specifies the IP version for external address for incoming traffic. Supported option is 'ipv4' and 'ipv6'. If omitted, 'ipv4' is used as a default.

- `internal-address`: Specifies the Internal IP address for incoming traffic. Must be empty when creating a new network load balancer. Must be provided when updating an existing load balancer.

- `internal-subnet-id`: Specifies the Subnet ID of internal IP address for incoming traffic.

- `internal-ip-version`: Specifies the IP version for internal address for incoming traffic. Supported option is 'ipv4' and 'ipv6'. If omitted, 'ipv4' is used as a default. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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