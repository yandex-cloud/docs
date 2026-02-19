---
editable: false
noIndex: true
---

# yc beta managed-clickhouse cluster add-zookeeper

Adds a ZooKeeper subcluster to the specified ClickHouse cluster.

#### Command Usage

Syntax:

`yc beta managed-clickhouse cluster add-zookeeper <CLUSTER-ID>`

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

ID of the ClickHouse cluster to modify. ||
|| `--convert-tables-to-replicated` | Enable automatic convertation of non-replicated MergeTree tables to replicated ones. ||
|| `--host-specs` | `shorthand/json`

Configuration of ZooKeeper hosts.

Shorthand Syntax:

```hcl
[
  {
    assign-public-ip = boolean,
    shard-name = string,
    subnet-id = string,
    type = CLICKHOUSE|ZOOKEEPER|KEEPER,
    zone-id = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "assign-public-ip": "boolean",
    "shard-name": "string",
    "subnet-id": "string",
    "type": "CLICKHOUSE|ZOOKEEPER|KEEPER",
    "zone-id": "string"
  }, ...
]
```

Fields:

```
assign-public-ip -> (boolean)
  Whether the host should get a public IP address on creation. After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with [assign_public_ip] set as needed. Possible values: * false - don't assign a public IP to the host. * true - the host should have a public IP address.
shard-name -> (string)
  Name of the shard that the host is assigned to.
subnet-id -> (string)
  ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the [Cluster.network_id] field.
type -> (struct)
  Type of the host to be deployed.
zone-id -> (string)
  ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request.
``` ||
|| `--resources` | `shorthand/json`

Resources allocated to Zookeeper hosts.

Shorthand Syntax:

```hcl
{
  disk-size = integer,
  disk-type-id = string,
  resource-preset-id = string
}
```

JSON Syntax:

```json
{
  "disk-size": "integer",
  "disk-type-id": "string",
  "resource-preset-id": "string"
}
```

Fields:

```
disk-size -> (integer)
  Volume of the storage available to a host, in bytes.
disk-type-id -> (string)
  Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
resource-preset-id -> (string)
  ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation
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