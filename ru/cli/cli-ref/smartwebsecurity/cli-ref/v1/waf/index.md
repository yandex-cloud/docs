---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/smartwebsecurity/cli-ref/v1/waf/
---

# yc smartwebsecurity v1 waf



#### Command Usage

Syntax:

`yc smartwebsecurity v1 waf <group>`

#### Command Tree

- [yc smartwebsecurity v1 waf rule-set-descriptor](rule-set-descriptor/index.md) — A set of methods for managing RuleSetDescriptor resources.

  - [yc smartwebsecurity v1 waf rule-set-descriptor get](rule-set-descriptor/get.md) — Returns the specified RuleSetDescriptor resource.

- [yc smartwebsecurity v1 waf waf-profile](waf-profile/index.md) — A set of methods for managing WafProfile resources.

  - [yc smartwebsecurity v1 waf waf-profile create](waf-profile/create.md) — Creates a WAF profile in the specified folder using the data specified in the request.

  - [yc smartwebsecurity v1 waf waf-profile delete](waf-profile/delete.md) — Deletes the specified WAF profile.

  - [yc smartwebsecurity v1 waf waf-profile get](waf-profile/get.md) — Returns the specified WafProfile resource.

  - [yc smartwebsecurity v1 waf waf-profile list](waf-profile/list.md) — Retrieves the list of WafProfile resources in the specified folder.

  - [yc smartwebsecurity v1 waf waf-profile update](waf-profile/update.md) — Updates the specified WAF profile.

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