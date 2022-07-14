# Setting up access to {{ objstorage-name }}

{{ mes-name }} supports using {{ objstorage-full-name }} as an {{ ES }} [snapshot repository](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html). This lets you use {{ objstorage-name }} to:

* [Transfer data from a third-party {{ ES }} cluster to {{ mes-name }}](../tutorials/migration-via-snapshots.md).

* Add [user extensions](cluster-extensions.md#add).

* [Store backups](./cluster-backups.md).

To access {{ objstorage-name }} bucket data from a cluster:

1. [Connect a service account to a cluster](#connect-service-account).
1. [Configure access rights](#configure-acl).
1. [Connect a snapshot repository](#register-snapshot-repository).

## Connecting a service account to a cluster {#connect-service-account}

{% if audience != "internal" %}

1. When [creating](./cluster-create.md) or [updating](./cluster-update.md#change-additional-settings) a cluster, either select an existing [service account](../../iam/concepts/users/service-accounts.md) or [create a new one](../../iam/operations/sa/create.md).

1. Make sure that this account [has the role](../../iam/operations/sa/assign-role-for-sa.md) `storage.editor`.

{% else %}

1. When [creating](./cluster-create.md) or [updating](./cluster-update.md#change-additional-settings) a cluster, either select an existing service account or create a new one.

1. Make sure that this account has the role `storage.editor`.

{% endif %}

## Setting up access rights {#configure-acl}

{% list tabs %}

- Management console

   {% if audience != "internal" %}

   1. In the [management console]({{ link-console-main }}), select the folder containing the desired bucket. If there is no such bucket, [create](../../storage/operations/buckets/create.md) it.

   {% else %}

   1. In the [management console]({{ link-console-main }}), select the folder containing the desired bucket. If there is no such bucket, create it.

   {% endif %}

   1. Select **{{ objstorage-name }}**.
   1. Go to the **Buckets** tab.
   1. {% if audience != "internal" %}Set up the [bucket ACL](../../storage/operations/buckets/edit-acl.md){% else %}Set up the bucket ACL{% endif %}:
      1. In the **Select user** drop-down list, specify the service account [connected to the cluster](#connect-service-account).
      1. Select the `READ and WRITE` permissions for the selected service account.
      1. Click **Add**.
      1. Click **Save**.

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
   PUT --cacert ~/.elasticsearch/root.crt https://admin:<password>@<FQDN or IP address of the host>:9200/_snapshot/<repository>
   ```

   In the request parameters, specify the bucket associated with the cluster service account:

   ```bash
   curl --cacert ~/.elasticsearch/root.crt https://admin:<password>@<FQDN or IP address of the host>:9200/_snapshot/<repository> \
        -X PUT \
        --header "Content-Type: application/json" \
        --data '{
          "type": "s3",
            "settings": {
            "endpoint": "{{ s3-storage-host }}",
            "bucket": "<bucket name>"
          }
        }'
   ```

   To learn more about managing repositories, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore-apis.html).
