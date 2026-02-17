---
editable: false
---

# yc desktops group create

Create a desktop group

#### Command Usage

Syntax:

`yc desktops group create [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--folder-id` | `string`

Desktop folder id. ||
|| `--image-id` | `string`

Desktop image id. ||
|| `--name` | `string`

Desktop name. ||
|| `--description` | `string`

Desktop description. ||
|| `--resource-spec` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Resources specification for desktop group.

Possible property names:

- `memory`: Specifies how much memory desktop should have. (required)

- `cores`: Amount of cores to attach to the desktop. (required)

- `core-fraction`: Amount of core-fraction to attach to the desktop. (required) ||
|| `--network-interface-spec` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Resources specification for desktop group.

Possible property names:

- `network-id`: Network id (required)

- `subnet-id`: Subnet IDs (required) ||
|| `--boot-disk-spec` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Boot disk specification for desktop group.

Possible property names:

- `disk-type`: Disk type (required)

- `disk-size`: Disk size (required) ||
|| `--data-disk-spec` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Data disk specification for desktop group.

Possible property names:

- `disk-type`: Disk type (required)

- `disk-size`: Disk size (required) ||
|| `--group-config` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Desktop group configuration.

Possible property names:

- `max-group-size`: Max group size (required)

- `hot-standby`: Hot standby (required)

- `user-account-id`: User account ids ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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