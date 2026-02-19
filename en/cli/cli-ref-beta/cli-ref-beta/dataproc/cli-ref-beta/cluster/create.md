---
editable: false
noIndex: true
---

# yc beta dataproc cluster create

Creates a cluster in the specified folder.

#### Command Usage

Syntax:

`yc beta dataproc cluster create <AUTOSCALING-SERVICE-ACCOUNT-ID>`

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
|| `--autoscaling-service-account-id` | `string`

ID of the service account to be used by the Instance Groups service. ||
|| `--bucket` | `string`

Name of the Object Storage bucket to use for Yandex Data Processing jobs. ||
|| `--config-spec` | `shorthand/json`

Configuration and resources for hosts that should be created with the cluster.

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
      assign-public-ip = boolean,
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
      name = string,
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      },
      role = MASTERNODE|DATANODE|COMPUTENODE,
      subnet-id = string
    }, ...
  ],
  version-id = string
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
      "assign-public-ip": "boolean",
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
      "name": "string",
      "resources": {
        "disk-size": "integer",
        "disk-type-id": "string",
        "resource-preset-id": "string"
      },
      "role": "MASTERNODE|DATANODE|COMPUTENODE",
      "subnet-id": "string"
    }, ...
  ],
  "version-id": "string"
}
```

Fields:

```
hadoop -> (struct)
  Yandex Data Processing specific options.
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
  Specification for creating subclusters.
  assign-public-ip -> (boolean)
    Assign public ip addresses for all hosts in subcluter.
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
  name -> (string)
    Name of the subcluster.
  resources -> (struct)
    Resource configuration for hosts in the subcluster.
    disk-size -> (integer)
      Volume of the storage available to a host, in bytes.
    disk-type-id -> (string)
      Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive.
    resource-preset-id -> (string)
      ID of the resource preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
  role -> (struct)
    Role of the subcluster in the Yandex Data Processing cluster.
  subnet-id -> (string)
    ID of the VPC subnet used for hosts in the subcluster.
version-id -> (string)
  Version of the image for cluster provisioning. All available versions are listed in the documentation.
``` ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster ||
|| `--description` | `string`

Description of the cluster. ||
|| `--environment` | `enum`

Environment of the cluster Possible Values: 'production', 'prestable' ||
|| `--folder-id` | `string`

ID of the folder to create a cluster in. To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--host-group-ids` | `[]string`

Host groups to place VMs of cluster on. ||
|| `--labels` | `map<string><string>`

Cluster labels as 'key:value' pairs. ||
|| `--log-group-id` | `string`

ID of the cloud logging log group to write logs. If not set, logs will not be sent to logging service ||
|| `--name` | `string`

Name of the cluster. The name must be unique within the folder. The name can't be changed after the Yandex Data Processing cluster is created. ||
|| `--security-group-ids` | `[]string`

User security groups. ||
|| `--service-account-id` | `string`

ID of the service account to be used by the Yandex Data Processing manager agent. ||
|| `--ui-proxy` | Enable UI Proxy feature. ||
|| `--zone-id` | `string`

ID of the availability zone where the cluster should be placed. To get the list of available zones make a [yandex.cloud.compute.v1.ZoneService.List] request. ||
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