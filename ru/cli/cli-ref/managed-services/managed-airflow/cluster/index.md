---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-airflow/cluster/index.md
---

# yc managed-airflow cluster

Manage Airflow clusters.

#### Command Usage

Syntax: 

`yc managed-airflow cluster <command>`

Aliases: 

- `clusters`

#### Command Tree

- [yc managed-airflow cluster get](get.md) — Show information about the specified Airflow cluster
- [yc managed-airflow cluster delete](delete.md) — Delete the specified Airflow cluster
- [yc managed-airflow cluster list-operations](list-operations.md) — List operations for the specified Airflow cluster
- [yc managed-airflow cluster start](start.md) — Start the specified Airflow cluster
- [yc managed-airflow cluster stop](stop.md) — Stop the specified Airflow cluster
- [yc managed-airflow cluster create](create.md) — Create Airflow cluster
- [yc managed-airflow cluster list](list.md) — List Airflow clusters
- [yc managed-airflow cluster update](update.md) — Update the specified Airflow cluster

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
|`-h`,`--help`|Display help for the command.|
