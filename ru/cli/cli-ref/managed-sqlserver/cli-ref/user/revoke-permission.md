---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-sqlserver/cli-ref/user/revoke-permission.md
---

# yc managed-sqlserver user revoke-permission

Revoke database access from the specified SQLServer user

#### Command Usage

Syntax:

`yc managed-sqlserver user revoke-permission <USER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

SQLServer cluster id. ||
|| `--cluster-name` | `string`

SQLServer cluster name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--database` | `string`

Name of the database that user is permitted to connect to. ||
|| `--roles` | `value[,value]`

User database access roles, possible values: DB_ACCESSADMIN,DB_BACKUPOPERATOR,DB_DATAREADER,DB_DATAWRITER,DB_DDLADMIN,DB_DENYDATAREADER,DB_DENYDATAWRITER,DB_OWNER,DB_SECURITYADMIN ||
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