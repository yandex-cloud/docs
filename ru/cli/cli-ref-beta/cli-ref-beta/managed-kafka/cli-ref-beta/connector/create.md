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
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the Apache Kafka® cluster to create the connector in. To get this ID, make a [ClusterService.List] request.|
|`--connector-spec`|<b>`shorthand/json`</b><br/>Configuration of the connector to create.<br/>Shorthand Syntax:<br/>{<br/>connector-config = connector-config-mirrormaker={<br/>replication-factor = int,<br/>source-cluster = {<br/>alias = str,<br/>cluster-connection = external-cluster={<br/>bootstrap-servers = str,<br/>sasl-mechanism = str,<br/>sasl-password = str,<br/>sasl-username = str,<br/>security-protocol = str,<br/>ssl-truststore-certificates = str<br/>} \| this-cluster={}<br/>},<br/>target-cluster = {<br/>alias = str,<br/>cluster-connection = external-cluster={<br/>bootstrap-servers = str,<br/>sasl-mechanism = str,<br/>sasl-password = str,<br/>sasl-username = str,<br/>security-protocol = str,<br/>ssl-truststore-certificates = str<br/>} \| this-cluster={}<br/>},<br/>topics = str<br/>} \| connector-config-s3-sink={<br/>file-compression-type = str,<br/>file-max-records = int,<br/>s3-connection = {<br/>bucket-name = str,<br/>storage = external-s3={<br/>access-key-id = str,<br/>endpoint = str,<br/>region = str,<br/>secret-access-key = str<br/>}<br/>},<br/>topics = str<br/>},<br/>name = str,<br/>properties = {key=str, key=...},<br/>tasks-max = int<br/>}<br/>JSON Syntax:<br/>"{<br/>"connector-config": {<br/>"connector-config-mirrormaker": {<br/>"replication-factor": "int",<br/>"source-cluster": {<br/>"alias": "str",<br/>"cluster-connection": {<br/>"external-cluster": {<br/>"bootstrap-servers": "str",<br/>"sasl-mechanism": "str",<br/>"sasl-password": "str",<br/>"sasl-username": "str",<br/>"security-protocol": "str",<br/>"ssl-truststore-certificates": "str"<br/>},<br/>"this-cluster": {}<br/>}<br/>},<br/>"target-cluster": {<br/>"alias": "str",<br/>"cluster-connection": {<br/>"external-cluster": {<br/>"bootstrap-servers": "str",<br/>"sasl-mechanism": "str",<br/>"sasl-password": "str",<br/>"sasl-username": "str",<br/>"security-protocol": "str",<br/>"ssl-truststore-certificates": "str"<br/>},<br/>"this-cluster": {}<br/>}<br/>},<br/>"topics": "str"<br/>},<br/>"connector-config-s3-sink": {<br/>"file-compression-type": "str",<br/>"file-max-records": "int",<br/>"s3-connection": {<br/>"bucket-name": "str",<br/>"storage": {<br/>"external-s3": {<br/>"access-key-id": "str",<br/>"endpoint": "str",<br/>"region": "str",<br/>"secret-access-key": "str"<br/>}<br/>}<br/>},<br/>"topics": "str"<br/>}<br/>},<br/>"name": "str",<br/>"properties": {<br/>"\<key\>": "str", ...<br/>},<br/>"tasks-max": "int"<br/>}"<br/>Fields:<br/>name -> (string)<br/>Name of the connector.<br/>properties -> (map[string,string])<br/>A set of properties passed to Managed Service for Apache Kafka® with the connector configuration. Example: 'sync.topics.config.enabled: true'.<br/>tasks-max -> (int)<br/>Maximum number of connector tasks. Default value is the number of brokers.<br/>connector-config -> (oneof<connector-config-mirrormaker\|connector-config-s3-sink>)<br/>Oneof connector-config field<br/>connector-config-mirrormaker -> (struct)<br/>Configuration of the MirrorMaker connector.<br/>replication-factor -> (int)<br/>Replication factor for automatically created topics.<br/>source-cluster -> (struct)<br/>Source cluster configuration for the MirrorMaker connector.<br/>alias -> (string)<br/>Alias of cluster connection configuration. Examples: 'source', 'target'.<br/>cluster-connection -> (oneof<external-cluster\|this-cluster>)<br/>Oneof cluster-connection field<br/>this-cluster -> (struct)<br/>Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty.<br/>external-cluster -> (struct)<br/>Configuration of connection to an external cluster with all the necessary credentials.<br/>bootstrap-servers -> (string)<br/>List of bootstrap servers of the cluster, separated by ','.<br/>sasl-mechanism -> (string)<br/>SASL mechanism to use for connection to the cluster.<br/>sasl-password -> (string)<br/>SASL password to use for connection to the cluster.<br/>sasl-username -> (string)<br/>SASL username to use for connection to the cluster.<br/>security-protocol -> (string)<br/>Security protocol to use for connection to the cluster.<br/>ssl-truststore-certificates -> (string)<br/>CA in PEM format to connect to external cluster. Lines of certificate separated by '\n' symbol.<br/>target-cluster -> (struct)<br/>Target cluster configuration for the MirrorMaker connector.<br/>alias -> (string)<br/>Alias of cluster connection configuration. Examples: 'source', 'target'.<br/>cluster-connection -> (oneof<external-cluster\|this-cluster>)<br/>Oneof cluster-connection field<br/>this-cluster -> (struct)<br/>Connection configuration of the cluster the connector belongs to. As all credentials are already known, leave this parameter empty.<br/>external-cluster -> (struct)<br/>Configuration of connection to an external cluster with all the necessary credentials.<br/>bootstrap-servers -> (string)<br/>List of bootstrap servers of the cluster, separated by ','.<br/>sasl-mechanism -> (string)<br/>SASL mechanism to use for connection to the cluster.<br/>sasl-password -> (string)<br/>SASL password to use for connection to the cluster.<br/>sasl-username -> (string)<br/>SASL username to use for connection to the cluster.<br/>security-protocol -> (string)<br/>Security protocol to use for connection to the cluster.<br/>ssl-truststore-certificates -> (string)<br/>CA in PEM format to connect to external cluster. Lines of certificate separated by '\n' symbol.<br/>topics -> (string)<br/>List of Kafka topics, separated by ','.<br/>connector-config-s3-sink -> (struct)<br/>Configuration of S3-Sink connector.<br/>file-compression-type -> (string)<br/>The compression type used for files put on GCS. The supported values are: 'gzip', 'snappy', 'zstd', 'none'. Optional, the default is 'none'.<br/>file-max-records -> (int)<br/>Max records per file.<br/>s3-connection -> (struct)<br/>Credentials for connecting to S3 storage.<br/>bucket-name -> (string)<br/>storage -> (oneof\<external-s3\>)<br/>Oneof storage field<br/>external-s3 -> (struct)<br/>access-key-id -> (string)<br/>endpoint -> (string)<br/>region -> (string)<br/>Default is 'us-east-1'.<br/>secret-access-key -> (string)<br/>topics -> (string)<br/>List of Kafka topics, separated by ','.|
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
