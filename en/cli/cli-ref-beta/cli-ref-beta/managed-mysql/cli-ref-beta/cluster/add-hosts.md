---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-mysql/cli-ref-beta/cluster/add-hosts.md
---

# yc beta managed-mysql cluster add-hosts

Adds new hosts in a cluster.

#### Command Usage

Syntax: 

`yc beta managed-mysql cluster add-hosts <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the cluster to add hosts to. To get this ID, make a [ClusterService.List] request.|
|`--host-specs`|<b>`shorthand/json`</b><br/>Configuration of the newly added hosts.<br/>Shorthand Syntax:<br/>[<br/>{<br/>assign-public-ip = bool,<br/>backup-priority = int,<br/>priority = int,<br/>replication-source = str,<br/>subnet-id = str,<br/>zone-id = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"assign-public-ip": "bool",<br/>"backup-priority": "int",<br/>"priority": "int",<br/>"replication-source": "str",<br/>"subnet-id": "str",<br/>"zone-id": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>assign-public-ip -> (bool)<br/>Option that enables public IP address for the host so that the host can be accessed from the internet. After a host has been created, this setting cannot be changed. To remove an assigned public IP address, or to assign a public IP address to a host without one, recreate the host with the appropriate [assign_public_ip] value set. Possible values: * 'false' - don't assign a public IP address to the host. * 'true' - assign a public IP address to the host.<br/>backup-priority -> (int)<br/>Host backup priority<br/>priority -> (int)<br/>Host master promotion priority<br/>replication-source -> (string)<br/>[Host.name] of the host to be used as the replication source (for cascading replication).<br/>subnet-id -> (string)<br/>ID of the subnet to assign to the host. This subnet should be a part of the cluster network (the network ID is specified in the [ClusterService.CreateClusterRequest.network_id]).<br/>zone-id -> (string)<br/>ID of the availability zone where the host resides. To get a list of available zones, make the [yandex.cloud.compute.v1.ZoneService.List] request.|
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
