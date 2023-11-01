---
editable: false
---

# yc managed-opensearch cluster update

Update a managed OpenSearchCluster.

#### Command Usage

Syntax: 

`yc managed-opensearch cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--id`|<b>`string`</b><br/>ID of the OpenSearch cluster.|
|`--name`|<b>`string`</b><br/>Name of the OpenSearch cluster.|
|`--max-clause-count`|<b>`int`</b><br/>Maximum amount of clauses to use in a query.|
|`--fielddata-cache-size`|<b>`string`</b><br/>Data field cache size.|
|`--reindex-remote-whitelist`|<b>`value[,value]`</b><br/>Comma-separated list of host:port pairs indicating the remote sources to be reindexed.|
|`--new-name`|<b>`string`</b><br/>Name of the cluster.|
|`--description`|<b>`string`</b><br/>Description of the cluster.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of labels given as key=value pairs.|
|`--security-group-names`|<b>`value[,value]`</b><br/>A comma-separated list of security group names to be used for the cluster.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A comma-separated list of security group IDs to be used for the cluster.|
|`--service-account-id`|<b>`string`</b><br/>service account id.|
|`--service-account-name`|<b>`string`</b><br/>ID of the service account to be used for the cluster.|
|`--delete-protection`|<b>`string`</b><br/>Wether to inhibit or not cluster deletion. Supported vlaues: 'true' or 'false'|
|`--maintenance`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Cluster maintenance window configuration. It defaults to anytime maintenance schedule.<br/><br/>Possible property names:<br/><ul> <li><code>schedule</code>:     Cluster maintenance window schedule type. Supported values: 'anytime', 'weekly'</li> <li><code>weekday</code>:     For the weekly maintenance schedule, it specifies the day of the week (mon, tue, wed, thu, fry, sat, sun).</li> <li><code>hour</code>:     For the weekly maintenance schedule, it specifies the maintenance start hour of the day. It defaults to 0.</li> </ul>|
|`--version`|<b>`string`</b><br/>OpenSearch version.|
|`--admin-password`|<b>`string`</b><br/>New password for entity. It is not secure to specify password in command line. To avoid it you can omit this flag and enter password when prompted.|
|`--generate-admin-password`|Generate random password|
|`--data-transfer-access`|<b>`string`</b><br/>Wether to allow or deny access to Data Transfer.|
|`--serverless-access`|<b>`string`</b><br/>Wether to allow or deny access to Serverless.|
|`--plugins`|<b>`value[,value]`</b><br/>OpenSearch plugins.|

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
