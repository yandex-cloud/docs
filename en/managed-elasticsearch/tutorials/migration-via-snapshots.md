# Migrating to {{ mes-name }} using snapshots

{{ mes-name }} clusters support the [snapshot](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html) mechanism. This lets you migrate to it data from another {{ ES }} cluster.

To migrate data from the *source cluster* in {{ ES }} to the *target cluster* in {{ mes-name }}:

1. [{#T}](#before-you-begin).
1. [{#T}](#create-snapshot).
1. [{#T}](#restore-snapshot).
1. [{#T}](#finish-migration).

If you no longer need the used resources, [delete them](#clear-out).

{% note warning %}

You can't use a snapshot if the {{ ES }} version in the source cluster is higher than that in the target cluster. For example, you won't be able to restore a snapshot of an {{ ES }} 7.13 cluster in a {{ mes-name }} 7.11 cluster.

{% endnote %}

## Set up a working environment {#before-you-begin}

### Create the necessary resources {#create-resources}

{% list tabs %}

- Manually

   
   1. [Create a {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md) with restricted access. This bucket will be used as a snapshot repository.
   1. [Create a service account](../../iam/operations/sa/create.md) and [assign it the](../../iam/operations/sa/assign-role-for-sa.md) `storage.editor` role. A service account is required to access the bucket from the source and target clusters.
   1. [Create a static access key](../../iam/operations/sa/create-access-key.md) for the service account.


         {% note warning %}

         Save the **key ID** and **secret key**. You'll need them in the next steps.

         {% endnote %}

   1. [Create a {{ mes-name }} target cluster](../operations/cluster-create.md#create-cluster) in the desired configuration with the following settings:

      * Public access to hosts.
      * The {{ ES }} version must be the same or higher than the version in the source cluster.

      Before creating a target cluster, [check the compatibility](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html#snapshot-restore-version-compatibility) of the source cluster and the selected version of the target cluster.

   1. [Install the `repository-s3` plugin](../operations/cluster-plugins.md#update) on the target cluster.

- Using {{ TF }}

   
   1. If you don't have {{ TF }}, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the [mes-migration.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/mes-migration.tf) configuration file to the same working directory. The file describes:


        * Network.
        * Subnet.
        * Security group and the rules required to access a {{ mes-name }} target cluster.
        * `sa-mes-cluster` service account required to create a {{ mes-name }} cluster.
        * `sa-bucket` service account to work with a {{ objstorage-name }} bucket.
        * Target cluster with the installed [repository-s3](https://www.elastic.co/guide/en/elasticsearch/plugins/7.16/repository-s3.html) plugin.

   1. Specify in the `mes-migration.tf` configuration file under `locals`:
            * [Folder ID](../../resource-manager/operations/folder/get-id.md).
      * [Password for the `admin` user](../operations/cluster-update.md#change-admin-password).
      * [Target cluster edition](../concepts/es-editions.md).
      * Target cluster version.
      * {{ objstorage-name }} bucket name.

   1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   
   1. [Create a static access key](../../iam/operations/sa/create-access-key.md) for the `sa-bucket` service account.


         {% note warning %}

         Save the **key ID** and **secret key**. You'll need them in the next steps.

         {% endnote %}

{% endlist %}

### Complete the configuration and check access to resources {#complete-setup}


1. [Set up the bucket ACL](../../storage/operations/buckets/edit-acl.md):


    1. In the **Select user** drop-down list, specify the created service account.
    1. Set the `READ + WRITE` permissions for the selected service account.
    1. Click **Add**.
    1. Click **Save**.

1. [Install the `repository-s3` plugin](https://www.elastic.co/guide/en/elasticsearch/plugins/7.16/repository-s3.html) on all the target cluster hosts.

1. For the `repository-s3` plugin to work, restart the {{ ES }} and Kibana services on all the source cluster hosts.

1. Make sure you can [connect to the {{ mes-name }} target cluster](../operations/cluster-connect.md) using the {{ ES }} API and Kibana.
1. Make sure the {{ ES }} source cluster can access the internet.

## Create a snapshot on the source cluster {#create-snapshot}

1. Connect the bucket as a snapshot repository on the source cluster:

   1. Add data about the static access key to the {{ ES }} [keystore](https://www.elastic.co/guide/en/elasticsearch/reference/current/elasticsearch-keystore.html).

      Run the procedure on **all hosts** of the source cluster.

      Add the following:

      * **Key ID**:

         ```bash
         $ES_PATH/bin/elasticsearch-keystore add s3.client.default.access_key
         ```

      * **Secret key**:

         ```bash
         $ES_PATH/bin/elasticsearch-keystore add s3.client.default.secret_key
         ```

         {% note info %}

         The path to {{ ES }} (`$ES_PATH`) depends on the selected installation method. To find out the path to the installed {{ ES }}, see the [installation documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/install-elasticsearch.html) (for example, for [DEB](https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html#deb-layout) and [RPM](https://www.elastic.co/guide/en/elasticsearch/reference/current/rpm.html#rpm-layout)).

         {% endnote %}

   1. Upload the data from the keystore:

      ```bash
      curl -X POST "https://<source cluster's FQDN>:9200/_nodes/reload_secure_settings"
      ```

   1. Register the repository:

      ```bash
      curl "https://<source cluster's FQDN>:9200/_snapshot/<repository name>" \
           -X PUT \
           -H 'Content-Type: application/json' -d '
             {
               "type": "s3",
               "settings": {
                 "bucket": "<bucket name>",
                 "endpoint": "{{ s3-storage-host }}"
               }
             }'
      ```

   For more information about connecting the repository, see the [plugin documentation](https://www.elastic.co/guide/en/elasticsearch/plugins/current/repository-s3.html).

   {% include [mes-objstorage-snapshot](../../_includes/mdb/mes/objstorage-snapshot.md) %}

1. Start creating a snapshot on the source cluster. You can create a snapshot of the entire cluster or some of the data. Place the snapshot in the repository created in the previous step. For more information, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html).

   Example of creating a snapshot with the `snapshot_1` name for the entire cluster:

   ```bash
   curl -X PUT \
        "https://<source cluster's FQDN>:9200/_snapshot/<repository name>/snapshot_1?wait_for_completion=true&pretty"
   ```

   Creating a snapshot may take a long time. Track the progress of the operation [using {{ ES }} tools](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html#monitor-snapshot), such as:

   ```bash
   curl -X GET \
        "https://<source cluster's FQDN>:9200/_snapshot/<repository name>/snapshot_1/_status?pretty"
   ```

## Restore a snapshot on the target cluster {#restore-snapshot}

1. [Configure access to the bucket with snapshots](../operations/s3-access.md) for the target cluster. Use the service account you [created earlier](#before-you-begin).

1. Connect the {{ objstorage-name }} bucket to the target cluster as snapshot storage:

   ```bash
   curl "https://admin:<admin user password>@<target cluster's FQDN >:9200/_snapshot/<repository name>" \
        -X PUT \
        -H 'Content-Type: application/json' -d '
          {
            "type": "s3",
            "settings": {
              "bucket": "<bucket name>",
              "endpoint": "{{ s3-storage-host }}"
            }
          }'
   ```

1. Select how to restore an index on the target cluster.

   With the default settings, an attempt to restore an index will fail in a cluster where the same-name index is already open. Even in {{ mes-name }} clusters without user data, there are open system indices (such as `.apm-custom-link` or `.kibana_*` ), which may interfere with the restore operation. To avoid this, use one of the restore policies:

   * Existing system indices are not migrated. Only indices created on the source cluster by the user are involved in the import process.

   * [Delete and restore](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html#delete-restore): Existing indices are closed and deleted with new empty indices created with the same names and then populated with data from a snapshot.

   * [Rename on restore](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html#rename-on-restore): Existing indices are not affected, new indices are created with other names. Snapshot data is restored to the new indices.

   {% note warning %}

   Closing all indices will make Kibana temporarily unavailable. Once the system indices are opened, Kibana will be available again.

   {% endnote %}

   For example, the following command closes all indices in the target cluster:

   ```bash
   curl -X POST \
        "https://admin:<admin user password>@<target cluster's FQDN>:9200/_all/_close?pretty"
   ```

   Example of restoring the entire snapshot:

   ```bash
   curl -X POST \
        "https://admin:<admin user password>@<target cluster's FQDN>:9200/_snapshot/<repository name>/snapshot_1/_restore"
   ```

1. Start restoring data from the snapshot on the target cluster. You can restore the entire snapshot or individual indices. For more information, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html).

   Example of restoring a snapshot with indication of the user indices, which need to be restored on the target cluster:

   ```bash
   curl -X POST \
        -H 'Content-Type: application/json' 'https://admin:<admin user password>@<target cluster's FQDN>:9200/_snapshot/<repository name>/snapshot_1/_restore' -d '
        {
          "indices": "<list of indices>"
        }'
   ```

   Where a `list of indices` is a list of comma-separated indices to be restored, for example, `my_index*, my_index_2.*`. Transferring only the user indices will enable you to avoid errors when restoring the snapshot. System indices are not affected.

   Restoring a snapshot may take a long time. Track the progress of the operation [using {{ ES }} tools](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html#monitor-snapshot), such as:

   ```bash
   curl -X GET \
        "https://admin:<admin user password>@<target cluster's FQDN>:9200/_snapshot/<repository name>/snapshot_1/_status?pretty"
   ```

1. If necessary, after the restore operation is completed, [open all closed indices](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-open-close.html).

   For example, the following command opens all indices in the target cluster:

   ```bash
   curl -X POST \
        "https://admin:<admin user password>@<target cluster's FQDN>:9200/_all/_open?pretty"
   ```

## Finish the migration {#finish-migration}

1. Make sure that all the necessary data has been transferred to the {{ mes-name }} target cluster.

   You can check this, for example, [using Kibana](../operations/cluster-connect.md).

1. If necessary, [disable the snapshot repository](https://www.elastic.co/guide/en/elasticsearch/reference/current/delete-snapshot-repo-api.html) on the side of the source and target clusters.

## Delete the resources you created {#clear-out}

{% list tabs %}

- Manually

   * [Delete the service account](../../iam/operations/sa/delete.md).
   * [Delete snapshots](../../storage/operations/objects/delete.md) from the bucket and then delete [the entire bucket](../../storage/operations/buckets/delete.md).
   * [Delete the {{ mes-name }} cluster](../operations/cluster-delete.md).

- Using {{ TF }}

   To delete the infrastructure created with {{ TF }}:

   1. In the terminal window, change to the directory containing the infrastructure plan.
   1. Delete the `mes-migration.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `mes-migration.tf` configuration file will be deleted.

{% endlist %}
