---
title: How to set up access to {{ objstorage-name }} from an {{ ES }} cluster
description: Follow this guide to set up access to {{ objstorage-name }} from an {{ ES }} cluster.
---

# Configuring access to {{ objstorage-name }} from a {{ ES }} cluster

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

{{ mes-name }} supports using {{ objstorage-full-name }} as an {{ ES }} snapshot repository. This allows you to use {{ objstorage-name }} for:

* [Migrating data from a third-party {{ ES }} cluster to {{ mes-name }}](../tutorials/migration-via-snapshots.md).

* Adding [user extensions](cluster-extensions.md#add).

* [Storing backups](./cluster-backups.md).

For more information about snapshots, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html).

To access {{ objstorage-name }} bucket data from a cluster:

1. [Connect a service account to a cluster](#connect-service-account).
1. [Configure access rights](#configure-acl).
1. [Connect a snapshot repository](#register-snapshot-repository).

## Connecting a service account to a cluster {#connect-service-account}

1. When [creating](./cluster-create.md) or [updating](./cluster-update.md#change-service-account) a cluster, either select an existing [service account](../../iam/concepts/users/service-accounts.md) or [create a new one](../../iam/operations/sa/create.md).

1. Make sure to [assign](../../iam/operations/sa/assign-role-for-sa.md) the `storage.editor` role or higher to this account.

## Setting up access rights {#configure-acl}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing the bucket you need. If there is no such bucket, [create](../../storage/operations/buckets/create.md) one.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Select the **{{ ui-key.yacloud.storage.switch_buckets }}** tab.
   1. Set up the [bucket ACL](../../storage/operations/buckets/edit-acl.md):
      1. In the **{{ ui-key.yacloud.component.acl-dialog.label_select-placeholder }}** drop-down list, specify the service account [connected to the cluster](#connect-service-account).
      1. Select the `READ and WRITE` permissions for the selected service account.
      1. Click **{{ ui-key.yacloud.common.add }}**.
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Connecting a snapshot repository {#register-snapshot-repository}

{% include [mes-objstorage-snapshot](../../_includes/mdb/mes/objstorage-snapshot.md) %}

1. [Connect](./cluster-connect.md) to the cluster.
1. Install the [repository-s3](cluster-plugins.md#elasticsearch) plugin:

   ```bash
   sudo bin/elasticsearch-plugin install repository-s3
   ```

1. Register the bucket as a snapshot repository using the [public {{ ES }} API](https://www.elastic.co/guide/en/elasticsearch/reference/current/put-snapshot-repo-api.html):

   ```http
   PUT --cacert ~/.elasticsearch/root.crt https://admin:<password>@<host_FQDN>:9200/_snapshot/<repository>
   ```

   In the request parameters, specify the bucket associated with the cluster service account:

   ```bash
   curl --request PUT \
        "https://admin:<password>@<host_FQDN>:9200/_snapshot/<repository>" \
        --cacert ~/.elasticsearch/root.crt \
        --header "Content-Type: application/json" \
        --data '{
          "type": "s3",
          "settings": {
            "endpoint": "{{ s3-storage-host }}",
            "bucket": "<bucket_name>",
            "base_path": "<path_to_snapshot_directory>",
            "canned_acl": "bucket-owner-full-control"
          }
        }'
   ```

   To learn more about managing repositories, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore-apis.html).
