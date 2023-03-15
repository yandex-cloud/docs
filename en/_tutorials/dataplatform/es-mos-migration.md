# Migrating data from {{ ES }} to {{ mos-full-name }}

There are two mechanisms to move data from a source {{ ES }} cluster to a target {{ mos-full-name }} cluster:

* [Using snapshots]({{ os.docs }}/opensearch/snapshots/index/) (snapshots).

   This method is good for {{ ES }} cluster versions 7.11 or lower.

* Remote [reindexing]({{ os.docs }}/opensearch/reindex-data/) (reindex data).

   You can use this mechanism to move your existing indexes, aliases, or data streams. This method is good for all {{ ES }} clusters of version 7.

## Migrating with snapshots {#snapshot}

To migrate data from a source cluster in {{ ES }} to a target cluster in {{ mos-name }} by using snapshots:

1. [Create a snapshot of the source cluster](#create-snapshot).
1. [Restore the snapshot on the target cluster](#restore-snapshot).
1. [Finish the migration](#finish-migration-snapshot).

If you no longer need the used resources, [delete them](#clear-out-snapshot).

### Before you begin {#before-you-begin-snapshot}

#### Prepare the infrastructure {#deploy-infrastructure-snapshot}

1. [Create a {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md) with restricted access. This bucket will be used as a snapshot repository.
1. [Create a service account](../../iam/operations/sa/create.md) and [assign to it the role](../../iam/operations/sa/assign-role-for-sa.md) `storage.editor`. A service account is required to access the bucket from the source and target clusters.
1. If you are transferring data from a third-party {{ ES }} cluster, [create a static access key](../../iam/operations/sa/create-access-key.md) for this service account.

   {% note warning %}

   Save the **key ID** and **secret key**. You'll need them in the next steps.

   {% endnote %}

1. [Create a {{ mos-name }} target cluster](../../managed-opensearch/operations/cluster-create.md#create-cluster) in the desired configuration with the following settings:

   * Plugin: `repository-s3`.
   * Public access to a group of `DATA` hosts.

#### Complete the configuration and check access to resources {#complete-setup-snapshot}

1. [Set up the bucket ACL](../../storage/operations/buckets/edit-acl.md):

   1. In the **Select user** drop-down list, specify the created service account.
   1. Select the `READ and WRITE` permissions for the selected service account.
   1. Click **Add**.
   1. Click **Save**.

1. Set up the {{ ES }} source cluster:

   {% list tabs %}

   - Third-party {{ ES }} cluster

      1. [Install the plugin]({{ links.es.docs }}/elasticsearch/plugins/7.11/repository-s3.html) `repository-s3` on all cluster hosts.

      1. For the `repository-s3` plugin to work, restart the {{ ES }} and Kibana services on all cluster hosts.

      1. Make sure the {{ ES }} source cluster can access the internet.

   - {{ mes-name }}

      1. [Install the plugin](../../managed-opensearch/operations/plugins.md#update) `repository-s3`.

      1. [Install an SSL certificate](../../managed-elasticsearch/operations/cluster-connect.md#get-ssl-cert).

      1. Make sure you can [connect to the source cluster](../../managed-elasticsearch/operations/cluster-connect.md) using the {{ ES }} API and Kibana.

   {% endlist %}

1. [Install an SSL certificate](../../managed-opensearch/operations/connect.md#ssl-certificate).

1. Make sure you can [connect](../../managed-opensearch/operations/connect.md) to the {{ mos-name }} target cluster using the {{ OS }} API and Dashboards.

### Create a snapshot on the source cluster {#create-snapshot}

1. Connect the bucket as a snapshot repository on the source cluster:

   {% list tabs %}

   - Third-party {{ ES }} cluster

      1. Add the static access key information to the {{ ES }} [keystore]({{ links.es.docs }}/elasticsearch/reference/current/elasticsearch-keystore.html) (keystore).

         {% note info %}

         Run the procedure on all hosts of the source cluster.

         {% endnote %}

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

         The path to {{ ES }} (`$ES_PATH`) depends on the selected installation method. To find a path to your {{ ES }} installation, see the [installation documentation]({{ links.es.docs }}/elasticsearch/reference/current/install-elasticsearch.html) (for example, for [DEB]({{ links.es.docs }}/elasticsearch/reference/current/deb.html#deb-layout), [RPM]({{ links.es.docs }}/elasticsearch/reference/current/rpm.html#rpm-layout)).

         {% endnote %}

      1. Upload the data from the keystore:

         ```bash
         curl --request POST "https://<IP address or FQDN of the host with the DATA role in the source cluster>:{{ port-mes }}/_nodes/reload_secure_settings"
         ```

      1. Register the repository:

         ```bash
         curl --request PUT \
              "https://<IP address or FQDN of the host with the DATA role in the source cluster>:{{ port-mes }}/_snapshot/<repository name>" \
              --header 'Content-Type: application/json' \
              --data '{
                "type": "s3",
                "settings": {
                  "bucket": "<bucket name>",
                  "endpoint": "{{ s3-storage-host }}"
                }
              }'
         ```

   - {{ mes-name }}

      Run the command:

      ```bash
      curl --request PUT \
           "https://admin:<admin user password>@<IP address or FQDN of the host with the DATA role in the source cluster>:{{ port-mes }}/_snapshot/<repository name>" \
           --cacert ~/.elasticsearch/root.crt \
           --header 'Content-Type: application/json' \
           --data '{
             "type": "s3",
             "settings": {
               "bucket": "<bucket name>",
               "endpoint": "{{ s3-storage-host }}"
             }
           }'
      ```

   {% endlist %}

   To learn more about adding the repository, see the [plugin documentation]({{ links.es.docs }}/elasticsearch/plugins/7.11/repository-s3.html).

   {% include [mes-objstorage-snapshot](../../_includes/mdb/mes/objstorage-snapshot.md) %}

1. Run the snapshot creation in the repository created in the previous step. You can create a snapshot of the entire cluster or some of the data. For more information, see the [{{ ES }} documentation]({{ links.es.docs }}/elasticsearch/reference/current/snapshots-take-snapshot.html).

   Example of creating a snapshot with the `snapshot_1` name for the entire cluster:

   {% list tabs %}

   - Third-party {{ ES }} cluster

      ```bash
      curl --request PUT \
           "https://<IP address or FQDN of the host with the DATA role in the source cluster>:{{ port-mes }}/_snapshot/<repository name>/snapshot_1?wait_for_completion=false&pretty"
      ```

   - {{ mes-name }}

      ```bash
      curl --request PUT \
           "https://admin:<admin user password>@<IP address or FQDN of the host with the DATA role in the source cluster>:{{ port-mes }}/_snapshot/<repository name>/snapshot_1?wait_for_completion=false&pretty" \
           --cacert ~/.elasticsearch/root.crt
      ```

   {% endlist %}

   Creating a snapshot may take a long time. Track the operation progress [using the {{ ES }} tools]({{ links.es.docs }}/elasticsearch/reference/current/snapshots-take-snapshot.html#monitor-snapshot), for example:

   {% list tabs %}

   - Third-party {{ ES }} cluster

      ```bash
      curl --request GET \
           "https://<IP address or FQDN of the host with the DATA role in the source cluster>:{{ port-mes }}/_snapshot/<repository name>/snapshot_1/_status?pretty"
      ```

   - {{ mes-name }}

      ```bash
      curl --request GET \
           "https://admin:<admin user password>@<IP address or FQDN of the host with the DATA role in the source cluster>:{{ port-mes }}/_snapshot/<repository name>/snapshot_1/_status?pretty" \
           --cacert ~/.elasticsearch/root.crt
      ```

   {% endlist %}

### Restore a snapshot on the target cluster {#restore-snapshot}

1. [Configure access to the bucket with snapshots](../../managed-opensearch/operations/s3-access.md#configure-acl) for the target cluster. Use the service account you [created earlier](#before-you-begin).

1. [Attach an {{ objstorage-name }} bucket to the target cluster](../../managed-opensearch/operations/s3-access.md#register-snapshot-repository). This bucket will be used as a read-only snapshot storage:

   ```bash
   curl --request PUT \
        "https://admin:<admin user password>@<ID of the OpenSearch host with the DATA role>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<repository name>" \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --data '{
          "type": "s3",
          "settings": {
            "bucket": "<bucket name>",
            "readonly" : "true",
            "endpoint": "{{ s3-storage-host }}"
          }
        }'
   ```

1. Select how to restore an index on the target cluster.

   With the default settings, an attempt to restore an index will fail in a cluster where the same-name index is already open. Even in {{ mos-name }} clusters without user data, there are open system indices (such as `.apm-custom-link` or `.kibana_*`), which may interfere with the restore operation. To avoid this, use one of the following methods:

   * Move only your custom indexes. Existing system indexes aren't migrated. Only indexes created on the source cluster by the user are involved in the import process.

   * Use the `rename_pattern` and `rename_replacement`.parameters. Indexes will be renamed as they are restored. To learn more, see the [{{ OS }} documentation]({{ os.docs }}/opensearch/snapshots/snapshot-restore#conflicts-and-compatibility).

   Example of restoring the entire snapshot:

   ```bash
   curl --request POST \
        "https://admin:<admin password>@<ID of the OpenSearch host with the DATA role>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<repository name>/snapshot_1/_restore" \
        --cacert ~/.opensearch/root.crt
   ```

1. Start restoring data from the snapshot on the target cluster.

   Example of restoring a snapshot with indication of the user indices, which need to be restored on the target cluster:

   ```bash
   curl --request POST \
        "https://admin:<admin user password>@<ID of the OpenSearch host with the DATA role>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<repository name>/snapshot_1/_restore?wait_for_completion=false&pretty" \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --data '{
          "indices": "<list of indexes>"
        }'
   ```

   Where a `list of indices` is a list of comma-separated indices to be restored, for example, `my_index*, my_index_2.*`.

   Restoring a snapshot may take a long time. To check the restoring status, run the command:

   ```bash
   curl --request GET \
        "https://admin:<admin password>@<ID of the OpenSearch host with the DATA role>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<repository name>/snapshot_1/_status?pretty" \
        --cacert ~/.opensearch/root.crt
   ```

### Finish the migration {#finish-migration-snapshot}

1. Make sure that all the necessary data has been transferred to the {{ mos-name }} target cluster.

   You can check this, for example, using [{{ OS }} Dashboards](../../managed-opensearch/operations/connect.md#dashboards).

1. If necessary, [disable the snapshot repository]({{ links.es.docs }}/elasticsearch/reference/current/delete-snapshot-repo-api.html) on the source and target clusters.

### Delete the resources you created {#clear-out-snapshot}

* [Delete the service account](../../iam/operations/sa/delete.md).
* [Delete the snapshots](../../storage/operations/objects/delete.md) from the bucket and then delete the [entire bucket](../../storage/operations/buckets/delete.md).
* [Delete the {{ mos-name }} cluster](../../managed-opensearch/operations/cluster-delete.md).

## Migrating by reindexing {#reindex}

To migrate data from a source cluster in {{ ES }} to a target cluster in {{ mos-name }} by using reindexing:

1. [Configure the target cluster](#configure-target-reindex).
1. [Start reindexing](#start-reindex).
1. [Check the results](#check-result-reindex).

If you no longer need these resources, [delete them](#clear-out-reindex).

### Before you begin {#before-you-begin-reindex}

1. [Create a target {{ mos-name }} cluster](../../managed-opensearch/operations/cluster-create.md#create-cluster) in the relevant configuration and public access to the host group with the `DATA` role.

1. [Install an SSL certificate](../../managed-opensearch/operations/connect.md#ssl-certificate).

1. Make sure you can [connect](../../managed-opensearch/operations/connect.md) to the {{ mos-name }} target cluster using the {{ OS }} API and Dashboards.

1. Make sure the {{ ES }} source cluster can access the internet.

1. In the source cluster, create a [user]({{ links.es.docs }}/kibana/current/xpack-security.html#_users_2) with the [roles]({{ links.es.docs }}/kibana/current/xpack-security.html#_roles_2) `monitoring_user` and `viewer`.

### Configure the target cluster {#configure-target-reindex}

1. [Create a role]({{ os.docs }}/security-plugin/access-control/users-roles/#create-roles) with the privileges `create_index` and `write` for all indexes (`*`).

1. [Create a user](../../managed-opensearch/operations/cluster-users.md) and assign the user this role.

   {% note tip %}

   In {{ mos-name }} clusters, you can run reindexing as the `admin` user assigned the `superuser` role, but it is more secure to create separate users with limited privileges for each job. For more information, see [{#T}](../../managed-opensearch/operations/cluster-users.md).

   {% endnote %}

### Start reindexing {#start-reindex}

1. [Retrieve a list of hosts](../../managed-opensearch/operations/host-groups.md#list-hosts) in the target cluster.

1. To start reindexing, run the request against the target cluster's host with the `DATA` role:

   ```bash
   curl --user <username in the target cluster>:<user password in the target cluster> \
        --cacert ~/.opensearch/root.crt \
        --request POST \
        "https://<ID of the OpenSearch host with the DATA role>.{{ dns-zone }}:{{ port-mos }}/_reindex?wait_for_completion=false&pretty" \
        --header 'Content-Type: application/json' \
        --data '{
          "source": {
            "remote": {
              "host": "https://<IP address of FQDN of the host with the DATA role in the source cluster>:{{ port-mes }}",
              "username": "<username in the source cluster>",
              "password": "<user password in the source cluster>"
            },
            "index": "<name of the index, alias, or data stream in the source cluster>"
          },
          "dest": {
            "index": "<name of the index, alias, or data stream in the target cluster>"
          }
        }'
   ```

   Result:

   ```text
   {
     "task" : "<ID of the reindexing job>"
   }
   ```

   To transfer several indexes, use a `for` loop:

   ```bash
   for index in <names of indexes, aliases, or data streams separated by a space>; do
     curl --user <username in the target cluster>:<user password in the target cluster> \
          --cacert ~/.opensearch/root.crt \
          --request POST \
          "https://<ID of the OpenSearch host with the DATA role>.{{ dns-zone }}:{{ port-mos }}/_reindex?wait_for_completion=false&pretty" \
          --header 'Content-Type: application/json' \
          --data '{
            "source": {
              "remote": {
                "host": "https://<IP address or FQDN of the host with the DATA role in the source cluster>:{{ port-mes }}",
                "username": "<username in the source cluster>",
                "password": "<user password in the source cluster>"
              },
              "index": "'$index'"
            },
            "dest": {
              "index": "'$index'"
            }
          }'
   done
   ```

   Result:

   ```text
   {
     "task" : "<ID of reindexing job 1>"
   }
   {
     "task" : "<ID of reindexing job 2>"
   }
   ...
   ```

   To learn more about reindexing parameters, see the [{{ OS }} documentation]({{ os.docs }}/opensearch/reindex-data/#source-index-options).

   Reindexing may take a long time. To check the operation status, run the command:

   ```bash
   curl --user <username in the target cluster>:<user password in the target cluster> \
        --cacert ~/.opensearch/root.crt \
        --request GET \
        "https://<ID of the OpenSearch host with the DATA role>.{{ dns-zone }}:{{ port-mos }}/_tasks/<ID of the reindexing job>"
   ```

1. To cancel reindexing, run the command:

   ```bash
   curl --user < username in the target cluster>:<user password in the target cluster> \
        --cacert ~/.opensearch/root.crt \
        --request POST \
        "https://admin:<admin password>@<ID of the OpenSearch host with the DATA role>.{{ dns-zone }}:{{ port-mos }}/_tasks/<ID of the reindexing job>/_cancel"
   ```

### Check the results {#check-result-reindex}

Make sure that all the necessary data has been transferred to the {{ mos-name }} target cluster.

You can check this, for example, using [{{ OS }} Dashboards](../../managed-opensearch/operations/connect.md#dashboards).

### Delete the resources you created {#clear-out-reindex}

If you no longer need these resources, delete them:

* [Delete the {{ mos-name }} cluster](../../managed-opensearch/operations/cluster-delete.md).
* If you reserved public static IPs for cluster access, release and [delete them](../../vpc/operations/address-delete.md).
