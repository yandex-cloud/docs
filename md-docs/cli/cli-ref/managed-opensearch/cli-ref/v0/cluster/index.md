[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник CLI (англ.)](../../../../index.md) > [managed-opensearch](../../index.md) > [v0](../index.md) > cluster > Overview

# yc managed-opensearch v0 cluster

Managed OpenSearch clusters.

#### Command Usage

Syntax:

`yc managed-opensearch cluster <command>`

Aliases:

- `clusters`

#### Command Tree

- [yc managed-opensearch v0 cluster add-access-binding](add-access-binding.md) — Add access binding for the specified OpenSearch cluster

- [yc managed-opensearch v0 cluster backup](backup.md) — Create a backup for a managed OpenSearch cluster.

- [yc managed-opensearch v0 cluster create](create.md) — Create an OpenSearch cluster

- [yc managed-opensearch v0 cluster delete](delete.md) — Delete Opensearch clusters.

- [yc managed-opensearch v0 cluster get](get.md) — Get information about an OpenSearch cluster.

- [yc managed-opensearch v0 cluster list](list.md) — List OpenSearch clusters in a folder

- [yc managed-opensearch v0 cluster list-access-bindings](list-access-bindings.md) — List access bindings for the specified OpenSearch cluster

- [yc managed-opensearch v0 cluster list-backups](list-backups.md) — List available backups for an OpenSearch cluster.

- [yc managed-opensearch v0 cluster remove-access-binding](remove-access-binding.md) — Remove access binding for the specified OpenSearch cluster

- [yc managed-opensearch v0 cluster restart-opensearch](restart-opensearch.md) — Restart OpenSearch on host.

- [yc managed-opensearch v0 cluster restore](restore.md) — Restore a managed OpenSearch cluster from a backup.

- [yc managed-opensearch v0 cluster set-access-bindings](set-access-bindings.md) — Set access bindings for the specified OpenSearch cluster and delete all existing access bindings if there were any

- [yc managed-opensearch v0 cluster start](start.md) — Start a managed OpenSearch cluster.

- [yc managed-opensearch v0 cluster stop](stop.md) — Stop a managed OpenSearch cluster.

- [yc managed-opensearch v0 cluster switch-master](switch-master.md) — Switch current master or ensure that it is not on specified hosts.

- [yc managed-opensearch v0 cluster update](update.md) — Update a managed OpenSearchCluster.

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