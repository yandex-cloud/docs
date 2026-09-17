[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [load-balancer](../../index.md) > [v0](../index.md) > [network-load-balancer](index.md) > add-listener

# yc load-balancer v0 network-load-balancer add-listener

Adds a listener to the specified network load balancer.

#### Command Usage

Syntax:

`yc load-balancer v0 network-load-balancer add-listener <LOAD-BALANCER-NAME>|<LOAD-BALANCER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
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