---
editable: false
---

# yc desktops group update

Update desktop group

#### Command Usage

Syntax:

`yc desktops group update [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Desktop group id. ||
|| `--name` | `string`

Desktop group name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--image-id` | `string`

Desktop group image id. ||
|| `--new-name` | `string`

New desktop group name. ||
|| `--description` | `string`

New desktop group description. ||
|| `--labels` | `key=value[,key=value...]`

New desktop group labels. ||
|| `--resources-spec` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

New resources specification for desktop group.

Possible property names:

- `memory`: Specifies how much memory desktop should have. (required)

- `cores`: Amount of cores to attach to the desktop. (required)

- `core-fraction`: Amount of core-fraction to attach to the desktop. (required) ||
|| `--boot-disk-spec` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

New boot disk specification for desktop group.

Possible property names:

- `disk-type`: Disk type (required)

- `disk-size`: Disk size (required) ||
|| `--data-disk-spec` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

New data disk specification for desktop group.

Possible property names:

- `disk-type`: Disk type (required)

- `disk-size`: Disk size (required) ||
|| `--group-config` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

New configuration for desktop group.

Possible property names:

- `max-group-size`: Max group size (required)

- `hot-standby`: Hot standby (required)

- `user-account-id`: User account ids ||
|| `--update-policy` | `string`

New desktop group update policy. ||
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