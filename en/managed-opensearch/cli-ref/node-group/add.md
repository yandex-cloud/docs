---
editable: false
---

# yc managed-opensearch node-group add

Add new node groups to a managed OpenSearch cluster.

#### Command Usage

Syntax:

`yc managed-opensearch node-group add [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the OpenSearch cluster. ||
|| `--cluster-name` | `string`

Name of the OpenSearch cluster. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--opensearch-node-group` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Individual configurations for OpenSearch node groups.

Possible property names:

- `name`: Name of the node group to be created

- `resource-preset-id`: ID of the resource preset to use for creating the node group. (required)

- `disk-size`: Disk size to attach to the selected resource preset. (required)

- `disk-type-id`: Disk type to use with the selected resource preset. It defaults to 'network-ssd'.

- `hosts-count`: Number of hosts to be created within the node group.

- `zone-ids`: IDs of the availability zones the hosts belong to. (required)

- `subnet-names`: Names of the subnets that the hosts belong to.

- `subnet-ids`: IDs of the subnets that the hosts belong to.

- `assign-public-ip`: Determines whether a public IP is assigned to the hosts in the group.

- `roles`: Roles to be given to the hosts in the node group. Supported values: 'manager', 'data', 'data+manager' (or 'manager+data') ||
|| `--dashboards-node-group` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Individual configurations for Dashboards node groups.

Possible property names:

- `name`: Name of the node group to be created

- `resource-preset-id`: ID of the resource preset to use for creating the node group. (required)

- `disk-size`: Disk size to attach to the selected resource preset. (required)

- `disk-type-id`: Disk type to use with the selected resource preset. It defaults to 'network-ssd'.

- `hosts-count`: Number of hosts to be created within the node group.

- `zone-ids`: IDs of the availability zones the hosts belong to. (required)

- `subnet-names`: Names of the subnets that the hosts belong to.

- `subnet-ids`: IDs of the subnets that the hosts belong to.

- `assign-public-ip`: Determines whether a public IP is assigned to the hosts in the group. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#