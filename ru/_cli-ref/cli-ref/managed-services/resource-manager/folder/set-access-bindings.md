# yc resource-manager folder set-access-bindings

Set access bindings for the specified folder and delete all existing access bindings if there were any

#### Command Usage

Syntax: 

`yc resource-manager folder set-access-bindings <FOLDER-NAME>|<FOLDER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> Folder id.|
|`--name`|<b>`string`</b><br/> Folder name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--access-binding`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Access binding to set. Can be used multiple times.  Possible property names:  role Binding role ID.  service-account-id Service account, whose access will be updated.  service-account-name Service account, whose access will be updated.  user-account-id User account, whose access will be updated.  user-yandex-login User account, whose access will be updated.  all-authenticated-users Access will be updated for all authenticated users  subject Subject whose access will be updated; in TYPE:ID format, e.g. userAccount:<ID>, serviceAccount:<ID>, system:<ID>.  |
|`-y`,`--yes`| Automatic yes to prompts.|

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
