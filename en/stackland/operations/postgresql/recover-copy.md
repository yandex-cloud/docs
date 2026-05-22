# Recovering a cluster

If you have lost a [{{ PG }}](../../concepts/components/postgresql.md) cluster in a [project](../projects/create-project.md), you can restore it from a backup.

## restoreClusterSpec property

When restoring from a backup, you can select a source of the cluster configuration (number of instances, storage size, {{ PG }} version, and so on), which is either the backup itself or the manifest:

* **`restoreClusterSpec: true`** (default): Cluster configuration is restored from the backup. The restored cluster will inherit `spec.instances`, `spec.storage`, `spec.version`, and other settings from the original cluster at the time of backup. This property is optional in the manifest.

* **`restoreClusterSpec: false`**: Cluster configuration is sourced from your manifest. Data is restored from the selected backup, while the number of instances, storage size, {{ PG }} version, and other settings are defined in the manifest. Use this mode if you need to restore data into a cluster with a different configuration, e.g., fewer instances or reduced disk size.

This setting is defined in `spec.bootstrap.recovery.restoreClusterSpec`.

## Using the CLI

1. Create a file of the `PostgresqlCluster` resource, e.g., using the `touch postgresqlcluster-from-backup.yaml` command.
1. Open the file and paste the configuration for recovery:

    {% list tabs %}

    - From a backup (configuration sourced from a backup)

        Set the `spec.bootstrap.recovery.fromBackup` property to the name of the backup to recover your cluster from. List of backups: `kubectl get PostgresqlBackups -n <project_name>`. The cluster configuration (instances, storage, version, and so on) will be sourced from the backup (default: `restoreClusterSpec: true`).

        {% include notitle [YAML-file](../../_includes/yamls/operations/postgresql/postgresqlcluster_from_backup.md) %}

    - From a backup with a custom configuration

        Specify `spec.bootstrap.recovery.fromBackup` and `spec.bootstrap.recovery.restoreClusterSpec: false`. Define the cluster configuration (`spec.instances`, `spec.storage`, `spec.version`, and so on) in the manifest. Data will be restored from the backup, but the cluster will be recreated with the settings you defined in the manifest.

        {% include notitle [YAML-file](../../_includes/yamls/operations/postgresql/postgresqlcluster_from_backup_custom_spec.md) %}

    - To a specific point in time:

        For point-in-time recovery (PITR), specify the backup name (`PostgresqlBackup`) to use in `spec.bootstrap.recovery.fromBackup`. List of backups: `kubectl get PostgresqlBackups -n <project_name>`. Use `spec.bootstrap.recovery.recoveryTarget.targetTime` to set a restore timestamp in RFC3339 format.

        {% include notitle [YAML-file](../../_includes/yamls/operations/postgresql/postgresqlcluster_from_backup_pitr.md) %}

    {% endlist %}

1. Apply the manifest: `kubectl apply -f postgresqlcluster-from-backup.yaml -n <project_name>`. Optionally, you can specify the project name in the `metadata.namespace` resource property and skip it in the command.

## Using the management console

1. If you have not opened a project yet, select one.
1. In the left-hand menu, select **{{ PG }} Clusters**.
1. Go to the **Backups** tab.
1. Select a backup and click **Recover from backup**.
1. Check the cluster settings and modify them if required:

    * **Recovery time**: Timestamp to recover your cluster up to.
    * **Cluster name**: Only use lowercase letters, numbers, and hyphens.
    * **Number of instances**: Number of cluster replicas.
    * **{{ PG }} version**: Select from the list of available versions.
    * **Computing resources**, where **Limits** is the upper limit and **Requests** is the lower limit.
    * **Storage**, where **Disk type** is the storage class (`stackland-nvme`, `stackland-ssd`, `stackland-hdd`, `stackland-other`). Learn more about storage classes in [Disk subsystem](../../concepts/components/disk-storage.md#storage-classes).
    * **Database**: Section containing authentication credentials.
    * **Connection pooler**: Handles writes and reads; used for all data-modifying operations and critical transactions.
    * **Backups**: Settings for copying the database to an S3 bucket.

1. Click **Create**.

That is it! Your cluster has been recovered and now appears in the project's cluster list.
