---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-kafka/cli-ref-beta/connector/create.md
---

# yc beta managed-kafka connector create

Creates a new Apache Kafka® connector in a cluster.

#### Command Usage

Syntax: 

`yc beta managed-kafka connector create <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the Apache Kafka® cluster to create the connector in.<br/><br/>To get this ID, make a [ClusterService.List] request.|
|`--connector-spec`|<b>`shorthand/json`</b><br/>Configuration of the connector to create.<br/><br/>Example:|
|`--connector-spec`|<b>`connector-config={connector-config-mirrormaker={replication-factor=42,`</b><br/>source-cluster={alias=value, cluster-connection={external-cluster={bootstrap-servers=value, sasl-mechanism=value, sasl-password=value, sasl-username=value, security-protocol=value, ssl-truststore-certificates=value}}}, target-cluster={alias=value, cluster-connection={external-cluster={bootstrap-servers=value, sasl-mechanism=value, sasl-password=value, sasl-username=value, security-protocol=value, ssl-truststore-certificates=value}}}, topics=value}}, name=value, properties={key=value}, tasks-max=42<br/><br/>Shorthand Syntax:<br/>{connector-config={connector-config-mirrormaker={replication-factor=int, source-cluster={alias=str, cluster-connection={external-cluster={bootstrap-servers=str, sasl-mechanism=str, sasl-password=str, sasl-username=str, security-protocol=str, ssl-truststore-certificates=str} \| this-cluster={}}}, target-cluster={alias=str, cluster-connection={external-cluster={bootstrap-servers=str, sasl-mechanism=str, sasl-password=str, sasl-username=str, security-protocol=str, ssl-truststore-certificates=str} \| this-cluster={}}}, topics=str} \| connector-config-s3-sink={file-compression-type=str, file-max-records=int, s3-connection={bucket-name=str, storage={external-s3={access-key-id=str, endpoint=str, region=str, secret-access-key=str}}}, topics=str}}, name=str, properties={key=str, key=...}, tasks-max=int}<br/>Fields:<br/>name              string                                                        — Name of the connector.<br/>properties        map[string,string]                                            — A set of properties passed to Managed Service for Apache Kafka® with the connector configuration.<br/>Example: 'sync.topics.config.enabled: true'.<br/>tasks-max         int                                                           — Maximum number of connector tasks. Default value is the number of brokers.<br/>connector-config  oneof<connector-config-mirrormaker\|connector-config-s3-sink>  — Oneof connector-config field<br/>connector-config-mirrormaker  struct  — Configuration of the MirrorMaker connector.<br/>replication-factor  int     — Replication factor for automatically created topics.<br/>source-cluster      struct  — Source cluster configuration for the MirrorMaker connector.<br/>alias               string                                — Alias of cluster connection configuration.<br/>Examples: 'source', 'target'.<br/>cluster-connection  oneof<external-cluster\|this-cluster>  — Oneof cluster-connection field<br/>this-cluster      struct  — Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty.<br/>external-cluster  struct  — Configuration of connection to an external cluster with all the necessary credentials.<br/>bootstrap-servers            string  — List of bootstrap servers of the cluster, separated by ','.<br/>sasl-mechanism               string  — SASL mechanism to use for connection to the cluster.<br/>sasl-password                string  — SASL password to use for connection to the cluster.<br/>sasl-username                string  — SASL username to use for connection to the cluster.<br/>security-protocol            string  — Security protocol to use for connection to the cluster.<br/>ssl-truststore-certificates  string  — CA in PEM format to connect to external cluster.<br/>Lines of certificate separated by '\n' symbol.<br/>target-cluster      struct  — Target cluster configuration for the MirrorMaker connector.<br/>alias               string                                — Alias of cluster connection configuration.<br/>Examples: 'source', 'target'.<br/>cluster-connection  oneof<external-cluster\|this-cluster>  — Oneof cluster-connection field<br/>this-cluster      struct  — Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty.<br/>external-cluster  struct  — Configuration of connection to an external cluster with all the necessary credentials.<br/>bootstrap-servers            string  — List of bootstrap servers of the cluster, separated by ','.<br/>sasl-mechanism               string  — SASL mechanism to use for connection to the cluster.<br/>sasl-password                string  — SASL password to use for connection to the cluster.<br/>sasl-username                string  — SASL username to use for connection to the cluster.<br/>security-protocol            string  — Security protocol to use for connection to the cluster.<br/>ssl-truststore-certificates  string  — CA in PEM format to connect to external cluster.<br/>Lines of certificate separated by '\n' symbol.<br/>topics              string  — List of Kafka topics, separated by ','.<br/>connector-config-s3-sink      struct  — Configuration of S3-Sink connector.<br/>file-compression-type  string  — The compression type used for files put on GCS.<br/>The supported values are: 'gzip', 'snappy', 'zstd', 'none'.<br/>Optional, the default is 'none'.<br/>file-max-records       int     — Max records per file.<br/>s3-connection          struct  — Credentials for connecting to S3 storage.<br/>bucket-name  string              —<br/>storage      oneof\<external-s3\>  — Oneof storage field<br/>external-s3  struct  —<br/>access-key-id      string  —<br/>endpoint           string  —<br/>region             string  — Default is 'us-east-1'.<br/>secret-access-key  string  —<br/>topics                 string  — List of Kafka topics, separated by ','.<br/>|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
