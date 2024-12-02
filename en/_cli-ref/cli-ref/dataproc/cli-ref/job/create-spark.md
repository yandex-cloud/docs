---
editable: false
---

# yc dataproc job create-spark

Create a Dataproc Spark job.

#### Command Usage

Syntax: 

`yc dataproc job create-spark [Flags...] [Global Flags...]`

Aliases: 

- `submit-spark`

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
|`--packages`|<b>`value[,value]`</b><br/>Packages|
|`--repositories`|<b>`value[,value]`</b><br/>Repositories|
|`--exclude-packages`|<b>`value[,value]`</b><br/>Packages to exclude|
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
