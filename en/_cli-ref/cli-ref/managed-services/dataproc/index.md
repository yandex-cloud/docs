---
editable: false
---

# yc dataproc

Manage data processing clusters.

#### Command Usage

Syntax: 

`yc dataproc <group>`

#### Command Tree

- [yc dataproc cluster](cluster/index.md) — Manage DataProc clusters.
	- [yc dataproc cluster get](cluster/get.md) — Get information about a cluster.
	- [yc dataproc cluster list](cluster/list.md) — List clusters in a folder.
	- [yc dataproc cluster create](cluster/create.md) — Create a cluster.
	- [yc dataproc cluster update](cluster/update.md) — Modify attributes of a cluster.
	- [yc dataproc cluster add-labels](cluster/add-labels.md) — Assign labels to a cluster.
	- [yc dataproc cluster remove-labels](cluster/remove-labels.md) — Remove labels from a cluster.
	- [yc dataproc cluster delete](cluster/delete.md) — Delete a cluster.
	- [yc dataproc cluster start](cluster/start.md) — Start a cluster.
	- [yc dataproc cluster stop](cluster/stop.md) — Stop a cluster.
	- [yc dataproc cluster list-hosts](cluster/list-hosts.md) — List hosts for a cluster.
	- [yc dataproc cluster list-ui-links](cluster/list-ui-links.md) — Show URLs of proxied web user interfaces.
	- [yc dataproc cluster list-operations](cluster/list-operations.md) — List operations for a cluster.
- [yc dataproc subcluster](subcluster/index.md) — Manage Dataproc subclusters.
	- [yc dataproc subcluster get](subcluster/get.md) — Get information about a subcluster.
	- [yc dataproc subcluster list](subcluster/list.md) — List subclusters in a cluster.
	- [yc dataproc subcluster create](subcluster/create.md) — Create a subcluster.
	- [yc dataproc subcluster update](subcluster/update.md) — Modify configuration or attributes of a subcluster.
	- [yc dataproc subcluster delete](subcluster/delete.md) — Delete a subcluster.
- [yc dataproc job](job/index.md) — Manage DataProc jobs.
	- [yc dataproc job get](job/get.md) — Get information about a Dataproc job.
	- [yc dataproc job list](job/list.md) — List Dataproc jobs for a cluster.
	- [yc dataproc job log](job/log.md) — List logs for Dataproc job.
	- [yc dataproc job create-spark](job/create-spark.md) — Create a Dataproc Spark job.
	- [yc dataproc job create-pyspark](job/create-pyspark.md) — Create a Dataproc PySpark job.
	- [yc dataproc job create-mapreduce](job/create-mapreduce.md) — Create a Dataproc MapReduce job.
	- [yc dataproc job create-hive](job/create-hive.md) — Create a Dataproc Hive job.
	- [yc dataproc job cancel](job/cancel.md) — Cancel Dataproc job.
- [yc dataproc resource-preset](resource-preset/index.md) — Learn about Data Proc resource presets.
	- [yc dataproc resource-preset get](resource-preset/get.md) — Get information about a Data Proc resource preset.
	- [yc dataproc resource-preset list](resource-preset/list.md) — List available resource presets for Data Proc.

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
