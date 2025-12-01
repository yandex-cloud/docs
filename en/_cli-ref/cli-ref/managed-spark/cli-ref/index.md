---
editable: false
---

# yc managed-spark

Manage Spark clusters.

#### Command Usage

Syntax: 

`yc managed-spark <group>`

Aliases: 

- `spark`

#### Command Tree

- [yc managed-spark cluster](cluster/index.md) — Manage Spark clusters
	- [yc managed-spark cluster add-access-binding](cluster/add-access-binding.md) — Add access binding for the specified Spark cluster
	- [yc managed-spark cluster create](cluster/create.md) — Create Spark cluster
	- [yc managed-spark cluster delete](cluster/delete.md) — Delete the specified Spark cluster
	- [yc managed-spark cluster get](cluster/get.md) — Show information about the specified Spark cluster
	- [yc managed-spark cluster list](cluster/list.md) — List Spark clusters
	- [yc managed-spark cluster list-access-bindings](cluster/list-access-bindings.md) — List access bindings for the specified Spark cluster
	- [yc managed-spark cluster list-operations](cluster/list-operations.md) — List operations for the specified Spark cluster
	- [yc managed-spark cluster remove-access-binding](cluster/remove-access-binding.md) — Remove access binding for the specified Spark cluster
	- [yc managed-spark cluster set-access-bindings](cluster/set-access-bindings.md) — Set access bindings for the specified Spark cluster and delete all existing access bindings if there were any
	- [yc managed-spark cluster start](cluster/start.md) — Start the specified Spark cluster
	- [yc managed-spark cluster stop](cluster/stop.md) — Stop the specified Spark cluster
	- [yc managed-spark cluster update](cluster/update.md) — Update the specified Spark cluster
- [yc managed-spark job](job/index.md) — Manage Spark jobs.
	- [yc managed-spark job cancel](job/cancel.md) — Cancel Spark job.
	- [yc managed-spark job create-pyspark](job/create-pyspark.md) — Create PySpark job.
	- [yc managed-spark job create-spark](job/create-spark.md) — Create Spark job.
	- [yc managed-spark job create-spark-connect](job/create-spark-connect.md) — Create Spark Connect job.
	- [yc managed-spark job get](job/get.md) — Get information about a Spark job.
	- [yc managed-spark job list](job/list.md) — List Spark jobs for a cluster.
	- [yc managed-spark job log](job/log.md) — List logs for Spark job.

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
