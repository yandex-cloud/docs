---
editable: false
---

# yc managed-trino catalog create sqlserver

Create MS SQL Server catalog

#### Command Usage

Syntax:

`yc managed-trino catalog create sqlserver <CATALOG-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

Trino cluster id. ||
|| `--cluster-name` | `string`

Trino cluster name. ||
|| `--name` | `string`

Name of the Trino catalog. ||
|| `--description` | `string`

Description of the catalog. ||
|| `--labels` | `key=value[,key=value...]`

A list of Trino catalog labels as key-value pairs. ||
|| `--on-premise-connection-url` | `string`

OnPremise connection URL. ||
|| `--on-premise-user-name` | `string`

OnPremise connection username. ||
|| `--on-premise-password` | `string`

OnPremise connection password. ||
|| `--additional-properties` | `key=value[,key=value...]`

A list of Trino catalog additional properties as key-value pairs. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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