---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/container/cli-ref-beta/lifecycle-policy/update.md
---

# yc beta container lifecycle-policy update

Updates the specified lifecycle policy.

#### Command Usage

Syntax: 

`yc beta container lifecycle-policy update <LIFECYCLE-POLICY-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>Description of lifecycle policy.|
|`--lifecycle-policy-id`|<b>`string`</b><br/>ID of the lifecycle policy.|
|`--name`|<b>`string`</b><br/>Name of lifecycle policy.|
|`--rules`|<b>`shorthand/json`</b><br/>The rules of the lifecycle policy.<br/><br/>Example:|
|`--rules`|<b>`[{description=value,`</b><br/>expire-period=1h30m, retained-top=1, tag-regexp=value, untagged=true}]<br/><br/>Shorthand Syntax:<br/>[{description=str, expire-period=duration, retained-top=int, tag-regexp=str, untagged=bool},...]<br/>Fields:<br/>description    string    — Description of the lifecycle policy rule.<br/>expire-period  duration  — Period of time for automatic deletion.<br/>Period must be a multiple of 24 hours.<br/>retained-top   int       — Number of Docker images (falling under the specified filter by tags) that must be left, even if the expire_period has already expired.<br/>tag-regexp     string    — Tag for specifying a filter in the form of a regular expression.<br/>untagged       bool      — Tag for applying the rule to Docker images without tags.<br/>|
|`--status`|<b>`enum`</b><br/>Status of the lifecycle policy. Possible Values: 'active', 'disabled'|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
