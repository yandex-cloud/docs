---
editable: false
noIndex: true
---

# yc beta managed-greenplum cluster restore

Creates a new Greenplum® cluster using the specified backup.

#### Command Usage

Syntax:

`yc beta managed-greenplum cluster restore <BACKUP-ID>`

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
|| `--backup-id` | `string`

ID of the backup to create a cluster from. To get the backup ID, use a [ClusterService.ListBackups] request. ||
|| `--config` | `shorthand/json`

Greenplum® cluster config.

Shorthand Syntax:

```hcl
{
  access = {
    data-lens = boolean,
    data-transfer = boolean,
    web-sql = boolean,
    yandex-query = boolean
  },
  assign-public-ip = boolean,
  backup-window-start = timeofday,
  subnet-id = string,
  zone-id = string
}
```

JSON Syntax:

```json
{
  "access": {
    "data-lens": "boolean",
    "data-transfer": "boolean",
    "web-sql": "boolean",
    "yandex-query": "boolean"
  },
  "assign-public-ip": "boolean",
  "backup-window-start": "timeofday",
  "subnet-id": "string",
  "zone-id": "string"
}
```

Fields:

```
access -> (struct)
  Access policy for external services.
  data-lens -> (boolean)
    Allows data export from the cluster to DataLens.
  data-transfer -> (boolean)
    Allows access for DataTransfer.
  web-sql -> (boolean)
    Allows SQL queries to the cluster databases from the management console.
  yandex-query -> (boolean)
    Allow access for YandexQuery.
assign-public-ip -> (boolean)
  Determines whether the host should get a public IP address on creation. After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with [assign_public_ip] set as needed. Possible values: * 'false' - do not assign a public IP to the master host. * 'true' - assign a public IP to the master host.
backup-window-start -> (timeofday)
  Time to start the daily backup, in the UTC timezone.
subnet-id -> (string)
  ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id].
zone-id -> (string)
  ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request.
``` ||
|| `--deletion-protection` | Determines whether the cluster is protected from being deleted. ||
|| `--description` | `string`

Description of the Greenplum® cluster. ||
|| `--environment` | `enum`

Deployment environment of the Greenplum® cluster. Possible Values: 'production', 'prestable' ||
|| `--folder-id` | `string`

ID of the folder to create the Greenplum® cluster in. ||
|| `--host-group-ids` | `[]string`

Host groups to place VMs of cluster on. ||
|| `--labels` | `map<string><string>`

Custom labels for the Greenplum® cluster as 'key:value' pairs. For example, "project":"mvp" or "source":"dictionary". ||
|| `--maintenance-window` | `shorthand/json`

A Greenplum® cluster maintenance window. Should be defined by either one of the two options.

Shorthand Syntax:

```hcl
{
  policy = anytime={} | weekly-maintenance-window={
    day = MON|TUE|WED|THU|FRI|SAT|SUN,
    hour = integer
  }
}
```

JSON Syntax:

```json
{
  "policy": {
    "anytime": {},
    "weekly-maintenance-window": {
      "day": "MON|TUE|WED|THU|FRI|SAT|SUN",
      "hour": "integer"
    }
  }
}
```

Fields:

```
policy -> (oneof<anytime|weekly-maintenance-window>)
  Oneof policy field
  anytime -> (struct)
    An any-time maintenance window.
  weekly-maintenance-window -> (struct)
    A weekly maintenance window.
    day -> (struct)
      Day of the week.
    hour -> (integer)
      Hour of the day in the UTC timezone.
``` ||
|| `--master-host-group-ids` | `[]string`

Host groups hosting VMs of the master subcluster. ||
|| `--master-resources` | `shorthand/json`

Resources of the Greenplum® master subcluster.

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
  Volume of the storage used by the host, in bytes.
disk-type-id -> (string)
  Type of the storage used by the host: 'network-hdd', 'network-ssd' or 'local-ssd'.
resource-preset-id -> (string)
  ID of the preset for computational resources allocated to a host. Available presets are listed in the documentation.
``` ||
|| `--name` | `string`

Name of the Greenplum® cluster. The name must be unique within the folder. ||
|| `--network-id` | `string`

ID of the network to create the cluster in. ||
|| `--restore-only` | `[]string`

List of databases and tables to restore ||
|| `--security-group-ids` | `[]string`

User security groups. ||
|| `--segment-host-count` | `int`

Number of segment hosts ||
|| `--segment-host-group-ids` | `[]string`

Host groups hosting VMs of the segment subcluster. ||
|| `--segment-in-host` | `int`

Number of segments on each host ||
|| `--segment-resources` | `shorthand/json`

Resources of the Greenplum® segment subcluster.

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
  Volume of the storage used by the host, in bytes.
disk-type-id -> (string)
  Type of the storage used by the host: 'network-hdd', 'network-ssd' or 'local-ssd'.
resource-preset-id -> (string)
  ID of the preset for computational resources allocated to a host. Available presets are listed in the documentation.
``` ||
|| `--service-account-id` | `string`

Service account that will be used to access a Yandex Cloud resources ||
|| `--time` | `time`

Timestamp of the moment to which the Greenplum cluster should be restored. (RFC3339) ||
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