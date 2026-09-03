---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-zonalshift/cli-ref/config/update/
---

# yc managed-zonalshift config update

Update a zonal shift configuration.

#### Command Usage

Syntax:

`yc managed-zonalshift config update <CONFIG-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `value[,value]`

ID of an MDB cluster. This flag can be specified multiple times or with comma-separated values. ||
|| `--drill-type` | `string`

Drill type. The only currently supported value is disable-zone. ||
|| `--zone` | `string`

Availability zone to disable. ||
|| `--skip-predict-availability` | Skip the availability prediction check before the drill starts. ||
|| `--skip-health-check` | Skip the cluster health check before the drill starts. ||
|| `--duration` | `duration`

Duration of a drill run. ||
|| `--description` | `string`

Description of the configuration. ||
|| `--cron-expression` | `string`

Cron expression for a recurring drill. ||
|| `--run-date` | `timestamp`

Time of a one-time drill in RFC3339 format. ||
|#

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