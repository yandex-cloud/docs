---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-redis/cli-ref-beta/user/create.md
---

# yc beta managed-redis user create

Creates a Redis user in the specified cluster.

#### Command Usage

Syntax: 

`yc beta managed-redis user create <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the Redis cluster to create a user in. To get the cluster ID, use a [ClusterService.List] request.|
|`--user-spec`|<b>`shorthand/json`</b><br/>Properties of the user to be created.<br/>Shorthand Syntax:<br/>{<br/>enabled = bool,<br/>name = str,<br/>passwords = str,...,<br/>permissions = {<br/>categories = str,<br/>commands = str,<br/>patterns = str,<br/>pub-sub-channels = str,<br/>sanitize-payload = str<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"enabled": "bool",<br/>"name": "str",<br/>"passwords": [<br/>"str", ...<br/>],<br/>"permissions": {<br/>"categories": "str",<br/>"commands": "str",<br/>"patterns": "str",<br/>"pub-sub-channels": "str",<br/>"sanitize-payload": "str"<br/>}<br/>}"<br/>Fields:<br/>enabled -> (bool)<br/>Is Redis user enabled<br/>name -> (string)<br/>Name of the Redis user.<br/>passwords -> ([]string)<br/>Password of the Redis user.<br/>permissions -> (struct)<br/>Set of permissions to grant to the user.<br/>categories -> (str)<br/>Command categories user has permissions to.<br/>commands -> (str)<br/>Commands user can execute.<br/>patterns -> (str)<br/>Keys patterns user has permission to.<br/>pub-sub-channels -> (str)<br/>Channel patterns user has permissions to.<br/>sanitize-payload -> (str)<br/>SanitizePayload parameter.|
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
