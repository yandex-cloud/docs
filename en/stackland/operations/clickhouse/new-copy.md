# Creating backups

You can create a backup for any [{{ CH }}](../../concepts/components/clickhouse.md) cluster existing in your [project](../projects/create-project.md).

{% list tabs group=instructions %}

- CLI {#cli}

`spec.type` supports two backup strategies:

- **full**: Creates a full cluster backup. The `spec.incrementFrom` field is ignored.
- **incremental**: Captures only the changes made since a previous backup. Under `spec.incrementFrom`, make sure to specify the name of the baseline `ClickhouseBackup` resource for the new increment, e.g., name of a full backup or the most recent increment.

Optionally, under `spec.shards`, list shards for the backup, where each item is an object with a `name` field containing the cluster shard ID. If not specified, the backup captures all shards in the cluster.

  1. Create the `ClickhouseBackup` resource file, e.g., using the `touch clickhousebackup.yaml` command.
  1. Open the file and paste the configuration:

      {% include notitle [YAML-file new-copy](../../_includes/yamls/operations/clickhouse/new-copy.md) %}

  1. Apply the manifest: `kubectl apply -f clickhousebackup.yaml -n <project_name>`. Optionally, you can specify the project name in the `metadata.namespace` resource property and skip it in the command.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **{{ CH }} Clusters**.
  1. Select a cluster.
  1. Click **Create backup**.
  1. Confirm the creation of a backup.

{% endlist %}

This is it, your backup has been created.

{% note info %}

To recover a deleted cluster from a backup, see [Recovering a cluster](recover-copy.md).

{% endnote %}
