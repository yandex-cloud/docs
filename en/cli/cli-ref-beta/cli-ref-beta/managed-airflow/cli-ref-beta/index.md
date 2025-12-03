---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-airflow/cli-ref-beta/index.md
---

# yc beta managed-airflow

Manage Airflow clusters

#### Command Usage

Syntax: 

`yc beta managed-airflow <group>`

#### Command Tree

- [yc beta managed-airflow cluster](cluster/index.md) — A set of methods for managing Apache Airflow Cluster resources.
	- [yc beta managed-airflow cluster create](cluster/create.md) — Creates an Apache Airflow cluster.
	- [yc beta managed-airflow cluster delete](cluster/delete.md) — Deletes the specified Apache Airflow cluster.
	- [yc beta managed-airflow cluster get](cluster/get.md) — Returns the specified Apache Airflow Cluster resource.
	- [yc beta managed-airflow cluster list](cluster/list.md) — Retrieves a list of Apache Airflow Cluster resources.
	- [yc beta managed-airflow cluster list-access-bindings](cluster/list-access-bindings.md) — Retrieves a list of access bindings for the specified Apache Airflow cluster.
	- [yc beta managed-airflow cluster list-operations](cluster/list-operations.md) — Retrieves the list of Operation resources for the specified cluster.
	- [yc beta managed-airflow cluster set-access-bindings](cluster/set-access-bindings.md) — Sets access bindings for the specified Apache Airflow cluster.
	- [yc beta managed-airflow cluster start](cluster/start.md) — Starts the specified Apache Airflow cluster.
	- [yc beta managed-airflow cluster stop](cluster/stop.md) — Stops the specified Apache Airflow cluster.
	- [yc beta managed-airflow cluster update](cluster/update.md) — Updates the specified Apache Airflow cluster.
	- [yc beta managed-airflow cluster update-access-bindings](cluster/update-access-bindings.md) — Updates access bindings for the specified Apache Airflow cluster.

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
