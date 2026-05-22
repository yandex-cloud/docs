---
canonical: https://yandex.cloud/en/docs/cli/cli-ref/smartwebsecurity/cli-ref/waf/waf-profile/
editable: false
---

# yc smartwebsecurity waf waf-profile

A set of methods for managing WafProfile resources.

#### Command Usage

Syntax:

`yc smartwebsecurity waf waf-profile <command>`

#### Command Tree

- [yc smartwebsecurity waf waf-profile create](create.md) — Creates a WAF profile in the specified folder using the data specified in the request.

- [yc smartwebsecurity waf waf-profile delete](delete.md) — Deletes the specified WAF profile.

- [yc smartwebsecurity waf waf-profile get](get.md) — Returns the specified WafProfile resource.

- [yc smartwebsecurity waf waf-profile list](list.md) — Retrieves the list of WafProfile resources in the specified folder.

- [yc smartwebsecurity waf waf-profile update](update.md) — Updates the specified WAF profile.

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
|| `--syntax` | `string`

CLI syntax: this standalone binary only supports 2 (current). Use main yc for syntax 1. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#
