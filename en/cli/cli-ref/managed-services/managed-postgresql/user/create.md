---
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-postgresql/user/create.md
---
# yc managed-postgresql user create

Create a PostgreSQL user

#### Command Usage

Syntax: 

`yc managed-postgresql user create <USER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/> PostgreSQL cluster id.|
|`--cluster-name`|<b>`string`</b><br/> PostgreSQL cluster name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--password`|<b>`string`</b><br/> Password of the PostgreSQL user.|
|`--conn-limit`|<b>`int`</b><br/> Number of connections available to the user.|
|`--permissions`|<b>`value[,value]`</b><br/> Names of the databases that the permission grants access to.|
|`--login`| Indicates whether the user can login. Defaults to true.|
|`--grants`|<b>`value[,value]`</b><br/> Roles granted to the user.|
|`--lock-timeout`|<b>`int`</b><br/> Lock timeout in milliseconds.|
|`--log-min-duration-statement`|<b>`int`</b><br/> Log minimal duration statement in milliseconds.|
|`--temp-file-limit`|<b>`int`</b><br/> Temporary file limit in bytes.|
|`--default-transaction-isolation`|<b>`string`</b><br/> Default transaction isolation. Values: 'transaction-isolation-read-uncommitted', 'transaction-isolation-read-committed', 'transaction-isolation-repeatable-read', 'transaction-isolation-serializable'|
|`--synchronous-commit`|<b>`string`</b><br/> Synchronous commit. Values: 'synchronous-commit-on', 'synchronous-commit-off', 'synchronous-commit-local', 'synchronous-commit-remote-write', 'synchronous-commit-remote-apply'|
|`--log-statement`|<b>`string`</b><br/> Log statement. Values: 'log-statement-none', 'log-statement-ddl', 'log-statement-mod', 'log-statement-all'|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
