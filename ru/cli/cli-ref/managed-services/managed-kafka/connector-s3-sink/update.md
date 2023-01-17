---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-kafka/connector-s3-sink/update.md
---

# yc managed-kafka connector-s3-sink update

Modify attributes of a Kafka S3-Sink connector.

#### Command Usage

Syntax: 

`yc managed-kafka connector-s3-sink update <CONNECTOR-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>Kafka cluster id.|
|`--cluster-name`|<b>`string`</b><br/>Kafka cluster name.|
|`--tasks-max`|<b>`int`</b><br/>Maximum number of s3-sink connector tasks.|
|`--properties`|<b>`key=value[,key=value...]`</b><br/>Additional properties for the Kafka s3-sink connector as key-value pairs.|
|`--topics`|<b>`string`</b><br/>List of topics, separated by comma, that will be replicated to bucket of s3-compatible storage.|
|`--file-max-records`|<b>`int`</b><br/>Max records number per single file in bucket of s3-compatible storage.|
|`--bucket-name`|<b>`string`</b><br/>Bucket of s3-compatible storage.|
|`--access-key-id`|<b>`string`</b><br/>ID of aws-compatible static-key.|
|`--secret-access-key`|<b>`string`</b><br/>Secret key of aws-compatible static-key.|
|`--storage-endpoint`|<b>`string`</b><br/>Endpoint of s3-compatible storage. Example: "storage.yandexcloud.net".|
|`--region`|<b>`string`</b><br/>Region of s3-compatible storage. Default: "us-east-1".|
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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
