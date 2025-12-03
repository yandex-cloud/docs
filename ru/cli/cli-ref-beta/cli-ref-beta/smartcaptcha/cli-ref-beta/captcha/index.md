---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/smartcaptcha/cli-ref-beta/captcha/index.md
---

# yc beta smartcaptcha captcha

A set of methods for managing Captcha resources.

#### Command Usage

Syntax: 

`yc beta smartcaptcha captcha <command>`

#### Command Tree

- [yc beta smartcaptcha captcha create](create.md) — Creates a captcha in the specified folder using the data specified in the request.
- [yc beta smartcaptcha captcha delete](delete.md) — Deletes the specified captcha.
- [yc beta smartcaptcha captcha get](get.md) — Returns the specified Captcha resource.
- [yc beta smartcaptcha captcha get-secret-key](get-secret-key.md) — Returns the secret data of specified Captcha resource.
- [yc beta smartcaptcha captcha list](list.md) — Retrieves the list of Captcha resources in the specified folder.
- [yc beta smartcaptcha captcha update](update.md) — Updates the specified captcha.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
