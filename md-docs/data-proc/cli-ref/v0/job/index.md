[Документация Yandex Cloud](../../../../index.md) > [Yandex Data Processing](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > job > Overview

# yc dataproc v0 job

Manage DataProc jobs.

#### Command Usage

Syntax:

`yc dataproc v0 job <command>`

Aliases:

- `jobs`

- `tasks`

- `task`

#### Command Tree

- [yc dataproc v0 job cancel](cancel.md) — Cancel Dataproc job.

- [yc dataproc v0 job create-hive](create-hive.md) — Create a Dataproc Hive job.

- [yc dataproc v0 job create-mapreduce](create-mapreduce.md) — Create a Dataproc MapReduce job.

- [yc dataproc v0 job create-pyspark](create-pyspark.md) — Create a Dataproc PySpark job.

- [yc dataproc v0 job create-spark](create-spark.md) — Create a Dataproc Spark job.

- [yc dataproc v0 job get](get.md) — Get information about a Dataproc job.

- [yc dataproc v0 job list](list.md) — List Dataproc jobs for a cluster.

- [yc dataproc v0 job log](log.md) — List logs for Dataproc job.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#