---
sourcePath: en/_cli-ref/cli-ref/managed-services/container/repository/lifecycle-policy/index.md
---
# yc container repository lifecycle-policy

Manage lifecycle policies for Docker image repositories.

#### Command Usage

Syntax: 

`yc container repository lifecycle-policy <command>`

Aliases: 

- `lifecycle-policies`
- `lp`

#### Command Tree

- [yc container repository lifecycle-policy get](get.md) — Get information about a lifecycle policy.
- [yc container repository lifecycle-policy list](list.md) — List lifecycle policies.
- [yc container repository lifecycle-policy create](create.md) — Create a lifecycle policy.
- [yc container repository lifecycle-policy update](update.md) — Modify configuration or attributes of a lifecycle policy.
- [yc container repository lifecycle-policy delete](delete.md) — Delete a lifecycle policy.
- [yc container repository lifecycle-policy dry-run](dry-run.md) — Dry run a lifecycle policy.
- [yc container repository lifecycle-policy list-dry-run-results](list-dry-run-results.md) — Dry run results for a lifecycle policy.
- [yc container repository lifecycle-policy get-dry-run-result](get-dry-run-result.md) — Get information about a dry run result for a lifecycle policy
- [yc container repository lifecycle-policy list-dry-run-affected-images](list-dry-run-affected-images.md) — List images affected by dry run for a lifecycle policy.

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
