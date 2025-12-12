---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-redis/cli-ref-beta/user/update.md
---

# yc beta managed-redis user update

Updates the specified Redis user.

#### Command Usage

Syntax: 

`yc beta managed-redis user update <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>ID of the Redis cluster the user belongs to. To get the cluster ID, use a [ClusterService.List] request.|
|`--enabled`|Is Redis user enabled|
|`--passwords`|<b>`strings`</b><br/>New passwords the Redis user.|
|`--permissions`|<b>`shorthand/json`</b><br/>New set of permissions to grant to the user.<br/>Shorthand Syntax:<br/>{<br/>categories = str,<br/>commands = str,<br/>patterns = str,<br/>pub-sub-channels = str,<br/>sanitize-payload = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"categories": "str",<br/>"commands": "str",<br/>"patterns": "str",<br/>"pub-sub-channels": "str",<br/>"sanitize-payload": "str"<br/>}"<br/>Fields:<br/>categories -> (str)<br/>Command categories user has permissions to.<br/>commands -> (str)<br/>Commands user can execute.<br/>patterns -> (str)<br/>Keys patterns user has permission to.<br/>pub-sub-channels -> (str)<br/>Channel patterns user has permissions to.<br/>sanitize-payload -> (str)<br/>SanitizePayload parameter.|
|`--user-name`|<b>`string`</b><br/>Name of the Redis user to be updated.|
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
