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
|`--rules`|<b>`shorthand/json`</b><br/>The rules of the lifecycle policy.<br/>Shorthand Syntax:<br/>[<br/>{<br/>description = str,<br/>expire-period = duration,<br/>retained-top = int,<br/>tag-regexp = str,<br/>untagged = bool<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"description": "str",<br/>"expire-period": "duration",<br/>"retained-top": "int",<br/>"tag-regexp": "str",<br/>"untagged": "bool"<br/>}, ...<br/>]"<br/>Fields:<br/>description -> (string)<br/>Description of the lifecycle policy rule.<br/>expire-period -> (duration)<br/>Period of time for automatic deletion. Period must be a multiple of 24 hours.<br/>retained-top -> (int)<br/>Number of Docker images (falling under the specified filter by tags) that must be left, even if the expire_period has already expired.<br/>tag-regexp -> (string)<br/>Tag for specifying a filter in the form of a regular expression.<br/>untagged -> (bool)<br/>Tag for applying the rule to Docker images without tags.|
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
