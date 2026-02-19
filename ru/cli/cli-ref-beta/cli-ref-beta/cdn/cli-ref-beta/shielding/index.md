---
editable: false
noIndex: true
---

# yc beta cdn shielding

Shielding management service.

#### Command Usage

Syntax:

`yc beta cdn shielding <command>`

#### Command Tree

- [yc beta cdn shielding activate](activate.md) — Activate shielding for a resource.

- [yc beta cdn shielding deactivate](deactivate.md) — Deactivate shielding for a resource.

- [yc beta cdn shielding get](get.md) — Get shielding details by resource ID.

- [yc beta cdn shielding list-available-locations](list-available-locations.md) — Lists available geographical locations.

- [yc beta cdn shielding update](update.md) — Updates shielding parameters for a resource, such as changing the geographical location of the shielding server.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#