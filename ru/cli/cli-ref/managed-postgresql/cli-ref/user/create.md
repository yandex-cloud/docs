---
editable: false
---

# yc managed-postgresql user create

Create a PostgreSQL user

#### Command Usage

Syntax:

`yc managed-postgresql user create <USER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

PostgreSQL cluster id. ||
|| `--cluster-name` | `string`

PostgreSQL cluster name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--password` | `string`

Password of the PostgreSQL user. ||
|| `--conn-limit` | `int`

Number of connections available to the user. ||
|| `--permissions` | `value[,value]`

Names of the databases that the permission grants access to. ||
|| `--login` | Indicates whether the user can login. Defaults to true. ||
|| `--grants` | `value[,value]`

Roles granted to the user. ||
|| `--generate-password` | Generate password using Connection Manager. ||
|| `--auth-method` | `string`

Authentication method for the user. Values: 'auth-method-password', 'auth-method-iam' ||
|| `--user-password-encryption` | `string`

Password-based authentication method for user. Values: 'user-password-encryption-md5', 'user-password-encryption-scram-sha-256' ||
|| `--lock-timeout` | `int`

Lock timeout in milliseconds. ||
|| `--log-min-duration-statement` | `int`

Log minimal duration statement in milliseconds. ||
|| `--temp-file-limit` | `int`

Temporary file limit in bytes. ||
|| `--default-transaction-isolation` | `string`

Default transaction isolation. Values: 'transaction-isolation-read-uncommitted', 'transaction-isolation-read-committed', 'transaction-isolation-repeatable-read', 'transaction-isolation-serializable' ||
|| `--synchronous-commit` | `string`

Synchronous commit. Values: 'synchronous-commit-on', 'synchronous-commit-off', 'synchronous-commit-local', 'synchronous-commit-remote-write', 'synchronous-commit-remote-apply' ||
|| `--log-statement` | `string`

Log statement. Values: 'log-statement-none', 'log-statement-ddl', 'log-statement-mod', 'log-statement-all' ||
|| `--statement-timeout` | `int`

Statement timeout in milliseconds. ||
|| `--idle-in-transaction-session-timeout` | `int`

Idle in transaction session timeout in milliseconds. ||
|| `--wal-sender-timeout` | `int`

WAL sender timeout in milliseconds. ||
|| `--pgaudit.log` | Enable audit events for user ||
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