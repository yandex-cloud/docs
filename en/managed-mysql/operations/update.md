---
title: How to change {{ MY }} cluster settings in {{ mmy-full-name }}
description: In this tutorial, you will learn how to change {{ MY }} cluster settings.
---

# Updating {{ MY }} cluster settings

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).
* [Change the disk type and increase the storage size](#change-disk-size).
* [Changing {{ MY }} settings](#change-mysql-config).

    {% note warning %}

    You cannot change {{ MY }} settings using SQL commands.

    {% endnote %}

* [Change additional cluster settings](#change-additional-settings).
* [Manually switch the master host](#start-manual-failover).
* [Move the cluster](#move-cluster) to another folder.
* [Edit security groups](#change-sg-set).

Learn more about other cluster updates:

* [{#T}](cluster-version-update.md).
* [Migrating cluster hosts to a different availability zone](host-migration.md).

## Changing the host class {#change-resource-preset}

The choice of a [host class](../concepts/instance-types.md) in {{ mmy-short-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources currently in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.

{% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}

When changing the host class:

* Your single-host cluster will be unavailable for a few minutes with database connections terminated.
* Your multi-host cluster will get a new master host. Its hosts will be stopped and updated one by one. Once stopped, a host will be unavailable for a few minutes.
* Using a [special FQDN](./connect.md#fqdn-master) does not guarantee a stable database connection: user sessions may be terminated.

We recommend changing the host class only when your cluster has no active workload.

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. To change the class of {{ MY }} hosts, under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select the required class.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the host class for a cluster:

  1. View the description of the CLI command for updating a cluster:

      ```bash
      {{ yc-mdb-my }} cluster update --help
      ```

  1. Get the list of available host classes (the `ZONE IDS` column specifies the availability zones where you can select the appropriate class):

     
     ```bash
     {{ yc-mdb-my }} resource-preset list
     ```

     Result:

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
      {{ yc-mdb-my }} cluster update <cluster_name_or_ID>
        --resource-preset <class_ID>
      ```

      {{ mmy-short-name }} will run the update host class command for the cluster.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      For more information about creating this file, see [this guide](./cluster-create.md).

  1. In the {{ mmy-name }} cluster description, edit the `resource_preset_id` parameter under `resources`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        resources {
          resource_preset_id = "<host_class>"
          ...
        }
      }
      ```

  1. Validate your configuration.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see this [{{ TF }} provider guide]({{ tf-provider-mmy }}).

    {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>' \
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

      * `updateMask`: Comma-separated list of settings you want to update.

          Here, we provide only one setting.

      * `configSpec.resources.resourcePresetId`: New host class.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
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
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Where:

      * `update_mask`: List of settings you want to update as an array of `paths[]` strings.

          Here, we provide only one setting.

      * `config_spec.resources.resource_preset_id`: New host class.

      You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Change the disk type and increase the storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  To change the disk type and increase the storage size for a cluster:

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

      * Select the [disk type](../concepts/storage.md).
      * Specify the required disk size.

  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the disk type and increase the storage size for a cluster:

  1. View the description of the CLI command for updating a cluster:

      ```bash
      {{ yc-mdb-my }} cluster update --help
      ```

  1. Specify the [disk type](../concepts/storage.md) and required storage size in the cluster update command (at least as large as `disk_size` in the cluster properties):

      ```bash
      {{ yc-mdb-my }} cluster update <cluster_name_or_ID> \
        --disk-type <disk_type> \
        --disk-size <storage_size_in_GB>
      ```

- {{ TF }} {#tf}

  To change the disk type and increase the storage size for a cluster:

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      For more information about creating this file, see [this guide](./cluster-create.md).

  1. Under `resources`, change the `disk_type_id` and `disk_size` parameter values:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        resources {
          disk_type_id = "<disk_type>"
          disk_size    = <storage_size_in_GB>
          ...
        }
      }
      ```

  1. Validate your configuration.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see this [{{ TF }} provider guide]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>' \
          --data '{
                    "updateMask": "configSpec.resources.diskTypeId,configSpec.resources.diskSize",
                    "configSpec": {
                      "resources": {
                        "diskTypeId": "<disk_type>",
                        "diskSize": "<storage_size_in_bytes>"
                      }
                    }
                  }'
      ```

      Where:

      * `updateMask`: Comma-separated list of settings you want to update.

      * `configSpec.resources`: Storage parameters:

          * `diskTypeId`: [Disk type](../concepts/storage.md).
          * `diskSize`: New storage size in bytes.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "update_mask": {
                  "paths": [
                    "config_spec.resources.disk_type_id",
                    "config_spec.resources.disk_size"
                  ]
                },
                "config_spec": {
                  "resources": {
                    "disk_type_id": "<disk_type>",
                    "disk_size": "<storage_size_in_bytes>"
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Where:

      * `update_mask`: List of settings you want to update as an array of `paths[]` strings.

      * `config_spec.resources`: Storage parameters:

          * `disk_type_id`: [Disk type](../concepts/storage.md).
          * `disk_size`: New storage size in bytes.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing {{ MY }} settings {#change-mysql-config}

{% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Configure the [{{ MY }}](../concepts/settings-list.md#dbms-cluster-settings) settings by clicking **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** under **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
  1. Click **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update the [{{ MY }} settings](../concepts/settings-list.md#dbms-cluster-settings):

  1. View the description of the CLI command to update the cluster configuration:

      ```bash
      {{ yc-mdb-my }} cluster update-config --help
      ```

  1. Set the required parameter values.

     All supported parameters are listed in the [request format for the update method](../api-ref/Cluster/update.md), in the `mysql_config_5_7` field. To specify a parameter name in the CLI call, convert its name from <q>lowerCamelCase</q> to <q>snake_case</q>. For example, convert the `logMinDurationStatement` parameter from an API request to `log_min_duration_statement` for the CLI command:

     ```bash
     {{ yc-mdb-my }} cluster update-config <cluster_name>
       --set log_min_duration_statement=100,<parameter_name>=<value>,...
     ```

     {{ mmy-short-name }} runs the update cluster settings operation.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      For more information about creating this file, see [this guide](./cluster-create.md).

  1. In the {{ mmy-name }} cluster description, add or update the [DBMS settings](../concepts/settings-list.md) under `mysql_config`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        mysql_config = {
          <{{ MY }}_setting_name> = <value>
          ...
        }
      }
      ```

  1. Validate your configuration.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see this [{{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_mysql_cluster#mysql-config).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>' \
          --data '{
                    "updateMask": "configSpec.mysqlConfig_<{{ MY }}_version>",
                    "configSpec": {
                      "mysqlConfig_<{{ MY }}_version>": {
                        "<setting_1>": "<value_1>",
                        "<setting_2>": "<value_2>",
                        ...
                        "<setting_N>": "<value_N>"
                      }
                    }
                  }'
      ```

      Where:

      * `updateMask`: Comma-separated list of settings you want to update.

          Here, we provide only one setting.

      * `configSpec.mysqlConfig_<{{ MY }}_version>`: {{ MY }} settings. Use a separate line for each setting; separate them by commas.

          See the [method description](../api-ref/Cluster/update.md#yandex.cloud.mdb.mysql.v1.UpdateClusterRequest) for the list of {{ MY }} versions available for the parameter. See [{#T}](../concepts/settings-list.md#dbms-cluster-settings) for a description and possible values for each setting.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "update_mask": {
                  "paths": [
                    "config_spec.mysql_config_<{{ MY }}_version>"
                  ]
                },
                "config_spec": {
                  "mysql_config_<{{ MY }}_version>": {
                    "<setting_1>": "<value_1>",
                    "<setting_2>": "<value_2>",
                    ...
                    "<setting_N>": "<value_N>"
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Where:

      * `update_mask`: List of settings you want to update as an array of `paths[]` strings.

          Here, we provide only one setting.

      * `configSpec.mysqlConfig_<{{ MY }}_version>`: {{ MY }} settings. Use a separate line for each setting; separate them by commas.

          See the [method description](../api-ref/Cluster/update.md#yandex.cloud.mdb.mysql.v1.UpdateClusterReques) for the list of {{ MY }} versions available for the parameter. See [{#T}](../concepts/settings-list.md#dbms-cluster-settings) for a description and possible values for each setting.

      You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

For more information on how to update the {{ MY }} settings, see [FAQ](../qa/configuring.md).

## Changing additional cluster settings {#change-additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Change additional cluster settings:

     - **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}**
       
       {% include [disk-size-autoscaling-console](../../_includes/mdb/mmy/disk-size-autoscaling-console.md) %}

     {% include [mmy-extra-settings](../../_includes/mdb/mmy-extra-settings-web-console.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change additional cluster settings:

    1. View the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-my }} cluster update --help
        ```

    1. Run the following command with the list of settings to update:

        
        ```bash
        {{ yc-mdb-my }} cluster update <cluster_name_or_ID> \
          --backup-window-start <backup_start_time> \
          --backup-retain-period-days=<backup_retention_period> \
          --datalens-access=<true_or_false> \
          --websql-access=<true_or_false> \
          --yandexquery-access=<true_or_false> \
          --disk-size-autoscaling disk-size-limit=<maximum_storage_size_in_GB>,`
                                 `planned-usage-threshold=<threshold_for_scheduled_increase_in_percent>,`
                                 `emergency-usage-threshold=<threshold_for_immediate_increase_in_percent> \
          --maintenance-window type=<maintenance_type>,`
                              `day=<day_of_week>,`
                              `hour=<hour> \
          --deletion-protection \
          --performance-diagnostics enabled=true,`
                                   `sessions-sampling-interval=<session_sampling_interval>,`
                                   `statements-sampling-interval=<statement_sampling_interval>
        ```


    You can update the following settings:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    * `--backup-retain-period-days`: Automatic backup retention period, in days. The valid values range from `7` to `60`. The default value is `7`.

    * `--datalens-access`: Enables access to the cluster from {{ datalens-name }}. The default value is `false`. For more information about setting up a connection, see [{#T}](datalens-connect.md).

    * `--websql-access`: Enables [SQL queries](web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}. The default value is `false`.

    * `--yandexquery-access`: Enables YQL queries against cluster databases from [{{ yq-full-name }}](../../query/concepts/index.md). This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage. The default value is `false`.


    {% include [disk-size-autoscaling-cli](../../_includes/mdb/mmy/disk-size-autoscaling-cli.md) %}

    * `--maintenance-window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters), where `type` is the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * `performance-diagnostics`: Enabling statistics collection for [cluster performance diagnostics](performance-diagnostics.md). For `sessions-sampling-interval` and `statements-sampling-interval`, possible values range from `1` to `86400` seconds.

    You can [get the cluster name with the list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      For more information about creating this file, see [this guide](cluster-create.md).

  1. To change the backup start time, add a `backup_window_start` block to the {{ mmy-name }} cluster description:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        backup_window_start {
          hours   = <hour>
          minutes = <minute>
        }
        ...
      }
      ```

      Where:

      * `hours`: Backup start hour.
      * `minutes`: Backup start minute.

  1. To change the backup retention period, specify the `backup_retain_period_days` parameter in the cluster description:

      ```hcl
        resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
          ...
          backup_retain_period_days = <backup_retention_period>
          ...
        }
      ```

      Where `backup_retain_period_days` is automatic backup retention period, in days. The valid values range from `7` to `60`. The default value is `7`.

  1. {% include [Access settings](../../_includes/mdb/mmy/terraform/access-settings.md) %}

  1. {% include [disk-size-autoscaling](../../_includes/mdb/mmy/terraform/disk-size-autoscaling.md) %}

  1. {% include [Maintenance window](../../_includes/mdb/mmy/terraform/maintenance-window.md) %}

  1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        deletion_protection = <protect_cluster_from_deletion>
      }
      ```

      Where `deletion_protection` is protection against accidental cluster deletion: `true` or `false`.

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

  1. To enable statistics collection for [cluster performance diagnostics](performance-diagnostics.md), add a `performance_diagnostics` block to your {{ mmy-name }} cluster description:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        performance_diagnostics {
          enabled = true
          sessions_sampling_interval = <session_sampling_interval>
          statements_sampling_interval = <statement_sampling_interval>
        }
        ...
      }
      ```

      For `sessions_sampling_interval` and `statements_sampling_interval`, possible values range from `1` to `86400` seconds.

  1. Validate your configuration.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see this [{{ TF }} provider guide]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      
      ```json
      {
          "updateMask": "configSpec.backupWindowStart,configSpec.backupRetainPeriodDays,configSpec.access,configSpec.performanceDiagnostics,maintenanceWindow,deletionProtection",
          "configSpec": {
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
                  "yandexQuery": <allow_access_from_Yandex_Query>
              },
              "performanceDiagnostics": {
                  "enabled": <enable_statistics_collection>,
                  "sessionsSamplingInterval": "<session_sampling_interval>",
                  "statementsSamplingInterval": "<statement_sampling_interval>"
              },
              "diskSizeAutoscaling": {
                  "plannedUsageThreshold": "<threshold_for_scheduled_increase_in_percent>",
                  "emergencyUsageThreshold": "<threshold_for_immediate_increase_in_percent>",
                  "diskSizeLimit": "<maximum_storage_size_in_bytes>"
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

      * `updateMask`: Comma-separated list of settings you want to update.
      * `configSpec`: Cluster settings:

          * `backupWindowStart`: [Backup](../concepts/backup.md) window settings.

              In this parameter, specify the backup start time:

              * `hours`: Between `0` and `23` hours.
              * `minutes`: Between `0` and `59` minutes.
              * `seconds`: Between `0` and `59` seconds.
              * `nanos`: Between `0` and `999999999` nanoseconds.

          * `backupRetainPeriodDays`: Number of days to retain the cluster backup, between `7` and `60`.

          * `access`: Settings for cluster access from {{ yandex-cloud }} services:

            * `dataLens`: Access from {{ datalens-name }}. For more information about setting up a connection, see [Connecting from {{ datalens-name }}](datalens-connect.md).
            * `webSql`: [SQL queries](web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}.
            * `yandexQuery`: YQL queries against cluster databases from [{{ yq-full-name }}](../../query/concepts/index.md). This feature is currently in [Preview](../../overview/concepts/launch-stages.md).


            The possible setting values are `true` or `false`.

          * `performanceDiagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:

              * `enabled`: Enables statistics collection, `true` or `false`.
              * `sessionsSamplingInterval`: Session sampling interval, from `1` to `86400` seconds.
              * `statementsSamplingInterval`: Statement sampling interval, from `1` to `86400` seconds.
          
          {% include [disk-size-autoscaling-rest](../../_includes/mdb/mmy/disk-size-autoscaling-rest.md) %}

      {% include [maintenance-window-rest](../../_includes/mdb/mmy/maintenance-window-rest.md) %}

      * `deletionProtection`: Cluster protection from accidental deletion, `true` or `false`.

          {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

  1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>' \
          --data "@body.json"
      ```

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Create a file named `body.json` and paste the following code into it:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      
      ```json
      {
          "cluster_id": "<cluster_ID>",
          "update_mask": {
              "paths": [
                  "config_spec.backup_window_start",
                  "config_spec.backup_retain_period_days",
                  "config_spec.access",
                  "config_spec.performance_diagnostics",
                  "maintenance_window",
                  "deletion_protection"
              ]
          },
          "config_spec": {
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
                  "yandex_query": <allow_access_from_Yandex_Query>
              },
              "performance_diagnostics": {
                  "enabled": <enable_statistics_collection>,
                  "sessions_sampling_interval": "<session_sampling_interval>",
                  "statements_sampling_interval": "<statement_sampling_interval>"
              },
              "disk_size_autoscaling": {
                  "planned_usage_threshold": "<threshold_for_scheduled_increase_in_percent>",
                  "emergency_usage_threshold": "<threshold_for_immediate_increase_in_percent>",
                  "disk_size_limit": "<maximum_storage_size_in_bytes>"
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

      * `update_mask`: List of settings you want to update as an array of `paths[]` strings.
      * `config_spec`: Cluster settings:

          * `backup_window_start`: [Backup](../concepts/backup.md) window settings.

              In this parameter, specify the backup start time:

              * `hours`: Between `0` and `23` hours.
              * `minutes`: Between `0` and `59` minutes.
              * `seconds`: Between `0` and `59` seconds.
              * `nanos`: Between `0` and `999999999` nanoseconds.

          * `backup_retain_period_days`: Number of days to retain the cluster backup, between `7` and `60`.

          * `access`: Settings for cluster access from {{ yandex-cloud }} services:

              * `data_lens`: Access from {{ datalens-name }}. For more information about setting up a connection, see [Connecting from {{ datalens-name }}](datalens-connect.md).
              * `web_sql`: [SQL queries](web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}.
              * `yandex_query`: YQL queries against cluster databases from [{{ yq-full-name }}](../../query/concepts/index.md). This feature is currently in [Preview](../../overview/concepts/launch-stages.md).


              The possible setting values are `true` or `false`.

          * `performance_diagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:

              * `enabled`: Enables statistics collection, `true` or `false`.
              * `sessions_sampling_interval`: Session sampling interval, from `1` to `86400` seconds.
              * `statements_sampling_interval`: Statement sampling interval, from `1` to `86400` seconds.

          {% include [disk-size-autoscaling-grpc](../../_includes/mdb/mmy/disk-size-autoscaling-grpc.md) %}

      {% include [maintenance-window-grpc](../../_includes/mdb/mmy/maintenance-window-grpc.md) %}

      * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`.

          {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Update \
          < body.json
      ```

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


### {{ connection-manager-name }} {#conn-man}

If you cluster has no integration with {{ connection-manager-name }}, enable **{{ ui-key.yacloud.mdb.forms.additional-field-connman }}**. It is only available in the [management console]({{ link-console-main }}).

The following resources will be created for each database user:

* [{{ connection-manager-name }} connection](../../metadata-hub/concepts/connection-manager.md) with information about the database connection.

* [{{ lockbox-name }} secret](../../metadata-hub/concepts/secret.md) with the user password. Storing passwords in {{ lockbox-name }} ensures their security.

  The connection and secret will be created for each new database user. To view all connections, select the **{{ ui-key.yacloud.connection-manager.label_connections }}** tab on the cluster page.

  You need the `connection-manager.viewer` role to view connection info. You can [use {{ connection-manager-name }}](../../metadata-hub/operations/connection-access.md) to configure access to connections.

  {% note info %}

  {{ connection-manager-name }} and secrets created with it are free of charge.

  {% endnote %}


## Manually switching the master {#start-manual-failover}

In a [highly available {{ mmy-name }} cluster](../concepts/high-availability.md) with multiple hosts, you can switch the master role from the current master host to one of the replicas. After this operation, the current master host becomes the replica host of the new master.

Specifics of switching master hosts in {{ mmy-name }}:

* You cannot assign the master role to a cascading replica.
* If you do not explicitly specify the replica host name, the master will switch to the replica with the highest priority or the smallest lag.

To learn more, see [Replication](../concepts/replication.md).

To switch the master:

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name and select the ![icon-hosts.svg](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
  1. Click ![icon-autofailover.svg](../../_assets/console-icons/shuffle.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.button_manual-failover }}**.
      * To switch the master to one of the replicas, leave the **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_auto }}** option enabled.
      * To switch the master to a specific replica, disable the **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_auto }}** option and then select the required replica from the drop-down list.
  1. Click **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_button }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run this command:

  ```bash
  {{ yc-mdb-my }} cluster start-failover <cluster_name_or_ID> \
      --host <replica_host_name>
  ```

  You can request the replica host name with the [list of cluster hosts](hosts.md#list) and the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.StartFailover](../api-ref/Cluster/startFailover.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>:startFailover' \
       --data '{
                 "hostName": "<host_FQDN>"
               }'
     ```

     Where `hostName` is the [FQDN of the replica](connect.md#fqdn) which becomes the master host.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/startFailover.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.StartFailover](../api-ref/grpc/Cluster/startFailover.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "host_name": "<host_FQDN>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mysql.v1.ClusterService.StartFailover
     ```

     Where `host_name` is the [FQDN of the replica](connect.md#fqdn) which becomes the master host.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/startFailover.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the cluster you want to move.
    1. Select **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.
    1. Select the folder you want to move your cluster to.
    1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To move a cluster:

    1. See the description of the CLI command for moving a cluster:

        ```bash
        {{ yc-mdb-my }} cluster move --help
        ```

    1. Specify the destination folder in that command:

        ```bash
        {{ yc-mdb-my }} cluster move <cluster_ID> \
           --destination-folder-name=<destination_folder_name>
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For more information about creating this file, see [this guide](./cluster-create.md).

    1. In the {{ mmy-name }} cluster description, edit or add the `folder_id` value:

        ```hcl
        resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
          ...
          folder_id = "<destination_folder_ID>"
        }
        ```

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see this [{{ TF }} provider guide]({{ tf-provider-mmy }}).

    {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.move](../api-ref/Cluster/move.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>:move' \
          --data '{
                    "destinationFolderId": "<folder_ID>"
                  }'
      ```

      Where `destinationFolderId` is the ID of the folder you want to move your cluster to. You can fetch this ID together with the [list of folders](../../resource-manager/operations/folder/get-id.md) in the cloud.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/move.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/Move](../api-ref/grpc/Cluster/move.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "destination_folder_id": "<folder_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Move
      ```

      Where `destination_folder_id` is the ID of the folder you want to move your cluster to. You can fetch this ID together with the [list of folders](../../resource-manager/operations/folder/get-id.md) in the cloud.

      You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/move.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


## Changing security groups {#change-sg-set}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select security groups for cluster network traffic.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

    1. View the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-my }} cluster update --help
        ```

    1. Specify the security groups in that command:

        ```bash
        {{ yc-mdb-my }} cluster update <cluster_name_or_ID> \
          --security-group-ids <list_of_security_group_IDs>
        ```

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      For more information about creating this file, see [this guide](./cluster-create.md).

  1. Edit the `security_group_ids` parameter in the {{ mmy-name }} cluster description:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
        ...
        security_group_ids = [<list_of_security_group_IDs>]
      }
      ```

  1. Validate your configuration.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see this [{{ TF }} provider guide]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>' \
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

      * `updateMask`: Comma-separated list of settings you want to update.

          Here, we provide only one setting.

      * `securityGroupIds`: New list of [security groups](../concepts/network.md#security-groups) presented in the form of array elements.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
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
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Where:

      * `update_mask`: List of settings you want to update as an array of `paths[]` strings.

          Here, we provide only one setting.

      * `security_group_ids`: New list of [security groups](../concepts/network.md#security-groups) presented in the form of array elements.

      You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect.md#configure-security-groups) to connect to the cluster.

{% endnote %}

