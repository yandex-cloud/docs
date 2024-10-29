---
title: How to change {{ CH }} cluster settings in {{ mch-full-name }}
description: Follow this guide to change {{ CH }} cluster settings.
---

# Updating {{ CH }} cluster settings

After creating a cluster, you can:


* [Change service account settings](#change-service-account).


* [{#T}](#change-resource-preset).

* [{#T}](#change-disk-size).

* [{#T}](#SQL-management).

* [Change additional cluster settings](#change-additional-settings).

* [Move a cluster](#move-cluster) to another folder.


* [Change cluster security groups](#change-sg-set).


* [Changing hybrid storage settings](#change-hybrid-storage).

Learn more about other cluster updates:

* [Migrating a cluster to a different availability zone](host-migration.md).

* [Configuring {{ CH }} servers](change-server-level-settings.md) as described in the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings).

* [Changing {{ CH }} settings at the query level](change-query-level-settings.md).


## Changing service account settings {#change-service-account}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**, select the service account you need from the list, or [create a new one](../../iam/operations/sa/create.md). For more information about setting up service accounts, see [{#T}](s3-access.md).

       {% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

{% endlist %}


## Changing the host class {#change-resource-preset}

{% note info %}

In clusters with {{ CK }}, {{ ZK }} hosts cannot be used. To learn more, see [Replication](../concepts/replication.md).

{% endnote %}

When changing the host class:

* Your single-host cluster will be unavailable for a few minutes with database connections terminated.
* In a multi-host cluster, hosts will be stopped and updated one by one. When stopped, a host will be unavailable for a few minutes.
* Using a [special FQDN](connect/fqdn.md#auto) does not guarantee a stable database connection: user sessions may be terminated.

We recommend changing the host class only when the cluster has no active workload.

Host class affects the amount of RAM that {{ CH }} can use. For more information, see [Memory management](../concepts/memory-management.md).

The minimum number of cores per {{ ZK }} host depends on the total number of cores on {{ CH }} hosts. To learn more, see [Replication](../concepts/replication.md#zk).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
  1. To change the {{ CH }} host class, select the platform, VM type, and required host class under **{{ ui-key.yacloud.mdb.forms.new_section_resource }}**.
  1. To change the {{ ZK }} host class, select the platform, VM type, and required {{ ZK }} host class under **{{ ui-key.yacloud.mdb.forms.section_zookeeper-resource }}**.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [host class](../concepts/instance-types.md) for the cluster:

  1. View a description of the update cluster CLI command:

     ```bash
     {{ yc-mdb-ch }} cluster update --help
     ```

  1. Request a list of available host classes (the `ZONE IDS` column specifies the availability zones where you can select the appropriate class):


     ```bash
     {{ yc-mdb-ch }} resource-preset list

     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 8.0 GB   |
     |           | {{ region-id }}-d                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```


  1. Specify the class in the update cluster command:

     ```bash
     {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
        --clickhouse-resource-preset=<class_ID>
     ```

     {{ mch-short-name }} will run the update host class command for the cluster.

  1. To change the class of a {{ ZK }} host, provide the value you need in the `--zookeeper-resource-preset` parameter.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. In the {{ mch-name }} cluster description, change the value of the `resource_preset_id` parameter in the `clickhouse.resources` and `zookeeper.resources` sections for {{ CH }} and {{ ZK }} hosts, respectively:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          clickhouse {
            resources {
              resource_preset_id = "<{{ CH }}_host_class>"
              ...
            }
          }
          zookeeper {
            resources {
              resource_preset_id = "<{{ ZK }}_host_class>"
              ...
            }
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

  To change the host class, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

  * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
  * Required values in the `configSpec.clickhouse.resources.resourcePresetId` parameter (`configSpec.zookeeper.resources.resourcePresetId` for ZooKeeper).

      To request a [list](../api-ref/ResourcePreset/list.md) of supported values, use the list method for the `ResourcePreset` resources.

  * List of settings to update, in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Increasing storage size {#change-disk-size}

{% note info %}

In clusters with {{ CK }}, {{ ZK }} hosts cannot be used. To learn more, see [Replication](../concepts/replication.md).

{% endnote %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  To increase the cluster storage size:

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, specify the required value.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To increase the cluster storage size:

  1. View a description of the update cluster CLI command:

     ```bash
     {{ yc-mdb-ch }} cluster update --help
     ```

  1. Specify the required storage in the cluster update command (it must be at least as large as `disk_size` in the cluster properties):

     ```bash
     {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
       --clickhouse-disk-size <storage_size_in_GB>
     ```

  1. To increase the storage capacity of {{ ZK }} hosts, provide the value you need in the `--zookeeper-disk-size` parameter.

- {{ TF }} {#tf}

  To increase storage size:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. In the {{ mch-name }} cluster description, change the value of the `disk_size` parameter in the `clickhouse.resources` and `zookeeper.resources` sections for {{ CH }} and {{ ZK }} hosts, respectively:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          clickhouse {
            resources {
              disk_size = <storage_size_in_GB>
              ...
            }
          }
          zookeeper {
            resources {
              disk_size = <storage_size_in_GB>
              ...
            }
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

  To increase the storage size, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

  * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
  * Required size of the {{ CH }} host storage in the `configSpec.clickhouse.resources.diskSize` parameter.
  * Required size of the {{ ZK }} host storage in the `configSpec.zookeeper.resources.diskSize` parameter.
  * List of cluster configuration fields to update in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Enabling user and database management via SQL {#SQL-management}

The {{ mch-name }} service lets enable cluster [user](./cluster-users.md#sql-user-management) and [database](./databases.md#sql-database-management) management via SQL.

{% note alert %}

This disables user and database management through standard {{ yandex-cloud }} interfaces (management console, CLI, {{ TF }}, API).

Once enabled, user and database management settings for SQL cannot be disabled.

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
  1. To [manage users via SQL](./cluster-users.md#sql-user-management), enable the **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** setting under **{{ ui-key.yacloud.mdb.forms.section_settings }}** and specify the `admin` user password.
  1. To [manage databases via SQL](./databases.md#sql-database-management), enable the **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** and **{{ ui-key.yacloud.mdb.forms.database_field_sql-database-management }}** settings under **{{ ui-key.yacloud.mdb.forms.section_settings }}** and specify the `admin` user password.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. To enable [SQL user management](./cluster-users.md#sql-user-management):

        * set `--enable-sql-user-management` to `true`.
        * Set a password for the `admin` user in the `--admin-password` parameter.

        ```bash
        {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
           ...
           --enable-sql-user-management true \
           --admin-password "<admin_user_password>"
        ```

    1. To enable [SQL database management](./databases.md#sql-database-management):

        * Set `--enable-sql-user-management` and `--enable-sql-database-management` to `true`;
        * Set a password for the `admin` user in the `--admin-password` parameter.

        ```bash
        {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
           ...
           --enable-sql-user-management true \
           --enable-sql-database-management true \
           --admin-password "<admin_user_password>"
        ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. {% include [Enable SQL user management with Terraform](../../_includes/mdb/mch/terraform/sql-management-users.md) %}

    1. {% include [Enable SQL database management with Terraform](../../_includes/mdb/mch/terraform/sql-management-databases.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

    To enable user and database management via SQL, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the appropriate values in the `configSpec.clickhouse.config` request parameter:

    * `sqlUserManagement`: Set to `true` to enable [user management through SQL](cluster-users.md#sql-user-management).
    * `sqlDatabaseManagement`: Set to `true` to enable [database management through SQL](databases.md#sql-database-management). For that, you also need to enable user management through SQL.
    * `adminPassword`: Set a password for the `admin` account to use for management tasks.

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**, change the additional cluster settings:

     {% include [mch-extra-settings](../../_includes/mdb/mch/extra-settings-web-console.md) %}

  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change additional cluster settings:

    1. View a description of the update cluster CLI command:

        ```bash
        {{ yc-mdb-ch }} cluster update --help
        ```

    1. Run the following command with a list of settings to update:


        ```bash
        {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
           --backup-window-start <backup_start_time> \
           --datalens-access=<true_or_false> \
           --metrika-access=<true_or_false> \
           --serverless-access=<true_or_false> \
           --websql-access=<true_or_false> \
           --yandexquery-access=<true_or_false> \
           --deletion-protection=<cluster_deletion_protection> \
           --maintenance-window type=<maintenance_type>,`
                               `day=<day_of_week>,`
                               `hour=<hour>
        ```


    You can change the following settings:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    * `--datalens-access`: Enables access from {{ datalens-name }}. The default value is `false`. For more information about setting up a connection, see [Connecting from {{ datalens-name }}](datalens-connect.md).


    * `--metrika-access`: Enables [data import from AppMetrica to your cluster](https://appmetrica.yandex.com/docs/common/cloud/about.html). The default value is `false`.

    * `--serverless-access`: Enables cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md). The default value is `false`. For more information about setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md) documentation.


    * `--websql-access`: Enables you to [run SQL queries](web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}. The default value is `false`.


    * `--yandexquery-access=true`: Enables cluster access from [{{ yq-full-name }}](../../query/concepts/index.md). This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage. Default value: `false`.

    * {% include [deletion-protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * `--maintenance-window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters), where `type` is the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    You can get the cluster ID and name [with a list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. To change the backup start time, add a `backup_window_start` block to the {{ mch-name }} cluster description:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          backup_window_start {
            hours   = <backup_start_hour>
            minutes = <backup_start_minute>
          }
          ...
        }
        ```

    1. To enable cluster access from other services and allow [running SQL queries from the management console](web-sql-query.md) using {{ websql-full-name }}, change the values of the appropriate fields in the `access` section:


        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          access {
            data_lens    = <access_from_{{ datalens-name }}>
            metrika      = <access_from_Metrica_and_AppMetrica>
            serverless   = <access_from_Cloud_Functions>
            web_sql      = <run_SQL_queries_from_management_console>
            yandex_query = <access_from_Yandex_Query>
          }
          ...
        }
        ```


        Where:

        * `data_lens`: Access from {{ datalens-name }}, `true` or `false`.


        * `metrika`: Access from Yandex Metrica and AppMetrica, `true` or `false`.
        * `serverless`: Access from {{ sf-name }}, `true` or `false`.


        * `yandex_query`: Access from {{ yq-full-name }}, `true` or `false`.
        * `web_sql`: Execution of SQL queries from the management console, `true` or `false`.

    1. {% include [Maintenance window](../../_includes/mdb/mch/terraform/maintenance-window.md) %}

    1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          deletion_protection = <cluster_deletion_protection>
        }
        ```

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

    To change additional cluster settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

    * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
    * Settings for access from other services and access to SQL queries from the management console using {{ websql-full-name }} in the `configSpec.access` parameter.
    * Backup window settings in the `configSpec.backupWindowStart` parameter.
    * [Maintenance](../concepts/maintenance.md) window settings (including for disabled clusters) in the `maintenanceWindow` parameter.
    * Cluster deletion protection settings in the `deletionProtection` parameter.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * List of cluster configuration fields to update in the `updateMask` parameter.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the cluster you want to move.
    1. Select **{{ ui-key.yacloud.common.move }}**.
    1. Select a folder you want to move the cluster to.
    1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To move a cluster:

    1. View a description of the CLI move cluster command:

        ```bash
        {{ yc-mdb-ch }} cluster move --help
        ```

    1. Specify the destination folder in the move cluster command:

        ```bash
        {{ yc-mdb-ch }} cluster move <cluster_name_or_ID> \
           --destination-folder-name=<destination_folder_name>
        ```

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API {#api}

    To move a cluster, use the [move](../api-ref/Cluster/move.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Move](../api-ref/grpc/Cluster/move.md) gRPC API call and provide the following in the request:

    * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
    * ID of the destination folder in the `destinationFolderId` parameter.

{% endlist %}


## Changing security groups {#change-sg-set}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select security groups for cluster network traffic.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

  1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-ch }} cluster update --help
      ```

  1. Specify the security groups in the update cluster command:

      ```bash
      {{ yc-mdb-ch }} cluster update <cluster_name> \
         --security-group-ids <list_of_security_group_IDs>
      ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. Change the value of the `security_group_ids` parameter in the cluster description:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          security_group_ids = [ <list_of_cluster_security_group_IDs> ]
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

  To update security groups, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

  * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * List of security group IDs in the `securityGroupIds` parameter.
  * List of settings to update, in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect/index.md#configuring-security-groups) to connect to the cluster.

{% endnote %}


## Changing hybrid storage settings {#change-hybrid-storage}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change [hybrid storage settings](../concepts/storage.md#hybrid-storage-settings):

  1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-ch }} cluster update --help
      ```

  1. If hybrid storage is disabled in the cluster, enable it:

      ```bash
      {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
          --cloud-storage=true
      ```

      {% include [Hybrid Storage cannot be switched off](../../_includes/mdb/mch/hybrid-storage-cannot-be-switched-off.md) %}

  1. Provide a list of settings to update:

      ```bash
      {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
          --cloud-storage-data-cache=<file_storage> \
          --cloud-storage-data-cache-max-size=<memory_size_in_bytes> \
          --cloud-storage-move-factor=<percentage_of_free_space> \
          --cloud-storage-prefer-not-to-merge=<merge_data_parts>
      ```

      You can change the following settings:

      {% include [Hybrid Storage settings CLI](../../_includes/mdb/mch/hybrid-storage-settings-cli.md) %}

- API {#api}

  To change hybrid storage settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

  * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  * `true` value in the `configSpec.cloudStorage.enabled` parameter if hybrid storage is not enabled.

    {% include [Hybrid Storage cannot be switched off](../../_includes/mdb/mch/hybrid-storage-cannot-be-switched-off.md) %}

  * The [hybrid storage settings](../concepts/storage.md#hybrid-storage-settings) in the `configSpec.cloudStorage` parameters:

      {% include [Hybrid Storage settings API](../../_includes/mdb/mch/hybrid-storage-settings-api.md) %}

  * List of settings to update, in the `updateMask` parameter.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
