---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-kafka/cli-ref/cluster/create.md
---

# yc managed-kafka cluster create

Create Kafka cluster

#### Command Usage

Syntax:

`yc managed-kafka cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the Kafka cluster. ||
|| `--description` | `string`

Description of the cluster. ||
|| `--environment` | `string`

Environment to deploy the cluster in. Supported values: 'production', 'prestable'. ||
|| `--labels` | `key=value[,key=value...]`

A list of Kafka cluster labels as key-value pairs. ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--datatransfer-access` | Allow access for DataTransfer ||
|| `--rest-api-enabled` | Enables REST API on kafka cluster ||
|| `--kafka-ui-enabled` | Enables Kafka UI on kafka cluster ||
|| `--version` | `string`

Version of the Kafka server software. ||
|| `--zone-ids` | `value[,value]`

List of availability zones. ||
|| `--brokers-count` | `int`

Count of brokers in each availability zone. ||
|| `--resource-preset` | `string`

Resource preset for computational resources available to a Kafka host (CPU, RAM etc.). ||
|| `--disk-size` | `byteSize`

Storage volume available to a Kafka host in GB. ||
|| `--disk-type` | `string`

Storage type of a Kafka host. ||
|| `--zookeeper-resource-preset` | `string`

Resource preset for computational resources available to a ZooKeeper host (CPU, RAM etc.). ||
|| `--zookeeper-disk-size` | `byteSize`

Storage volume available to a ZooKeeper host in GB. ||
|| `--zookeeper-disk-type` | `string`

Storage type of a ZooKeeper host. ||
|| `--controller-resource-preset` | `string`

Resource preset for computational resources available to a KRaft-controller host (CPU, RAM etc.). ||
|| `--controller-disk-size` | `byteSize`

Storage volume available to a KRaft-controller host in GB. ||
|| `--controller-disk-type` | `string`

Storage type of a KRaft-controller host. ||
|| `--assign-public-ip` | Whether a Kafka brokers should get a public IP address. ||
|| `--schema-registry` | Enables managed Schema Registry sevice. ||
|| `--subnet-ids` | `value[,value]`

Optional list of subnets to place nodes of the cluster in. If not specified nodes will be placed in arbitrary subnets of the given network within given availability zones. ||
|| `--security-group-ids` | `value[,value]`

A list of security groups for the Kafka cluster. ||
|| `--host-group-ids` | `value[,value]`

A list of host groups to place VMs of cluster on. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--disk-encryption-key-id` | `string`

ID of the key to encrypt cluster disks. ||
|| `--compression-type` | `string`

Allows to set Kafka cluster configuration property "compression.type". Possible values are: gzip, snappy, lz4, zstd, producer, uncompressed. ||
|| `--log-flush-interval-messages` | `int`

Allows to set Kafka cluster configuration property "log.flush.interval.messages". The number of messages accumulated on a log partition before messages are flushed to disk. ||
|| `--log-flush-interval-ms` | `int`

Allows to set Kafka cluster configuration property "log.flush.interval.ms". The maximum time in ms that a message in any topic is kept in memory before flushed to disk. ||
|| `--log-flush-scheduler-interval-ms` | `int`

Allows to set Kafka cluster configuration property "log.flush.scheduler.interval.ms". The frequency in ms that the log flusher checks whether any log needs to be flushed to disk. ||
|| `--log-retention-bytes` | `int`

Allows to set Kafka cluster configuration property "log.retention.bytes". The maximum size of the log before deleting it. ||
|| `--log-retention-hours` | `int`

Allows to set Kafka cluster configuration property "log.retention.hours". The number of hours to keep a log file before deleting it. ||
|| `--log-retention-minutes` | `int`

Allows to set Kafka cluster configuration property "log.retention.minutes". The number of minutes to keep a log file before deleting it. ||
|| `--log-retention-ms` | `int`

Allows to set Kafka cluster configuration property "log.retention.ms". The number of milliseconds to keep a log file before deleting it. ||
|| `--log-segment-bytes` | `int`

Allows to set Kafka cluster configuration property "log.segment.bytes". The maximum size of a single log file. ||
|| `--auto-create-topics-enable` | Allows to set Kafka cluster configuration property "auto.create.topics.enable". Enable auto creation of topic on the server. ||
|| `--num-partitions` | `int`

Allows to set Kafka cluster configuration property "num.partitions". Default number of partitions per topic on the whole cluster. ||
|| `--default-replication-factor` | `int`

Allows to set Kafka cluster configuration property "default.replication.factor". Default replication factor of the topic on the whole cluster. ||
|| `--message-max-bytes` | `int`

Allows to set Kafka cluster configuration property "message.max.bytes". This is the largest size of the message that can be received by the broker from a producer. Must be not more then "replica.fetch.max.bytes" configuration property of this Kafka cluster. Default value: 1048588. ||
|| `--replica-fetch-max-bytes` | `int`

Allows to set Kafka cluster configuration property "replica.fetch.max.bytes". Buffer size for inter-broker message replication. Must be not less then "message.max.bytes" configuration property of this Kafka cluster and "max.message.bytes" configuration property of all topics into this Kafka cluster. Default value: 1048576. ||
|| `--offsets-retention-minutes` | `int`

Allows to set Kafka cluster configuration property "offsets.retention.minutes". Offset storage time after a consumer group loses all its consumers. Default value: 10080. ||
|| `--ssl-cipher-suites` | `value[,value]`

Allows to set Kafka cluster configuration property "ssl.cipher.suites". List of all valid cipher suites for this cluster, separated by comma. ||
|| `--maintenance-window` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Maintenance window settings

Possible property names:

- `type`: Type of maintenance window, it can be anytime or weekly. A day and hour of window need to be specified with weekly window.

- `hour`: Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.

- `day`: Day of week for maintenance window if window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun' ||
|| `--disk-size-autoscaling` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Disk size autoscaling settings

Possible property names:

- `disk-size-limit`: Set disk size limit

- `planned-usage-threshold`: Planned usage threshold

- `emergency-usage-threshold`: Emergency usage threshold ||
|| `--sasl-enabled-mechanisms` | `value[,value]`

Allows to set Kafka cluster configuration property "sasl.enabled.mechanisms". List of all valid sasl enabled mechanisms for this cluster, separated by comma. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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