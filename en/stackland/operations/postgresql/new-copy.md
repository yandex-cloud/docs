# Creating backups

You can create a backup for any [{{ PG }}](../../concepts/components/postgresql.md) cluster existing in your [project](../projects/create-project.md).

{% list tabs group=instructions %}

- CLI {#cli}

  1. Create a file of the `PostgresqlBackup` resource, e.g., using the `touch postgresqlbackup.yaml` command.
  1. Open the file and paste the configuration:

      {% include notitle [YAML-file new-copy](../../_includes/yamls/operations/postgresql/new-copy.md) %}

  1. Apply the manifest: `kubectl apply -f postgresqlbackup.yaml -n <project name>`. Optionally, you can specify the project name in the `metadata.namespace` resource property and skip it in the command.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **{{ PG }} Clusters**.
  1. Select the cluster.
  1. Click **Create backup**.
  1. Confirm the creation of a backup.

{% endlist %}

This is it, your backup has been created.

{% note info %}

To recover a deleted cluster from a backup, see [Recovering a cluster](recover-copy.md).

{% endnote %}
