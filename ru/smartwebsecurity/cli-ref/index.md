---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/smartwebsecurity/cli-ref/
---

# yc smartwebsecurity

Manage SmartWebSecurity resources

Command tree v1 (new CLI interface) is the default. Run `yc smartwebsecurity v1 <command>`.
Legacy command tree v0 is also available: `yc smartwebsecurity v0 <command>`.
Set `services.smartwebsecurity.version: v0` or `services.smartwebsecurity.version: v1` in your profile to change the default.

#### Command Usage

Syntax:

`yc smartwebsecurity <group>`

Aliases:

- `smart-web-security`

- `sws`

#### Command Tree

- [yc smartwebsecurity advanced-rate-limiter](advanced-rate-limiter/index.md) — 



- [yc smartwebsecurity match-list](match-list/index.md) — 



- [yc smartwebsecurity security-profile](security-profile/index.md) — A set of methods for managing SecurityProfile resources.

  - [yc smartwebsecurity security-profile create](security-profile/create.md) — Creates a security profile in the specified folder using the data specified in the request.

  - [yc smartwebsecurity security-profile delete](security-profile/delete.md) — Deletes the specified security profile.

  - [yc smartwebsecurity security-profile get](security-profile/get.md) — Returns the specified SecurityProfile resource.

  - [yc smartwebsecurity security-profile list](security-profile/list.md) — Retrieves the list of SecurityProfile resources in the specified folder.

  - [yc smartwebsecurity security-profile update](security-profile/update.md) — Updates the specified security profile.

- [yc smartwebsecurity v0](v0/index.md) — (legacy command tree) Manage SmartWebSecurity resources



- [yc smartwebsecurity v1](v1/index.md) — Manage SmartWebSecurity resources



- [yc smartwebsecurity waf](waf/index.md) — 



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
|| `--no-pager` | Do not pipe help output through a pager. ||
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
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#