---
editable: false
---

# yc managed-opensearch cluster restore

Restore a managed OpenSearch cluster from a backup.

#### Command Usage

Syntax: 

`yc managed-opensearch cluster restore`

#### Flags

| Flag | Description |
|----|----|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--backup-id`|<b>`string`</b><br/>ID of the backup to use for restoring a managed OpenSearch cluster.|
|`--name`|<b>`string`</b><br/>Name of the OpenSearchCluster.|
|`--description`|<b>`string`</b><br/>Description of the cluster.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of labels given as key=value pairs.|
|`--environment`|<b>`string`</b><br/>Name of the environment wherein deploying the cluster. Supported values: 'production' (default), 'prestable'.|
|`--network-id`|<b>`string`</b><br/>Network id.|
|`--network-name`|<b>`string`</b><br/>Network name.|
|`--security-group-names`|<b>`value[,value]`</b><br/>A comma-separated list of security group names to be used for the cluster.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A comma-separated list of security group IDs to be used for the cluster.|
|`--service-account-id`|<b>`string`</b><br/>service account id.|
|`--service-account-name`|<b>`string`</b><br/>ID of the service account to be used for the cluster.|
|`--delete-protection`|Wether to inhibit or not cluster deletion.|
|`--maintenance`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Cluster maintenance window configuration. It defaults to anytime maintenance schedule.<br/><br/>Possible property names:<br/><ul> <li><code>schedule</code>:     Cluster maintenance window schedule type. Supported values: 'anytime', 'weekly'</li> <li><code>weekday</code>:     For the weekly maintenance schedule, it specifies the day of the week (mon, tue, wed, thu, fry, sat, sun).</li> <li><code>hour</code>:     For the weekly maintenance schedule, it specifies the maintenance start hour of the day. It defaults to 0.</li> </ul>|
|`--version`|<b>`string`</b><br/>OpenSearch version.|
|`--admin-password`|<b>`string`</b><br/>Password for entity. Usage of --read-admin-password is more secure|
|`--read-admin-password`|Read password for entity from input|
|`--generate-admin-password`|Generate random password|
|`--data-transfer-access`|Wether to allow or deny access to Data Transfer.|
|`--serverless-access`|Wether to allow or deny access to Serverless.|
|`--plugins`|<b>`value[,value]`</b><br/>OpenSearch plugins.|
|`--advanced-params`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Advanced OpenSearch configuration parameters.<br/><br/>Possible property names:<br/><ul> <li><code>max-clause-count</code>:     Maximum amount of clauses to use in a query.</li> <li><code>fielddata-cache-size</code>:     Data field cache size.</li> <li><code>reindex-remote-whitelist</code>:     Comma-separated list of host:port pairs indicating the remote sources to be reindexed.</li> </ul>|
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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
