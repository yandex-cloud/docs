---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-mongodb/cli-ref-beta/cluster/add-shard.md
---

# yc beta managed-mongodb cluster add-shard

Creates a new shard.

#### Command Usage

Syntax:

`yc beta managed-mongodb cluster add-shard <CLUSTER-ID>`

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

ID of the MongoDB cluster to add a shard to. To get the cluster ID, use a [ClusterService.List] request. ||
|| `--host-specs` | `shorthand/json`

Configurations for mongod hosts to be created with the shard.

Shorthand Syntax:

```hcl
[
  {
    assign-public-ip = bool,
    hidden = bool,
    priority = double,
    secondary-delay-secs = int,
    shard-name = str,
    subnet-id = str,
    tags = {key=str, key=...},
    type = MONGOD|MONGOS|MONGOCFG|MONGOINFRA,
    zone-id = str
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "assign-public-ip": "bool",
    "hidden": "bool",
    "priority": "double",
    "secondary-delay-secs": "int",
    "shard-name": "str",
    "subnet-id": "str",
    "tags": {
      "<key>": "str", ...
    },
    "type": "MONGOD|MONGOS|MONGOCFG|MONGOINFRA",
    "zone-id": "str"
  }, ...
]
```

Fields:

```
assign-public-ip -> (bool)
  Whether the host should get a public IP address on creation. After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with [assign_public_ip] set as needed. Possible values: * false - don't assign a public IP to the host. * true - the host should have a public IP address.
hidden -> (bool)
  Is host hidden in replSet
priority -> (double)
  Priority of host for the election in replSet
secondary-delay-secs -> (int)
  The number of seconds "behind" the primary that this replica set member should "lag"
shard-name -> (string)
  Name of the shard that the host belongs to.
subnet-id -> (string)
  ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The network ID is set in the [Cluster.network_id] field.
tags -> (map[string,string])
  Host tags
type -> (struct)
  Type of the host to be deployed.
zone-id -> (string)
  ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request.
``` ||
|| `--shard-name` | `string`

Name of the MongoDB shard to create. ||
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