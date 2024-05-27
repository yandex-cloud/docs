# Migrating data from {{ ES }} to {{ mos-full-name }}


{% note info %}

{{ mes-full-name }} is unavailable as of April 11, 2024.

{% endnote %}


There are three mechanisms to migrate data from a source {{ ES }} cluster to a target {{ mos-full-name }} cluster:

* [{{ data-transfer-full-name }} service](../../data-transfer/index.yaml)

   This method is good for any {{ ES }} cluster.

   For an example of this kind of migration, see [Migrating data to {{ OS }} using {{ data-transfer-full-name }}](../../data-transfer/tutorials/mes-to-mos.md).

* Snapshots

   This method is good for {{ ES }} cluster versions 7.11 or lower.

   To learn more about snapshots, see the [{{ OS }} documentation]({{ os.docs }}/opensearch/snapshots/index/).

* Remote [reindexing]({{ os.docs }}/opensearch/reindex-data/) (reindex data)

   You can use this mechanism to move your existing indexes, aliases, or data streams. This method is good for all {{ ES }} clusters of version 7.

## Migration using snapshots {#snapshot}

To migrate data from a source cluster in {{ ES }} to a target cluster in {{ mos-name }} using snapshots:

1. [Create a snapshot in the source cluster](#create-snapshot).
1. [Restore the snapshot in the target cluster](#restore-snapshot).
1. [Complete your migration](#finish-migration-snapshot).

If you no longer need the resources you are using, [delete them](#clear-out-snapshot).

### Getting started {#before-you-begin-snapshot}

#### Prepare the infrastructure {#deploy-infrastructure-snapshot}

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Create an {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md) with restricted access. This bucket will be used as a snapshot repository.
   1. [Create a service account](../../iam/operations/sa/create.md) and [assign](../../iam/operations/sa/assign-role-for-sa.md) the `storage.editor` role to it. A service account is required to access the bucket from the source and target clusters.

      1. If you are transferring data from a third-party {{ ES }} cluster, [create a static access key](../../iam/operations/sa/create-access-key.md) for this service account.


      {% note warning %}

      Save the **key ID** and **secret key**. You will need them in the next steps.

      {% endnote %}

   1. [Create a target {{ mos-name }} cluster](../../managed-opensearch/operations/cluster-create.md#create-cluster) in the required configuration with the following settings:

      * Plugin: `repository-s3`.
      * Public access to a group of `DATA` hosts.

- Using {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

   1. Download the [es-mos-migration-snapshot.tf](https://github.com/yandex-cloud-examples/yc-elasticsearch-migration-to-managed-opensearch/blob/main/es-mos-migration-snapshot.tf) configuration file to the same working directory. The file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security group](../../vpc/concepts/security-groups.md) and rules required to connect to a {{ mos-name }} cluster.
      * Service account to work with the {{ objstorage-name }} bucket.
      * {{ objstorage-name }} bucket.
      * {{ mos-name }} target cluster.

   1. In the `es-mos-migration-snapshot.tf` file, specify these variables:

      * `folder_id`: Cloud folder ID, the same one specified in the provider settings.
      * `bucket_name`: Bucket name consistent with the [naming conventions](../../storage/concepts/bucket.md#naming).
      * `os_admin_password`: {{ OS }} admin user password.
      * `os_version`: {{ OS }} version.

   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

#### Complete the configuration and check access to resources {#complete-setup-snapshot}

1. [Set up the bucket ACL](../../storage/operations/buckets/edit-acl.md):

   1. In the **{{ ui-key.yacloud.component.acl-dialog.label_select-placeholder }}** drop-down list, specify the created service account.
   1. Select the `READ and WRITE` permissions for the selected service account.
   1. Click **{{ ui-key.yacloud.common.add }}**.
   1. Click **{{ ui-key.yacloud.common.save }}**.

1. Set up the {{ ES }} source cluster:

   
   {% include [source-3p](es-mos-migration/source-3p.md) %}


1. [Install an SSL certificate](../../managed-opensearch/operations/connect.md#ssl-certificate).

1. Make sure you can [connect to the target {{ mos-name }} cluster](../../managed-opensearch/operations/connect.md) using the {{ OS }} API and Dashboards.

### Create a snapshot on the source cluster {#create-snapshot}

1. Connect the bucket as a snapshot repository on the source cluster:

   
   {% include [connect-bucket-3p](es-mos-migration/connect-bucket-3p.md) %}


   To learn more about adding the repository, see the [plugin documentation]({{ links.es.docs }}/elasticsearch/plugins/7.11/repository-s3.html).

   {% include [mes-objstorage-snapshot](../../_includes/mdb/mes/objstorage-snapshot.md) %}

1. Run the snapshot creation in the repository created in the previous step. You can create a snapshot of the entire cluster or some of the data. For more information, see the [{{ ES }} documentation]({{ links.es.docs }}/elasticsearch/reference/current/snapshots-take-snapshot.html).

   Example of creating a snapshot with the `snapshot_1` name for the entire cluster:

   
   {% include [create-snapshot-3p](es-mos-migration/create-snapshot-3p.md) %}


   Creating a snapshot may take a long time. Track the operation progress [using the {{ ES }} tools]({{ links.es.docs }}/elasticsearch/reference/current/snapshots-take-snapshot.html#monitor-snapshot), for example:

   
   {% include [track-snapshot-creation-3p](es-mos-migration/track-snapshot-creation-3p.md) %}


### Restore a snapshot on the target cluster {#restore-snapshot}

1. [Configure access to the bucket with snapshots](../../managed-opensearch/operations/s3-access.md#configure-acl) for the target cluster. Use the service account you [previously created](#before-you-begin).

1. [Attach an {{ objstorage-name }} bucket to the target cluster](../../managed-opensearch/operations/s3-access.md#register-snapshot-repository). This bucket will be used as a read-only snapshot storage:

   ```bash
   curl --request PUT \
        "https://admin:<admin_user_password>@<{{ OS }}_DATA_host_ID>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<repository_name>" \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --data '{
          "type": "s3",
          "settings": {
            "bucket": "<bucket_name>",
            "readonly" : "true",
            "endpoint": "{{ s3-storage-host }}"
          }
        }'
   ```

1. Select how to restore an index on the target cluster.

   With the default settings, an attempt to restore an index will fail in a cluster where the same-name index is already open. Even in {{ mos-name }} clusters without user data, there are open system indexes (such as `.apm-custom-link` or `.kibana_*`), which may interfere with the restore operation. To avoid this, use one of the following methods:

   * Migrate only your custom indexes. The existing system indexes are not migrated. The import process only affects the user-created indexes on the source cluster.

   * Use the `rename_pattern` and `rename_replacement` parameters. Indexes will be renamed as they are restored. To learn more, see the [{{ OS }} documentation]({{ os.docs }}/opensearch/snapshots/snapshot-restore#conflicts-and-compatibility).

   Example of restoring the entire snapshot:

   ```bash
   curl --request POST \
        "https://admin:<admin_user_password>@<{{ OS }}_DATA_host_ID>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<repository_name>/snapshot_1/_restore" \
        --cacert ~/.opensearch/root.crt
   ```

1. Start restoring data from the snapshot on the target cluster.

   Example of restoring a snapshot with indication of the custom indexes to be restored on the target cluster:

   ```bash
   curl --request POST \
        "https://admin:<admin_user_password>@<{{ OS }}_DATA_host_ID>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<repository_name>/snapshot_1/_restore?wait_for_completion=false&pretty" \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --data '{
          "indices": "<list_of_indexes>"
        }'
   ```

   Where `indices` is a list of comma-separated indexes to be restored, e.g., `my_index*, my_index_2.*`.

   Restoring a snapshot may take a long time. To check the restoring status, run this command:

   ```bash
   curl --request GET \
        "https://admin:<admin_user_password>@<{{ OS }}_DATA_host_ID>.{{ dns-zone }}:{{ port-mos }}/_snapshot/<repository_name>/snapshot_1/_status?pretty" \
        --cacert ~/.opensearch/root.crt
   ```

### Complete your migration {#finish-migration-snapshot}

1. Make sure all the indexes you need have been transferred to the target {{ mos-name }} cluster, and the number of documents in them is the same as in the source cluster:

   {% list tabs group=programming_language %}

   - Bash {#bash}

      Run this command:

      ```bash
      curl \
          --user <username_in_the_target_cluster>:<user_password_in_the_target_cluster> \
          --cacert ~/.opensearch/root.crt \
          --request GET 'https://<{{ OS }}_DATA_host_ID>.{{ dns-zone }}:{{ port-mos }}/_cat/indices?v'
      ```

      The list should contain the indexes transferred from {{ ES }} with the number of documents specified in the `docs.count` column.

   - {{ OS }} Dashboards {#opensearch}

      1. [Connect](../../managed-opensearch/operations/connect.md#dashboards) to the target cluster using {{ OS }} Dashboards.
      1. Select the `Global` tenant.
      1. Open the control panel by clicking ![os-dashboards-sandwich](../../_assets/console-icons/bars.svg).
      1. Under **{{ OS }} Plugins**, select **Index Management**.
      1. Go to **Indexes**.

      The list should contain the indexes transferred from {{ ES }} with the number of documents specified in the **Total documents** column.

   {% endlist %}

1. [Disable the snapshot repository]({{ links.es.docs }}/elasticsearch/reference/current/delete-snapshot-repo-api.html) on the source and target clusters, if required.

### Delete the resources you created {#clear-out-snapshot}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

   * [Delete the service account](../../iam/operations/sa/delete.md).
   * [Delete snapshots](../../storage/operations/objects/delete.md) from the bucket and then delete the [entire bucket](../../storage/operations/buckets/delete.md).
   * [Delete the {{ mos-name }} cluster](../../managed-opensearch/operations/cluster-delete.md).

- Using {{ TF }} {#tf}

   1. Delete all objects from the bucket.
   1. In the terminal window, go to the directory containing the infrastructure plan.
   1. Delete the `es-mos-migration-snapshot.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `es-mos-migration-snapshot.tf` configuration file will be deleted.

{% endlist %}

## Migration using reindexing {#reindex}


To migrate data from a source cluster in {{ ES }} to a target cluster in {{ mos-name }} through reindexing:

1. [Configure the target cluster](#configure-target-reindex).
1. [Start reindexing](#start-reindex).
1. [Check the result](#check-result-reindex).

If you no longer need the resources you created, [delete them](#clear-out-reindex).


### Getting started {#before-you-begin-reindex}


1. Prepare the infrastructure:

   {% list tabs group=instructions %}

   - Manually {#manual}

      [Create a target {{ mos-name }} cluster](../../managed-opensearch/operations/cluster-create.md#create-cluster) in the relevant configuration with public access to a group of hosts with the `DATA` role.

   - Using {{ TF }} {#tf}

      1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
      1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
      1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
      1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

      1. Download the [es-mos-migration-reindex.tf](https://github.com/yandex-cloud-examples/yc-elasticsearch-migration-to-managed-opensearch/blob/main/es-mos-migration-reindex.tf) configuration file to the same working directory. The file describes:

         * [Network](../../vpc/concepts/network.md#network).
         * [Subnet](../../vpc/concepts/network.md#subnet).
         * [Security group](../../vpc/concepts/security-groups.md) and rules required to connect to a {{ mos-name }} cluster.
         * {{ mos-name }} target cluster.

      1. In the `es-mos-migration-reindex.tf` file, specify these variables:

         * `os_admin_password`: {{ OS }} admin user password.
         * `os_version`: {{ OS }} version.

      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. Install an SSL certificate:

   {% include [install-certificate](../../_includes/mdb/mos/install-certificate.md) %}

1. Make sure you can [connect to the target {{ mos-name }} cluster](../../managed-opensearch/operations/connect.md) using the {{ OS }} API and Dashboards.


1. Make sure the {{ ES }} source cluster can access the internet.


1. In the source cluster, create a [user]({{ links.es.docs }}/kibana/current/xpack-security.html#_users_2) with the `monitoring_user` and `viewer` [roles]({{ links.es.docs }}/kibana/current/xpack-security.html#_roles_2).


### Configure the target cluster {#configure-target-reindex}


1. [Create a role]({{ os.docs }}/security-plugin/access-control/users-roles/#create-roles) with the `create_index` and `write` privileges for all indexes (`*`).

1. [Create a user](../../managed-opensearch/operations/cluster-users.md) and assign this role to them.

   {% note tip %}

   In {{ mos-name }} clusters, you can run re-indexing as the `admin` user with the `superuser` role; however, it is more secure to create separate users with limited privileges for each job. For more information, see [{#T}](../../managed-opensearch/operations/cluster-users.md).

   {% endnote %}


### Start reindexing {#start-reindex}


1. [Retrieve the list of hosts](../../managed-opensearch/operations/host-groups.md#list-hosts) in the target cluster.

1. To start reindexing, run the request against the target cluster's host with the `DATA` role:

   ```bash
   curl --user <username_in_the_target_cluster>:<user_password_in_the_target_cluster> \
        --cacert ~/.opensearch/root.crt \
        --request POST \
        "https://<{{ OS }}_DATA_host_ID>.{{ dns-zone }}:{{ port-mos }}/_reindex?wait_for_completion=false&pretty" \
        --header 'Content-Type: application/json' \
        --data '{
          "source": {
            "remote": {
              "host": "https://<source_cluster_DATA_host_IP_or_FQDN>:{{ port-mes }}",
              "username": "<username_in_the_source_cluster>",
              "password": "<user_password_in_the_source_cluster>"
            },
            "index": "<source_cluster_index_alias_or_data_stream_name>"
          },
          "dest": {
            "index": "<target_cluster_index_alias_or_data_stream_name>"
          }
        }'
   ```

   Result:

   ```text
   {
     "task" : "<reindexing_job_ID>"
   }
   ```

   To transfer several indexes, use a `for` loop:

   ```bash
   for index in <space-separated_list_of_index_alias_or_data_stream_names>; do
     curl --user <username_in_the_target_cluster>:<user_password_in_the_target_cluster> \
          --cacert ~/.opensearch/root.crt \
          --request POST \
          "https://<{{ OS }}_DATA_host_ID>.{{ dns-zone }}:{{ port-mos }}/_reindex?wait_for_completion=false&pretty" \
          --header 'Content-Type: application/json' \
          --data '{
            "source": {
              "remote": {
                "host": "https://<source_cluster_DATA_host_IP_or_FQDN>:{{ port-mes }}",
                "username": "<username_in_the_source_cluster>",
                "password": "<user_password_in_the_source_cluster>"
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
     "task" : "<ID_of_reindexing_job_1>"
   }
   {
     "task" : "<ID_of_reindexing_job_2>"
   }
   ...
   ```

   To learn more about reindexing parameters, see the [{{ OS }} documentation]({{ os.docs }}/opensearch/reindex-data/#source-index-options).

   Reindexing may take a long time. To check the operation status, run this command:

   ```bash
   curl --user <username_in_the_target_cluster>:<user_password_in_the_target_cluster> \
        --cacert ~/.opensearch/root.crt \
        --request GET \
        "https://<{{ OS }}_DATA_host_ID>.{{ dns-zone }}:{{ port-mos }}/_tasks/<reindexing_job_ID>"
   ```

1. To cancel reindexing, run this command:

   ```bash
   curl --user <username_in_the_target_cluster>:<user_password_in_the_target_cluster> \
        --cacert ~/.opensearch/root.crt \
        --request POST \
        "https://<{{ OS }}_DATA_host_ID>.{{ dns-zone }}:{{ port-mos }}/_tasks/<reindexing_job_ID>/_cancel"
   ```


### Check the result {#check-result-reindex}


Make sure all the indexes you need have been transferred to the target {{ mos-name }} cluster, and the number of documents in them is the same as in the source cluster:

{% list tabs group=programming_language %}

- Bash {#bash}

   Run this command:

   ```bash
   curl \
       --user <username_in_the_target_cluster>:<user_password_in_the_target_cluster> \
       --cacert ~/.opensearch/root.crt \
       --request GET 'https://<{{ OS }}_DATA_host_ID>.{{ dns-zone }}:{{ port-mos }}/_cat/indices?v'
   ```

   The list should contain the indexes transferred from {{ ES }} with the number of documents specified in the `docs.count` column.

- {{ OS }} Dashboards {#opensearch}

   1. [Connect](../../managed-opensearch/operations/connect.md#dashboards) to the target cluster using {{ OS }} Dashboards.
   1. Select the `Global` tenant.
   1. Open the control panel by clicking ![os-dashboards-sandwich](../../_assets/console-icons/bars.svg).
   1. Under **{{ OS }} Plugins**, select **Index Management**.
   1. Go to **Indexes**.

   The list should contain the indexes transferred from {{ ES }} with the number of documents specified in the **Total documents** column.

{% endlist %}


### Delete the resources you created {#clear-out-reindex}



Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

* Delete the resources depending on how they were created:

   {% list tabs group=instructions %}

   - Manually {#manual}

      [Delete the {{ mos-name }} cluster](../../managed-opensearch/operations/cluster-delete.md).

   - Using {{ TF }} {#tf}

      1. In the terminal window, go to the directory containing the infrastructure plan.
      1. Delete the `es-mos-migration-reindex.tf` configuration file.
      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.

      1. Confirm updating the resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         All the resources described in the `es-mos-migration-reindex.tf` configuration file will be deleted.

   {% endlist %}

* If you reserved public static IPs for cluster access, release and [delete them](../../vpc/operations/address-delete.md).

