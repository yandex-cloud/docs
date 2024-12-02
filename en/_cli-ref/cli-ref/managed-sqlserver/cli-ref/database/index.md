---
editable: false
---

# yc managed-sqlserver database

Manage SQLServer databases

#### Command Usage

Syntax: 

`yc managed-sqlserver database <command>`

Aliases: 

- `databases`

#### Command Tree

- [yc managed-sqlserver database backup-export](backup-export.md) — Export SQLServer database backup to Object Storage
- [yc managed-sqlserver database backup-import](backup-import.md) — Import SQLServer database from external backup in Object Storage
- [yc managed-sqlserver database create](create.md) — Create SQLServer database
- [yc managed-sqlserver database delete](delete.md) — Delete the specified SQLServer database
- [yc managed-sqlserver database get](get.md) — Show information about the specified SQLServer database
- [yc managed-sqlserver database list](list.md) — List SQLServer databases
- [yc managed-sqlserver database restore](restore.md) — Restore SQLServer database

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
