---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/backup/index.md
---

# yc backup

Manage Yandex Cloud Backup resources

#### Command Usage

Syntax: 

`yc backup <group>`

#### Command Tree

- [yc backup vm](vm/index.md) — Manage resources
	- [yc backup vm list](vm/list.md) — Lists available resources
	- [yc backup vm list-tasks](vm/list-tasks.md) — Show information about tasks
	- [yc backup vm list-policies](vm/list-policies.md) — Shows policies applied to the instance
	- [yc backup vm list-applicable-policies](vm/list-applicable-policies.md) — Shows policies that could be applied to the instance
	- [yc backup vm get](vm/get.md) — Show information about selected vm(-s)
	- [yc backup vm delete](vm/delete.md) — Delete the resource
- [yc backup backup](backup/index.md) — Manage backups
	- [yc backup backup list](backup/list.md) — Lists available backups
	- [yc backup backup list-archives](backup/list-archives.md) — Lists available archives
	- [yc backup backup delete](backup/delete.md) — Delete backup
	- [yc backup backup recover](backup/recover.md) — Start recovery of the backup
	- [yc backup backup get](backup/get.md) — Get full information about backup
- [yc backup policy](policy/index.md) — Manage policies
	- [yc backup policy list](policy/list.md) — Lists available policies
	- [yc backup policy list-applications](policy/list-applications.md) — Lists policy applications
	- [yc backup policy get](policy/get.md) — Show policy by id
	- [yc backup policy create](policy/create.md) — Create policy
	- [yc backup policy update](policy/update.md) — Update the policy
	- [yc backup policy delete](policy/delete.md) — Delete policy(-es)
	- [yc backup policy apply](policy/apply.md) — Apply policy to vm(-s)
	- [yc backup policy revoke](policy/revoke.md) — Revoke policy from vm(-s)
	- [yc backup policy execute](policy/execute.md) — Execute policy for vm
- [yc backup agent](agent/index.md) — Manage backup agents
	- [yc backup agent install](agent/install.md) — Installs backup agent on instance. Attention! This command could be executed only on instances with oslogin support. Supported os families are: ubuntu, centos, debian, redos. This command will execute ssh connection on given instance, install needed packages, download agent installer script and launch downloaded agent installer script.
	- [yc backup agent reinstall](agent/reinstall.md) — Reinstalls backup agent on instance. Attention! This command could be executed only on instances with oslogin support. Supported os families are: ubuntu, centos, debian, redos. This command will execute ssh connection on given instance, install needed packages, download agent reinstaller script and launch downloaded agent reinstaller script.
	- [yc backup agent debug-info](agent/debug-info.md) — Displays backup agent installation logs. Attention! This command could be executed only on instances with oslogin support. This command will execute ssh connection on given instance, and fetch agent logs.
- [yc backup provider](provider/index.md) — Manage backup provider
	- [yc backup provider activate](provider/activate.md) — Activate backup provider

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
