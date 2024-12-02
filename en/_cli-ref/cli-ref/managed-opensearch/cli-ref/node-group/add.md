---
editable: false
---

# yc managed-opensearch node-group add

Add new node groups to a managed OpenSearch cluster.

#### Command Usage

Syntax: 

`yc managed-opensearch node-group add [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>ID of the OpenSearch cluster.|
|`--cluster-name`|<b>`string`</b><br/>Name of the OpenSearch cluster.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--opensearch-node-group`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Individual configurations for OpenSearch node groups.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Name of the node group to be created</li> <li><code>resource-preset-id</code>:     ID of the resource preset to use for creating the node group. (required)</li> <li><code>disk-size</code>:     Disk size to attach to the selected resource preset. (required)</li> <li><code>disk-type-id</code>:     Disk type to use with the selected resource preset. It defaults to 'network-ssd'.</li> <li><code>hosts-count</code>:     Number of hosts to be created within the node group.</li> <li><code>zone-ids</code>:     IDs of the availability zones the hosts belong to. (required)</li> <li><code>subnet-names</code>:     Names of the subnets that the hosts belong to.</li> <li><code>subnet-ids</code>:     IDs of the subnets that the hosts belong to.</li> <li><code>assign-public-ip</code>:     Determines whether a public IP is assigned to the hosts in the group.</li> <li><code>roles</code>:     Roles to be given to the hosts in the node group. Supported values: 'manager', 'data', 'data+manager' (or 'manager+data')</li> </ul>|
|`--dashboards-node-group`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Individual configurations for Dashboards node groups.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Name of the node group to be created</li> <li><code>resource-preset-id</code>:     ID of the resource preset to use for creating the node group. (required)</li> <li><code>disk-size</code>:     Disk size to attach to the selected resource preset. (required)</li> <li><code>disk-type-id</code>:     Disk type to use with the selected resource preset. It defaults to 'network-ssd'.</li> <li><code>hosts-count</code>:     Number of hosts to be created within the node group.</li> <li><code>zone-ids</code>:     IDs of the availability zones the hosts belong to. (required)</li> <li><code>subnet-names</code>:     Names of the subnets that the hosts belong to.</li> <li><code>subnet-ids</code>:     IDs of the subnets that the hosts belong to.</li> <li><code>assign-public-ip</code>:     Determines whether a public IP is assigned to the hosts in the group.</li> </ul>|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
