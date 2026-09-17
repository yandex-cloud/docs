---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/cdn/cli-ref/
---

# yc cdn

Manage CDN resources

Command tree v0 is the default. Run `yc cdn <command>` or `yc cdn v0 <command>`.

#### Command Usage

Syntax:

`yc cdn <group>`

#### Command Tree

- [yc cdn cache](cache/index.md) — Manage CDN resources cache

  - [yc cdn cache prefetch](cache/prefetch.md) — Prefetch CDN resource paths

  - [yc cdn cache purge](cache/purge.md) — Purge CDN resource paths

- [yc cdn origin](origin/index.md) — Manage origins inside origin group

  - [yc cdn origin create](origin/create.md) — Create origin

  - [yc cdn origin delete](origin/delete.md) — Delete the specified origin.

  - [yc cdn origin get](origin/get.md) — Show information about the specified origin

  - [yc cdn origin list](origin/list.md) — List origins in the specified origin group

  - [yc cdn origin update](origin/update.md) — Update origin. PUT behaviour - specify all parameters

- [yc cdn origin-group](origin-group/index.md) — Manage origin groups

  - [yc cdn origin-group create](origin-group/create.md) — Create origin group

  - [yc cdn origin-group delete](origin-group/delete.md) — Delete the specified origin group.

  - [yc cdn origin-group get](origin-group/get.md) — Show information about the specified origin group

  - [yc cdn origin-group list](origin-group/list.md) — List origin groups in the specified folder

  - [yc cdn origin-group update](origin-group/update.md) — Update origin group

- [yc cdn provider](provider/index.md) — Manage CDN providers

  - [yc cdn provider activate](provider/activate.md) — Activate CDN provider

  - [yc cdn provider list-activated](provider/list-activated.md) — List activated CDN providers

- [yc cdn resource](resource/index.md) — Manage CDN resources

  - [yc cdn resource create](resource/create.md) — Create resource

  - [yc cdn resource delete](resource/delete.md) — Delete resource.

  - [yc cdn resource get](resource/get.md) — Show information about resource

  - [yc cdn resource get-provider-cname](resource/get-provider-cname.md) — Get provider CNAME

  - [yc cdn resource list](resource/list.md) — List resources in the specified folder

  - [yc cdn resource update](resource/update.md) — Update resource

- [yc cdn v0](v0/index.md) — Manage CDN resources



#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#