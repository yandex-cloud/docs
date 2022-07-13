---
sourcePath: en/_cli-ref/cli-ref/managed-services/dataproc/job/create-mapreduce.md
---
# yc dataproc job create-mapreduce

Create a Dataproc MapReduce job.

#### Command Usage

Syntax: 

`yc dataproc job create-mapreduce [Flags...] [Global Flags...]`

Aliases: 

- `submit-mapreduce`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>ID of the cluster.|
|`--cluster-name`|<b>`string`</b><br/>Name of the cluster.|
|`--name`|<b>`string`</b><br/>Optional job name|
|`--main-class`|<b>`string`</b><br/>Main class name|
|`--main-jar-file-uri`|<b>`string`</b><br/>Mai JAR file URI|
|`--jar-file-uris`|<b>`value[,value]`</b><br/>JAR file URIs|
|`--file-uris`|<b>`value[,value]`</b><br/>File URIs|
|`--archive-uris`|<b>`value[,value]`</b><br/>Archive URIs|
|`--properties`|<b>`stringToString`</b><br/>Properties|
|`--args`|<b>`value[,value]`</b><br/>Arguments|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
