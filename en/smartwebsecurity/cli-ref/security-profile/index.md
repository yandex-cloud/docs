---
editable: false
sourcePath: en/_cli-ref/cli-ref/smartwebsecurity/cli-ref/security-profile/index.md
---

# yc smartwebsecurity security-profile

Manage security profiles

#### Command Usage

Syntax:

`yc smartwebsecurity security-profile <command>`

#### Command Tree

- [yc smartwebsecurity security-profile create](create.md) — Create a security profile

- [yc smartwebsecurity security-profile delete](delete.md) — Delete the specified security profile

- [yc smartwebsecurity security-profile get](get.md) — Show information about the specified security profile

- [yc smartwebsecurity security-profile list](list.md) — List security profiles

- [yc smartwebsecurity security-profile update](update.md) — Update the specified security profile

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