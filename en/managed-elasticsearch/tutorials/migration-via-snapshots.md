# Migrating to {{ mes-name }} using snapshots

A {{ mes-name }} cluster supports the mechanism of [snapshots](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html). This lets you migrate to it data from another {{ ES }} cluster.

To migrate data from the *source cluster* in {{ ES }} to the {{ mes-name }} *target cluster*:
1. [Create a snapshot on the source cluster](#create-snapshot).
1. [Start restoring data from the snapshot on the target cluster](#restore-from-snapshot).
1. [Finish the migration](#finish-migration).


## Before you start {#before-you-begin}

1. [Create a bucket {{ objstorage-name }}](../../storage/operations/buckets/create.md) with restricted access. This bucket will be used as a snapshot repository.
1. [Create a service account](../../iam/operations/sa/create.md). It is necessary to access the bucket from the source and target clusters.
1. Before creating a target cluster [check the compatibility](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html#snapshot-restore-version-compatibility) of the source cluster and the selected version of the target cluster.

   {% note warning %}

   You can't use a snapshot if the {{ ES }} version in the source cluster is older than that in the target cluster. For example, you won't be able to restore a snapshot of an {{ ES }} 7.13 cluster in a {{ mes-name }} 7.11 cluster.

   {% endnote %}

1. [Create a {{ mes-name }} target cluster](../operations/cluster-create.md) in the desired configuration, but don't populate it with data.
1. Make sure you can [connect to the {{ mes-name }} target cluster](../operations/cluster-connect.md) using the {{ ES }} API and Kibana.
1. Make sure the {{ ES }} source cluster can access the internet.

## Create a snapshot on the source cluster {#create-snapshot}

1. [Assign the role](../../iam/operations/sa/assign-role-for-sa) `storage.editor` to the [previously created](#before-you-begin) service account.
1. [Create a static access key](../../iam/operations/sa/create-access-key.md) for this service account.

   {% note warning %}

   Save the **key id** and **private key**. You'll need them in the next steps.

   {% endnote %}

1. [Configure the ACL](../../storage/operations/buckets/edit-acl.md) for the [previously created](#before-you-begin) bucket:
   1. In the **Select user** drop-down list, specify the service account.
   1. Select the `READ + WRITE` permissions for the selected service account.
   1. Click **Add**.
   1. Click **Save**.

1. [Install](https://www.elastic.co/guide/en/elasticsearch/plugins/7.16/repository-s3.html) the `repository-s3` plugin on the source cluster.

   It must be installed on **all hosts** of the source cluster. Once you have installed it, you'll need to restart the {{ ES }} services and Kibana on the hosts.

1. Connect the bucket as a snapshot repository on the source cluster:
   1. Add the static access key information to the {{ ES }} [keystore](https://www.elastic.co/guide/en/elasticsearch/reference/current/elasticsearch-keystore.html).

      This should be done on **all hosts** of the source cluster.

      Add the following:
      * **ID of the key**:

        ```bash
        $ES_PATH/bin/elasticsearch-keystore add s3.client.default.access_key 
        ```

      * **Private key**:

        ```bash
        $ES_PATH/bin/elasticsearch-keystore add s3.client.default.secret_key 
        ```

      {% note info %}

      The path to {{ ES }} (`$ES_PATH`) depends on the selected installation method. To find out the path to the installed {{ ES }}, see the [installation guide](https://www.elastic.co/guide/en/elasticsearch/reference/current/install-elasticsearch.html) (for example, for [DEB](https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html#deb-layout) and [RPM](https://www.elastic.co/guide/en/elasticsearch/reference/current/rpm.html#rpm-layout)).

      {% endnote %}

   1. Upload the data from the keystore:

      ```bash
      curl -X POST "http://<FQDN of the source cluster>:9200/_nodes/reload_secure_settings" 
      ```

   1. Register the repository:

      ```bash
      curl -X PUT "http://<FQDN of the source cluster>:9200/_snapshot/<repository name>" -H 'Content-Type: application/json' -d '
      {
        "type": "s3",
        "settings": {
          "bucket": "<bucket name>",
          "endpoint": "{{ s3-storage-host }}"
        }
      }
      '
      ```

   For more information about connecting the repository, see the [plugin documentation](https://www.elastic.co/guide/en/elasticsearch/plugins/current/repository-s3.html).

   {% include [mes-objstorage-snapshot](../../_includes/mdb/mes/objstorage-snapshot.md) %}

1. Start creating a snapshot on the source cluster. You can create a snapshot of the entire cluster or some of the data. Place the snapshot in the repository created in the previous step. For more information, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html).

   Example of creating a snapshot of the entire cluster:

   ```bash
   curl -X PUT "http://<FQDN of the source cluster>:9200/_snapshot/<repository name>/snapshot_1?wait_for_completion=true&pretty"
   ```

   The snapshot creation starts. It may take a long time. Track the progress of the operation [using {{ ES }} tools](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-monitor-snapshot-restore.html), such as:

   ```bash
   curl -X GET "http://<FQDN of the source cluster>:9200/_snapshot/_status?pretty"
   ```


## Start restoring data from the snapshot on the target cluster {#restore-from-snapshot}

1. [Configure access to the bucket with snapshots](../operations/s3-access.md) for the target cluster. Use the [previously created](#before-you-begin) service account.

1. If necessary, [close all or some indices](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-close.html) on the target cluster.

   With the default settings, an attempt to restore an index will fail in a cluster where this index is already open. Even in a new {{ mes-name }} cluster without user data, there are open system indices (such as `.apm-custom-link` or `.kibana_*`), which may interfere with the restore operation.

   To avoid this, close the indices or configure a special restore policy. For example, {{ ES }} can restore indices from a snapshot under different names. For more information, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html).

   {% note warning %}

   Closing all indices will make Kibana temporarily unavailable. Once the system indices are opened, Kibana will be available again.

   {% endnote %}

   For example, the following command closes all indices in the target cluster:

   ```bash
   curl --cacert ~/.elasticsearch/root.crt -X POST "https://admin:<admin password>@<FQDN of the target cluster>:9200/_all/_close?pretty"
   ```

1. Start restoring data from the snapshot on the target cluster. You can restore both the entire snapshot and part of it. For more information, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html).

   Example of restoring the entire snapshot:

   ```bash
   curl --cacert ~/.elasticsearch/root.crt -X POST "https://admin:<admin password>@<FQDN of the target cluster>:9200/_snapshot/<repository name>/snapshot_1/_restore"
   ```

   The data restore from the snapshot starts. It may take a long time. Track the progress of the operation [using {{ ES }} tools](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-monitor-snapshot-restore.html), such as:

   ```bash
   curl --cacert ~/.elasticsearch/root.crt -X GET "https://admin:<admin password>@<FQDN of the target cluster>:9200/_snapshot/_status?pretty"
   ```

1. If necessary, after the restore operation is completed, [open all closed indices](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-open-close.html).

   For example, the following command opens all indices in the target cluster:

   ```bash
   curl --cacert ~/.elasticsearch/root.crt -X POST "https://admin:<admin password>@<FQDN of the target cluster>:9200/_all/_open?pretty"
   ```

## Finish the migration {#finish-migration}

1. Make sure that all the necessary data has been transferred to the {{ mes-name }} target cluster.

   You can check this, for example, [using Kibana](../operations/cluster-connect.md).

1. If necessary, [disable the snapshot repository](https://www.elastic.co/guide/en/elasticsearch/reference/current/delete-snapshot-repo-api.html) on the side of the source and target clusters.

1. If necessary, delete unused resources in {{ yandex-cloud }}:
   * [Delete the service account](../../iam/operations/sa/delete.md).
   * [Delete the snapshots](../../storage/operations/objects/delete.md) from the bucket and then delete the [entire bucket](../../storage/operations/buckets/delete.md).
