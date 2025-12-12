---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-opensearch/cli-ref-beta/cluster/add-dashboards-node-group.md
---

# yc beta managed-opensearch cluster add-dashboards-node-group

Creates a Dashboards type host group.

#### Command Usage

Syntax: 

`yc beta managed-opensearch cluster add-dashboards-node-group <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the OpenSearch cluster to create the Dashboards type host group in. To get the ID, use a [ClusterService.List] request.|
|`--node-group-spec`|<b>`shorthand/json`</b><br/>Configuration of the new host group.<br/>Shorthand Syntax:<br/>{<br/>assign-public-ip = bool,<br/>disk-size-autoscaling = {<br/>disk-size-limit = int,<br/>emergency-usage-threshold = int,<br/>planned-usage-threshold = int<br/>},<br/>hosts-count = int,<br/>name = str,<br/>resources = {<br/>disk-size = int,<br/>disk-type-id = str,<br/>resource-preset-id = str<br/>},<br/>subnet-ids = str,...,<br/>zone-ids = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"assign-public-ip": "bool",<br/>"disk-size-autoscaling": {<br/>"disk-size-limit": "int",<br/>"emergency-usage-threshold": "int",<br/>"planned-usage-threshold": "int"<br/>},<br/>"hosts-count": "int",<br/>"name": "str",<br/>"resources": {<br/>"disk-size": "int",<br/>"disk-type-id": "str",<br/>"resource-preset-id": "str"<br/>},<br/>"subnet-ids": [<br/>"str", ...<br/>],<br/>"zone-ids": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>assign-public-ip -> (bool)<br/>Determines whether a public IP is assigned to the hosts in the group.<br/>disk-size-autoscaling -> (struct)<br/>Disk size autoscaling settings<br/>disk-size-limit -> (int)<br/>Limit on how large the storage for database instances can automatically grow, in bytes.<br/>emergency-usage-threshold -> (int)<br/>Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.<br/>planned-usage-threshold -> (int)<br/>Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.<br/>hosts-count -> (int)<br/>Number of hosts in the group.<br/>name -> (string)<br/>Name of the group.<br/>resources -> (struct)<br/>Resources allocated to the hosts.<br/>disk-size -> (int)<br/>Volume of the storage used by the host, in bytes.<br/>disk-type-id -> (string)<br/>Type of the storage used by the host: 'network-hdd', 'network-ssd' or 'local-ssd'.<br/>resource-preset-id -> (string)<br/>ID of the preset for computational resources allocated to a host.<br/>subnet-ids -> ([]string)<br/>IDs of the subnets that the hosts belong to.<br/>zone-ids -> ([]string)<br/>IDs of the availability zones the hosts belong to.|
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
