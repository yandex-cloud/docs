---
editable: false
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

- [yc container repository lifecycle-policy create](create.md) — Create a lifecycle policy.

- [yc container repository lifecycle-policy delete](delete.md) — Delete a lifecycle policy.

- [yc container repository lifecycle-policy dry-run](dry-run.md) — Dry run a lifecycle policy.

- [yc container repository lifecycle-policy get](get.md) — Get information about a lifecycle policy.

- [yc container repository lifecycle-policy get-dry-run-result](get-dry-run-result.md) — Get information about a dry run result for a lifecycle policy

- [yc container repository lifecycle-policy list](list.md) — List lifecycle policies.

- [yc container repository lifecycle-policy list-dry-run-affected-images](list-dry-run-affected-images.md) — List images affected by dry run for a lifecycle policy.

- [yc container repository lifecycle-policy list-dry-run-results](list-dry-run-results.md) — Dry run results for a lifecycle policy.

- [yc container repository lifecycle-policy update](update.md) — Modify configuration or attributes of a lifecycle policy.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#