---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/load-balancer/cli-ref/v0/network-load-balancer/attach-target-group/
---

# yc load-balancer v0 network-load-balancer attach-target-group

Attaches a target group to the specified network load balancer.

#### Command Usage

Syntax:

`yc load-balancer v0 network-load-balancer attach-target-group <LOAD-BALANCER-NAME>|<LOAD-BALANCER-ID> [Flags...] [Global Flags...]`

Aliases:

- `attach`

#### Flags

#|
||Flag | Description ||
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
|| `--id` | `string`

Network-Load-Balancer id. ||
|| `--name` | `string`

Network-Load-Balancer name. ||
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