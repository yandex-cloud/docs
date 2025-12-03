---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-kubernetes/cli-ref-beta/marketplace/helm-release/index.md
---

# yc beta managed-kubernetes marketplace helm-release

A set of methods for managing Helm release.

#### Command Usage

Syntax: 

`yc beta managed-kubernetes marketplace helm-release <command>`

#### Command Tree

- [yc beta managed-kubernetes marketplace helm-release get](get.md) — Returns the specified Helm release.
- [yc beta managed-kubernetes marketplace helm-release install](install.md) — Installs helm release into specified Kubernetes Cluster.
- [yc beta managed-kubernetes marketplace helm-release list](list.md) — Retrieves the list of Helm releases in the specified Kubernetes Cluster.
- [yc beta managed-kubernetes marketplace helm-release uninstall](uninstall.md) — Uninstalls helm release.
- [yc beta managed-kubernetes marketplace helm-release update](update.md) — Updates helm release.

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
