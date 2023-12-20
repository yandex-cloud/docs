---
title: "How to change {{ MG }} cluster settings in {{ mmg-full-name }}"
description: "Follow this guide to change {{ MG }} cluster settings."
---

# Changing {{ MG }} cluster settings

After creating a cluster, you can:

- [Change the host class](#change-resource-preset).

- [{#T}](#change-disk-size).

- Configure [{{ MG }} servers](#change-mongod-config) as described in the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/configuration-options/).

- [Change additional cluster settings](#change-additional-settings).

- [Move a cluster](#move-cluster) to another folder.


- [{#T}](#change-sg-set).


To move a cluster to a different availability zone, see this [guide](host-migration.md). You will thus move the cluster hosts.

## Changing the host class {#change-resource-preset}

{% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

   1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.

   1. {% include [mmg-settings-host-class](../../_includes/mdb/mmg/settings-host-class.md) %}

   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the [host class](../concepts/instance-types.md) for the cluster:

   1. View a description of the update cluster CLI command:

      ```
      {{ yc-mdb-mg }} cluster update --help
      ```

   1. Request a list of available host classes (the `ZONES` column specifies the availability zones where you can select the appropriate class):

      
      ```bash
      {{ yc-mdb-mg }} resource-preset list

      +-----------+--------------------------------+-------+----------+
      |    ID     |            ZONE IDS            | CORES |  MEMORY  |
      +-----------+--------------------------------+-------+----------+
      | s1.micro  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 8.0 GB   |
      |           | {{ region-id }}-c                  |       |          |
      | ...                                                           |
      +-----------+--------------------------------+-------+----------+
      ```



   1. Specify the class in the update cluster command. When changing the class, keep in mind the host role: it depends on the [sharding type](../concepts/sharding.md#shard-management). You can use parameters for hosts with different roles in a single command.

      * For `MONGOD` hosts:

         ```bash
         {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
            --mongod-resource-preset <class_ID>
         ```

      * For `MONGOINFRA` hosts:

         ```bash
         {{ yc-mdb-mg }} cluster update <cluster name_or_ID> \
            --mongoinfra-resource-preset=<class_ID>
         ```

      * For `MONGOS` hosts:

         ```bash
         {{ yc-mdb-mg }} cluster update <cluster name_or_ID> \
            --mongos-resource-preset=<class_ID>
         ```

      * For `MONGOCFG` hosts:

         ```bash
         {{ yc-mdb-mg }} cluster update <cluster name_or_ID> \
            --mongocfg-resource-preset=<class_ID>
         ```

      {{ mmg-short-name }} will run the update host class command for the cluster.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mmg-name }} cluster description, edit the value of the `resource_preset_id` parameter for `resources_mongod`, `resources_mongoinfra`, `resources_mongos`, or `resources_mongocfg`. The resource type depends on the [sharding type](../concepts/sharding.md#shard-management).

      For example:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
        ...
        resources_mongod {
            resource_preset_id = "<host_class>"
            ...
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

   To change the host class, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterID` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * Host class in the `configSpec.mongodbSpec_<{{ MG }}_version>.mongod.resources.resourcePresetId` parameter.

      To retrieve a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset` resources.

   * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Increasing storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Management console

   To increase the cluster storage size:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
   1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, specify the required value.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To increase the cluster storage size:

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-mg }} cluster update --help
      ```

   1. Specify the required storage size in the update cluster command.It must be at least as large as the current `disk_size` value in the cluster properties.

      When increasing the storage size, keep in mind the host role: it depends on the [sharding type](../concepts/sharding.md#shard-management). You can use parameters for hosts with different roles in a single command.

      * For `MONGOD` hosts:

         ```bash
         {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
            --mongod-disk-size <storage_size_in_GB>
         ```

      * For `MONGOINFRA` hosts:

         ```bash
         {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
            --mongoinfra-disk-size <storage_size_GB>
         ```

      * For `MONGOS` hosts:

         ```bash
         {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
            --mongos-disk-size <storage_size_GB>
         ```

      * For `MONGOCFG` hosts:

         ```bash
         {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
            --mongocfg-disk-size <storage_size_GB>
         ```

      If all these conditions are met, {{ mmg-short-name }} will launch the operation to increase the storage size.

- {{ TF }}

   To increase the cluster storage size:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mmg-name }} cluster description, edit the value of the `disk_size` parameter for `resources_mongod`, `resources_mongoinfra`, `resources_mongos`, or `resources_mongocfg`. The resource type depends on the [sharding type](../concepts/sharding.md#shard-management).

      For example:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
        ...
        resources_mongod {
          disk_size = <storage_size_GB>
          ...
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

   To increase the cluster storage size, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterID` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * New storage size in the `configSpec.mongodbSpec_<{{ MG }}_version>.mongod.resources.diskSize` parameter.
   * List of settings you want to update, in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing {{ MG }} settings {#change-mongod-config}

You can change the DBMS settings of the hosts in your cluster.

{% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
   1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
   1. To change the [{{ MG }} settings](../concepts/settings-list.md#dbms-cluster-settings), click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** under **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update the [{{ MG }} settings](../concepts/settings-list.md#dbms-cluster-settings) for a cluster, run the command:

   ```
   {{ yc-mdb-mg }} cluster update-config
   ```

   For example, to set [net.maxIncomingConnections](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-net.maxIncomingConnections) to `4096`, run the following command:

   ```
   {{ yc-mdb-mg }} cluster update-config <cluster_name> \
      --set net.max_incoming_connections=4096
   ```

   {{ mmg-short-name }} will run the update DBMS settings command for the cluster. If the setting being changed is only applied when the database is restarted, {{ mmg-short-name }} will restart the database instances on all cluster hosts, one by one.

- API

   To change {{ MG }} settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterID` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * Required {{ MG }} setting values in the `configSpec.mongodbSpec_<{{ MG }}_version>.mongod.config` parameter.

      All supported settings are described in the [API reference](../api-ref/Cluster/update.md) and in [{#T}](../concepts/settings-list.md).

   * List of cluster settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
   1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
   1. Change additional cluster settings:

      {% include [mmg-extra-settings](../../_includes/mdb/mmg-extra-settings.md) %}

   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change additional cluster settings:

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-mg }} cluster update --help
      ```

   1. Run the following command with a list of settings to update:

      ```bash
      {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
        --backup-retain-period-days=<retention_period> \
        --backup-window-start <backup_start_time> \
        --maintenance-window type=<maintenance_type>,`
                             `day=<day_of_week>,`
                             `hour=<hour> \
        --performance-diagnostics=<enable_diagnostics> \
        --deletion-protection=<deletion_protection>
      ```

   You can change the following settings:

   * `--backup-retain-period`: The retention period for automatic backups (in days)
      
      The `<retention_period>` parameter value must be in the range from {{ mmg-backup-retention-min }} to {{ mmg-backup-retention-max }} (the default value is {{ mmg-backup-retention }}). This feature is at the [Preview stage](../../overview/concepts/launch-stages.md). For more information, see [{#T}](../concepts/backup.md).


      Changing the retention period affects both new automatic backups and existing backups.

      For example, if the original retention period was 7 days and the remaining lifetime of a separate automatic backup is 1 day, then when the retention period increases to 9 days, the remaining lifetime of this backup becomes 3 days.

   {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

   * `--maintenance-window`: Settings for the [maintenance window](../concepts/maintenance.md) (including those for disabled clusters), where `type` is the maintenance type:

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

   * `--performance-diagnostics`: Specify the parameter to use the [{#T}](performance-diagnostics.md) tool in the cluster. This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage.

   * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

      {% include [deletion-protection-limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

   You can get the cluster ID and name [with a list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. To change the backup start time, add a block named `backup_window_start` to the {{ mmg-name }} cluster description under `cluster_config`:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
        ...
        cluster_config {
          backup_window_start {
            hours   = <hour>
            minutes = <minute>
          }
          ...
        }
        ...
      }
      ```

      Where `hours` and `minutes` is the hour and minute when the backup starts.

   1. To allow access from [{{ datalens-full-name }}](../../datalens/concepts/index.md), add a block named `access` under `cluster_config` to the {{ mmg-name }} cluster description:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
        ...
        cluster_config {
          ...
          access {
            data_lens = <access_from_{{ datalens-name }}>
          }
        ...
      }
      ```

      Where `data_lens` enables access from {{ datalens-name }}, `true` or `false`.

   1. {% include [Maintenance window](../../_includes/mdb/mmg/terraform/maintenance-window.md) %}

   1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
        ...
        deletion_protection = <deletion_protection>
      }
      ```

      Where `deletion_protection` is cluster deletion protection, `true` or `false`.

      {% include [deletion-protection-limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

   To change additional cluster settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterID` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * New backup start time in the `configSpec.backupWindowStart` parameter.
   * Settings for access from other services in the `configSpec.access` parameter.
   * Settings for the [maintenance window](../concepts/maintenance.md) (including those for disabled clusters) in the `maintenanceWindow` parameter.
   * Permission to collect statistics for cluster performance diagnostics in the `performanceDiagnostics.profilingEnabled` parameter.
   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion-protection-limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

   * List of cluster configuration fields to update in the `UpdateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the cluster you want to move.
   1. Select **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.
   1. Select a folder you want to move the cluster to.
   1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To move a cluster:

   1. View a description of the CLI move cluster command:

      ```bash
      {{ yc-mdb-mg }} cluster move --help
      ```

   1. Specify the destination folder in the move cluster command:

      ```bash
      {{ yc-mdb-mg }} cluster move <cluster_name_or_ID> \
         --destination-folder-name=<destination_folder_name>
      ```

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To move a cluster, use the [move](../api-ref/Cluster/move.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Move](../api-ref/grpc/cluster_service.md#Move) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * ID of the destination folder in the `destinationFolderId` parameter.

{% endlist %}


## Changing security groups {#change-sg-set}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
   1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select security groups for cluster network traffic.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-mg }} cluster update --help
      ```

   1. Specify the security groups in the update cluster command:

      ```bash
      {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
        --security-group-ids <list_of_security_group_IDs>
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mmg-name }} cluster description, change the `security_group_ids` parameter value:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
        ...
        security_group_ids = [ <list_of_security_group_IDs> ]
        ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

   To update security groups, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   - Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   - List of security group IDs in the `securityGroupIds` parameter.
   - List of cluster configuration fields to update in the `UpdateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect/index.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

