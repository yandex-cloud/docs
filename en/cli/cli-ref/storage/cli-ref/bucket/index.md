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

- [yc storage bucket create](create.md) — Create new bucket

- [yc storage bucket delete](delete.md) — Delete the specified bucket

- [yc storage bucket delete-https](delete-https.md) — Deletes bucket https settings

- [yc storage bucket get](get.md) — Show information about the specified bucket

- [yc storage bucket get-https](get-https.md) — Shows bucket https settings

- [yc storage bucket list](list.md) — Lists buckets of specified folder id

- [yc storage bucket set-https](set-https.md) — Sets bucket https settings

- [yc storage bucket stats](stats.md) — Shows bucket stats

- [yc storage bucket update](update.md) — Update the specified bucket

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