# yc managed-kafka cluster create

Create Kafka cluster

#### Command Usage

Syntax: 

`yc managed-kafka cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/> Name of the Kafka cluster.|
|`--description`|<b>`string`</b><br/> Description of the cluster.|
|`--environment`|<b>`string`</b><br/> Environment to deploy the cluster in. Supported values: 'production', 'prestable'.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> A list of Kafka cluster labels as key-value pairs.|
|`--network-id`|<b>`string`</b><br/> Network id.|
|`--network-name`|<b>`string`</b><br/> Network name.|
|`--datatransfer-access`| Allow access for DataTransfer|
|`--version`|<b>`string`</b><br/> Version of the Kafka server software.|
|`--zone-ids`|<b>`value[,value]`</b><br/> List of availability zones.|
|`--brokers-count`|<b>`int`</b><br/> Count of brokers in each availability zone.|
|`--resource-preset`|<b>`string`</b><br/> Resource preset for computational resources available to a Kafka host (CPU, RAM etc.).|
|`--disk-size`|<b>`byteSize`</b><br/> Storage volume available to a Kafka host.|
|`--disk-type`|<b>`string`</b><br/> Storage type of a Kafka host.|
|`--zookeeper-resource-preset`|<b>`string`</b><br/> Resource preset for computational resources available to a ZooKeeper host (CPU, RAM etc.).|
|`--zookeeper-disk-size`|<b>`byteSize`</b><br/> Storage volume available to a ZooKeeper host.|
|`--zookeeper-disk-type`|<b>`string`</b><br/> Storage type of a ZooKeeper host.|
|`--assign-public-ip`| Whether a Kafka brokers should get a public IP address.|
|`--unmanaged-topics`| Whether a Kafka cluster allows to manage topics via AdminAPI.|
|`--schema-registry`| Enables managed Schema Registry sevice.|
|`--subnet-ids`|<b>`value[,value]`</b><br/> Optional list of subnets to place nodes of the cluster in. If not specified nodes will be placed in arbitrary subnets of the given network within given availability zones.|
|`--security-group-ids`|<b>`value[,value]`</b><br/> A list of security groups for the Kafka cluster.|
|`--host-group-ids`|<b>`value[,value]`</b><br/> A list of host groups to place VMs of cluster on.|
|`--deletion-protection`| Deletion Protection inhibits deletion of the cluster.|
|`--compression-type`|<b>`string`</b><br/> Allows to set Kafka cluster configuration property "compression.type". Possible values are: gzip, snappy, lz4, zstd, producer, uncompressed.|
|`--log-flush-interval-messages`|<b>`int`</b><br/> Allows to set Kafka cluster configuration property "log.flush.interval.messages". The number of messages accumulated on a log partition before messages are flushed to disk.|
|`--log-flush-interval-ms`|<b>`int`</b><br/> Allows to set Kafka cluster configuration property "log.flush.interval.ms". The maximum time in ms that a message in any topic is kept in memory before flushed to disk.|
|`--log-flush-scheduler-interval-ms`|<b>`int`</b><br/> Allows to set Kafka cluster configuration property "log.flush.scheduler.interval.ms". The frequency in ms that the log flusher checks whether any log needs to be flushed to disk.|
|`--log-retention-bytes`|<b>`int`</b><br/> Allows to set Kafka cluster configuration property "log.retention.bytes". The maximum size of the log before deleting it.|
|`--log-retention-hours`|<b>`int`</b><br/> Allows to set Kafka cluster configuration property "log.retention.hours". The number of hours to keep a log file before deleting it.|
|`--log-retention-minutes`|<b>`int`</b><br/> Allows to set Kafka cluster configuration property "log.retention.minutes". The number of minutes to keep a log file before deleting it.|
|`--log-retention-ms`|<b>`int`</b><br/> Allows to set Kafka cluster configuration property "log.retention.ms". The number of milliseconds to keep a log file before deleting it.|
|`--log-segment-bytes`|<b>`int`</b><br/> Allows to set Kafka cluster configuration property "log.segment.bytes". The maximum size of a single log file.|
|`--log-preallocate`| Allows to set Kafka cluster configuration property "log.preallocate". Should pre allocate file when create new segment?|
|`--auto-create-topics-enable`| Allows to set Kafka cluster configuration property "auto.create.topics.enable". Enable auto creation of topic on the server.|
|`--num-partitions`|<b>`int`</b><br/> Allows to set Kafka cluster configuration property "num.partitions". Default number of partitions per topic on the whole cluster.|
|`--default-replication-factor`|<b>`int`</b><br/> Allows to set Kafka cluster configuration property "default.replication.factor". Default replication factor of the topic on the whole cluster.|
|`--maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Maintenance window settings  Possible property names:  type Type of maintenance window, it can be anytime or weekly. A day and hour of window need to be specified with weekly window.  hour Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.  day Day of week for maintenance window if window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'  |
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
