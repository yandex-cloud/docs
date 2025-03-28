---
title: Migrating to {{ mes-name }} using snapshots
description: '{{ mes-name }} clusters support snapshots. This allows you to migrate data from another {{ ES }} cluster to them. For more information about snapshots, see the {{ ES }} documentation.'
---

# Migrating to {{ mes-name }} using snapshots

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

{{ mes-name }} clusters support snapshots. This allows you to migrate data from another {{ ES }} cluster to them. For more information about snapshots, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html).

To migrate data from the {{ ES }} *source cluster* to the {{ mes-name }} *target cluster*:

1. [Set up the runtime environment](#before-you-begin).
1. [Create a snapshot in the source cluster](#create-snapshot).
1. [Restore the snapshot in the target cluster](#restore-snapshot).
1. [Complete your migration](#finish-migration).

If you no longer need the resources you are using, [delete them](#clear-out).

{% note warning %}

You cannot use a snapshot if the {{ ES }} version in the source cluster is higher than that in the target cluster. For example, you will not be able to restore a snapshot of an {{ ES }} 7.13 cluster in a {{ mes-name }} 7.11 cluster.

{% endnote %}

## Set up the runtime environment {#before-you-begin}

### Create the required resources {#create-resources}

{% list tabs group=resources %}

- Manually {#manual}

    1. [Create an {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md) with restricted access. This bucket will be used as a snapshot repository.
    1. [Create a service account](../../iam/operations/sa/create.md) and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `storage.editor` role. A service account is required to access the bucket from the source and target clusters.
    1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the service account.

        {% note warning %}

        Save the **key ID** and **secret key**. You will need them in the next steps.

        {% endnote %}

    1. [Create a {{ mes-name }} target cluster](../operations/cluster-create.md#create-cluster) in desired configuration with the following settings:

        * Public access to hosts.
        * The {{ ES }} version must be the same or higher than the version in the source cluster.

        Before creating a target cluster, [check the compatibility](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html#snapshot-restore-version-compatibility) of the source cluster and the selected version of the target cluster.

    1. [Install the `repository-s3` plugin](../operations/cluster-plugins.md#update) in the target cluster.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [mes-migration.tf](https://github.com/yandex-cloud-examples/yc-elasticsearch-migration-via-snapshots/blob/main/mes-migration.tf) configuration file to the same working directory. This file describes:

       * Network.
       * Subnet.
       * Security group and rules required to access the {{ mes-name }} target cluster.
       * `sa-mes-cluster` service account required to create a {{ mes-name }} cluster.
       * `sa-bucket` service account to work with the {{ objstorage-name }} bucket.
       * Target cluster with the [repository-s3](https://www.elastic.co/guide/en/elasticsearch/plugins/7.16/repository-s3.html) plugin installed.

    1. Specify the following under `locals` in the `mes-migration.tf` configuration file:
        * [Folder ID](../../resource-manager/operations/folder/get-id.md)
        * [`admin` user password](../operations/cluster-update.md#change-admin-password)
        * [Target cluster edition](../concepts/es-editions.md)
        * Target cluster version
        * {{ objstorage-name }} bucket name

    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Create the required infrastructure:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the `sa-bucket` service account.

        {% note warning %}

        Save the **key ID** and **secret key**. You will need them in the next steps.

        {% endnote %}

{% endlist %}

### Complete the configuration and check access to resources {#complete-setup}

1. [Set up the bucket ACL](../../storage/operations/buckets/edit-acl.md):

    1. In the **{{ ui-key.yacloud.component.acl-dialog.label_select-placeholder }}** drop-down list, specify the created service account.
    1. Select the `READ and WRITE` permissions for the selected service account.
    1. Click **{{ ui-key.yacloud.common.add }}**.
    1. Click **{{ ui-key.yacloud.common.save }}**.

1. [Install the `repository-s3` plugin](https://www.elastic.co/guide/en/elasticsearch/plugins/7.16/repository-s3.html) on all source cluster hosts.

1. For the `repository-s3` plugin to work, restart {{ ES }} and Kibana on all source cluster hosts.

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
        curl -X POST "https://<source_cluster_FQDN>:9200/_nodes/reload_secure_settings"
        ```

    1. Register the repository:

        ```bash
        curl "https://<source_cluster_FQDN>:9200/_snapshot/<repository_name>" \
             -X PUT \
             -H 'Content-Type: application/json' -d '
               {
                 "type": "s3",
                 "settings": {
                   "bucket": "<bucket_name>",
                   "endpoint": "{{ s3-storage-host }}"
                 }
               }'
        ```

    For more information about connecting the repository, see the [plugin documentation](https://www.elastic.co/guide/en/elasticsearch/plugins/current/repository-s3.html).

    {% include [mes-objstorage-snapshot](../../_includes/mdb/mes/objstorage-snapshot.md) %}

1. Start creating a snapshot on the source cluster. You can create a snapshot of the entire cluster or some of the data. Place the snapshot in the repository created in the previous step. For more information, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html).

    Example of creating a snapshot named `snapshot_1` for the entire cluster:

    ```bash
    curl -X PUT \
         "https://<source_cluster_FQDN>:9200/_snapshot/<repository_name>/snapshot_1?wait_for_completion=true&pretty"
    ```

    Creating a snapshot may take a long time. Track the progress of the operation [using the {{ ES }} tools](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html#monitor-snapshot), such as:

    ```bash
    curl -X GET \
         "https://<source_cluster_FQDN>:9200/_snapshot/<repository_name>/snapshot_1/_status?pretty"
    ```

## Restore a snapshot on the target cluster {#restore-snapshot}

1. [Configure access to the bucket with snapshots](../operations/s3-access.md) for the target cluster. Use the service account you [previously created](#before-you-begin).

1. Connect the {{ objstorage-name }} bucket to the target cluster as a snapshot storage:

    ```bash
    curl "https://admin:<admin_user_password>@<host_FQDN>:9200/_snapshot/<repository_name>" \
         -X PUT \
         -H 'Content-Type: application/json' -d '
           {
             "type": "s3",
             "settings": {
               "bucket": "<bucket_name>",
               "endpoint": "{{ s3-storage-host }}"
             }
           }'
    ```

1. Select how to restore an index on the target cluster.

    With the default settings, an attempt to restore an index will fail in a cluster where the same-name index is already open. Even in {{ mes-name }} clusters without user data, there are open system indexes (such as `.apm-custom-link` or `.kibana_*`, etc.), which may interfere with the restore operation. To avoid this, use one of the restore policies:

    * Existing system indices are not migrated. Only indices created on the source cluster by the user are involved in the import process.

    * [Delete and restore](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html#delete-restore): Existing indexes are closed and deleted with new empty indexes created with the same names and then populated with data from a snapshot.

    * [Rename on restore](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html#rename-on-restore): Existing indexes are not affected, new indexes are created with other names. Snapshot data is restored to the new indexes.

    {% note warning %}

    Closing all indexes will make Kibana temporarily unavailable. Once the system indexes are opened, Kibana will be available again.

    {% endnote %}

    For example, the following command closes all indexes in the target cluster:

    ```bash
    curl -X POST \
         "https://admin:<admin_user_password>@<target_cluster_FQDN>:9200/_all/_close?pretty"
    ```

    Example of restoring the entire snapshot:

    ```bash
    curl -X POST \
         "https://admin:<admin_user_password>@<target_cluster_FQDN>:9200/_snapshot/<repository_name>/snapshot_1/_restore"
    ```

1. Start restoring data from the snapshot on the target cluster. You can restore the entire snapshot or individual indexes. For more information, see the relevant [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html).

    Example of restoring a snapshot with indication of the custom indexes to be restored on the target cluster:

    ```bash
    curl -X POST \
         -H 'Content-Type: application/json' 'https://admin:<admin_user_password>@<target_cluster_FQDN>:9200/_snapshot/<repository_name>/snapshot_1/_restore' -d '
         {
           "indices": "<list_of_indexes>"
         }'
    ```

    Where `list of indexes` is a list of comma-separated indexes to restore, e.g., `my_index*, my_index_2.*`. Transferring only the user indexes will enable you to avoid errors when restoring the snapshot. System indexes are not affected.

    Restoring a snapshot may take a long time. Track the progress of the operation [using the {{ ES }} tools](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html#monitor-snapshot), such as:

    ```bash
    curl -X GET \
         "https://admin:<admin_user_password>@<target_cluster_FQDN>:9200/_snapshot/<repository_name>/snapshot_1/_status?pretty"
    ```

1. If necessary, after the restore operation is completed, [open all closed indexes](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-open-close.html).

    For example, the following command opens all indexes in the target cluster:

    ```bash
    curl -X POST \
         "https://admin:<admin_user_password>@<target_cluster_FQDN>:9200/_all/_open?pretty"
    ```

## Complete your migration {#finish-migration}

1. Make sure that all required data has been transferred to the {{ mes-name }} target cluster.

    You can check this, for example, [using Kibana](../operations/cluster-connect.md).

1. If necessary, [disable the snapshot repository](https://www.elastic.co/guide/en/elasticsearch/reference/current/delete-snapshot-repo-api.html) on the side of the source and target clusters.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=resources %}

- Manually {#manual}

    * [Delete the service account](../../iam/operations/sa/delete.md)
    * [Delete snapshots](../../storage/operations/objects/delete.md) from the bucket and then delete the [entire bucket](../../storage/operations/buckets/delete.md).
    * [Delete the {{ mes-name }} cluster](../operations/cluster-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
