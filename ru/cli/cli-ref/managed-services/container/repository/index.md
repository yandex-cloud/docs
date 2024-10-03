---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/container/repository/index.md
---

# yc container repository

Manage Docker image repositories.

#### Command Usage

Syntax: 

`yc container repository <group|command>`

Aliases: 

- `repositories`
- `repo`

#### Command Tree

- [yc container repository get](get.md) — Get information about a Docker image repository.
- [yc container repository list](list.md) — List Docker image repositories.
- [yc container repository list-access-bindings](list-access-bindings.md) — List access bindings for the specified repository
- [yc container repository set-access-bindings](set-access-bindings.md) — Set access bindings for the specified repository and delete all existing access bindings if there were any
- [yc container repository add-access-binding](add-access-binding.md) — Add access binding for the specified repository
- [yc container repository remove-access-binding](remove-access-binding.md) — Remove access binding for the specified repository
- [yc container repository lifecycle-policy](lifecycle-policy/index.md) — Manage lifecycle policies for Docker image repositories.
	- [yc container repository lifecycle-policy get](lifecycle-policy/get.md) — Get information about a lifecycle policy.
	- [yc container repository lifecycle-policy list](lifecycle-policy/list.md) — List lifecycle policies.
	- [yc container repository lifecycle-policy create](lifecycle-policy/create.md) — Create a lifecycle policy.
	- [yc container repository lifecycle-policy update](lifecycle-policy/update.md) — Modify configuration or attributes of a lifecycle policy.
	- [yc container repository lifecycle-policy delete](lifecycle-policy/delete.md) — Delete a lifecycle policy.
	- [yc container repository lifecycle-policy dry-run](lifecycle-policy/dry-run.md) — Dry run a lifecycle policy.
	- [yc container repository lifecycle-policy list-dry-run-results](lifecycle-policy/list-dry-run-results.md) — Dry run results for a lifecycle policy.
	- [yc container repository lifecycle-policy get-dry-run-result](lifecycle-policy/get-dry-run-result.md) — Get information about a dry run result for a lifecycle policy
	- [yc container repository lifecycle-policy list-dry-run-affected-images](lifecycle-policy/list-dry-run-affected-images.md) — List images affected by dry run for a lifecycle policy.

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
