# Setting up access to {{ objstorage-name }}

{{ mes-name }} supports the use of {{ objstorage-full-name }} as an {{ ES }} [snapshot repository](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html). This lets you use {{ objstorage-name }} to store [backups](./cluster-backups.md).

To access {{ objstorage-name }} bucket data from a cluster:

1. [Connect the service account to the cluster](#connect-service-account).
1. [Configure access rights](#configure-acl).
1. [Connect the snapshot repository](#register-snapshot-repository).

## Connecting a service account to a cluster {#connect-service-account}

1. When [creating](./cluster-create.md) or [updating](./cluster-update.md#update-additional-settings) a cluster, select an existing [service account](../../iam/concepts/users/service-accounts.md) or [create a new one](../../iam/operations/sa/create.md).
1. Make sure that this account has the [role of](../../iam/operations/sa/assign-role-for-sa.md) `storage.editor` assigned.

## Setting up access rights {#configure-acl}

1. In the management console, select the folder containing the desired bucket. If there is no bucket, [create one](../../storage/operations/buckets/create.md).
1. Select **{{ objstorage-name }}**.
1. Go to the **Buckets** tab.
1. Set up the [bucket ACL](../../storage/operations/buckets/edit-acl.md):
    1. In the **Select user** drop-down list, specify the service account [connected to the cluster](#connect-service-account).
    1. Select the `READ + WRITE` permissions for the selected service account.
    1. Click **Add**.
    1. Click **Save**.

## Connecting a snapshot repository {#register-snapshot-repository}

{% include [mes-objstorage-snapshot](../../_includes/mdb/mes/objstorage-snapshot.md) %}

1. When [creating](./cluster-create.md) or [updating](./cluster-update.md#update-additional-settings) a cluster, enable the [repository-s3](../concepts/plugins.md) plugin.

1. Register the bucket as a snapshot repository using the public [{{ ES }} API](https://www.elastic.co/guide/en/elasticsearch/reference/current/put-snapshot-repo-api.html):

    ```http
    PUT --cacert ~/.elasticsearch/root.crt https://admin:<password>@<FQDN or host IP address>:9200/_snapshot/<repository>
    ```

    In the request parameters, specify the bucket associated with the cluster service account:

    ```bash
    curl --cacert ~/.elasticsearch/root.crt https://admin:<password>@<FQDN or host IP address>:9200/_snapshot/<repository> \
         -X PUT \
         --header "Content-Type: application/json" \
         --data '{
           "type": "s3",
             "settings": {
             "endpoint": "storage.yandexcloud.net",
             "bucket": "<bucket name>"
           }
         }'
    ```

    For more information on managing repositories, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore-apis.html).

