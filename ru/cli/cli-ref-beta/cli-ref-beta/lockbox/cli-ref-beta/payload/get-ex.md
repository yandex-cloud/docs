---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/lockbox/cli-ref-beta/payload/get-ex.md
---

# yc beta lockbox payload get-ex



#### Command Usage

Syntax: 

`yc beta lockbox payload get-ex <VERSION-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--version-id`|<b>`string`</b><br/>|
|`--secret-id`|<b>`string`</b><br/>|
|`--folder-and-name`|<b>`shorthand/json`</b><br/><br/><br/>Example:|
|`--folder-and-name`|<b>`folder-id=value,`</b><br/>secret-name=value<br/><br/>Shorthand Syntax:<br/>{folder-id=str, secret-name=str}<br/>Fields:<br/>folder-id    string  required  —<br/>secret-name  string  required  —|

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
