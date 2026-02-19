---
editable: false
noIndex: true
---

# yc beta cdn resource

Provider's resources management service.

#### Command Usage

Syntax:

`yc beta cdn resource <command>`

#### Command Tree

- [yc beta cdn resource create](create.md) — Creates a CDN resource in the specified folder.

- [yc beta cdn resource delete](delete.md) — Deletes client's CDN resource.

- [yc beta cdn resource get](get.md) — Get client's CDN resource by resource id.

- [yc beta cdn resource get-attributes](get-attributes.md) — Get resource attributes.

- [yc beta cdn resource get-provider-cname](get-provider-cname.md) — Deprecated: Provider-specific CNAME is now available in the `provider_cname` field of each Resource message.

- [yc beta cdn resource list](list.md) — Lists CDN resources.

- [yc beta cdn resource update](update.md) — Updates the specified CDN resource.

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