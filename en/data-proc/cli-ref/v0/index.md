---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/dataproc/cli-ref/v0/
---

# yc dataproc v0

Manage data processing clusters.

#### Command Usage

Syntax:

`yc dataproc v0 <group>`

#### Command Tree

- [yc dataproc v0 cluster](cluster/index.md) — Manage DataProc clusters.

  - [yc dataproc v0 cluster add-access-binding](cluster/add-access-binding.md) — Add access binding for the specified cluster

  - [yc dataproc v0 cluster add-labels](cluster/add-labels.md) — Assign labels to a cluster.

  - [yc dataproc v0 cluster create](cluster/create.md) — Create a cluster.

  - [yc dataproc v0 cluster delete](cluster/delete.md) — Delete a cluster.

  - [yc dataproc v0 cluster get](cluster/get.md) — Get information about a cluster.

  - [yc dataproc v0 cluster list](cluster/list.md) — List clusters in a folder.

  - [yc dataproc v0 cluster list-access-bindings](cluster/list-access-bindings.md) — List access bindings for the specified cluster

  - [yc dataproc v0 cluster list-hosts](cluster/list-hosts.md) — List hosts for a cluster.

  - [yc dataproc v0 cluster list-operations](cluster/list-operations.md) — List operations for a cluster.

  - [yc dataproc v0 cluster list-ui-links](cluster/list-ui-links.md) — Show URLs of proxied web user interfaces.

  - [yc dataproc v0 cluster remove-access-binding](cluster/remove-access-binding.md) — Remove access binding for the specified cluster

  - [yc dataproc v0 cluster remove-labels](cluster/remove-labels.md) — Remove labels from a cluster.

  - [yc dataproc v0 cluster set-access-bindings](cluster/set-access-bindings.md) — Set access bindings for the specified cluster and delete all existing access bindings if there were any

  - [yc dataproc v0 cluster start](cluster/start.md) — Start a cluster.

  - [yc dataproc v0 cluster stop](cluster/stop.md) — Stop a cluster.

  - [yc dataproc v0 cluster update](cluster/update.md) — Modify attributes of a cluster.

- [yc dataproc v0 job](job/index.md) — Manage DataProc jobs.

  - [yc dataproc v0 job cancel](job/cancel.md) — Cancel Dataproc job.

  - [yc dataproc v0 job create-hive](job/create-hive.md) — Create a Dataproc Hive job.

  - [yc dataproc v0 job create-mapreduce](job/create-mapreduce.md) — Create a Dataproc MapReduce job.

  - [yc dataproc v0 job create-pyspark](job/create-pyspark.md) — Create a Dataproc PySpark job.

  - [yc dataproc v0 job create-spark](job/create-spark.md) — Create a Dataproc Spark job.

  - [yc dataproc v0 job get](job/get.md) — Get information about a Dataproc job.

  - [yc dataproc v0 job list](job/list.md) — List Dataproc jobs for a cluster.

  - [yc dataproc v0 job log](job/log.md) — List logs for Dataproc job.

- [yc dataproc v0 resource-preset](resource-preset/index.md) — Learn about Data Proc resource presets.

  - [yc dataproc v0 resource-preset get](resource-preset/get.md) — Get information about a Data Proc resource preset.

  - [yc dataproc v0 resource-preset list](resource-preset/list.md) — List available resource presets for Data Proc.

- [yc dataproc v0 subcluster](subcluster/index.md) — Manage Dataproc subclusters.

  - [yc dataproc v0 subcluster create](subcluster/create.md) — Create a subcluster.

  - [yc dataproc v0 subcluster delete](subcluster/delete.md) — Delete a subcluster.

  - [yc dataproc v0 subcluster get](subcluster/get.md) — Get information about a subcluster.

  - [yc dataproc v0 subcluster list](subcluster/list.md) — List subclusters in a cluster.

  - [yc dataproc v0 subcluster update](subcluster/update.md) — Modify configuration or attributes of a subcluster.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#