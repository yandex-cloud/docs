# {{ mtr-name }}

{{ mch-name }} is a managed service for working with {{ TR }}, a distributed SQL engine. The service streamlines deployment and updates of {{ TR }} clusters and provides declarative management of data source catalogs along with {{ iam-name }} integration.

With {{ mtr-name }}, you can:

* Create clusters using the `TrinoCluster` custom resource.
* Connect data sources to the cluster using the `TrinoCatalog` custom resource.
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

A catalog in {{ TR }} configures a connection to a data source. {{ mtr-name }} manages catalogs using the `TrinoCatalog` custom resource. Each resource describes a single catalog and is associated with a specific cluster via the `spec.cluster` field.

Supported connector types:

* {{ PG }}: Connection properties are specified in `spec.postgres`.
* {{ CH }}: Connection properties are specified in `spec.clickhouse`.
* {{ IBRG }}: Connection to [{{ rest-catalog-name }}](rest-catalog.md) in {{ stackland-name }} is set in `spec.stacklandRestCatalog`.

In the manifest, specify a single section with connector settings. `spec.type` is not used.

For {{ PG }} and {{ CH }}, credentials and certificates are stored in Kubernetes secrets referenced in the `credentialsSecretRef` and `certificateSecretRef` fields.

For {{ IBRG }}, specify the name of an existing `StacklandRestCatalog` resource in `spec.stacklandRestCatalog.catalogRef`. The catalog must reside in the same namespace as `TrinoCatalog` and the {{ TR }} cluster. The connection and storage access settings are configured automatically. See the example in the [Creating a {{ mtr-name }} catalog](../../operations/trino/create-catalog.md) guide.

