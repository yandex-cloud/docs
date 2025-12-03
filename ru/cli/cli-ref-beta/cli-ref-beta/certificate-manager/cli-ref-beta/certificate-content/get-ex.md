---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/certificate-manager/cli-ref-beta/certificate-content/get-ex.md
---

# yc beta certificate-manager certificate-content get-ex



#### Command Usage

Syntax: 

`yc beta certificate-manager certificate-content get-ex <VERSION-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--private-key-format`|<b>`enum`</b><br/>Possible Values: 'pkcs1', 'pkcs8'|
|`--version-id`|<b>`string`</b><br/>|
|`--certificate-id`|<b>`string`</b><br/>|
|`--folder-and-name`|<b>`shorthand/json`</b><br/><br/><br/>Example:|
|`--folder-and-name`|<b>`certificate-name=value,`</b><br/>folder-id=value<br/><br/>Shorthand Syntax:<br/>{certificate-name=str, folder-id=str}<br/>Fields:<br/>certificate-name  string  required  —<br/>folder-id         string  required  —|

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
