# Managing backups

{{ mes-short-name }} enables you to create [index](../concepts/indexing.md) backups using both {{ yandex-cloud }} tools and the {{ ES }} [snapshot](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html) mechanism.

## Creating backups with {{ yandex-cloud }} tools {#cloud-backups}

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

### Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with the data from the backup. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup. You can control restore speed [{{ ES }} tools](https://www.elastic.co/guide/en/elasticsearch/reference/current/recovery.html).

When creating a new cluster, set all required parameters.

{% list tabs %}

- Management console

   To restore an existing cluster from a backup:
   1. Go to the folder page and select **{{ mes-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon for the required backup and click **Restore cluster**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
   1. Click **Restore cluster**.

   To restore a previously deleted cluster from a backup:
   1. Go to the folder page and select **{{ mes-name }}**.
   1. Click the **Backups** tab.
   1. Find the desired backup using the backup creation time and cluster ID. The **Name** column contains the IDs in `<cluster ID>:<backup ID>` format.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon for the required backup and click **Restore cluster**.
   1. Set up the new cluster. You can select a folder for the new cluster from the **Folder** list.
   1. Click **Restore cluster**.

   {{ mes-name }} launches the operation to create a cluster from the backup.


{% endlist %}

### Creating a backup {#create-backup}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mes-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.
   1. Click **Create a backup**.


{% endlist %}

### Getting a list of backups {#list-backups}

{% list tabs %}

- Management console

   To get a list of cluster backups:
   1. Go to the folder page and select **{{ mes-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.

   To get a list of all backups in a folder:
   1. Go to the folder page and select **{{ mes-name }}**.
   1. Click the **Backups** tab.


{% endlist %}

### Getting information about backups {#get-backup}

{% list tabs %}

- Management console

   To get information about the backup of an existing cluster:
   1. Go to the folder page and select **{{ mes-name }}**.
   1. Click on the name of the cluster you need and select the tab **Backup copies**.

   To get information about the backup of a previously deleted cluster:
   1. Go to the folder page and select **{{ mes-name }}**.
   1. Click the **Backups** tab.


{% endlist %}


## Backups using snapshots {#snapshot-backups}

To work with snapshots, use the [{{ ES }} public API](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore-apis.html) and a bucket in {{ objstorage-name }} to store them.

### Retrieving a snapshot list {#list-snapshots}

1. Find the repository containing snapshot backups in the {{ ES }} repository list:

   ```http
   GET https://admin:<password>@<host_FQDN_or_IP-address>:9200/_snapshot/_all
   ```

   If the desired repository is not on the list, [connect it](./s3-access.md).

1. Get a list of snapshots in the repository:

   ```http
   GET https://admin:<password>@<host_FQDN_or_IP_ address>:9200/_snapshot/<repository>/_all
   ```

   Each snapshot is a single backup.


### Creating a snapshot {#create-snapshot}

1. In the {{ ES }} repository list, find the repository where you want to create the snapshot:

   ```http
   GET https://admin:<password>@<host_FQDN_or_IP-address>:9200/_snapshot/_all
   ```

   If the desired repository is not on the list, [connect it](./s3-access.md).

1. [Create a snapshot](https://www.elastic.co/guide/en/elasticsearch/reference/current/create-snapshot-api.html) of the desired data or cluster in the selected repository:

   ```http
   PUT https://admin:<password>@<host_FQDN_or_IP-address>:9200/_snapshot/<repository>/<snapshot>
   ```

### Restoring a cluster from a snapshot {#restore-from-snapshot}

{% note warning %}

When restoring from snapshots, the following restrictions apply:

* The {{ ES }} version in the cluster must be equal to or higher than the {{ ES }} version where the snapshot was taken.
* To restore the indexes, be sure that the major {{ ES }} version in the cluster is no more than one unit higher than the major {{ ES }} version where the snapshot was taken. For example, you can use version 6.0 (but not 7.0) to recover indexes created in version 5.0.

{% endnote %}

1. [Create a new {{ ES }} cluster](./cluster-create.md) in the desired configuration, but don't populate it with data.

   When creating a cluster, select:

   * The number and class of hosts as well as the size and type of storage based on snapshot size and performance requirements. If necessary, [upgrade your host class](./cluster-update.md#change-resource-preset) or [increase cluster storage size](./cluster-update.md#change-disk-size).

   * The {{ ES }} version used to make the snapshot or higher.

1. Close the open indexes using the [{{ES}} API](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-close.html):

   ```http
   POST: https://admin:<password>@<host_FQDN_or_IP-address>:9200/<index>/_close
   ```

   To restore an entire cluster, close all open indices. To restore individual indices, close only those indices.

1. [Retrieve a list of backups](#list-snapshots) and find the desired snapshot.
1. [Start restoring](https://www.elastic.co/guide/en/elasticsearch/reference/current/restore-snapshot-api.html) an entire cluster or individual data indexes and streams from the desired snapshot.

For more information about restoring from snapshots, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html).
