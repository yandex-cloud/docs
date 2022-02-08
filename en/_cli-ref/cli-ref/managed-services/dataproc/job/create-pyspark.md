# yc dataproc job create-pyspark

Create a Dataproc PySpark job.

#### Command Usage

Syntax: 

`yc dataproc job create-pyspark [Flags...] [Global Flags...]`

Aliases: 

- `submit-pyspark`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/> ID of the cluster.|
|`--cluster-name`|<b>`string`</b><br/> Name of the cluster.|
|`--name`|<b>`string`</b><br/> Optional job name|
|`--main-python-file-uri`|<b>`string`</b><br/> Main Python file URI|
|`--python-file-uris`|<b>`value[,value]`</b><br/> Python file URIs|
|`--jar-file-uris`|<b>`value[,value]`</b><br/> JAR file URIs|
|`--file-uris`|<b>`value[,value]`</b><br/> File URIs|
|`--archive-uris`|<b>`value[,value]`</b><br/> Archive URIs|
|`--packages`|<b>`value[,value]`</b><br/> Packages|
|`--repositories`|<b>`value[,value]`</b><br/> Repositories|
|`--exclude-packages`|<b>`value[,value]`</b><br/> Packages to exclude|
|`--properties`|<b>`stringToString`</b><br/> Properties|
|`--args`|<b>`value[,value]`</b><br/> Arguments|
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
