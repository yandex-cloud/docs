# Managing backups

{{ mes-name }} enables you to use [snapshots](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html) in {{ ES }} to manage data backups. To work with snapshots, use the [{{ ES }} public API](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore-apis.html) and a bucket in {{ objstorage-name }} to store them.

## Getting a list of backups {#list-backups}

1. Find the repository containing snapshot backups in the {{ ES }} repository list:

    ```http
    GET https://admin:<password>@<FQDN_or_host_IP_address>:9200/_snapshot/_all
    ```

    If the desired repository is not on the list, [connect it](./s3-access.md).

1. Get a list of snapshots in the repository:

    ```http
    GET https://admin:<password>@<FQDN_or_host_IP_address>:9200/_snapshot/<repository>/_all
    ```

    Each snapshot is a single backup.

## Creating a backup {#create-backup}

1. In the {{ ES }} repository list, find the repository where you want to create the snapshot:

    ```http
    GET https://admin:<password>@<FQDN_or_host_IP_address>:9200/_snapshot/_all
    ```

    If the desired repository is not on the list, [connect it](./s3-access.md).

1. [Create a snapshot]( https://www.elastic.co/guide/en/elasticsearch/reference/current/create-snapshot-api.html) of the required data or an entire cluster in the selected repository:

    ```http
    PUT https://admin:<password>@<FQDN_or_host_IP_address>:9200/_snapshot/<repository>/<snapshot>
    ```

## Restoring clusters from backups {#restore}

{% note warning %}

When restoring from snapshots, the following restrictions apply:

* The {{ ES }} version in the cluster must be equal to or higher than the {{ ES }} version where the snapshot was taken.
* To restore the indices, be sure that the major {{ ES }} version in the cluster is no more than one unit higher than the major {{ ES }} version where the snapshot was taken. For example, you can use version 6.0 (but not 7.0) to recover indices created in version 5.0.

{% endnote %}

1. [Create a new {{ ES }} cluster](./cluster-create.md) in the desired configuration, but don't populate it with data.

    When creating a cluster, select:

    * The number and class of hosts as well as the size and type of storage based on snapshot size and performance requirements. If necessary, [upgrade your host class](./cluster-update.md#change-resource-preset) or [increase cluster storage size](./cluster-update.md#change-disk-size).

    * The {{ ES }} version used to make the snapshot or higher.

1. Close any open indices with the [{{ES}} API](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-close.html):

    ```http
    POST: https://admin:<password>@<FQDN_or_host_IP_address>:9200/<index>/_close
    ```

    To restore an entire cluster, close all open indices. To restore individual indices, close only those indices.

1. [Get a list of backups](#list-backups) and find the desired snapshot.

1. [Launch the restore operation](https://www.elastic.co/guide/en/elasticsearch/reference/current/restore-snapshot-api.html) of an entire cluster or individual indices and data streams using the desired snapshot.

For more information about restoring from snapshots, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html).

