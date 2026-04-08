# Updating PostgreSQL cluster settings

If you have a [{{ PG }}](../../concepts/components/postgresql.md) cluster in your [project](../projects/create-project.md), you can update its settings.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Open the `PostgresqlCluster` resource, e.g., using the `open postgresqlcluster.yaml` command.
  1. Open the resource file and edit the following properties:

      * `metadata.name`: Cluster name.
      * `metadata.namespace`: Project name.
      * `spec.instances`: Number of cluster replicas.
      * `spec.storage.size`: Storage size. You can only increase it.
      * `spec.storage.autoScaling.enabled`: Enabling automatic storage expansion.
      * `spec.storage.autoScaling.maxSize`: Maximum storage size.
      * `spec.storage.autoScaling.standardIncreasePercent`: Storage expansion percentage.
      * `spec.storage.autoScaling.resizeTriggerPercent`: Storage usage percentage threshold that triggers storage expansion.
      * `spec.storage.readOnlyTriggerPercent`: Disk usage percentage to switch to read-only mode.
      * `spec.enableSuperuserAccess`: You can disable superuser access while editing.
      * `spec.resources`: Pod resource limits.
      * `spec.postgresConfiguration`: {{ PG }} configuration.
      * `spec.poolers.[ro|rw|r].port`: Connection pooler port settings.
      * `spec.poolers.[ro|rw|r].instances`: Number of connection pooler replicas.
      * `spec.poolers.[ro|rw|r].type`: Cluster type for the connection pooler, e.g., `ClusterIP`.
      * `spec.poolers.[ro|rw|r].odyssey.poolMode`: Operation mode of the database connection pool (session or transaction).
      * `spec.backup`: Backup settings.
      * `spec.deletionProtection`: Deletion protection. If set to `true`, you cannot delete the cluster until the protection is disabled.

  1. Apply the manifest: `kubectl apply -f postgresqlcluster.yaml -n <project name>`. Optionally, you can specify the project name in the `metadata.namespace` resource property and skip it in the command.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **{{ PG }} Clusters**.
  1. Select the cluster.
  1. Click **Edit**.
  1. Edit the following fields:

      * **Cluster name**. Only use lowercase letters, numbers, and hyphens.
      * **Number of instances**: Number of cluster replicas.
      * **Computing resources**, where **Limits** is the upper limit and **Requests** is the lower limit.
      * **Storage**: Increase the storage size or enable automatic storage expansion.
      * **Connection pooler**: Handles writes and reads; used for all data-modifying operations and critical transactions.
      * **Backups**: Settings for creating the database backup in an S3 bucket.
      * **Deletion protection**: Toggle. You cannot delete the cluster until the protection is disabled.

  1. Click **Save**.

{% endlist %}

This is it, your cluster settings have been updated.
