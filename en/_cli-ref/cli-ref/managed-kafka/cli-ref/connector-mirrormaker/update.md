---
editable: false
---

# yc managed-kafka connector-mirrormaker update

Modify attributes of a Kafka Mirrormaker connector.

#### Command Usage

Syntax: 

`yc managed-kafka connector-mirrormaker update <CONNECTOR-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>Kafka cluster id.|
|`--cluster-name`|<b>`string`</b><br/>Kafka cluster name.|
|`--direction`|<b>`string`</b><br/>Allows to set direction of mirrormaker connector. Valid values: [ingress, egress]. If this cluster is target cluster of mirrormaker connector then enter "ingress". Otherwise enter "egress".|
|`--tasks-max`|<b>`int`</b><br/>Allows to set maximum number of mirrormaker connector tasks.|
|`--properties`|<b>`key=value[,key=value...]`</b><br/>Allows to set properties for the Kafka mirrormaker connector as key-value pairs.|
|`--replication-factor`|<b>`int`</b><br/>Allows to set mirrormaker connector configuration property "replication-factor". Replication factor of replicated topic.|
|`--topics`|<b>`string`</b><br/>Allows to set connector configuration property "topics". List of topics, separated by comma, that will be replicated from source cluster to target.|
|`--this-cluster-alias`|<b>`string`</b><br/>Allows to set alias of this kafka cluster for mirrormaker connector.|
|`--external-cluster`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>External cluster settings.<br/><br/>Possible property names:<br/><ul> <li><code>alias</code>:     Allows to set alias of external kafka cluster for mirrormaker connector.</li> <li><code>bootstrap-servers</code>:     Allows to set comma-separated list of bootstrap servers to connect to external kafka cluster.Value has format: &quot;host1:port1,host2:port2,...,hostN:portN&quot;.</li> <li><code>security-protocol</code>:     Allows to set security-protocol to connect to external kafka cluster.</li> <li><code>sasl-mechanism</code>:     Allows to set sasl-mechanism to connect to external kafka cluster.</li> <li><code>sasl-username</code>:     Allows to set sasl-username to connect to external kafka cluster.</li> <li><code>sasl-password</code>:     Allows to set sasl-password to connect to external kafka cluster.</li> <li><code>ssl-truststore-certificates</code>:     Allows to set ssl-truststore-certificates to connect to external kafka cluster.This is a string, that contains PEM-certificates.</li> </ul>|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
