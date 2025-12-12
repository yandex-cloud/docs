---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/smartcaptcha/cli-ref-beta/captcha/list.md
---

# yc beta smartcaptcha captcha list

Retrieves the list of Captcha resources in the specified folder.

#### Command Usage

Syntax: 

`yc beta smartcaptcha captcha list <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--folder-id`|<b>`string`</b><br/>ID of the folder that the captcha belongs to. Currently page_size, page_token, filter and order_by are not supported and List method will return all captchas in the folder.|

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
