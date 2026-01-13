---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-spark/cli-ref/job/index.md
---

# yc managed-spark job

Manage Spark jobs.

#### Command Usage

Syntax: 

`yc managed-spark job <command>`

Aliases: 

- `jobs`
- `tasks`
- `task`

#### Command Tree

- [yc managed-spark job cancel](cancel.md) — Cancel Spark job.
- [yc managed-spark job create-pyspark](create-pyspark.md) — Create PySpark job.
- [yc managed-spark job create-spark](create-spark.md) — Create Spark job.
- [yc managed-spark job create-spark-connect](create-spark-connect.md) — Create Spark Connect job.
- [yc managed-spark job get](get.md) — Get information about a Spark job.
- [yc managed-spark job list](list.md) — List Spark jobs for a cluster.
- [yc managed-spark job log](log.md) — List logs for Spark job.

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
