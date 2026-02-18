---
editable: false
---

# yc cloud-registry registry lifecycle-policy

Manage lifecycle policies for artifacts

#### Command Usage

Syntax:

`yc cloud-registry registry lifecycle-policy <command>`

Aliases:

- `lifecycle-policies`

- `lp`

#### Command Tree

- [yc cloud-registry registry lifecycle-policy change-state](change-state.md) — Changes the state of the specified lifecycle policy

- [yc cloud-registry registry lifecycle-policy create](create.md) — Create a lifecycle policy.

- [yc cloud-registry registry lifecycle-policy delete](delete.md) — Deletes the specified lifecycle policy

- [yc cloud-registry registry lifecycle-policy get](get.md) — Get information about a lifecycle policy.

- [yc cloud-registry registry lifecycle-policy list](list.md) — List lifecycle policies.

- [yc cloud-registry registry lifecycle-policy update](update.md) — Updates the specified lifecycle policy

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