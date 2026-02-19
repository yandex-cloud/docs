---
editable: false
noIndex: true
---

# yc beta cdn

Manage CDN resources

#### Command Usage

Syntax:

`yc beta cdn <group>`

#### Command Tree

- [yc beta cdn cache](cache/index.md) — A set of methods for managing Cache Service resources.

  - [yc beta cdn cache prefetch](cache/prefetch.md) — Uploads specified files from origins to cache of the specified resource. For defails about prefetching, see [documentation](/docs/cdn/concepts/caching#prefetch).

  - [yc beta cdn cache purge](cache/purge.md) — Removes specified files from the cache of the specified resource. For details about purging, see [documentation](/docs/cdn/concepts/caching#purge).

- [yc beta cdn origin](origin/index.md) — 

  - [yc beta cdn origin create](origin/create.md) — Creates origin inside origin group.

  - [yc beta cdn origin delete](origin/delete.md) — Deletes origin from origin group.

  - [yc beta cdn origin get](origin/get.md) — Get origin in origin group.

  - [yc beta cdn origin list](origin/list.md) — Lists origins of origin group.

  - [yc beta cdn origin update](origin/update.md) — Updates the specified origin from the origin group.

- [yc beta cdn origin-group](origin-group/index.md) — 

  - [yc beta cdn origin-group create](origin-group/create.md) — Creates origin group.

  - [yc beta cdn origin-group delete](origin-group/delete.md) — Deletes origin group with specified origin group id.

  - [yc beta cdn origin-group get](origin-group/get.md) — Gets origin group with specified origin group id.

  - [yc beta cdn origin-group list](origin-group/list.md) — Lists origins of origin group.

  - [yc beta cdn origin-group update](origin-group/update.md) — Updates the specified origin group.

- [yc beta cdn provider](provider/index.md) — A set of methods for managing Provider Service resources.

  - [yc beta cdn provider activate](provider/activate.md) — Deprecated: This functionality is no longer supported - provider activation happens automatically.

  - [yc beta cdn provider list-activated](provider/list-activated.md) — List activated providers for specified client.

- [yc beta cdn raw-logs](raw-logs/index.md) — 

  - [yc beta cdn raw-logs activate](raw-logs/activate.md) — 

  - [yc beta cdn raw-logs deactivate](raw-logs/deactivate.md) — 

  - [yc beta cdn raw-logs get](raw-logs/get.md) — 

  - [yc beta cdn raw-logs update](raw-logs/update.md) — 

- [yc beta cdn resource](resource/index.md) — Provider's resources management service.

  - [yc beta cdn resource create](resource/create.md) — Creates a CDN resource in the specified folder.

  - [yc beta cdn resource delete](resource/delete.md) — Deletes client's CDN resource.

  - [yc beta cdn resource get](resource/get.md) — Get client's CDN resource by resource id.

  - [yc beta cdn resource get-attributes](resource/get-attributes.md) — Get resource attributes.

  - [yc beta cdn resource get-provider-cname](resource/get-provider-cname.md) — Deprecated: Provider-specific CNAME is now available in the `provider_cname` field of each Resource message.

  - [yc beta cdn resource list](resource/list.md) — Lists CDN resources.

  - [yc beta cdn resource update](resource/update.md) — Updates the specified CDN resource.

- [yc beta cdn resource-rules](resource-rules/index.md) — 

  - [yc beta cdn resource-rules create](resource-rules/create.md) — Create new resource rule with specified unique name and rule patter.

  - [yc beta cdn resource-rules delete](resource-rules/delete.md) — Delete specified by id resource rule.

  - [yc beta cdn resource-rules get](resource-rules/get.md) — Get specified by id resource rule.

  - [yc beta cdn resource-rules list](resource-rules/list.md) — List all rules for specified resource.

  - [yc beta cdn resource-rules update](resource-rules/update.md) — Update specified by id resource rule.

- [yc beta cdn shielding](shielding/index.md) — Shielding management service.

  - [yc beta cdn shielding activate](shielding/activate.md) — Activate shielding for a resource.

  - [yc beta cdn shielding deactivate](shielding/deactivate.md) — Deactivate shielding for a resource.

  - [yc beta cdn shielding get](shielding/get.md) — Get shielding details by resource ID.

  - [yc beta cdn shielding list-available-locations](shielding/list-available-locations.md) — Lists available geographical locations.

  - [yc beta cdn shielding update](shielding/update.md) — Updates shielding parameters for a resource, such as changing the geographical location of the shielding server.

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