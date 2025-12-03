---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-gitlab/cli-ref-beta/instance/index.md
---

# yc beta managed-gitlab instance

InstanceService provides methods for managing GitLab instances.

#### Command Usage

Syntax: 

`yc beta managed-gitlab instance <command>`

#### Command Tree

- [yc beta managed-gitlab instance create](create.md) — Creates a new GitLab instance in the specified folder.
- [yc beta managed-gitlab instance delete](delete.md) — Deletes the specified GitLab instance.
- [yc beta managed-gitlab instance get](get.md) — Returns the specified GitLab instance.
- [yc beta managed-gitlab instance list](list.md) — Retrieves the list of GitLab instances in the specified folder.
- [yc beta managed-gitlab instance start](start.md) — Starts the specified GitLab instance.
- [yc beta managed-gitlab instance stop](stop.md) — Stops the specified GitLab instance.
- [yc beta managed-gitlab instance update](update.md) — Updates GitLab instance.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
