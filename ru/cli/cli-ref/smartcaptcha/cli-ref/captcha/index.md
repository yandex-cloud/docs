---
editable: false
sourcePath: en/_cli-ref/cli-ref/smartcaptcha/cli-ref/captcha/index.md
---

# yc smartcaptcha captcha

Manage captchas

#### Command Usage

Syntax:

`yc smartcaptcha captcha <command>`

#### Command Tree

- [yc smartcaptcha captcha create](create.md) — Create a captcha

- [yc smartcaptcha captcha delete](delete.md) — Delete the specified captcha

- [yc smartcaptcha captcha get](get.md) — Show information about the specified captcha

- [yc smartcaptcha captcha list](list.md) — List captchas

- [yc smartcaptcha captcha update](update.md) — Update the specified captcha

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