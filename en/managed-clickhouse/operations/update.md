# Changing {{ CH }} cluster settings

After creating a cluster, you can:

* [Change service account settings](#change-service-account).

* [{#T}](#change-resource-preset).

* [{#T}](#change-disk-size).

* [{#T}](#SQL-management).

* [Configure the {{ CH }} servers](#change-clickhouse-config) according to the [{{ CH }} documentation]({{ ch.docs }}/operations/server-configuration-parameters/settings).

* [Change additional cluster settings](#change-additional-settings).

* [Move a cluster](#move-cluster) to another folder.


* [Change cluster security groups](#change-sg-set).


## Change service account settings {#change-service-account}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   
   1. Under **Service settings**, select the desired service account from the list or [create a new one](../../iam/operations/sa/create.md). For more information about setting up service accounts, see [{#T}](s3-access.md).


        {% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

{% endlist %}

## Changing the host class {#change-resource-preset}

{% note info %}

In clusters with {{ CK }}, {{ ZK }} hosts cannot be used. For more information, see [{#T}](../concepts/replication.md).

{% endnote %}

Host class affects the amount of RAM that {{ CH }} can use. For more information, see [{#T}](../concepts/memory-management.md).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. To change the {{ CH }} host class, select the platform, VM type, and the desired host class under **Resources**.
   1. To change the {{ ZK }} host class, select the platform, VM type, and the desired {{ ZK }} host class under **{{ ZK }} host class**.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the [host class](../concepts/instance-types.md) for the cluster:

   1. View a description of the CLI's update cluster command:

      ```
      {{ yc-mdb-ch }} cluster update --help
      ```

   1. Request a list of available host classes (the `ZONES` column specifies the availability zones where you can select the appropriate class):

      
      ```bash
      {{ yc-mdb-ch }} resource-preset list

      +-----------+--------------------------------+-------+----------+
      |    ID     |            ZONE IDS            | CORES |  MEMORY  |
      +-----------+--------------------------------+-------+----------+
      | s1.micro  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 8.0 GB   |
      |           | {{ region-id }}-c                  |       |          |
      | ...                                                           |
      +-----------+--------------------------------+-------+----------+
      ```


   1. Specify the class in the update cluster command:

      ```
      {{ yc-mdb-ch }} cluster update <cluster name> \
         --clickhouse-resource-preset <class ID>
      ```

      {{ mch-short-name }} will run the update host class command for the cluster.

   1. To change the class of a {{ ZK }} host, pass the desired value in the `--zookeeper-resource-preset` parameter.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mch-name }} cluster description, change the value of the `resource_preset_id` parameter in the `clickhouse.resources` and `zookeeper.resources` blocks for {{ CH }} and {{ ZK }} hosts, respectively:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        clickhouse {
          resources {
            resource_preset_id = "<{{ CH }} host class>"
            ...
          }
        }
        zookeeper {
          resources {
            resource_preset_id = "<{{ ZK }} host class>"
            ...
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * Required values in the `configSpec.clickhouse.resources.resourcePresetId` parameter (`configSpec.zookeeper.resources.resourcePresetId` for ZooKeeper).

      To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for `ResourcePreset` resources.

   * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Increasing storage size {#change-disk-size}

{% note info %}

In clusters with {{ CK }}, {{ ZK }} hosts cannot be used. For more information, see [{#T}](../concepts/replication.md).

{% endnote %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Management console

   To increase a cluster's storage size:

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. Under **Storage size**, specify the required value.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To increase a cluster's storage size:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-ch }} cluster update --help
      ```

   1. Specify the required amount of storage in the  cluster update command (it must be at least as large as `disk_size` in the cluster properties):

      ```bash
      {{ yc-mdb-ch }} cluster update <cluster name or ID> \
       --clickhouse-disk-size <storage size in GB>
      ```

   1. To increase the storage capacity of {{ ZK }} hosts, pass the desired value in the `--zookeeper-disk-size` parameter.

- {{ TF }}

   To increase storage size:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mch-name }} cluster description, change the value of the `disk_size` parameter in the `clickhouse.resources` and `zookeeper.resources` blocks for {{ CH }} and {{ ZK }}, respectively:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        clickhouse {
          resources {
            disk_size = <storage size in gigabytes>
            ...
          }
        }
        zookeeper {
          resources {
            disk_size = <storage size in gigabytes>
            ...
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To increase storage size, use the API [update](../api-ref/Cluster/update.md) method and pass the following in in the call:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * The required amount of the {{ CH }} host storage in the `configSpec.clickhouse.resources.diskSize` parameter.
   * The required amount of the {{ ZK }} host storage in the `configSpec.zookeeper.resources.diskSize` parameter.
   * List of cluster configuration fields to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Enabling user and database management via SQL {#SQL-management}

The {{ mch-name }} service lets enable cluster [user](./cluster-users.md#sql-user-management) and [database](./databases.md#sql-database-management) management via SQL.

{% note alert %}

This disables user and database management through other interfaces.

Once enabled, user and database management settings for SQL cannot be disabled.

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mch-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. To [manage users via SQL](./cluster-users.md#sql-user-management), enable the **User management via SQL** setting under **DBMS settings** and specify the password of the `admin` user.
   1. To [manage databases via SQL](./databases.md#sql-database-management), enable the **User management via SQL** and **Database management via SQL** settings under **DBMS settings** and specify the password of the `admin` user.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. To enable [SQL user management](./cluster-users.md#sql-user-management):

      * set `--enable-sql-user-management` to `true`.
      * Set a password for the `admin` user in the `--admin-password` parameter.

      ```bash
      {{ yc-mdb-ch }} cluster update <cluster name or ID>\
         ...
         --enable-sql-user-management true \
         --admin-password "<admin account password>"
      ```

   1. To enable [SQL database management](./databases.md#sql-database-management):

      * Set `--enable-sql-user-management` and `--enable-sql-database-management` to `true`;
      * Set a password for the `admin` user in the `--admin-password` parameter.

      ```bash
      {{ yc-mdb-ch }} cluster update <cluster name or ID>\
         ...
         --enable-sql-user-management true \
         --enable-sql-database-management true \
         --admin-password "<admin account password>"
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. {% include [Enable SQL user management with Terraform](../../_includes/mdb/mch/terraform/sql-management-users.md) %}

   1. {% include [Enable SQL database management with Terraform](../../_includes/mdb/mch/terraform/sql-management-databases.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   Use the API [update](../api-ref/Cluster/update.md) method and pass all the requisite values in the `configSpec.clickhouse.config` parameter:

   * `sqlUserManagement`: Set to `true` to enable [user management via SQL](cluster-users.md#sql-user-management).
   * `sqlDatabaseManagement`: Set to `true` to enable [database management via SQL](databases.md#sql-database-management). User management via SQL needs to be enabled.
   * `adminPassword`: Set a password for the `admin` account to use for management tasks.

{% endlist %}

## Changing {{ CH }} settings {#change-clickhouse-config}

{% note info %}

You can only update the value of [Max server memory usage]({{ ch.docs }}/operations/server-configuration-parameters/settings/#max_server_memory_usage) by [changing the {{ CH }} host class](#change-resource-preset).

For more information, see [{#T}](../concepts/memory-management.md).

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. Change the [{{ CH }} settings](../concepts/settings-list.md#dbms-cluster-settings) by clicking **Configure** under **DBMS settings**:
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change [{{ CH }} server](../concepts/settings-list.md) settings:

   1. View the full list of settings specified for the cluster:

      ```bash
      {{ yc-mdb-ch }} cluster get <cluster ID or name> --full
      ```

   1. View a description of the CLI's update cluster configuration command:

      ```bash
      {{ yc-mdb-ch }} cluster update-config --help
      ```

   1. Set the required parameter values:

      ```bash
      {{ yc-mdb-ch }} cluster update-config <cluster ID or name> \
           --set <parameter1 name>=<value1>,...
      ```

      {{ mch-short-name }} runs the update cluster settings operation.

      All the supported parameters are listed in the [description of settings for{{ CH }}](../concepts/settings-list.md).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mch-name }} cluster description, change the values of the parameters in the `clickhouse.config` block:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        clickhouse {
          ...

          config {
            # General DBMS settings
            ...

            merge_tree {
              # MergeTree engine settings
              ...
            }

            kafka {
              # General settings to get data from Apache Kafka
              ...
            }

            kafka_topic {
              # Settings for an individual Apache Kafka topic
              ...
            }

            rabbit_mq {
              # Settings to get data from {{ RMQ }}
              username = "<username>"
              password = "<password>"
            }

            compression {
              # Data compression settings
              method              = "<compression algorithm: LZ4 or ZSTD>"
              min_part_size       = <minimum table data chunk size in bytes>
              min_part_size_ratio = <ratio of smallest data chunk size to full table size>
            }

            graphite_rollup {
              # GraphiteMergeTree engine settings for thinning and aggregation/averaging
              # (rollup) of Graphite data.
              ...
            }
          }
        ...
        }
      ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * Required values in the `configSpec.clickhouse.config` parameter.

      All supported settings are described in [{#T}](../concepts/settings-list.md#dbms-cluster-settings) and the [API reference](../api-ref/Cluster/update.md).

   * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. Under **Service settings**, change the additional cluster settings:

      {% include [mch-extra-settings](../../_includes/mdb/mch/extra-settings-web-console.md) %}

   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change additional cluster settings:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-ch }} cluster update --help
      ```

   1. Run the command with a list of settings to update:

      ```bash
      {{ yc-mdb-ch }} cluster update <cluster ID or name> \
         --backup-window-start <backup start time> \
         --datalens-access=<true or false> \
         --maintenance-window type=<maintenance-window type: anytime or weekly>,`
                             `day=<day of the week for the weekly type>,`
                             `hour=<hour of the day for the weekly type> \
         --metrika-access=<true or false> \
         --websql-access=<true or false> \
         --serverless-access=<true or false> \
         --datatransfer-access=<true or false> \
         --deletion-protection=<cluster deletion protection: true or false>
      ```

   You can change the following settings:

   {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

   
   * `--datalens-access`: Enables DataLens access. Default value: `false`. For more information about setting up a connection, see [{#T}](datalens-connect.md).
   

   * `--maintenance-window`: Settings for the [maintenance window](../concepts/maintenance.md) (including disabled clusters):

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

   * `--metrika-access`: Enables [data import from AppMetrika to your cluster](https://appmetrica.yandex.com/docs/common/cloud/about.html). Default value: `false`.

   * `--websql-access`: Enables [SQL queries to be run](web-sql-query.md) from the management console. Default value: `false`.
      
   * `--serverless-access`: Enables cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md). Default value: `false`. For more detail on setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md).


   * {% include [datatransfer access](../../_includes/mdb/cli/datatransfer-access-update.md) %}

   * {% include [deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

      {% include [deletion protection limits db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   You can find out the cluster ID and name in the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. To change the backup start time, add a `backup_window_start` block to the {{ mch-name }} cluster description:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        backup_window_start {
          hours   = <backup start hour>
          minutes = <backup start minute>
        }
        ...
      }
      ```

   1. To allow access from other services and [execution of SQL queries from the management console](web-sql-query.md), change the values of the appropriate fields in the `access` block:

      
      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        access {
          data_lens  = <Access from DataLens: true or false>
          metrika    = <Access from Yandex.Metrica and AppMetrica: true or false>
          serverless = <Access from Cloud Functions: true or false>
          web_sql    = <Run SQL queries from the management console: true or false>
        }
        ...
      }
      ```



   1. {% include [Maintenance window](../../_includes/mdb/mch/terraform/maintenance-window.md) %}

   1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        deletion_protection = <protect cluster from deletion: true or false>
      }
      ```

      {% include [deletion protection limits db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * Settings for access from other services and access to SQL queries from the management console in the `configSpec.access parameter`.
   * Backup window settings in the `configSpec.backupWindowStart` parameter.
   * Settings for the [maintenance window](../concepts/maintenance.md) (including for disabled clusters) in the `maintenanceWindow` parameter.
   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion protection limits db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   * List of cluster configuration fields to update in the `UpdateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}


      
   To allow cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md), pass `true` for the `configSpec.access.serverless` parameter. For more detail on setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md).


   {% include [datatransfer access](../../_includes/mdb/api/datatransfer-access-create.md) %}


{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mch-name }}**.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon to the right of the cluster you wish to move.
   1. Click **Move**.
   1. Select the folder you want to move the cluster to.
   1. Click **Move**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To move a cluster:

   1. View a description of the CLI move cluster command:

      ```bash
      {{ yc-mdb-ch }} cluster move --help
      ```

   1. Specify the destination folder in the move cluster command:

      ```bash
      {{ yc-mdb-ch }} cluster move <cluster ID> \
         --destination-folder-name=<destination folder name>
      ```

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [move](../api-ref/Cluster/move.md) API method and pass the following in the query:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The ID of the destination folder in the `destinationFolderId parameter`.

{% endlist %}


## Changing security groups {#change-sg-set}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. Under **Network settings**, select security groups for cluster network traffic.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

   1. View a description of the CLI's update cluster command:

      ```
      {{ yc-mdb-ch }} cluster update --help
      ```

   1. Specify the security groups in the update cluster command:

      ```
      {{ yc-mdb-ch }} cluster update <cluster name> \
         --security-group-ids <security group ID list>
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Change the value of the `security_group_ids` parameter in the cluster description:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        security_group_ids = ["<list of cluster security group IDs>"]
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The list of security group IDs in the `securityGroupIds` parameter.
   * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}


## Changing hybrid storage settings {#change-hybrid-storage}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change [hybrid storage settings](../concepts/storage.md#hybrid-storage-settings):

   1. View a description of the CLI's update cluster command:

      ```
      {{ yc-mdb-ch }} cluster update --help
      ```

   1. If hybrid storage is disabled in the cluster, enable it:

      ```bash
      {{ yc-mdb-ch }} cluster update <cluster name> \
          --cloud-storage=true
      ```

      {% include [Hybrid Storage cannot be switched off](../../_includes/mdb/mch/hybrid-storage-cannot-be-switched-off.md) %}

   1. Pass a list of settings to update:

      ```bash
      {{ yc-mdb-ch }} cluster update <cluster name> \
          --cloud-storage-data-cache=<true or false> \
          --cloud-storage-data-cache-max-size=<amount of memory (in bytes)> \
          --cloud-storage-move-factor=<share of free space>
      ```

      You can change the following settings:

      {% include [Hybrid Storage settings CLI](../../_includes/mdb/mch/hybrid-storage-settings-cli.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The `true` value in the `configSpec.cloudStorage.enabled` parameter if hybrid storage is not enabled.

      {% include [Hybrid Storage cannot be switched off](../../_includes/mdb/mch/hybrid-storage-cannot-be-switched-off.md) %}

   * The [hybrid storage settings](../concepts/storage.md#hybrid-storage-settings) in the `configSpec.cloudStorage` parameters:

      {% include [Hybrid Storage settings API](../../_includes/mdb/mch/hybrid-storage-settings-api.md) %}

   * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
