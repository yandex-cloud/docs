---
title: How to change {{ PG }} cluster settings in {{ mpg-full-name }}
description: In this tutorial, you will learn how to change settings for a {{ PG }} cluster.
---

# Updating {{ PG }} cluster settings

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).

* [Configure servers](#change-postgresql-config) according to the [{{ PG }} documentation](https://www.postgresql.org/docs/current/runtime-config.html).

* [Change additional cluster settings](#change-additional-settings).

* [Manually switch the master host](#start-manual-failover).

* [Move a cluster](#move-cluster) to another folder.


* [Change cluster security groups](#change-sg-set).


Learn more about other cluster updates:

* [Upgrading the {{ PG }} version](cluster-version-update.md).

* [Managing disk space](storage-space.md).

* [Migrating cluster hosts to a different availability zone](host-migration.md).

## Changing the host class {#change-resource-preset}

{% note info %}

Some {{ PG }} settings [depend on the selected host class](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

When changing the host class:

* Your single-host cluster will be unavailable for a few minutes with database connections terminated.
* Your multi-host cluster will get a new master host. Its hosts will be stopped and updated one by one. Once stopped, a host will be unavailable for a few minutes.
* Using a [special FQDN](./connect.md#special-fqdns) does not guarantee a stable database connection: user sessions may be terminated.

We recommend changing the host class only when the cluster has no active workload.

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select the required class for the {{ PG }} hosts.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [host class](../concepts/instance-types.md) for the cluster:

  1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-pg }} cluster update --help
      ```

  1. Request a list of available host classes (the `ZONE IDS` column specifies the availability zones where you can select the appropriate class):


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


  1. Specify the class in the update cluster command:

      ```bash
      {{ yc-mdb-pg }} cluster update <cluster_name_or_ID> \
          --resource-preset <host_class_ID>
      ```

      {{ mpg-short-name }} will run the update host class command for the cluster.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

  1. In the {{ mpg-name }} cluster description, change the `resource_preset_id` attribute value under `config.resources`:

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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

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

     * `updateMask`: List of parameters to update as a single string, separated by commas.

       In this case, only one parameter is provided.

     * `configSpec.resources.resourcePresetId`: New [host class](../concepts/instance-types.md).

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/update.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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

     * `update_mask`: List of parameters to update as an array of `paths[]` strings.

       In this case, only one parameter is provided.

     * `config_spec.resources.resource_preset_id`: New [host class](../concepts/instance-types.md).

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Changing {{ PG }} settings {#change-postgresql-config}

You can change the DBMS settings of the hosts in your cluster.

{% note warning %}

* You cannot change {{ PG }} settings using SQL commands.
* Some {{ PG }} settings [depend on the selected host class or storage size](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
  1. Change the [{{ PG }} settings](../concepts/settings-list.md) by clicking **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** under **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
  1. Click **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update the [{{ PG }} settings](../concepts/settings-list.md):

  1. View the full list of settings specified for the cluster:

     ```bash
     {{ yc-mdb-pg }} cluster get <cluster_name_or_ID> --full
     ```

  1. View a description of the update cluster configuration CLI command:

      ```bash
      {{ yc-mdb-pg }} cluster update-config --help
      ```

  1. Set the required parameter values:

      All supported parameters are listed in the [request format for the update method](../api-ref/Cluster/update.md), in the following field: `postgresqlConfig_<{{ PG }}_version>`. To specify a parameter name in the CLI call, convert the name from <q>lowerCamelCase</q> to <q>snake_case</q>. For example, the `maxPreparedTransactions` parameter from an API call must be converted to `max_prepared_transactions` for the CLI command:

      ```bash
      {{ yc-mdb-pg }} cluster update-config <cluster_name_or_ID> \
         --set <parameter_1_name>=<value_1>,<parameter_2_name>=<value_2>,...
      ```

      {{ mpg-short-name }} runs the update cluster settings operation.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

    1. In the {{ mpg-short-name }} cluster description, change the values of the parameters in `config.postgresql_config`. If there is no such section, create one.

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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

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

     * `updateMask`: List of parameters to update as a single string, separated by commas.

       In this case, specify all the {{ PG }} settings to update.

     * `configSpec.postgresqlConfig_<{{ PG }}_version>`: {{ PG }} settings. Use a separate line for each setting, separated by commas.

       See the [method description](../api-ref/Cluster/update.md#body_params) for the list of {{ PG }} versions available for the parameter. See [{#T}](../concepts/settings-list.md#dbms-cluster-settings) for description and possible values for each setting.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/update.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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

     * `update_mask`: List of parameters to update as an array of `paths[]` strings.

       In this case, specify all the {{ PG }} settings to update.

     * `config_spec.postgresql_config_<{{ PG }}_version>`: {{ PG }} settings. Use a separate line for each setting, separated by commas.

       See the [method description](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.ConfigSpec) for the list of {{ PG }} versions available for the parameter. See [{#T}](../concepts/settings-list.md#dbms-cluster-settings) for description and possible values for each setting.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% note warning %}

Changing additional settings will cause the cluster to restart. The exceptions are the maintenance window settings and deletion protection settings.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
  1. Change additional cluster settings:

     {% include [mpg-extra-settings](../../_includes/mdb/mpg/extra-settings-web-console.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change additional cluster settings:

    1. View a description of the update cluster CLI command:

        ```bash
        {{ yc-mdb-pg }} cluster update --help
        ```

    1. Run the following command with a list of settings to update:


        ```bash
        {{ yc-mdb-pg }} cluster update <cluster_name_or_ID> \
            --backup-window-start <backup_start_time> \
            --datalens-access=<true_or_false> \
            --maintenance-window type=<maintenance_type>,`
                                `day=<day_of_week>,`
                                `hour=<hour> \
            --websql-access=<true_or_false> \
            --deletion-protection=<deletion_protection> \
            --connection-pooling-mode=<connection_pooler_mode> \
            --serverless-access=<true_or_false> \
            --yandexquery-access=<access_via_{{ yq-name }}> \
            --performance-diagnostics enabled=<true_or_false>,`
                                     `sessions-sampling-interval=<session_sampling_interval>,`
                                     `statements-sampling-interval=<statement_sampling_interval>
        ```



    You can change the following settings:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    * `--datalens-access`: Enables access from DataLens. The default value is `false`. For more information on setting up a connection, see [Connecting to a cluster from {{ datalens-name }}](datalens-connect.md).

    * `--maintenance-window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters), where `type` is the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * `--websql-access`: Enables you to [run SQL queries](web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}. The default value is `false`.


    * `--serverless-access`: Enables cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md). The default value is `false`. For more information about setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md) documentation.

    * `--yandexquery-access`: Enables cluster access from [{{ yq-full-name }}](../../query/concepts/index.md). This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage and provided upon request.


    * `--autofailover`: Manages automatic master change setup. To learn more, see [Replication](../concepts/replication.md#replication-auto). The default value is `true`.

    * `--connection-pooling-mode`: Specifies the [connection pooler mode](../concepts/pooling.md) (`SESSION`, `TRANSACTION`, or `STATEMENT`).

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        By default, the parameter inherits its value from the cluster when creating users and databases. You can also set the value manually; for more information, see the [User management](cluster-users.md) and [Database management](databases.md) sections.

        If the parameter is changed on a running cluster, only users and databases with the **Same as cluster** protection will inherit the new value.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * `--performance-diagnostics`: Settings for [collecting statistics](./performance-diagnostics.md#activate-stats-collector):

        * `enabled`: If `true`, enables collecting statistics. The default value is `false`.
        * `sessions-sampling-interval`: Session sampling interval, seconds. The values range from `1` to `86400`.
        * `statements-sampling-interval`: Statement sampling interval, seconds. The values range from `60` to `86400`.

    You can [get the cluster name with a list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

  1. To change the backup start time, add a `config.backup_window_start` block to the {{ mpg-name }} cluster description:

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

  1. To enable access from {{ datalens-full-name }} and allow [execution of SQL queries from the management console](web-sql-query.md) using {{ websql-full-name }}, change the values of the appropriate fields in the `config.access` section:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
        ...
        config {
          access {
            data_lens = <access_from_{{ datalens-name }}>
            web_sql   = <run_SQL_queries_from_management_console>
            ...
        }
        ...
      }
      ```

      Where:

      * `data_lens`: Access from {{ datalens-name }}, `true` or `false`.
      * `web_sql`: Execution of SQL queries from the management console using {{ websql-full-name }} (`true` or `false`).

  1. To change the [connection pooler mode](../concepts/pooling.md), add the `config.pooler_config` section to the {{ mpg-name }} cluster description:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
        ...
        config {
          pooler_config {
            pool_discard = <Odyssey_parameter>
            pooling_mode = "<operation_mode>"
          }
          ...
        }
      }
      ```

      Where:

      * `pool_discard`: Odyssey `pool_discard` parameter, `true` or `false`.
      * `pooling_mode`: Operation mode, `SESSION`, `TRANSACTION`, or `STATEMENT`.

  1. {% include [Maintenance window](../../_includes/mdb/mpg/terraform/maintenance-window.md) %}

  1. {% include [Performance diagnostics](../../_includes/mdb/mpg/terraform/performance-diagnostics.md) %}

  1. To enable protection of the cluster, its databases, and users against accidental deletion, add the `deletion_protection` field set to `true` to your cluster description:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
        ...
        deletion_protection = <deletion_protection>
      }
      ```

      `deletion_protection`: Protection of the cluster, its databases, and users against deletion (`true` or `false`).

      By default, the parameter inherits its value from the cluster when creating users and databases. You can also set the value manually; for more information, see the [User management](cluster-users.md) and [Database management](databases.md) sections.

      If the parameter is changed on a running cluster, only users and databases with the **Same as cluster** protection will inherit the new value.

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}


     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>' \
       --data '{
                 "updateMask": "configSpec.poolerConfig,configSpec.backupWindowStart,configSpec.backupRetainPeriodDays,configSpec.access,configSpec.performanceDiagnostics.sessionsSamplingInterval,configSpec.performanceDiagnostics.statementsSamplingInterval,maintenanceWindow,deletionProtection",
                 "configSpec": {
                   "poolerConfig": {
                     "poolingMode": "<connection_pooling_mode>",
                     "poolDiscard": <discard_client_state_after_each_transaction:_true_or_false>
                   },
                   "backupWindowStart": {
                     "hours": "<hours>",
                     "minutes": "<minutes>",
                     "seconds": "<seconds>",
                     "nanos": "<nanoseconds>"
                   },
                   "backupRetainPeriodDays": "<number_of_days>",
                   "access": {
                     "dataLens": <access_to_{{ datalens-name }}:_true_or_false>,
                     "webSql": <access_to_{{ websql-name }}:_true_or_false>,
                     "serverless": <access_to_Cloud_Functions:_true_or_false>,
                     "dataTransfer": <access_to_Data_Transfer:_true_or_false>,
                     "yandexQuery": <access_to_{{ yq-name }}:_true_or_false>
                   },
                   "performanceDiagnostics": {
                     "enabled": <activate_statistics_collection:_true_or_false>,
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
                 "deletionProtection": <deletion_protection:_true_or_false>
               }'
     ```


     Where:

     * `updateMask`: List of parameters to update as a single string, separated by commas.
     * `configSpec`: Cluster settings:

       * `poolerConfig`: Connection pooler settings:

         * `poolingMode`: Connection pooler's operation mode. Possible values: `SESSION`, `TRANSACTION`, and `STATEMENT`. For more information on each of the modes, see [{#T}](../concepts/pooling.md).
         * `poolDiscard`: Whether clients discard their states after each transaction. Similar to the [server_reset_query_always](https://www.pgbouncer.org/config.html) for the [PgBouncer](https://www.pgbouncer.org/usage) connection pooler.

       * `backupWindowStart`: [Backup](../concepts/backup.md) window settings.

         In the parameter, specify the time to start backup. Possible values:

         * `hours`: Between `60` and `86400` hours.
         * `minutes`: Between `0` and `59` minutes.
         * `seconds`: Between `0` and `59` seconds.
         * `nanos`: Between `0` and `999999999` nanoseconds.

       * `backupRetainPeriodDays`: The number of days to retain a backup of the cluster. Possible values: between `7` and `60` days.


       * `access`: Settings of the cluster access to the following {{ yandex-cloud }} services:

         * `dataLens`: [{{ datalens-full-name }}](../../datalens/index.yaml).
         * `webSql`: [{{ websql-full-name }}](../../websql/index.yaml).
         * `serverless`: [{{ sf-full-name }}](../../functions/index.yaml).
         * `dataTransfer`: [{{ data-transfer-full-name }}](../../data-transfer/index.yaml).
         * `yandexQuery`: [{{ yq-full-name }}](../../query/index.yaml).


       * `performanceDiagnostics`: Settings for [collecting statistics](performance-diagnostics.md#activate-stats-collector):

         * `enabled`: Enable collecting statistics.
         * `sessionsSamplingInterval`: Session sampling interval. The values range from `1` to `86400` seconds.
         * `statementsSamplingInterval`: Statement sampling interval. The values range from `60` to `86400` seconds.

     * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters). In `maintenanceWindow`, provide one of the two parameters:

       * `ANYTIME`: Maintenance can take place at any time.
       * `weeklyMaintenanceWindow`: Maintenance takes place once a week at the specified time:

         * `day`: Day of week, in `DDD` format.
         * `hour`: Hour, in `HH` format. The values range from `1` to `24` hours.

     * `deletionProtection`: Protection of the cluster, its databases, and users against deletion.

       By default, the parameter inherits its value from the cluster when creating users and databases. You can also set the value manually; for more information, see the [User management](cluster-users.md) and [Database management](databases.md) sections.

        If the parameter is changed on a running cluster, only users and databases with the **Same as cluster** protection will inherit the new value.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/update.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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
                 "pool_discard": <discard_client_state_after_each_transaction:_true_or_false>
               },
               "backup_window_start": {
                 "hours": "<hours>",
                 "minutes": "<minutes>",
                 "seconds": "<seconds>",
                 "nanos": "<nanoseconds>"
               },
               "backup_retain_period_days": "<number_of_days>",
               "access": {
                 "data_lens": <access_to_{{ datalens-name }}:_true_or_false>,
                 "web_sql": <access_to_{{ websql-name }}:_true_or_false>,
                 "serverless": <access_to_Cloud_Functions:_true_or_false>,
                 "data_transfer": <access_to_Data_Transfer:_true_or_false>,
                 "yandex_query": <access_to_{{ yq-name }}:_true_or_false>
               },
               "performance_diagnostics": {
                 "enabled": <activate_statistics_collection:_true_or_false>,
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
             "deletion_protection": <deletion_protection:_true_or_false>
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```


     * `update_mask`: List of parameters to update as an array of `paths[]` strings.
     * `config_spec`: Cluster settings:

       * `pooler_config`: Connection pooler settings:

         * `pooling_mode`: Connection pooler's operation mode. Possible values: `SESSION`, `TRANSACTION`, and `STATEMENT`. For more information on each of the modes, see [{#T}](../concepts/pooling.md).
         * `pool_discard`: Whether clients discard their states after each transaction. Similar to the [server_reset_query_always](https://www.pgbouncer.org/config.html) for the [PgBouncer](https://www.pgbouncer.org/usage) connection pooler.

       * `backup_window_start`: [Backup](../concepts/backup.md) window settings.

         In the parameter, specify the time to start backup. Possible values:

         * `hours`: Between `60` and `86400` hours.
         * `minutes`: Between `0` and `59` minutes.
         * `seconds`: Between `0` and `59` seconds.
         * `nanos`: Between `0` and `999999999` nanoseconds.

       * `backup_retain_period_days`: The number of days to retain a backup of the cluster. Possible values: between `7` and `60` days.


       * `access`: Settings of the cluster access to the following {{ yandex-cloud }} services:

         * `data_lens`: [{{ datalens-full-name }}](../../datalens/index.yaml)
         * `web_sql`: [{{ websql-full-name }}](../../websql/index.yaml)
         * `serverless`: [{{ sf-full-name }}](../../functions/index.yaml)
         * `data_transfer`: [{{ data-transfer-full-name }}](../../data-transfer/index.yaml)
         * `yandex_query`: [{{ yq-full-name }}](../../query/index.yaml)


       * `performance_diagnostics`: Settings for [collecting statistics](performance-diagnostics.md#activate-stats-collector):

         * `enabled`: Enable collecting statistics.
         * `sessions_sampling_interval`: Session sampling interval. The values range from `1` to `86400` seconds.
         * `statements_sampling_interval`: Statement sampling interval. The values range from `60` to `86400` seconds.

     * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings (including those for disabled clusters). In `maintenance_window`, provide one of the two parameters:

       * `ANYTIME`: Maintenance can take place at any time.
       * `weekly_maintenance_window`: Maintenance takes place once a week at the specified time:

         * `day`: Day of week, in `DDD` format.
         * `hour`: Hour, in `HH` format. The values range from `1` to `24` hours.

     * `deletion_protection`: Protection of the cluster, its databases, and users against deletion.

       By default, the parameter inherits its value from the cluster when creating users and databases. You can also set the value manually; for more information, see the [User management](cluster-users.md) and [Database management](databases.md) sections.

        If the parameter is changed on a running cluster, only users and databases with the **Same as cluster** protection will inherit the new value.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Manually switching the master {#start-manual-failover}

In a fault-tolerant {{ mpg-name }} cluster with multiple hosts, you can switch the master role from the current master host to one of the replicas. After this operation, the current master host becomes the replica host of the new master.

Specifics of switching master hosts in {{ mpg-name }}

* You cannot switch the master host to a replica for which the source of the replication stream is explicitly given.
* If you do not specify the replica host name explicitly, the master host will switch to one of the quorum replicas.

To learn more, see [Replication](../concepts/replication.md).

To switch the master:

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of the cluster you need and select the ![icon-hosts.svg](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.
  1. Click ![icon-autofailover.svg](../../_assets/console-icons/shuffle.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.button_manual-failover }}**.
      * To switch the master to one of the quorum replicas, leave the **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_auto }}** option enabled.
      * To switch the master to a specific replica, disable the **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_auto }}** option and then select the required replica from the drop-down list.
  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_button }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run this command:

  ```bash
  {{ yc-mdb-pg }} cluster start-failover <cluster_name_or_ID> \
      --host <replica_host_name>
  ```

  You can request the replica host name with a [list of cluster hosts](hosts.md#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

    1. In the `host_master_name` parameter, specify the name of the replica host to switch to.

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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.startFailover](../api-ref/Cluster/startFailover.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

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

     Where `hostName` is the [FQDN of the replica](connect.md#fqdn) to become the master host.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/startFailover.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/StartFailover](../api-ref/grpc/Cluster/startFailover.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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

     Where `host_name` is the [FQDN of the replica](connect.md#fqdn) to become the master host.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure the request was successful.

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the cluster you want to move.
    1. Select **{{ ui-key.yacloud.mdb.clusters.button_action-move }}**.
    1. Select a folder you want to move the cluster to.
    1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To move a cluster:

    1. View a description of the CLI move cluster command:

        ```bash
        {{ yc-mdb-pg }} cluster move --help
        ```

    1. Specify the destination folder in the move cluster command:

        ```bash
        {{ yc-mdb-pg }} cluster move <cluster_ID> \
           --destination-folder-name=<destination_folder_name>
        ```

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.move](../api-ref/Cluster/move.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

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

     Where `destinationFolderId` is the ID of the folder to which you want to move your cluster. You can fetch this ID along with the [list of folders](../../resource-manager/operations/folder/get-id.md) in the cloud.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/move.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/Move](../api-ref/grpc/Cluster/move.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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

     Where `destination_folder_id` is the ID of the folder to which you want to move your cluster. You can fetch this ID along with the [list of folders](../../resource-manager/operations/folder/get-id.md) in the cloud.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

After the cluster is moved, it will continue using the cloud network from the source folder. If you want to host the cluster in a different cloud network, use the [restore from a backup](./cluster-backups.md) feature and specify the required network for the cluster backup.

To move a cluster to a different availability zone, follow [this guide](host-migration.md). You will thus move the cluster hosts.


## Changing security groups {#change-sg-set}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select security groups for cluster network traffic.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

  1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-pg }} cluster update --help
      ```

  1. Specify the security groups in the update cluster command:

      ```bash
      {{ yc-mdb-pg }} cluster update <cluster_name_or_ID> \
          --security-group-ids <list_of_security_group_IDs>
      ```

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

  1. Change the value of the `security_group_ids` parameter in the cluster description:

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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

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

     * `updateMask`: List of parameters to update as a single string, separated by commas.

       In this case, only one parameter is provided.

     * `securityGroupIds`: New list of [security groups](../concepts/network.md#security-groups), in the array-like form.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/update.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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

     * `update_mask`: List of parameters to update as an array of `paths[]` strings.

       In this case, only one parameter is provided.

     * `security_group_ids`: New list of [security groups](../concepts/network.md#security-groups), in the array-like form.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure the request was successful.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

