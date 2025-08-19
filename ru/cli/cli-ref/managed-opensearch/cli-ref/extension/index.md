---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-opensearch/cli-ref/extension/index.md
---

# yc managed-opensearch extension

Extensions of a managed OpenSearch cluster.

#### Command Usage

Syntax: 

`yc managed-opensearch extension <command>`

Aliases: 

- `extensions`

#### Command Tree

- [yc managed-opensearch extension create](create.md) — Create a new extension for a managed OpenSearch cluster.
- [yc managed-opensearch extension delete](delete.md) — Delete an extension from a managed OpenSearch cluster.
- [yc managed-opensearch extension get](get.md) — Get information about an extension in a managed OpenSearch cluster.
- [yc managed-opensearch extension list](list.md) — List extensions for a managed OpenSearch cluster.
- [yc managed-opensearch extension update](update.md) — Update an extension in a managed OpenSearch cluster.

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
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
