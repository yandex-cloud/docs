[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for Apache Airflow™](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > cluster > Overview

# yc managed-airflow v0 cluster

Manage Airflow clusters.

#### Command Usage

Syntax:

`yc managed-airflow cluster <command>`

Aliases:

- `clusters`

#### Command Tree

- [yc managed-airflow v0 cluster add-access-binding](add-access-binding.md) — Add access binding for the specified Airflow cluster

- [yc managed-airflow v0 cluster create](create.md) — Create Airflow cluster

- [yc managed-airflow v0 cluster delete](delete.md) — Delete the specified Airflow cluster

- [yc managed-airflow v0 cluster get](get.md) — Show information about the specified Airflow cluster

- [yc managed-airflow v0 cluster list](list.md) — List Airflow clusters

- [yc managed-airflow v0 cluster list-access-bindings](list-access-bindings.md) — List access bindings for the specified Airflow cluster

- [yc managed-airflow v0 cluster list-operations](list-operations.md) — List operations for the specified Airflow cluster

- [yc managed-airflow v0 cluster remove-access-binding](remove-access-binding.md) — Remove access binding for the specified Airflow cluster

- [yc managed-airflow v0 cluster set-access-bindings](set-access-bindings.md) — Set access bindings for the specified Airflow cluster and delete all existing access bindings if there were any

- [yc managed-airflow v0 cluster start](start.md) — Start the specified Airflow cluster

- [yc managed-airflow v0 cluster stop](stop.md) — Stop the specified Airflow cluster

- [yc managed-airflow v0 cluster update](update.md) — Update the specified Airflow cluster

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