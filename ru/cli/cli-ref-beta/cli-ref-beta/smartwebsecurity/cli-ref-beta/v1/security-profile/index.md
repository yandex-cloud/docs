---
editable: false
noIndex: true
---

# yc beta smartwebsecurity v1 security-profile

A set of methods for managing SecurityProfile resources.

#### Command Usage

Syntax:

`yc beta smartwebsecurity v1 security-profile <command>`

#### Command Tree

- [yc beta smartwebsecurity v1 security-profile create](create.md) — Creates a security profile in the specified folder using the data specified in the request.

- [yc beta smartwebsecurity v1 security-profile delete](delete.md) — Deletes the specified security profile.

- [yc beta smartwebsecurity v1 security-profile get](get.md) — Returns the specified SecurityProfile resource.

- [yc beta smartwebsecurity v1 security-profile list](list.md) — Retrieves the list of SecurityProfile resources in the specified folder.

- [yc beta smartwebsecurity v1 security-profile update](update.md) — Updates the specified security profile.

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