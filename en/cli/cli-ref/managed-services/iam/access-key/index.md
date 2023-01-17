---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/iam/access-key/index.md
---

# yc iam access-key

Manage service account access keys. Access keys are used for the authentication by Yandex Object Storage API to provide compatibility with Amazon S3 API. Access keys can be created only for service account.

#### Command Usage

Syntax: 

`yc iam access-key <command>`

Aliases: 

- `access-keys`

#### Command Tree

- [yc iam access-key get](get.md) — Show information about the specified access key
- [yc iam access-key list](list.md) — List access keys for the specified service account
- [yc iam access-key create](create.md) — Create an access key for the specified service account
- [yc iam access-key delete](delete.md) — Delete the specified access key

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
