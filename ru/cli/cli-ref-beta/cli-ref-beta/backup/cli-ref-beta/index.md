---
editable: false
noIndex: true
---

# yc beta backup

Manage Backup resources

#### Command Usage

Syntax:

`yc beta backup <group>`

#### Command Tree

- [yc beta backup agent](agent/index.md) — 

  - [yc beta backup agent get-supported-os-versions](agent/get-supported-os-versions.md) — 

  - [yc beta backup agent init](agent/init.md) — 

  - [yc beta backup agent issue-token](agent/issue-token.md) — 

  - [yc beta backup agent register](agent/register.md) — 

  - [yc beta backup agent update](agent/update.md) — 

- [yc beta backup backup](backup/index.md) — A set of methods for managing [backups](/docs/backup/concepts/backup).

  - [yc beta backup backup delete](backup/delete.md) — Delete specific backup.

  - [yc beta backup backup delete-archive](backup/delete-archive.md) — Delete specific archive.

  - [yc beta backup backup get](backup/get.md) — Get backup by its id.

  - [yc beta backup backup list](backup/list.md) — List backups using filters.

  - [yc beta backup backup list-archives](backup/list-archives.md) — List archives that holds backups for specified folder or

  - [yc beta backup backup list-files](backup/list-files.md) — ListFiles of the backup.

  - [yc beta backup backup start-files-recovery](backup/start-files-recovery.md) — StartFilesRecovery runs recovery process of selected files to specific Compute Cloud instance.

  - [yc beta backup backup start-recovery](backup/start-recovery.md) — Start recovery process of specified backup to specific Compute Cloud instance.

- [yc beta backup policy](policy/index.md) — A set of methods for managing [policies](/docs/backup/concepts/policy).

  - [yc beta backup policy apply](policy/apply.md) — Apply policy to [Compute Cloud instance](/docs/backup/concepts/vm-connection#os).

  - [yc beta backup policy create](policy/create.md) — Create a new policy.

  - [yc beta backup policy delete](policy/delete.md) — Delete specific policy.

  - [yc beta backup policy execute](policy/execute.md) — Run policy on specific Compute Cloud instance. That will create backup

  - [yc beta backup policy get](policy/get.md) — Get specific policy.

  - [yc beta backup policy list](policy/list.md) — List [policies](/docs/backup/concepts/policy) of specified folder.

  - [yc beta backup policy list-applications](policy/list-applications.md) — List applied policies using filters.

  - [yc beta backup policy revoke](policy/revoke.md) — Revoke policy from Compute Cloud instance.

  - [yc beta backup policy update](policy/update.md) — Update specific policy.

- [yc beta backup provider](provider/index.md) — A set of methods for managing [backup providers](/docs/backup/concepts/#providers).

  - [yc beta backup provider activate](provider/activate.md) — Activate provider for specified client.

  - [yc beta backup provider list-activated](provider/list-activated.md) — List activated providers for specified client.

- [yc beta backup resource](resource/index.md) — A set of methods for managing backup resources: [Compute Cloud instances](/docs/backup/concepts/vm-connection#os).

  - [yc beta backup resource create-directory](resource/create-directory.md) — CreateDirectory creates new directory by requested path.

  - [yc beta backup resource delete](resource/delete.md) — Delete specific Compute Cloud instance from Cloud Backup. It does not delete

  - [yc beta backup resource get](resource/get.md) — Get specific Compute Cloud instance.

  - [yc beta backup resource get-instance-registration-token](resource/get-instance-registration-token.md) — Get instance registration token to install backup agent withot SA attached to instance

  - [yc beta backup resource list](resource/list.md) — List resources: Compute Cloud instances.

  - [yc beta backup resource list-directory](resource/list-directory.md) — ListDirectory returns all subdirectories found in requested directory identified

  - [yc beta backup resource list-operations](resource/list-operations.md) — ListOperations return all operations in backup service for given instance

  - [yc beta backup resource list-tasks](resource/list-tasks.md) — List tasks of resources.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#