---
editable: false
sourcePath: en/_cli-ref/cli-ref/baremetal/cli-ref/server/reinstall.md
---

# yc baremetal server reinstall

Reinstall the specified server

#### Command Usage

Syntax:

`yc baremetal server reinstall <SERVER-NAME>|<SERVER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Server id. ||
|| `--name` | `string`

Server name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--os-settings` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Specifies the image id of the server. Image id or image name is necessary if you want to specify a OsSettingsSpec

Possible property names:

- `image-id`: Specifies the image id of the server. Image id or image name is necessary if you want to specify a OsSettingsSpec

- `image-name`: Specifies the image name of the server. Image id or image name is necessary if you want to specify a OsSettingsSpec

- `ssh-key-public`: Specifies the ssh key public of the server.

- `ssh-key-user-id`: Specifies the ssh key user id of the server.

- `password-plain-text`: Specifies the password plain text of the server.

- `password-lockbox-secret`: Specifies the lockbox secret password of the server. ||
|| `--storage` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Specifies  storages to the server.

Possible property names:

- `partition`: Specifies partitions of the storage

- `disk`: Specifies disks of the storage. if you want to specify the disk type, specify only 1 disk and do not specify the raid type.

- `raid-type`: Specifies the type of the storage raid type Values: 'raid0', 'raid1', 'raid10' ||
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