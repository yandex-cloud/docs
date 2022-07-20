---
sourcePath: en/_cli-ref/cli-ref/managed-services/dataproc/job/index.md
---
# yc dataproc job

Manage DataProc jobs.

#### Command Usage

Syntax: 

`yc dataproc job <command>`

Aliases: 

- `jobs`
- `tasks`
- `task`

#### Command Tree

- [yc dataproc job get](get.md) — Get information about a Dataproc job.
- [yc dataproc job list](list.md) — List Dataproc jobs for a cluster.
- [yc dataproc job log](log.md) — List logs for Dataproc job.
- [yc dataproc job create-spark](create-spark.md) — Create a Dataproc Spark job.
- [yc dataproc job create-pyspark](create-pyspark.md) — Create a Dataproc PySpark job.
- [yc dataproc job create-mapreduce](create-mapreduce.md) — Create a Dataproc MapReduce job.
- [yc dataproc job create-hive](create-hive.md) — Create a Dataproc Hive job.
- [yc dataproc job cancel](cancel.md) — Cancel Dataproc job.

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
