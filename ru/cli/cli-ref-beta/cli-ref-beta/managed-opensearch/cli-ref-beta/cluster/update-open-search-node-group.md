---
editable: false
noIndex: true
---

# yc beta managed-opensearch cluster update-open-search-node-group

Updates an OpenSearch type host group.

#### Command Usage

Syntax:

`yc beta managed-opensearch cluster update-open-search-node-group <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the OpenSearch cluster to update the OpenSearch type host group in. To get the ID, use a [ClusterService.List] request. ||
|| `--name` | `string`

Name of the OpenSearch type host group to be updated. ||
|| `--node-group-spec` | `shorthand/json`

New configuration for the host group.

Shorthand Syntax:

```hcl
{
  assign-public-ip = boolean,
  disk-size-autoscaling = {
    disk-size-limit = integer,
    emergency-usage-threshold = integer,
    planned-usage-threshold = integer
  },
  hosts-count = integer,
  resources = {
    disk-size = integer,
    disk-type-id = string,
    resource-preset-id = string
  },
  roles = [
    DATA|MANAGER, ...
  ],
  subnet-ids = string,...,
  zone-ids = string,...
}
```

JSON Syntax:

```json
{
  "assign-public-ip": "boolean",
  "disk-size-autoscaling": {
    "disk-size-limit": "integer",
    "emergency-usage-threshold": "integer",
    "planned-usage-threshold": "integer"
  },
  "hosts-count": "integer",
  "resources": {
    "disk-size": "integer",
    "disk-type-id": "string",
    "resource-preset-id": "string"
  },
  "roles": [
    "DATA|MANAGER", ...
  ],
  "subnet-ids": [
    "string", ...
  ],
  "zone-ids": [
    "string", ...
  ]
}
```

Fields:

```
assign-public-ip -> (boolean)
  Whether the hosts should get a public IP address.
disk-size-autoscaling -> (struct)
  Disk size autoscaling settings
  disk-size-limit -> (integer)
    Limit on how large the storage for database instances can automatically grow, in bytes.
  emergency-usage-threshold -> (integer)
    Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
  planned-usage-threshold -> (integer)
    Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
hosts-count -> (integer)
  Number of hosts in the group.
resources -> (struct)
  Resources allocated to the hosts.
  disk-size -> (integer)
    Volume of the storage used by the host, in bytes.
  disk-type-id -> (string)
    Type of the storage used by the host: 'network-hdd', 'network-ssd' or 'local-ssd'.
  resource-preset-id -> (string)
    ID of the preset for computational resources allocated to a host.
roles -> ([]struct)
  Opensearch roles applicable to the node group.
subnet-ids -> ([]string)
  IDs of the subnets for hosts
zone-ids -> ([]string)
  IDs of the availability zones for hosts
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#