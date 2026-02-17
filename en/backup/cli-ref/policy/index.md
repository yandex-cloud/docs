---
editable: false
---

# yc backup policy

Manage policies

#### Command Usage

Syntax:

`yc backup policy <command>`

Aliases:

- `policies`

#### Command Tree

- [yc backup policy apply](apply.md) — Apply policy to vm(-s)

- [yc backup policy create](create.md) — Create policy

- [yc backup policy delete](delete.md) — Delete policy(-es)

- [yc backup policy execute](execute.md) — Execute policy for vm

- [yc backup policy get](get.md) — Show policy by id

- [yc backup policy list](list.md) — Lists available policies

- [yc backup policy list-applications](list-applications.md) — Lists policy applications

- [yc backup policy revoke](revoke.md) — Revoke policy from vm(-s)

- [yc backup policy update](update.md) — Update the policy

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