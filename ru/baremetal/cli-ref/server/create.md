---
editable: false
sourcePath: en/_cli-ref/cli-ref/baremetal/cli-ref/server/create.md
---

# yc baremetal server create

Create an server

#### Command Usage

Syntax:

`yc baremetal server create <SERVER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the server. ||
|| `--description` | `string`

Specifies a textual description of the server. ||
|| `--hardware-pool-id` | `string`

Specifies a textual hardware pool id of the server. ||
|| `--rental-period-id` | `string`

Specifies a textual rental period id of the server. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--network-interfaces` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Adds a network interface spec to the server.

Possible property names:

- `private-subnet-id`: Specifies the ID of the private subnet that the interface will be part of.

- `public-subnet-id`: Specifies the ID of the public subnet that the interface will be part of.

- `private-subnet-name`: Specifies the name of the private subnet that the interface will be part of.

- `public-subnet-name`: Specifies the name of the public subnet that the interface will be part of.

- `ephemeral-public-subnet`: Creates an ephemeral public subnet for the interface. ||
|| `--configuration-id` | `string`

Specifies a textual configuration id of the server. ||
|| `--configuration-name` | `string`

Specifies a textual configuration name of the server. ||
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