When you update a catalog, {{ mtr-name }} recreates the cluster. While the new configuration is being applied, the cluster switches to `Updating` and active queries are interrupted. For more information, see [Updating a cluster](#cluster-update).

### Data storage for Iceberg {#iceberg-storage}

{{ IBRG }} data files are stored in [{{ objstorage-name }}](storage.md). A bucket is created automatically together with the {{ rest-catalog-name }} catalog. When connecting a catalog to {{ TR }}, there is no need to specify a bucket, storage address, or access keys.

### REST catalog authentication {#iceberg-auth}

When working with a catalog, the permissions of the user or service account used for {{ TR }} queries are used. [Assign it a role](../../operations/rest-catalog/create-principal.md) for the folder or required catalog resources. Also, the relevant operations must be permitted in the [{{ TR }} access rules](#access-control).

The IAM token is provided to {{ TR }} via auth-proxy in the additional `iam-token` parameter and is used when accessing the REST catalog. There is no need to create a separate catalog user and specify OAuth2 credentials in `TrinoCatalog`.

For a service account, specify the `ServiceAccount` resource name in `spec.accessControl` in Kubernetes, not the IAM subject ID.

### Additional Iceberg settings {#iceberg-settings}

Under `spec.stacklandRestCatalog.additionalProperties` in the `TrinoCatalog` resource, you can configure data storage and queries to run for the {{ IBRG }} catalog. All properties in this section are optional.

#|
|| Goal: | Parameters ||
|| Selecting data format and compression | `iceberg.file-format`: Default file format for new tables (`PARQUET`, `ORC`, or `AVRO`). `iceberg.compression-codec`: Default compression method during recording (`NONE`, `SNAPPY`, `LZ4`, `ZSTD`, or `GZIP`). ||
|| Configuring file size | `iceberg.target-max-file-size`: Target maximum size of recorded files, e.g., `512MB`. The actual size may be larger. ||
|| Requiring a filter by partitions | `iceberg.query-partition-filter-required: true` requires a filter by partition keys in queries to partitioned tables. In `iceberg.query-partition-filter-required-schemas`, specify SQL schemas to which the requirement applies as a single comma-separated string, e.g, `reports,events`. ||
|| Using table statistics | `iceberg.table-statistics-enabled`: Using statistics to select a query plan. `iceberg.extended-statistics.collect-on-write`: Collecting extended statistics when writing data. ||
|| Caching metadata | `iceberg.metadata-cache.enabled`: Caching table metadata, which reduces the number of repeated requests to the storage. ||
|| Limiting table vacuuming | `iceberg.expire-snapshots.min-retention` and `iceberg.remove-orphan-files.min-retention`: Minimum allowed `retention_threshold` values for the `expire_snapshots` and `remove_orphan_files` commands, respectively, e.g., `7d`. The commands delete old table snapshots and unused files. The vacuuming should be run separately. ||
|| Limiting the number of storage connections | `s3.max-connections`: Maximum number of connections with {{ objstorage-name }}, an integer not less than `1`. ||
|| Configuring storage timeouts | `s3.socket-connect-timeout`: Timeout for establishing a connection. `s3.socket-timeout`: Timeout for read or write operations. These can be set to, e.g., `10s` and `30s`, respectively. ||
|| Configuring retries | `s3.max-error-retries`: Maximum number of retries on storage access errors, an integer not less than `1`. ||
|| Working with views | `iceberg.rest-catalog.view-endpoints-enabled: true` enables creating and reading Iceberg views in the REST Catalog. Without this property, a view creation operation may throw an error. For details, see [Iceberg views](#iceberg-views). ||
|#

### Iceberg views {#iceberg-views}

For creating and reading Iceberg views via {{ rest-catalog-name }}, meet these two conditions:

1. Under `spec.stacklandRestCatalog.additionalProperties`, specify the `iceberg.rest-catalog.view-endpoints-enabled: true` value.
1. In the `CREATE VIEW` command, add `SECURITY INVOKER`.

When working with {{ rest-catalog-name }}, permissions are checked for the user or service account used for the query. With `SECURITY INVOKER`, when reading a view, {{ TR }} accesses base tables with the IAM token of the user running the query. If `SECURITY INVOKER` is not specified, `SECURITY DEFINER` mode is used: permissions are checked on behalf of the view owner, which is incompatible with the {{ rest-catalog-name }} access model.

Here is an example:

```sql
CREATE VIEW analytics.events_summary
SECURITY INVOKER
AS
SELECT id, name FROM analytics.events;
```

To learn how these properties behave, see the {{ TR }} documentation: [Iceberg settings](https://trino.io/docs/current/connector/iceberg.html#general-configuration) and [working with S3](https://trino.io/docs/current/object-storage/file-system-s3.html#general-configuration).

Specify property names in full, including dots. Write Boolean values (`true` and `false`) and digits without quotation marks. Specify sizes and time intervals as strings with a measurement unit, e.g., `"512MB"`, `"30s"`, or `"7d"`.

Property names and possible values are checked for the selected {{ TR }} version. If the property is not supported or the value is of the wrong type, the attempt to create or update a catalog will fail.

See an example of a manifest with additional settings in the [Creating a {{ mtr-name }} catalog guide](../../operations/trino/create-catalog.md#cli).

## Access management {#access-control}

The `spec.accessControl` property of the `TrinoCluster` resource sets access rules for {{ TR }} resources. Rules are categorized by resource type:

* `catalogs`: Access to catalogs. Privileges: `all`, `read-only`, and `none`.
* `schemas`: Access to schemas. The `owner` field defines whether or not the user is the schema owner.
* `tables`: Access to tables and specific columns. Privileges: `SELECT`, `INSERT`, `DELETE`, `UPDATE`, `OWNERSHIP`, and `GRANT_SELECT`. You can set a filter by rows and masks for columns.
* `functions`: Access to functions. Privileges: `EXECUTE`, `GRANT_EXECUTE`, and `OWNERSHIP`.
* `procedures`: Access to procedures. Privileges: `EXECUTE` and `GRANT_EXECUTE`.
* `queries`: Managing queries. Privileges: `execute`, `view`, and `kill`. If the `queryOwner` field is specified, the `execute` privilege is not available.

The matching fields (`user`, `catalog`, `schema`, `table`, `function`, `procedure`, and `queryOwner`) are set as regular expressions. If a field is not set, {{ TR }} inserts `.*` so the rule applies to all values.

For queries on behalf of a service account, specify the `ServiceAccount` resource name in the `user` field in Kubernetes, not the IAM subject ID.

## Cluster network access {#network-access}

After the cluster is created, you can find connection addresses in the `status.fqdn` field of the `TrinoCluster` resource:

```bash
kubectl get trinocluster <cluster_name> -n <namespace> -o jsonpath='{.status.fqdn}'
```

Response structure:

* `external`: Coordinator FQDN for connecting via {{ TR }} clients (CLI, JDBC).
* `webUI`: FQDN for access to Trino UI.

## Image versions {#image-catalog}

The `TrinoImageCatalog` resource defines the list of available {{ TR }} versions. The operator creates it automatically during the component installation. The version set in `spec.version` of the `TrinoCluster` resource must also be specified in `TrinoImageCatalog`. Otherwise, the system will reject any attempt to create or update a cluster.

## Deletion protection {#deletion-protection}

The `spec.deletionProtection` property in the `TrinoCluster` resource prevents accidental deletion of the cluster via the Kubernetes API. With protection enabled (`spec.deletionProtection: true`), the operator rejects any attempt to delete the resource; the `kubectl delete` command and deletion through the management console do not work until protection is disabled.

* The default value is `false`, meaning that protection is disabled.
* To enable or disable deletion protection, set the relevant `spec.deletionProtection` value when creating or [updating your cluster](../../operations/trino/edit-cluster.md).
* Protection is limited to the `TrinoCluster` resource. It does not apply to operator-created resources, such as `Pod`, `Service`, `ConfigMap`, and `Secret`.

## Cluster health states {#states}

You can check the cluster’s current state in the `status.phase` field of the `TrinoCluster` resource. Valid values:

* `Running`: Cluster is running, and all nodes are ready.
* `Updating`: Operator is applying a new configuration (workers, coordinator, or catalogs are being updated).
* `Warning`: Cluster is running with minor errors. For details, refer to `status.conditions`.
* `Failed`: Cluster failed to start or is not operational. For info on the root cause, refer to `status.conditions` with `reason: NodesFailed`.
* `Deleting`: Cluster is being deleted.

For a complete list of reconciliation conditions, see `status.conditions`.
