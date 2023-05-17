---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/compute/instance/update-container.md
---

# yc compute instance update-container

Update the specified virtual machine instance running Docker container

#### Command Usage

Syntax: 

`yc compute instance update-container <INSTANCE-NAME>|<INSTANCE-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Instance id.|
|`--name`|<b>`string`</b><br/>Instance name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--container-arg`|<b>`value[,value]`</b><br/>A list of arguments to append to container entrypoint. Overrides default container CMD|
|`--clear-container-args`|Removes the list of arguments from container declaration.|
|`--container-command`|<b>`string`</b><br/>Executable to run when the container starts. Overrides default container ENTRYPOINT|
|`--clear-container-command`|Removes command from container declaration.|
|`--container-env`|<b>`key=value[,key=value...]`</b><br/>Declare environment variable KEY with value VALUE passed to container. Only the last value of KEY is taken when KEY is repeated more than once.<br/>Values, declared with --container-env flag override those with the same KEY from file, provided in --container-env-file.|
|`--container-env-file`|<b>`string`</b><br/>Declare environment variables in a file. Values, declared with --container-env flag override those with the same KEY from file.<br/>File must contain lines in format KEY=VALUE, variables without value are not supported.|
|`--remove-container-env`|<b>`string`</b><br/>Removes environment variable KEY from container declaration.|
|`--container-image`|<b>`string`</b><br/>Container image name.|
|`--container-name`|<b>`string`</b><br/>Container name.|
|`--container-privileged`|Specify whether to run container in privileged mode.|
|`--container-stdin`|Open container STDIN.|
|`--container-tty`|Allocate a pseudo-TTY for the container.|
|`--container-restart-policy`|<b>`string`</b><br/>Specify whether to restart a container on exit. Must be one of: Always, Never, OnFailure.|
|`--container-volume-tmpfs`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Add tmpfs-backed docker volume<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Specifies the name of the volume. (required)</li> <li><code>mount-path</code>:     Specifies the mount path of the volume inside a container. (required)</li> </ul>|
|`--container-volume-host-path`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Add docker volume bound to host path<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Specifies the name of the volume. (required)</li> <li><code>mount-path</code>:     Specifies the mount path of the volume inside a container. (required)</li> <li><code>ro</code>:     Specifies whether the volume is read-only or not inside a container. Default: false</li> <li><code>host-path</code>:     Specifies a path on host VM that will be bound to the volume. (required)</li> </ul>|
|`--remove-container-volume`|<b>`string`</b><br/>Remove docker volume from container declaration by its name. Several names separated with comma can be provided.|
|`--clear-container-volumes`|Remove all docker volumes from container declaration|
|`--docker-compose-file`|<b>`string`</b><br/>Docker compose file.|
|`--coi-spec-file`|<b>`string`</b><br/>Container optimized image YAML file.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
