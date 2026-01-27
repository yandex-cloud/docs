---
title: How to update {{ PG }} cluster settings in {{ mpg-full-name }}
description: In this guide, you will learn how to update {{ PG }} cluster settings.
---

# Updating {{ PG }} cluster settings

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).

* [Configure servers](#change-postgresql-config) as described in the [{{ PG }} guides](https://www.postgresql.org/docs/current/runtime-config.html).

* [Change additional cluster settings](#change-additional-settings).

* [Manually switch the master host](#start-manual-failover).

* [Move the cluster](#move-cluster) to another folder.


* [Change cluster security groups](#change-sg-set).


{% note info %}

All configuration changes require the cluster to be running.

{% endnote %}

Learn more about other cluster updates:

* [{{ PG }} version upgrade](cluster-version-update.md).

* [Managing disk space](storage-space.md).

* [Migrating cluster hosts to a different availability zone](host-migration.md).

## Changing the host class {#change-resource-preset}

{% note info %}

Some {{ PG }} settings [depend on the selected host class](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

When changing the host class:

* A single-host cluster will be unavailable for a few minutes and all database connections will be dropped.
* A multi-host cluster will switch to a new master host Each host will undergo a rolling update and will be unavailable for a few minutes while it updates.
* Using a [special FQDN](./connect.md#special-fqdns) does not guarantee a stable database connection: user sessions may be terminated.

We recommend changing the host class only when your cluster has no active workload.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Select your cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select the {{ PG }} host class.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [host class](../concepts/instance-types.md) for a cluster:

  1. View the description of the CLI command for updating a cluster:

      ```bash
      {{ yc-mdb-pg }} cluster update --help
      ```

  1. Request a list of available host classes. The `ZONE IDS` column lists the availability zones where the relevant class can be selected:

     
     ```bash
     {{ yc-mdb-pg }} resource-preset list
     ```

     ```text
     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 8.0 GB   |
     |           | {{ region-id }}-d                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```


  1. Specify the relevant class in the cluster update command:

      ```bash
      {{ yc-mdb-pg }} cluster update <cluster_name_or_ID> \
          --resource-preset <host_class_ID>
      ```

      {{ mpg-short-name }} will start updating the host class for your cluster.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      To learn how to create this file, see [Creating a cluster](cluster-create.md).

      For a complete list of {{ mpg-name }} cluster configuration fields you can update, see [this {{ TF }} provider guide]({{ tf-provider-mpg }}).

  1. In the {{ mpg-name }} cluster description, update the `resource_preset_id` attribute value under `config.resources`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
        ...
        config {
          resources {
            resource_preset_id = "<host_class>"
            ...
          }
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>' \
       --data '{
                 "updateMask": "configSpec.resources.resourcePresetId",
                 "configSpec": {
                   "resources": {
                     "resourcePresetId": "<host_class>"
                   }
                 }
               }'
     ```

     Where:

     * `updateMask`: Comma-separated string of settings you want to update.

       Here, we provide only one setting.

     * `configSpec.resources.resourcePresetId`: New [host class](../concepts/instance-types.md).

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "update_mask": {
               "paths": [
                 "config_spec.resources.resource_preset_id"
               ]
             },
             "config_spec": {
               "resources": {
                 "resource_preset_id": "<host_class>"
               }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Where:

     * `update_mask`: List of parameters to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * `config_spec.resources.resource_preset_id`: New [host class](../concepts/instance-types.md).

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure your request was successful.

{% endlist %}

## Updating {{ PG }} settings {#change-postgresql-config}

You can change the DBMS settings for the hosts in your cluster.

{% note warning %}

* You cannot change {{ PG }} settings using SQL commands.
* Some {{ PG }} settings [depend on the selected host class or storage size](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Select your cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Change the [{{ PG }} settings](../concepts/settings-list.md) by clicking **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** under **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
  1. Click **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update the [{{ PG }} settings](../concepts/settings-list.md):

  1. View the full list of cluster settings:

     ```bash
     {{ yc-mdb-pg }} cluster get <cluster_name_or_ID> --full
     ```

  1. View the description of the CLI command for updating the cluster configuration:

      ```bash
      {{ yc-mdb-pg }} cluster update-config --help
      ```

  1. Set the parameter values as needed:

      All supported arguments are listed in the `postgresqlConfig_<{{ PG }}_version>` field of the [ `update` method’s request format](../api-ref/Cluster/update.md). To specify an argument name in the CLI call, convert its name from <q>lowerCamelCase</q> to <q>snake_case</q>. For example, the `maxPreparedTransactions` argument from the API request becomes `max_prepared_transactions` for the CLI command:

      ```bash
      {{ yc-mdb-pg }} cluster update-config <cluster_name_or_ID> \
         --set <parameter_1_name>=<value_1>,<parameter_2_name>=<value_2>,...
      ```

      {{ mpg-short-name }} will start updating the cluster settings.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

        For a complete list of {{ mpg-name }} cluster configuration fields you can update, see [this {{ TF }} provider guide]({{ tf-provider-mpg }}).

    1. Update the settings in the `config.postgresql_config` section of your {{ mpg-short-name }} cluster description. If there is no such section, create one.

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
          ...
          config {
            ...
            postgresql_config = {
              max_connections                   = <maximum_number_of_connections>
              enable_parallel_hash              = <true_or_false>
              vacuum_cleanup_index_scale_factor = <number_between_0_and_1>
              ...
            }
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>' \
       --data '{
                 "updateMask": "configSpec.postgresqlConfig_<{{ PG }}_version>.<setting_1>,...,configSpec.postgresqlConfig_<{{ PG }}_version>.<setting_N>",
                 "configSpec": {
                   "postgresqlConfig_<{{ PG }}_version>": {
                     "<setting_1>": "<value_1>",
                     "<setting_2>": "<value_2>",
                     ...
                     "<setting_N>": "<value_N>"
                   }
                 }
               }'
     ```

     Where:

     * `updateMask`: Comma-separated string of settings you want to update.

       List all {{ PG }} settings you want to update.

     * `configSpec.postgresqlConfig_<{{ PG }}_version>`: {{ PG }} settings. Enter each setting on a new line, separated by commas.

       See the [method description](../api-ref/Cluster/update.md#yandex.cloud.mdb.postgresql.v1.UpdateClusterRequest) for the list of {{ PG }} versions supporting this option. See [{#T}](../concepts/settings-list.md#dbms-cluster-settings) for the descriptions and possible values of the settings.

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "update_mask": {
               "paths": [
                 "config_spec.postgresql_config_<{{ PG }}_version>.<setting_1>",
                 "config_spec.postgresql_config_<{{ PG }}_version>.<setting_2>",
                 ...,
                 "config_spec.postgresql_config_<{{ PG }}_version>.<setting_N>"
               ]
             },
             "config_spec": {
               "postgresql_config_<{{ PG }}_version>": {
                 "<setting_1>": "<value_1>",
                 "<setting_2>": "<value_2>",
                 ...
                 "<setting_N>": "<value_N>"
               }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Where:

     * `update_mask`: List of parameters to update as an array of strings (`paths[]`).

       List all {{ PG }} settings you want to update.

     * `config_spec.postgresql_config_<{{ PG }}_version>`: {{ PG }} settings. Specify each setting on a new line, separated by commas.

       See the [method description](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.ConfigSpec) for the list of {{ PG }} versions supporting this option. See [{#T}](../concepts/settings-list.md#dbms-cluster-settings) for the descriptions and possible values of the settings.

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure your request was successful.

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% note warning %}

Changing additional settings will restart the cluster. The only exceptions are the maintenance window and deletion protection settings.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Select your cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  
  
  1. {% include [diagnostics-settings-console](../../_includes/mdb/mpg/diagnostics-settings-console.md) %}
  

  1. Update additional cluster settings:

     {% include [mpg-extra-settings](../../_includes/mdb/mpg/extra-settings-web-console.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change additional cluster settings:

    1. View the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-pg }} cluster update --help
        ```

    1. Run the following command with the list of settings you want to update:

        ```bash
        {{ yc-mdb-pg }} cluster update <cluster_name_or_ID> \
            --backup-window-start <backup_start_time> \
            --backup-retain-period-days=<automatic_backup_retention_period_in_days> \
            --datalens-access=<allow_access_from_{{ datalens-name }}> \
            --maintenance-window type=<maintenance_type>,`
                                `day=<day_of_week>,`
                                `hour=<hour> \
            --websql-access=<allow_access_from_{{ websql-name }}> \
            --deletion-protection \
            --connection-pooling-mode=<connection_pooler_mode> \
            --serverless-access=<allow_access_from_Serverless_Containers> \
            --yandexquery-access=<allow_access_from_Yandex_Query> \
            --performance-diagnostics enabled=<enable_statistics_collection>,`
                                     `sessions-sampling-interval=<session_sampling_interval>,`
                                     `statements-sampling-interval=<statement_sampling_interval>
        ```

    You can update the following settings:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    * `--backup-retain-period-days`: Automatic backup retention period, in days.

    * `--datalens-access`: Enables access from DataLens. The default value is `false`. To learn more about configuring a connection, see [Connecting to a cluster from {{ datalens-name }}](datalens-connect.md).

    * `--maintenance-window`: [Maintenance window](../concepts/maintenance.md) settings (including for stopped clusters), where `type` is the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * `--websql-access`: Enables running [SQL queries](web-sql-query.md) on cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}. The default value is `false`.
    
    
    * `--serverless-access`: Enables access to the cluster from [{{ sf-full-name }}](../../functions/concepts/index.md). The default value is `false`. For more information about setting up access, see [this {{ sf-name }} guide](../../functions/operations/database-connection.md).

    * `--yandexquery-access`: Enables access to the cluster from [{{ yq-full-name }}](../../query/concepts/index.md). This feature is in the [Preview](../../overview/concepts/launch-stages.md) stage and can be enabled upon request.


    * `--connection-pooling-mode`: Specifies the [connection pooler mode](../concepts/pooling.md) (`SESSION`, `TRANSACTION`, or `STATEMENT`).

    * `--deletion-protection`: Deletion protection for the cluster, its databases, and users.

        By default, when users and databases are created, this setting’s value is inherited from the cluster. You can also specify this setting manually. See [User management](cluster-users.md) and [Database management](databases.md) for details.

        If the setting is changed on a running cluster, the new value will only be inherited by users and databases with the **Same as cluster** protection level.

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

    
    * `--performance-diagnostics`: [Statistics collection](./performance-diagnostics.md#activate-stats-collector) settings:

        * `enabled`: The value of `true` enables statistics collection. The default value is `false`.
        * `sessions-sampling-interval`: Session sampling interval in seconds. Allowed values range from `1` to `86400`.
        * `statements-sampling-interval`: Statement sampling interval in seconds. Allowed values range from `60` to `86400`.


    You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      To learn how to create this file, see [Creating a cluster](cluster-create.md).

      For a complete list of {{ mpg-name }} cluster configuration fields you can update, see [this {{ TF }} provider guide]({{ tf-provider-mpg }}).

  1. To change the backup start time, add the `config.backup_window_start` section to the {{ mpg-name }} cluster description:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
        ...
        config {
          backup_window_start {
            hours   = <backup_start_hour>
            minutes = <backup_start_minute>
          }
          ...
        }
      }
      ```

  1. To allow access to the cluster from {{ datalens-full-name }} and to enable [running SQL queries from the management console](web-sql-query.md) using {{ websql-full-name }}, update the relevant fields in the `config.access` section:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
        ...
        config {
          access {
            data_lens = <allow_access_from_{{ datalens-name }}>
            web_sql   = <allow_access_from_{{ websql-name }}>
            ...
        }
        ...
      }
      ```

      Where:

      * `data_lens`: Access from {{ datalens-name }}, `true` or `false`.
      * `web_sql`: Execution of SQL queries from the management console using {{ websql-full-name }} (`true` or `false`).

  1. To change the [connection pooler mode](../concepts/pooling.md), add a `config.pooler_config` section to the {{ mpg-name }} cluster description:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
        ...
        config {
          pooler_config {
            pool_discard = <clear_client_states_after_each_transaction>
            pooling_mode = "<operation_mode>"
          }
          ...
        }
      }
      ```

      Where:

      * `pool_discard`: Defines whether clients should discard their state after each transaction, `true` or `false`.
      * `pooling_mode`: Operation mode, `SESSION`, `TRANSACTION`, or `STATEMENT`.

  1. {% include [Maintenance window](../../_includes/mdb/mpg/terraform/maintenance-window.md) %}

  
  1. {% include [Performance diagnostics](../../_includes/mdb/mpg/terraform/performance-diagnostics.md) %}


  1. To protect your cluster, its databases, and users against accidental deletion, add the `deletion_protection` field set to `true` to your cluster description:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
        ...
        deletion_protection = <protect_cluster_from_deletion>
      }
      ```

      `deletion_protection`: Protection of the cluster, its databases, and users against deletion (`true` or `false`).

      By default, when users and databases are created, this setting’s value is inherited from the cluster. You can also specify this setting manually. See [User management](cluster-users.md) and [Database management](databases.md) for details.

      If the setting is changed on a running cluster, the new value will only be inherited by users and databases with the **Same as cluster** protection level.

      {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     
     ```json
     {
       "updateMask": "configSpec.poolerConfig,configSpec.backupWindowStart,configSpec.backupRetainPeriodDays,configSpec.access,configSpec.performanceDiagnostics.sessionsSamplingInterval,configSpec.performanceDiagnostics.statementsSamplingInterval,maintenanceWindow,deletionProtection",
       "configSpec": {
         "poolerConfig": {
           "poolingMode": "<connection_pooling_mode>",
           "poolDiscard": <clear_client_states_after_each_transaction>
         },
         "backupWindowStart": {
           "hours": "<hours>",
           "minutes": "<minutes>",
           "seconds": "<seconds>",
           "nanos": "<nanoseconds>"
         },
         "backupRetainPeriodDays": "<number_of_days>",
         "access": {
           "dataLens": <allow_access_from_{{ datalens-name }}>,
           "webSql": <allow_access_from_{{ websql-name }}>,
           "serverless": <allow_access_from_Cloud_Functions>,
           "dataTransfer": <allow_access_from_Data_Transfer>,
           "yandexQuery": <allow_access_from_{{ yq-name }}>
         },
         "performanceDiagnostics": {
           "enabled": <enable_statistics_collection>,
           "sessionsSamplingInterval": "<session_sampling_interval>",
           "statementsSamplingInterval": "<statement_sampling_interval>"
         }
       },
       "maintenanceWindow": {
         "weeklyMaintenanceWindow": {
           "day": "<day_of_week>",
           "hour": "<hour>"
         }
       },
       "deletionProtection": <protect_cluster_from_deletion>
     }
     ```


     Where:

     * `updateMask`: Comma-separated string of settings you want to update.
     * `configSpec`: Cluster settings:

       * `poolerConfig`: Connection pooler settings:

         * `poolingMode`: Connection pooler's operation mode. Possible values: `SESSION`, `TRANSACTION`, and `STATEMENT`. To learn more about each mode, see [{#T}](../concepts/pooling.md).
         * `poolDiscard`: Defines whether clients should discard their state after each transaction, `true` or `false`. Corresponds to the [server_reset_query_always](https://www.pgbouncer.org/config.html) option for the [PgBouncer](https://www.pgbouncer.org/usage) connection pooler.

       * `backupWindowStart`: [Backup](../concepts/backup.md) window settings.

         Here, specify the backup start time. Allowed values:

         * `hours`: From `0` to `23` hours.
         * `minutes`: From `0` to `59` minutes.
         * `seconds`: From `0` to `59` seconds.
         * `nanos`: From `0` to `999999999` nanoseconds.

       * `backupRetainPeriodDays`: Number of days to retain the cluster backup. Possible values: between `7` and `60` days.

       
       * `access`: Cluster access settings for the following {{ yandex-cloud }} services:

         * `dataLens`: [{{ datalens-full-name }}](../../datalens/index.yaml)
         * `webSql`: [{{ websql-full-name }}](../../websql/index.yaml)
         * `serverless`: [{{ sf-full-name }}](../../functions/index.yaml)
         * `dataTransfer`: [{{ data-transfer-full-name }}](../../data-transfer/index.yaml)
         * `yandexQuery`: [{{ yq-full-name }}](../../query/index.yaml)

         The possible values are `true` or `false`.


       
       * `performanceDiagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:

         * `enabled`: Enables statistics collection, `true` or `false`.
         * `sessionsSamplingInterval`: Session sampling interval. The values range from `1` to `86400` seconds.
         * `statementsSamplingInterval`: Statement sampling interval. The values range from `60` to `86400` seconds.


     * `maintenanceWindow`: [Maintenance](../concepts/maintenance.md) window settings, including for stopped clusters. In `maintenanceWindow`, provide one of the two values:

       * `anytime`: Maintenance can occur at any time.
       * `weeklyMaintenanceWindow`: Maintenance occurs once a week at the specified time:

         * `day`: Day of the week, in `DDD` format.
         * `hour`: Hour, in `HH` format. Allowed values range from `1` to `24` hours.

     * `deletionProtection`: Protection of the cluster, its databases, and users against deletion, `true` or `false` value.

        By default, when users and databases are created, this setting’s value is inherited from the cluster. You can also specify this setting manually. See [User management](cluster-users.md) and [Database management](databases.md) for details.

        If the setting is changed on a running cluster, the new value will only be inherited by users and databases with the **Same as cluster** protection level.

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>' \
       --data "@body.json"
     ```

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Create a file named `body.json` and paste the following code into it:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     
     ```json
     {
       "cluster_id": "<cluster_ID>",
       "update_mask": {
         "paths": [
           "config_spec.pooler_config",
           "config_spec.backup_window_start",
           "config_spec.backup_retain_period_days",
           "config_spec.access",
           "config_spec.performance_diagnostics.sessions_sampling_interval",
           "config_spec.performance_diagnostics.statements_sampling_interval",
           "maintenance_window",
           "deletion_protection"
         ]
       },
       "config_spec": {
         "pooler_config": {
           "pooling_mode": "<connection_pooling_mode>",
           "pool_discard": <clear_client_states_after_each_transaction>
         },
         "backup_window_start": {
           "hours": "<hours>",
           "minutes": "<minutes>",
           "seconds": "<seconds>",
           "nanos": "<nanoseconds>"
         },
         "backup_retain_period_days": "<number_of_days>",
         "access": {
           "data_lens": <allow_access_from_{{ datalens-name }}>,
           "web_sql": <allow_access_from_{{ websql-name }}>,
           "serverless": <allow_access_from_Cloud_Functions>,
           "data_transfer": <allow_access_from_Data_Transfer>,
           "yandex_query": <allow_access_from_{{ yq-name }}>
         },
         "performance_diagnostics": {
           "enabled": <enable_statistics_collection>,
           "sessions_sampling_interval": "<session_sampling_interval>",
           "statements_sampling_interval": "<statement_sampling_interval>"
         }
       },
       "maintenance_window": {
         "weekly_maintenance_window": {
           "day": "<day_of_week>",
           "hour": "<hour>"
         }
       },
       "deletion_protection": <protect_cluster_from_deletion>
     }
     ```


     Where:

     * `update_mask`: List of parameters to update as an array of strings (`paths[]`).
     * `config_spec`: Cluster settings:

       * `pooler_config`: Connection pooler settings:

         * `pooling_mode`: Connection pooler's operation mode. Possible values: `SESSION`, `TRANSACTION`, and `STATEMENT`. To learn more about each mode, see [{#T}](../concepts/pooling.md).
         * `pool_discard`: Defines whether clients should discard their state after each transaction, `true` or `false`. Corresponds to the [server_reset_query_always](https://www.pgbouncer.org/config.html) option for the [PgBouncer](https://www.pgbouncer.org/usage) connection pooler.

       * `backup_window_start`: [Backup](../concepts/backup.md) window settings.

         Here, specify the backup start time. Allowed values:

         * `hours`: From `0` to `23` hours.
         * `minutes`: From `0` to `59` minutes.
         * `seconds`: From `0` to `59` seconds.
         * `nanos`: From `0` to `999999999` nanoseconds.

       * `backup_retain_period_days`: Number of days to retain the cluster backup. Possible values: between `7` and `60` days.

       
       * `access`: Cluster access settings for the following {{ yandex-cloud }} services:

         * `data_lens`: [{{ datalens-full-name }}](../../datalens/index.yaml)
         * `web_sql`: [{{ websql-full-name }}](../../websql/index.yaml)
         * `serverless`: [{{ sf-full-name }}](../../functions/index.yaml)
         * `data_transfer`: [{{ data-transfer-full-name }}](../../data-transfer/index.yaml)
         * `yandex_query`: [{{ yq-full-name }}](../../query/index.yaml)

         The possible values are `true` or `false`.


       
       * `performance_diagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:

         * `enabled`: Enables statistics collection, `true` or `false`.
         * `sessions_sampling_interval`: Session sampling interval. The values range from `1` to `86400` seconds.
         * `statements_sampling_interval`: Statement sampling interval. The values range from `60` to `86400` seconds.


     * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings, including for stopped clusters. In `maintenance_window`, provide one of the two values:

       * `anytime`: Maintenance can take place at any time.
       * `weekly_maintenance_window`: Maintenance occurs once a week at the specified time:

         * `day`: Day of the week, in `DDD` format.
         * `hour`: Hour, in `HH` format. Allowed values range from `1` to `24` hours.

     * `deletion_protection`: Protection of the cluster, its databases, and users against deletion, `true` or `false` value.

        By default, when users and databases are created, this setting’s value is inherited from the cluster. You can also specify this setting manually. See [User management](cluster-users.md) and [Database management](databases.md) for details.

        If the setting is changed on a running cluster, the new value will only be inherited by users and databases with the **Same as cluster** protection level.

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d @ \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update \
       < body.json
     ```

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure your request was successful.

{% endlist %}


### {{ connection-manager-name }} {#conn-man}

If you cluster has no integration with {{ connection-manager-name }}, enable **{{ ui-key.yacloud.mdb.forms.additional-field-connman }}**. You can only do it in the [management console]({{ link-console-main }}).

The following resources will be created for each database user:

* [{{ connection-manager-name }} connection](../../metadata-hub/concepts/connection-manager.md) containing database connection details.

* [{{ lockbox-name }} secret](../../metadata-hub/concepts/secret.md) containing the user password. {{ lockbox-name }} provides secure storage for passwords.

The connection and secret will be created for each new database user. To view all connections, open the **{{ ui-key.yacloud.connection-manager.label_connections }}** tab on the cluster page.

You need the `connection-manager.viewer` role to view the connection details. You can [use {{ connection-manager-name }} to configure access to connections](../../metadata-hub/operations/connection-access.md).

{% note info %}

{{ connection-manager-name }} and secrets created with it are free of charge.

{% endnote %}


## Manual master failover {#start-manual-failover}

In a fault-tolerant multi-host {{ mpg-name }} cluster, you can perform a manual failover from the current master host to one of the replicas. Once this operation is complete, the former master host will act as a replica to the new master.

Master failover specifics in {{ mpg-name }}

* A replica with an explicitly defined replication source cannot be promoted to master.
* Unless the replica name for promotion is explicitly specified, the master will fail over to one of the quorum replicas.

To learn more, see [Replication](../concepts/replication.md).

To perform a master failover:

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and select the ![icon-hosts.svg](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.
  1. Click ![icon-autofailover.svg](../../_assets/console-icons/shuffle.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.button_manual-failover }}**.
      * To switch the master to one of the quorum replicas, leave the **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_auto }}** option enabled.
      * To switch the master to a specific replica, disable the **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_auto }}** option and select the required replica from the drop-down list.
  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_button }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run this command:

  ```bash
  {{ yc-mdb-pg }} cluster start-failover <cluster_name_or_ID> \
      --host <replica_host_name>
  ```

  You can get the replica name from the [cluster’s host list](hosts.md#list) and the cluster name from the [folder’s cluster list](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

        For a complete list of {{ mpg-name }} cluster configuration fields you can update, see [this {{ TF }} provider guide]({{ tf-provider-mpg }}).

    1. In the `host_master_name` argument, specify the name of the replica you want to promote.

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
          ...
          host_master_name = "<replica_host_name>"
        }
        ```

        Where `host_master_name` is the name of the replica host, i.e., the `name` attribute of the appropriate `host` section.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.StartFailover](../api-ref/Cluster/startFailover.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>:startFailover' \
       --data '{
                 "hostName": "<host_FQDN>"
               }'
     ```

     Where `hostName` is the [FQDN of the replica](connect.md#fqdn) promoted to master.

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/startFailover.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.StartFailover](../api-ref/grpc/Cluster/startFailover.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "host_name": "<host_FQDN>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.StartFailover
     ```

     Where `host_name` is the [FQDN of the replica](connect.md#fqdn) promoted to master.

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure your request was successful.

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the cluster you want to move.
    1. Select **{{ ui-key.yacloud.mdb.clusters.button_action-move }}**.
    1. Select the destination folder for your cluster.
    1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To move a cluster:

    1. View the description of the CLI command for moving a cluster:

        ```bash
        {{ yc-mdb-pg }} cluster move --help
        ```

    1. Specify the destination folder in the cluster move command:

        ```bash
        {{ yc-mdb-pg }} cluster move <cluster_ID> \
           --destination-folder-name=<destination_folder_name>
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](./cluster-create.md).

    1. In the {{ mpg-name }} cluster description, edit or add the `folder_id` parameter value:

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
          ...
          folder_id = "<destination_folder_ID>"
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider article]({{ tf-provider-mpg }}).

    {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.Move](../api-ref/Cluster/move.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>:move' \
       --data '{
                 "destinationFolderId": "<folder_ID>"
               }'
     ```

     Where `destinationFolderId` is the ID of the target folder for your cluster. You can get this ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/move.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.Move](../api-ref/grpc/Cluster/move.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "destination_folder_id": "<folder_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Move
     ```

     Where `destination_folder_id` is the ID of the target folder for your cluster. You can get this ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

After the move, the cluster will still use the cloud network from the original folder. To host the cluster in another cloud network, use the [restore from a backup](./cluster-backups.md) feature, specifying the target network for the restored cluster.

To move a cluster to a different availability zone, follow [this guide](host-migration.md). Following this procedure, you will move the cluster hosts.


## Updating security groups {#change-sg-set}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Select your cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select the security groups for cluster network traffic.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

  1. View the description of the CLI command for updating a cluster:

      ```bash
      {{ yc-mdb-pg }} cluster update --help
      ```

  1. Specify the security groups in the cluster update command:

      ```bash
      {{ yc-mdb-pg }} cluster update <cluster_name_or_ID> \
          --security-group-ids <list_of_security_group_IDs>
      ```

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      To learn how to create this file, see [Creating a cluster](cluster-create.md).

      For a complete list of {{ mpg-name }} cluster configuration fields you can update, see [this {{ TF }} provider guide]({{ tf-provider-mpg }}).

  1. Edit the `security_group_ids` value in the cluster description:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
        ...
        security_group_ids = [ <list_of_security_group_IDs> ]
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>' \
       --data '{
                 "updateMask": "securityGroupIds",
                 "securityGroupIds": [
                   "<security_group_1_ID>",
                   "<security_group_2_ID>",
                   ...
                   "<security_group_N_ID>"
                 ]
               }'
     ```

     Where:

     * `updateMask`: Comma-separated string of settings you want to update.

       Here, we provide only one setting.

     * `securityGroupIds`: New [security groups](../concepts/network.md#security-groups), formatted as an array.

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "update_mask": {
               "paths": [
                 "security_group_ids"
               ]
             },
             "security_group_ids": [
               "<security_group_1_ID>",
               "<security_group_2_ID>",
               ...
               "<security_group_N_ID>"
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Where:

     * `update_mask`: List of parameters to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * `security_group_ids`: New [security groups](../concepts/network.md#security-groups), formatted as an array.

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure your request was successful.

{% endlist %}

{% note warning %}

You may need to additionally [configure security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

