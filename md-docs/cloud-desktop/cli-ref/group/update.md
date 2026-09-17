[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Desktop](../../index.md) > [Справочник CLI (англ.)](../index.md) > [group](index.md) > update

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

- `memory`: Specifies how much memory desktop should have.

- `cores`: Amount of cores to attach to the desktop.

- `core-fraction`: Amount of core-fraction to attach to the desktop. ||
|| `--boot-disk-spec` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

New boot disk specification for desktop group.

Possible property names:

- `disk-type`: Disk type

- `disk-size`: Disk size ||
|| `--data-disk-spec` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

New data disk specification for desktop group.

Possible property names:

- `disk-type`: Disk type

- `disk-size`: Disk size ||
|| `--group-config` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

New configuration for desktop group.

Possible property names:

- `max-group-size`: Max group size

- `hot-standby`: Hot standby

- `user-account-id`: User account ids

- `time-zone`: Time zone for lifetime control. For example "Europe/Moscow".

- `cron-start`: Cron expression for automatic start desktops in group. For example "0 0 * * *".

- `cron-stop`: Cron expression for automatic stop desktops in group. For example "0 0 * * *". ||
|| `--update-policy` | `string`

New desktop group update policy. ||
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