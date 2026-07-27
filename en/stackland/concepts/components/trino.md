# {{ mtr-name }}

{{ mch-name }} is a managed service for working with {{ TR }}, a distributed SQL engine. The service streamlines deployment and updates of {{ TR }} clusters and provides declarative management of data source catalogs along with {{ iam-name }} integration.

With {{ mtr-name }}, you can:

* Create clusters using the `TrinoCluster` custom resource.
* Connect external data sources to the cluster using the `TrinoCatalog` custom resource.
* Set up access rules for catalogs, schemas, tables, functions, procedures, and queries.
* Manage {{ TR }} image versions using the `TrinoImageCatalog` custom resource.

## Cluster architecture {#architecture}

A {{ TR }} cluster consists of two node types:

* **Coordinator**: The only node that accepts and schedules SQL queries and distributes jobs between workers. The coordinator also provisions the Trino UI and API.
* **Workers**: Nodes that run parts of SQL queries and return results to the coordinator. You can modify the number of workers manually using the `spec.worker.replicas` property.

Editing certain properties triggers cluster recreation and terminates active queries. For more information, see [Updating a cluster](#cluster-update).

## Creating a cluster {#configuration}

Here is an example of a minimal cluster configuration:

{% include notitle [YAML-file](../../_includes/yamls/operations/trino/create-cluster-min.md) %}

Where:

* `version`: {{ TR }} version. The valid values are retrieved from the `TrinoImageCatalog` resource set by the operator.
* `coordinator.resources`: Queries and CPU / RAM limits for the coordinator pod.
* `worker.replicas`: Number of workers per cluster. The minimum value is `1`.
* `worker.resources`: Queries and CPU / RAM limits for each worker pod.

You can also set the following under `spec`:

* `config`: Additional {{ TR }} settings in `key–value` format. The available keys and values are defined in the validation schema for the relevant {{ TR }} cluster version. The operator publishes schemas in ConfigMap `trino-omdb-operator-<version>` within its namespace, where you can view the current list. For example, the `io.trino` key specifies a logging level (the possible values are `DEBUG`, `INFO`, `WARN`, and `ERROR`). Any keys or values that do not match the validation schema will be rejected during cluster creation or update.
* `accessControl`: {{ TR }} resource access rules. See [Access management](#access-control).
* `deletionProtection`: Protection against accidental cluster deletion. See [Deletion protection](#deletion-protection).

## Updating a cluster {#cluster-update}

When you update certain properties, {{ mtr-name }} recreates the cluster. While the new configuration is being applied, the cluster switches to `Updating` and active queries get interrupted.

The system will recreate a cluster if any of the following `TrinoCluster` resource properties are updated:

* `spec.version`
* `spec.coordinator.resources`
* `spec.worker.resources`
* `spec.config`
* Any properties of the associated `TrinoCatalog` resources.

Updates to the following properties are applied without recreating the cluster:

* `spec.worker.replicas`
* `spec.accessControl`

## Catalogs {#catalogs}

A catalog in {{ TR }} configures a connection to an external data source. {{ mtr-name }} manages catalogs using the `TrinoCatalog` custom resource. Each resource describes a single catalog and is associated with a specific cluster via the `spec.cluster` field.

Supported connector types:

* `postgresql`: {{ PG }} connection.
* `clickhouse`: {{ CH }} connection.
* `iceberg`: {{ IBRG }} connection via the REST catalog.

Catalog credentials and certificates are stored in Kubernetes Secrets referenced in the `credentialsSecretRef` and `certificateSecretRef` fields.

When you update a catalog, {{ mtr-name }} recreates the cluster. While the new configuration is being applied, the cluster switches to `Updating`, and active queries get interrupted. For more information, see [Updating a cluster](#cluster-update).

### Data storage for Iceberg {#iceberg-storage}

An Iceberg catalog uses object storage for data files. Two modes are supported:

* `s3`: Any S3-compatible storage. Connection settings and credentials are defined in the `spec.iceberg.s3` property.
* `stackland-storage`: Managed {{ stackland-name }} object storage. The operator retrieves and maintains connection settings and credentials automatically based on the bucket reference in `spec.iceberg.stacklandStorage.bucketRef`. This mode is only available for clusters with enabled [{{ objstorage-name }}](storage.md).

### REST catalog authentication {#iceberg-auth}

The REST catalog supports two types of OAuth2 authentication:

* Static token: Token is stored in a Secret referenced in `spec.iceberg.rest.oauth2.accessTokenSecretRef`.
* Client credentials: Operator exchanges the client ID or secret for a token via an authorization server. These properties are defined in `spec.iceberg.rest.oauth2.clientCredentials`.

You can use only one authentication method per catalog.

## Access management {#access-control}

The `spec.accessControl` property of the `TrinoCluster` resource sets access rules for {{ TR }} resources. Rules are categorized by resource type:

* `catalogs`: Access to catalogs. Privileges: `all`, `read-only`, and `none`.
* `schemas`: Access to schemas. The `owner` field defines whether or not the user is the schema owner.
* `tables`: Access to tables and specific columns. Privileges: `SELECT`, `INSERT`, `DELETE`, `UPDATE`, `OWNERSHIP`, and `GRANT_SELECT`. You can set a filter by rows and masks for columns.
* `functions`: Access to functions. Privileges: `EXECUTE`, `GRANT_EXECUTE`, and `OWNERSHIP`.
* `procedures`: Access to procedures. Privileges: `EXECUTE` and `GRANT_EXECUTE`.
* `queries`: Managing queries. Privileges: `execute`, `view`, and `kill`. If the `queryOwner` field is specified, the `execute` privilege is not available.

The matching fields (`user`, `catalog`, `schema`, `table`, `function`, `procedure`, and `queryOwner`) are set as regular expressions. If a field is not set, {{ TR }} inserts `.*` so the rule applies to all values.

## Cluster network access {#network-access}

After the cluster is created, you can find connection addresses in the `status.fqdn` field of the `TrinoCluster` resource:

```bash
kubectl get trinocluster <cluster_name> -n <namespace> -o jsonpath='{.status.fqdn}'
```

Response structure:

* `external`: FQDN of the coordinator for connection via {{ TR }} clients (CLI, JDBC).
* `webUI`: FQDN for access to Trino UI.

## Image versions {#image-catalog}

The `TrinoImageCatalog` resource defines the list of available {{ TR }} versions. The operator creates it automatically during the component installation. The version set in `spec.version` of the `TrinoCluster` resource must also be specified in `TrinoImageCatalog`. Otherwise, the system will reject any attempt to create or update a cluster.

## Deletion protection {#deletion-protection}

The `spec.deletionProtection` setting in the `TrinoCluster` resource prevents accidental deletion of the cluster via the Kubernetes API. With protection enabled (`spec.deletionProtection: true`), the operator rejects any attempt to delete the resource; the `kubectl delete` command and deletion through the management console do not work until protection is disabled.

* The default value is `false`, meaning that protection is disabled.
* To enable or disable deletion protection, set the relevant `spec.deletionProtection` value when creating or [updating your cluster](../../operations/trino/edit-cluster.md).
* Protection is limited to the `TrinoCluster` resource. It does not apply to operator-created resources, such as `Pod`, `Service`, `ConfigMap`, and `Secret`.

## Cluster health states {#states}

You can check the cluster’s current state in the `status.state` field of the `TrinoCluster` resource. Valid values:

* `Running`: Cluster is running, and all nodes are ready.
* `Updating`: Operator is applying a new configuration (workers, coordinator, or catalogs are being updated).
* `Warning`: Cluster is running with minor errors. For details, refer to `status.conditions`.
* `Failed`: Cluster failed to start or is not operational. For info on the root cause, refer to `status.conditions` with `reason: NodesFailed`.
* `Deleting`: Cluster is being deleted.

For a complete list of reconciliation conditions, see `status.conditions`.
