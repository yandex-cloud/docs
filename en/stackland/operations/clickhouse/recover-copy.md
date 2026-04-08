# Recovering a cluster

If you have lost a [{{ CH }}](../../concepts/components/clickhouse.md) cluster in a [project](../projects/create-project.md), you can recover it.

## Using the CLI

`spec.clickhouse.recovery` supports two recovery options:

- **fullRecovery**: Recovery of the whole cluster from one full backup. Specify the name of the `ClickhouseBackup` resource in `spec.clickhouse.recovery.fullRecovery.backup.name`. A good option if you have a full cluster backup.
- **shardsRecovery**: Recovery by shards from different backups. In `spec.clickhouse.recovery.shardsRecovery.backups[]`, specify an element with the following fields for each shard:
  - `backup.name`: Name of the `ClickhouseBackup` resource for the shard.
  - `shard`: Shard ID (e.g., `shard-1` or `shard-2`) must match `shards[].id` in the cluster specification.

List of backups: `kubectl get ClickhouseBackup -n <project_name>`.

1. Create the `ClickhouseCluster` resource file, Here is an example: `touch clickhousecluster-from-backup.yaml`.
1. Open the file and paste the configuration for recovery:

    {% list tabs %}

    - From one full backup (fullRecovery)

        Substitute into `spec.clickhouse.recovery.fullRecovery.backup.name` the name of the backup to restore the whole cluster from.

        {% include notitle [YAML-file](../../_includes/yamls/operations/clickhouse/cluster_from_backup_full.md) %}

    - By shards (shardsRecovery)

        For each shard, specify in `spec.clickhouse.recovery.shardsRecovery.backups[]` an element with `backup.name` (name of backup for the shard) and `shard` (shard ID). The number of elements must match the number of shards in the cluster.

        {% include notitle [YAML-file](../../_includes/yamls/operations/clickhouse/cluster_from_backup.md) %}

    {% endlist %}

1. Apply the manifest: `kubectl apply -f clickhousecluster-from-backup.yaml -n <project_name>`. Optionally, you can specify the project name in the `metadata.namespace` resource property and skip it in the command.

## Using the management console

1. If you have not opened a project yet, select one.
1. In the left-hand menu, select **{{ CH }} Clusters**.
1. Go to the **Backups** tab.
1. In the row with the backup you need, click **Restore**.
1. Check the cluster settings and modify them, if required:
1. Click **Restore**.

That is it! Your cluster has been recovered and now appears in the project's cluster list.
