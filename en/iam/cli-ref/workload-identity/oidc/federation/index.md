---
editable: false
sourcePath: en/_cli-ref/cli-ref/iam/cli-ref/workload-identity/oidc/federation/index.md
---

# yc iam workload-identity oidc federation

Manage workload identity OIDC federation

#### Command Usage

Syntax: 

`yc iam workload-identity oidc federation <command>`

#### Command Tree

- [yc iam workload-identity oidc federation add-audiences](add-audiences.md) — Add audiences to workload identity federation
- [yc iam workload-identity oidc federation add-labels](add-labels.md) — Add labels to workload identity federation
- [yc iam workload-identity oidc federation create](create.md) — Create a workload identity federation
- [yc iam workload-identity oidc federation delete](delete.md) — Delete the specified workload identity federation
- [yc iam workload-identity oidc federation get](get.md) — Show information about the specified workload identity federation
- [yc iam workload-identity oidc federation list](list.md) — List workload identity federations
- [yc iam workload-identity oidc federation remove-audiences](remove-audiences.md) — Remove audiences from workload identity federation
- [yc iam workload-identity oidc federation remove-labels](remove-labels.md) — Remove labels from workload identity federation
- [yc iam workload-identity oidc federation update](update.md) — Update the specified workload identity federation

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
