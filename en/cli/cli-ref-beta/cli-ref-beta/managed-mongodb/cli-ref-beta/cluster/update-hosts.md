---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-mongodb/cli-ref-beta/cluster/update-hosts.md
---

# yc beta managed-mongodb cluster update-hosts

Updates the specified parameters for the host.

#### Command Usage

Syntax: 

`yc beta managed-mongodb cluster update-hosts <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the MongoDB cluster to update hosts from. To get the MongoDB cluster ID, use a [ClusterService.List] request.|
|`--update-host-specs`|<b>`shorthand/json`</b><br/>New configurations to apply to hosts of a Managed Service for MongoDB cluster.<br/>Shorthand Syntax:<br/>[<br/>{<br/>assign-public-ip = bool,<br/>hidden = bool,<br/>host-name = str,<br/>priority = double,<br/>secondary-delay-secs = int,<br/>tags = {key=str, key=...}<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"assign-public-ip": "bool",<br/>"hidden": "bool",<br/>"host-name": "str",<br/>"priority": "double",<br/>"secondary-delay-secs": "int",<br/>"tags": {<br/>"\<key\>": "str", ...<br/>}<br/>}, ...<br/>]"<br/>Fields:<br/>assign-public-ip -> (bool)<br/>Determines whether the host should get a public IP address after the update.<br/>hidden -> (bool)<br/>Determines if the host is a hidden replica set member. Such members cannot become primary in a replica set, and they are invisible to client applications. However, hidden members can participate in elections of the primary host. For more information, see the MongoDB documentation.<br/>host-name -> (string)<br/>Host to be updated. Specify the host FQDN.<br/>priority -> (double)<br/>Priority of the host to be elected as the primary in the replica set. The minimum value is '0' if the Managed Service for MongoDB cluster contains three or more secondary hosts. Otherwise, the minimum value is '1'.<br/>secondary-delay-secs -> (int)<br/>The time, in seconds, by which the given replica set member lags behind the primary host.<br/>tags -> (map[string,string])<br/>Host tag list that contains key-value pairs for the given replica set member. For more information about how to specify the tags and what values to choose, see the MongoDB documentation.|
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
