---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/vpc/security-group/index.md
---

# yc vpc security-group

Manage security groups.

#### Command Usage

Syntax: 

`yc vpc security-group <command>`

Aliases: 

- `security-groups`
- `sg`

#### Command Tree

- [yc vpc security-group get](get.md) — Get information about a security group.
- [yc vpc security-group list](list.md) — List security groups in a folder.
- [yc vpc security-group create](create.md) — Create a security group.
- [yc vpc security-group update](update.md) — Modify configuration or attributes of a security group.
- [yc vpc security-group add-labels](add-labels.md) — Add labels to a security group.
- [yc vpc security-group remove-labels](remove-labels.md) — Remove labels from a security group.
- [yc vpc security-group delete](delete.md) — Delete a security group.
- [yc vpc security-group list-operations](list-operations.md) — List operations for a security group.
- [yc vpc security-group move](move.md) — Move a security group to another folder.
- [yc vpc security-group update-rules](update-rules.md) — Update rules of a security group.
- [yc vpc security-group update-rule-meta](update-rule-meta.md) — Update rule of a security group.

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
