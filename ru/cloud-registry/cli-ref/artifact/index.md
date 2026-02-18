---
editable: false
---

# yc cloud-registry artifact

[PREVIEW] Manage artifacts

#### Command Usage

Syntax:

`yc cloud-registry artifact <command>`

#### Command Tree

- [yc cloud-registry artifact add-access-binding](add-access-binding.md) — Add access binding for the specified artifact

- [yc cloud-registry artifact delete](delete.md) — Delete the specified registry artifact

- [yc cloud-registry artifact get](get.md) — Get information about the artifact

- [yc cloud-registry artifact list-access-bindings](list-access-bindings.md) — Lists access bindings for the specified artifact

- [yc cloud-registry artifact remove-access-binding](remove-access-binding.md) — Remove access binding for the specified artifact

- [yc cloud-registry artifact set-access-bindings](set-access-bindings.md) — Set access bindings for the specified artifact and remove existing ones

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