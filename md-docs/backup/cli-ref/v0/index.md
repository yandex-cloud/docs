# yc backup v0

Manage Yandex Cloud Backup resources

#### Command Usage

Syntax:

`yc backup v0 <group>`

#### Command Tree

- [yc backup v0 agent](agent/index.md) — Manage backup agents

  - [yc backup v0 agent debug-info](agent/debug-info.md) — Displays backup agent installation logs. Attention! This command could be executed only on instances with oslogin support. This command will execute ssh connection on given instance, and fetch agent logs.

  - [yc backup v0 agent install](agent/install.md) — Installs backup agent on instance. Attention! This command could be executed only on instances with oslogin support. Supported os families are: ubuntu, centos, debian, redos. This command will execute ssh connection on given instance, install needed packages, download agent installer script and launch downloaded agent installer script.

  - [yc backup v0 agent reinstall](agent/reinstall.md) — Reinstalls backup agent on instance. Attention! This command could be executed only on instances with oslogin support. Supported os families are: ubuntu, centos, debian, redos. This command will execute ssh connection on given instance, install needed packages, download agent reinstaller script and launch downloaded agent reinstaller script.

- [yc backup v0 backup](backup/index.md) — Manage backups

  - [yc backup v0 backup batch-delete](backup/batch-delete.md) — Batch deletion of all backups from arhcive

  - [yc backup v0 backup delete](backup/delete.md) — Delete backup

  - [yc backup v0 backup get](backup/get.md) — Get full information about backup

  - [yc backup v0 backup list](backup/list.md) — Lists available backups

  - [yc backup v0 backup list-archives](backup/list-archives.md) — Lists available archives

  - [yc backup v0 backup recover](backup/recover.md) — Start recovery of the backup

- [yc backup v0 policy](policy/index.md) — Manage policies

  - [yc backup v0 policy apply](policy/apply.md) — Apply policy to vm(-s)

  - [yc backup v0 policy create](policy/create.md) — Create policy

  - [yc backup v0 policy delete](policy/delete.md) — Delete policy(-es)

  - [yc backup v0 policy execute](policy/execute.md) — Execute policy for vm

  - [yc backup v0 policy get](policy/get.md) — Show policy by id

  - [yc backup v0 policy list](policy/list.md) — Lists available policies

  - [yc backup v0 policy list-applications](policy/list-applications.md) — Lists policy applications

  - [yc backup v0 policy revoke](policy/revoke.md) — Revoke policy from vm(-s)

  - [yc backup v0 policy update](policy/update.md) — Update the policy

- [yc backup v0 provider](provider/index.md) — Manage backup provider

  - [yc backup v0 provider activate](provider/activate.md) — Activate backup provider

- [yc backup v0 vm](vm/index.md) — Manage resources

  - [yc backup v0 vm delete](vm/delete.md) — Delete the resource

  - [yc backup v0 vm get](vm/get.md) — Show information about selected vm(-s)

  - [yc backup v0 vm list](vm/list.md) — Lists available resources

  - [yc backup v0 vm list-applicable-policies](vm/list-applicable-policies.md) — Shows policies that could be applied to the instance

  - [yc backup v0 vm list-policies](vm/list-policies.md) — Shows policies applied to the instance

  - [yc backup v0 vm list-tasks](vm/list-tasks.md) — Show information about tasks

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