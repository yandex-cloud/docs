---
editable: false
noIndex: true
---

# yc beta dataproc cluster update

Updates the configuration of the specified cluster.

#### Command Usage

Syntax:

`yc beta dataproc cluster update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--autoscaling-service-account-id` | `string`

ID of the new service account to be used by the Instance Groups service. ||
|| `--bucket` | `string`

Name of the new Object Storage bucket to use for Yandex Data Processing jobs. ||
|| `--cluster-id` | `string`

ID of the cluster to update. To get the cluster ID, make a [ClusterService.List] request. ||
|| `--config-spec` | `shorthand/json`

Configuration and resources for hosts that should be created with the Yandex Data Processing cluster.

Shorthand Syntax:

```hcl
{
  hadoop = {
    initialization-actions = [
      {
        args = string,...,
        timeout = integer,
        uri = string
      }, ...
    ],
    oslogin-enabled = boolean,
    properties = {key=string, key=...},
    services = [
      HDFS|YARN|MAPREDUCE|HIVE|TEZ|ZOOKEEPER|HBASE|SQOOP|FLUME|SPARK|ZEPPELIN|OOZIE|LIVY, ...
    ],
    ssh-public-keys = string,...
  },
  subclusters-spec = [
    {
      autoscaling-config = {
        cpu-utilization-target = float64,
        decommission-timeout = integer,
        max-hosts-count = integer,
        measurement-duration = duration,
        preemptible = boolean,
        stabilization-duration = duration,
        warmup-duration = duration
      },
      hosts-count = integer,
      id = string,
      name = string,
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    }, ...
  ]
}
```

JSON Syntax:

```json
{
  "hadoop": {
    "initialization-actions": [
      {
        "args": [
          "string", ...
        ],
        "timeout": "integer",
        "uri": "string"
      }, ...
    ],
    "oslogin-enabled": "boolean",
    "properties": {
      "<key>": "string", ...
    },
    "services": [
      "HDFS|YARN|MAPREDUCE|HIVE|TEZ|ZOOKEEPER|HBASE|SQOOP|FLUME|SPARK|ZEPPELIN|OOZIE|LIVY", ...
    ],
    "ssh-public-keys": [
      "string", ...
    ]
  },
  "subclusters-spec": [
    {
      "autoscaling-config": {
        "cpu-utilization-target": "float64",
        "decommission-timeout": "integer",
        "max-hosts-count": "integer",
        "measurement-duration": "duration",
        "preemptible": "boolean",
        "stabilization-duration": "duration",
        "warmup-duration": "duration"
      },
      "hosts-count": "integer",
      "id": "string",
      "name": "string",
      "resources": {
        "disk-size": "integer",
        "disk-type-id": "string",
        "resource-preset-id": "string"
      }
    }, ...
  ]
}
```

Fields:

```
hadoop -> (struct)
  Hadoop specific options
  initialization-actions -> ([]struct)
    Set of init-actions
    args -> ([]string)
      Arguments to the initialization action
    timeout -> (integer)
      Execution timeout
    uri -> (string)
      URI of the executable file
  oslogin-enabled -> (boolean)
    Oslogin enable on cluster nodes
  properties -> (map[string,string])
    Properties set for all hosts in '*-site.xml' configurations. The key should indicate the service and the property. For example, use the key 'hdfs:dfs.replication' to set the 'dfs.replication' property in the file '/etc/hadoop/conf/hdfs-site.xml'.
  services -> ([]struct)
    Set of services used in the cluster (if empty, the default set is used).
  ssh-public-keys -> ([]string)
    List of public SSH keys to access to cluster hosts.
subclusters-spec -> ([]struct)
  New configuration for subclusters in a cluster.
  autoscaling-config -> (struct)
    Configuration for instance group based subclusters
    cpu-utilization-target -> (float64)
      Defines an autoscaling rule based on the average CPU utilization of the instance group.
    decommission-timeout -> (integer)
      Timeout to gracefully decommission nodes during downscaling. In seconds. Default value: 120
    max-hosts-count -> (integer)
      Upper limit for total instance subcluster count.
    measurement-duration -> (duration)
      Time in seconds allotted for averaging metrics.
    preemptible -> (boolean)
      Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see documentation.
    stabilization-duration -> (duration)
      Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should.
    warmup-duration -> (duration)
      The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected.
  hosts-count -> (integer)
    Number of hosts in the subcluster.
  id -> (string)
    ID of the subcluster to update. To get the subcluster ID make a [SubclusterService.List] request.
  name -> (string)
    Name of the subcluster.
  resources -> (struct)
    Resource configuration for each host in the subcluster.
    disk-size -> (integer)
      Volume of the storage available to a host, in bytes.
    disk-type-id -> (string)
      Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive.
    resource-preset-id -> (string)
      ID of the resource preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
``` ||
|| `--decommission-timeout` | `int`

Timeout to gracefully decommission nodes. In seconds. Default value: 0 ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster ||
|| `--description` | `string`

New description for the cluster. ||
|| `--labels` | `map<string><string>`

A new set of cluster labels as 'key:value' pairs. ||
|| `--log-group-id` | `string`

ID of the cloud logging log group to write logs. If not set, logs will not be sent to logging service ||
|| `--name` | `string`

New name for the Yandex Data Processing cluster. The name must be unique within the folder. ||
|| `--security-group-ids` | `[]string`

User security groups. ||
|| `--service-account-id` | `string`

ID of the new service account to be used by the Yandex Data Processing manager agent. ||
|| `--ui-proxy` | Enable UI Proxy feature. ||
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