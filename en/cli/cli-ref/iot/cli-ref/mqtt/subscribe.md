---
editable: false
sourcePath: en/_cli-ref/cli-ref/iot/cli-ref/mqtt/subscribe.md
---

# yc iot mqtt subscribe

Subscribe telemetry

#### Command Usage

Syntax:

`yc iot mqtt subscribe [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cert` | `string`

Client certificate for authentication. ||
|| `--key` | `string`

Client private key for authentication. ||
|| `-u`, `--username` | `string`

Provide a username. ||
|| `-P`, `--password` | `string`

Provide a password. Not recommended for usage. Will ask password when --password isn't present. ||
|| `-t`, `--topic` | `string`

Mqtt topic name. ||
|| `-q`, `--qos` | `string`

Quality of service level to use for all messages (0 or 1)/(at-most-once or at-least-once). Defaults to 0. ||
|| `--details` | Print topic name, qos, message id for subscribed data. ||
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