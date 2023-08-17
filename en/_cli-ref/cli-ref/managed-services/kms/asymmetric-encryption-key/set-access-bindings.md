---
editable: false
---

# yc kms asymmetric-encryption-key set-access-bindings

Set access bindings for the specified asymmetric encryption key and delete all existing access bindings if there were any

#### Command Usage

Syntax: 

`yc kms asymmetric-encryption-key set-access-bindings <ASYMMETRIC-ENCRYPTION-KEY> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Asymmetric encryption key id.|
|`--name`|<b>`string`</b><br/>Asymmetric encryption key name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--access-binding`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Access binding to set. Can be used multiple times.<br/><br/>Possible property names:<br/><ul> <li><code>role</code>:     Binding role ID.</li> <li><code>service-account-id</code>:     Service account, whose access will be updated.</li> <li><code>service-account-name</code>:     Service account, whose access will be updated.</li> <li><code>user-account-id</code>:     User account, whose access will be updated.</li> <li><code>user-yandex-login</code>:     User account, whose access will be updated.</li> <li><code>all-authenticated-users</code>:     Access will be updated for all authenticated users</li> <li><code>subject</code>:     Subject whose access will be updated; in TYPE:ID format, e.g. userAccount:&lt;ID&gt;, serviceAccount:&lt;ID&gt;, system:&lt;ID&gt;.</li> </ul>|
|`-y`,`--yes`|Automatic yes to prompts.|

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
