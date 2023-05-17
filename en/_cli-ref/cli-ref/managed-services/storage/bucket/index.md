---
editable: false
---

# yc storage bucket

Manage buckets

#### Command Usage

Syntax: 

`yc storage bucket <command>`

Aliases: 

- `buckets`

#### Command Tree

- [yc storage bucket list](list.md) — Lists buckets of specified folder id
- [yc storage bucket get](get.md) — Show information about the specified bucket
- [yc storage bucket create](create.md) — Create new bucket
- [yc storage bucket update](update.md) — Update the specified bucket
- [yc storage bucket delete](delete.md) — Delete the specified bucket
- [yc storage bucket stats](stats.md) — Shows bucket stats
- [yc storage bucket get-https](get-https.md) — Shows bucket https settings
- [yc storage bucket set-https](set-https.md) — Sets bucket https settings
- [yc storage bucket delete-https](delete-https.md) — Deletes bucket https settings

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
