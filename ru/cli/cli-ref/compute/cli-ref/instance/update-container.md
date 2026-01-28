---
editable: false
sourcePath: en/_cli-ref/cli-ref/compute/cli-ref/instance/update-container.md
---

# yc compute instance update-container

Update the specified virtual machine instance running Docker container

#### Command Usage

Syntax:

`yc compute instance update-container <INSTANCE-NAME>|<INSTANCE-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Instance id. ||
|| `--name` | `string`

Instance name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--container-arg` | `value[,value]`

A list of arguments to append to container entrypoint. Overrides default container CMD ||
|| `--clear-container-args` | Removes the list of arguments from container declaration. ||
|| `--container-command` | `string`

Executable to run when the container starts. Overrides default container ENTRYPOINT ||
|| `--clear-container-command` | Removes command from container declaration. ||
|| `--container-env` | `key=value[,key=value...]`

Declare environment variable KEY with value VALUE passed to container. Only the last value of KEY is taken when KEY is repeated more than once.
Values, declared with --container-env flag override those with the same KEY from file, provided in --container-env-file. ||
|| `--container-env-file` | `string`

Declare environment variables in a file. Values, declared with --container-env flag override those with the same KEY from file.
File must contain lines in format KEY=VALUE, variables without value are not supported. ||
|| `--remove-container-env` | `string`

Removes environment variable KEY from container declaration. ||
|| `--container-image` | `string`

Container image name. ||
|| `--container-name` | `string`

Container name. ||
|| `--container-privileged` | Specify whether to run container in privileged mode. ||
|| `--container-stdin` | Open container STDIN. ||
|| `--container-tty` | Allocate a pseudo-TTY for the container. ||
|| `--container-restart-policy` | `string`

Specify whether to restart a container on exit. Must be one of: Always, Never, OnFailure. ||
|| `--container-volume-tmpfs` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Add tmpfs-backed docker volume

Possible property names:

- `name`: Specifies the name of the volume. (required)

- `mount-path`: Specifies the mount path of the volume inside a container. (required) ||
|| `--container-volume-host-path` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Add docker volume bound to host path

Possible property names:

- `name`: Specifies the name of the volume. (required)

- `mount-path`: Specifies the mount path of the volume inside a container. (required)

- `ro`: Specifies whether the volume is read-only or not inside a container. Default: false

- `host-path`: Specifies a path on host VM that will be bound to the volume. (required) ||
|| `--remove-container-volume` | `string`

Remove docker volume from container declaration by its name. Several names separated with comma can be provided. ||
|| `--clear-container-volumes` | Remove all docker volumes from container declaration ||
|| `--docker-compose-file` | `string`

Docker compose file. ||
|| `--coi-spec-file` | `string`

Container optimized image YAML file. ||
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