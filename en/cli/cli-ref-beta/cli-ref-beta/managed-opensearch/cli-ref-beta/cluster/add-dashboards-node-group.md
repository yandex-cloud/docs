---
editable: false
noIndex: true
---

# yc beta managed-opensearch cluster add-dashboards-node-group

Creates a Dashboards type host group.

#### Command Usage

Syntax:

`yc beta managed-opensearch cluster add-dashboards-node-group <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--cluster-id` | `string`

ID of the OpenSearch cluster to create the Dashboards type host group in. To get the ID, use a [ClusterService.List] request. ||
|| `--node-group-spec` | `shorthand/json`

Configuration of the new host group.

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
  name = string,
  resources = {
    disk-size = integer,
    disk-type-id = string,
    resource-preset-id = string
  },
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
  "name": "string",
  "resources": {
    "disk-size": "integer",
    "disk-type-id": "string",
    "resource-preset-id": "string"
  },
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
  Determines whether a public IP is assigned to the hosts in the group.
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
name -> (string)
  Name of the group.
resources -> (struct)
  Resources allocated to the hosts.
  disk-size -> (integer)
    Volume of the storage used by the host, in bytes.
  disk-type-id -> (string)
    Type of the storage used by the host: 'network-hdd', 'network-ssd' or 'local-ssd'.
  resource-preset-id -> (string)
    ID of the preset for computational resources allocated to a host.
subnet-ids -> ([]string)
  IDs of the subnets that the hosts belong to.
zone-ids -> ([]string)
  IDs of the availability zones the hosts belong to.
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