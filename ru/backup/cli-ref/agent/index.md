---
editable: false
sourcePath: en/_cli-ref/cli-ref/backup/cli-ref/agent/index.md
---

# yc backup agent

Manage backup agents

#### Command Usage

Syntax: 

`yc backup agent <command>`

Aliases: 

- `agents`

#### Command Tree

- [yc backup agent debug-info](debug-info.md) — Displays backup agent installation logs. Attention! This command could be executed only on instances with oslogin support. This command will execute ssh connection on given instance, and fetch agent logs.
- [yc backup agent install](install.md) — Installs backup agent on instance. Attention! This command could be executed only on instances with oslogin support. Supported os families are: ubuntu, centos, debian, redos. This command will execute ssh connection on given instance, install needed packages, download agent installer script and launch downloaded agent installer script.
- [yc backup agent reinstall](reinstall.md) — Reinstalls backup agent on instance. Attention! This command could be executed only on instances with oslogin support. Supported os families are: ubuntu, centos, debian, redos. This command will execute ssh connection on given instance, install needed packages, download agent reinstaller script and launch downloaded agent reinstaller script.

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
