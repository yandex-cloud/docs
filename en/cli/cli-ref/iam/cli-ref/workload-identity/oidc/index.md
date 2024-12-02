---
editable: false
sourcePath: en/_cli-ref/cli-ref/iam/cli-ref/workload-identity/oidc/index.md
---

# yc iam workload-identity oidc



#### Command Usage

Syntax: 

`yc iam workload-identity oidc <group>`

#### Command Tree

- [yc iam workload-identity oidc federation](federation/index.md) — Manage workload identity OIDC federation
	- [yc iam workload-identity oidc federation add-audiences](federation/add-audiences.md) — Add audiences to workload identity federation
	- [yc iam workload-identity oidc federation add-labels](federation/add-labels.md) — Add labels to workload identity federation
	- [yc iam workload-identity oidc federation create](federation/create.md) — Create a workload identity federation
	- [yc iam workload-identity oidc federation delete](federation/delete.md) — Delete the specified workload identity federation
	- [yc iam workload-identity oidc federation get](federation/get.md) — Show information about the specified workload identity federation
	- [yc iam workload-identity oidc federation list](federation/list.md) — List workload identity federations
	- [yc iam workload-identity oidc federation remove-audiences](federation/remove-audiences.md) — Remove audiences from workload identity federation
	- [yc iam workload-identity oidc federation remove-labels](federation/remove-labels.md) — Remove labels from workload identity federation
	- [yc iam workload-identity oidc federation update](federation/update.md) — Update the specified workload identity federation

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
