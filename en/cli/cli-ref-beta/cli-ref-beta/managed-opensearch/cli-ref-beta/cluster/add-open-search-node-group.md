---
editable: false
noIndex: true
---

# yc beta managed-opensearch cluster add-open-search-node-group

Creates an OpenSearch type host group.

#### Command Usage

Syntax:

`yc beta managed-opensearch cluster add-open-search-node-group <CLUSTER-ID>`

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

ID of the OpenSearch cluster to create the OpenSearch type host group in. To get the ID, use a [ClusterService.List] request. ||
|| `--node-group-spec` | `shorthand/json`

Configuration of the new host group.

Shorthand Syntax:

```hcl
{
  assign-public-ip = bool,
  disk-size-autoscaling = {
    disk-size-limit = int,
    emergency-usage-threshold = int,
    planned-usage-threshold = int
  },
  hosts-count = int,
  name = str,
  resources = {
    disk-size = int,
    disk-type-id = str,
    resource-preset-id = str
  },
  roles = [
    DATA|MANAGER, ...
  ],
  subnet-ids = str,...,
  zone-ids = str,...
}
```

JSON Syntax:

```json
{
  "assign-public-ip": "bool",
  "disk-size-autoscaling": {
    "disk-size-limit": "int",
    "emergency-usage-threshold": "int",
    "planned-usage-threshold": "int"
  },
  "hosts-count": "int",
  "name": "str",
  "resources": {
    "disk-size": "int",
    "disk-type-id": "str",
    "resource-preset-id": "str"
  },
  "roles": [
    "DATA|MANAGER", ...
  ],
  "subnet-ids": [
    "str", ...
  ],
  "zone-ids": [
    "str", ...
  ]
}
```

Fields:

```
assign-public-ip -> (bool)
  Determines whether a public IP is assigned to the hosts in the group.
disk-size-autoscaling -> (struct)
  Disk size autoscaling settings
  disk-size-limit -> (int)
    Limit on how large the storage for database instances can automatically grow, in bytes.
  emergency-usage-threshold -> (int)
    Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
  planned-usage-threshold -> (int)
    Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
hosts-count -> (int)
  Number of hosts in the group.
name -> (string)
  Name of the group.
resources -> (struct)
  Resources allocated to the hosts.
  disk-size -> (int)
    Volume of the storage used by the host, in bytes.
  disk-type-id -> (string)
    Type of the storage used by the host: 'network-hdd', 'network-ssd' or 'local-ssd'.
  resource-preset-id -> (string)
    ID of the preset for computational resources allocated to a host.
roles -> ([]struct)
  Roles of the hosts in the group.
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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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