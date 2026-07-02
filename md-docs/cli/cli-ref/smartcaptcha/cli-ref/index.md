[Документация Yandex Cloud](../../../../index.md) > [Интерфейс командной строки](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > smartcaptcha > Overview

# yc smartcaptcha

Manage SmartCaptcha resources

Command tree v1 (new CLI interface) is the default. Run `yc smartcaptcha v1 <command>`.
Legacy command tree v0 is also available: `yc smartcaptcha v0 <command>`.
Set `services.smartcaptcha.version: v0` or `services.smartcaptcha.version: v1` in your profile to change the default.

#### Command Usage

Syntax:

`yc smartcaptcha <group>`

Aliases:

- `smart-captcha`

- `sc`

#### Command Tree

- [yc smartcaptcha captcha](captcha/index.md) — A set of methods for managing Captcha resources.

  - [yc smartcaptcha captcha create](captcha/create.md) — Creates a captcha in the specified folder using the data specified in the request.

  - [yc smartcaptcha captcha delete](captcha/delete.md) — Deletes the specified captcha.

  - [yc smartcaptcha captcha get](captcha/get.md) — Returns the specified Captcha resource.

  - [yc smartcaptcha captcha get-secret-key](captcha/get-secret-key.md) — Returns the secret data of specified Captcha resource.

  - [yc smartcaptcha captcha list](captcha/list.md) — Retrieves the list of Captcha resources in the specified folder.

  - [yc smartcaptcha captcha update](captcha/update.md) — Updates the specified captcha.

- [yc smartcaptcha v0](v0/index.md) — (legacy command tree) Manage SmartCaptcha resources



- [yc smartcaptcha v1](v1/index.md) — Manage SmartCaptcha resources



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