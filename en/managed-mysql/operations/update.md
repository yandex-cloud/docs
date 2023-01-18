---
title: "Tutorial on changing settings for a {{ MY }} cluster"
description: "In this tutorial, you'll learn how to change settings for a {{ MY }} cluster."
---

# Changing {{ MY }} cluster settings

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).

* [{#T}](#change-disk-size).

* [Changing settings{{ MY }}](#change-mysql-config).

   {% note warning %}

   You can't change {{ MY }} settings using SQL commands.

   {% endnote %}

* [Change additional cluster settings](#change-additional-settings).

* [Move a cluster](#move-cluster) to another folder.


* [{#T}](#change-sg-set).


## Changing the host class {#change-resource-preset}

The choice of a host class in {{ mmy-short-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find **Managed Databases**.

{% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. To change the class of {{ MY }} hosts, under **Host class**, select the required class.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the [host class](../concepts/instance-types.md) for the cluster:

   1. View a description of the CLI's update cluster command:

      ```
      {{ yc-mdb-my }} cluster update --help
      ```

   1. Request a list of available host classes (the `ZONES` column specifies the availability zones where you can select the appropriate class):

      
      ```
      {{ yc-mdb-my }} resource-preset list
      ```

      Result:

      ```
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
      {{ yc-mdb-my }} cluster update <cluster name>
        --resource-preset <class ID>
      ```

      {{ mmy-short-name }} will run the update host class command for the cluster.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. In the {{ mmy-name }} cluster description, change the `resource_preset_id` parameter value under `resources`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        resources {
          resource_preset_id = "<host class>"
          ...
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   To change the [host class](../concepts/instance-types.md), use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   * The desired host class in the `configSpec.resources.resourcePresetId` parameter. To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset` resources.
   * List of settings to update (`configSpec.resources.resourcePresetId` in this case) in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Increasing storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Management console

   To increase a cluster's storage size:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. Under **Storage size**, specify the required value.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To increase a cluster's storage size:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-my }} cluster update --help
      ```

   1. Specify the required amount of storage in the cluster update command (it must be at least as large as `disk_size` in the cluster properties):

      ```bash
      {{ yc-mdb-my }} cluster update <cluster name or ID> \
        --disk-size <storage size in GB>
      ```

- {{ TF }}

   To increase a cluster's storage size:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. Change the `disk_size` parameter value under `resources`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        resources {
          disk_size = <storage size in GB>
          ...
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   To increase a cluster's storage size, use the API [update](../api-ref/Cluster/update.md) method and pass the following in the call:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   * Storage size in the `configSpec.resources.diskSize` parameter.
   * List of cluster configuration fields to update in the `updateMask` parameter (`configSpec.resources.diskSize` in this case).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing {{ MY }} settings {#change-mysql-config}

{% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. Change the [{{ MY }} settings](../concepts/settings-list.md#dbms-cluster-settings) by clicking **Configure** under **DBMS settings**:
   1. Click **Save**.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update the [{{ MY }} settings](../concepts/settings-list.md#dbms-cluster-settings):

   1. View a description of the CLI's update cluster configuration command:

      ```
      {{ yc-mdb-my }} cluster update-config --help
      ```

   1. Set the required parameter values.

      All supported parameters are listed in the request [format for the update method](../api-ref/Cluster/update.md), in the `mysql_config_5_7` field. To specify the parameter name in the CLI's call, convert the name from <q>lowerCamelCase</q> to <q>snake_case</q>. For example, the `logMinDurationStatement` parameter from an API request should be converted to `log_min_duration_statement` for the CLI command:

      ```
      {{ yc-mdb-my }} cluster update-config <cluster name>
         --set log_min_duration_statement=100,<parameter name>=<value>,...
      ```

      {{ mmy-short-name }} runs the update cluster settings operation.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. In the {{ mmy-name }} cluster description, add or update the [DBMS settings](../concepts/settings-list.md) under `mysql_config`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        mysql_config = {
          <{{ MY }} setting name> = <value>
          ...
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_mysql_cluster#mysql-config).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   * An array with new {{ MY }} settings in the following parameter:
      * `configSpec.mysqlConfig_5_7.sqlMode` for {{ MY }} 5.7.
      * `configSpec.mysqlConfig_8_0.sqlMode` for {{ MY }} 8.0.
   * List of cluster configuration fields to update in the `UpdateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. Change additional cluster settings:

      {% include [mmy-extra-settings](../../_includes/mdb/mmy-extra-settings-web-console.md) %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change additional cluster settings:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-my }} cluster update --help
      ```

   1. Run the command with a list of settings to update:

      
      ```bash
      {{ yc-mdb-my }} cluster update <cluster name> \
        --backup-window-start <backup start time> \
        --datalens-access=<true or false> \
        --maintenance-window type=<maintenance type: anytime or weekly>,`
                            `day=<day of week for weekly>,`
                            `hour=<hour for weekly> \
        --websql-access=<true or false> \
        --deletion-protection=<cluster deletion protection: true or false>
      ```



   You can change the following settings:

   {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

   *`--datalens-access`: Enables DataLens access. Default value: `false`. For more information about setting up a connection, see [{#T}](datalens-connect.md).

   * `--maintenance-window`: Settings for the [maintenance window](../concepts/maintenance.md) (including disabled clusters):

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

   *`--websql-access`: Enables [SQL queries to be run](web-sql-query.md) from the management console. Default value: `false`.

   * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   You can [retrieve the cluster name with a list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. To change the backup start time, add a `backup_window_start` block to the {{ mmy-name }} cluster description:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        backup_window_start {
          hours   = <backup start hour>
          minutes = <backup start minute>
        }
        ...
      }
      ```

   
   1. {% include [Access settings](../../_includes/mdb/mmy/terraform/access-settings.md) %}


   1. {% include [Maintenance window](../../_includes/mdb/mmy/terraform/maintenance-window.md) %}

   1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        deletion_protection = <protect cluster from deletion: true or false>
      }
      ```

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To retrieve the ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
      * Settings for access from other services and access to SQL queries from the management console in the `configSpec.access` parameter.
   * Backup window settings in the `configSpec.backupWindowStart` parameter.
   * Settings for the [maintenance window](../concepts/maintenance.md) (including for disabled clusters) in the `maintenanceWindow` parameter.
   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

   {% include [DataTransfer access](../../_includes/mdb/api/datatransfer-access-create.md) %}

   
   {% include [datalens access](../../_includes/mdb/api/datalens-access.md) %}


   You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mmy-name }}**.
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
      {{ yc-mdb-my }} cluster move --help
      ```

   1. Specify the destination folder in the move cluster command:

      ```bash
      {{ yc-mdb-my }} cluster move <cluster ID> \
         --destination-folder-name=<destination folder name>
      ```

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [move](../api-ref/Cluster/move.md) API method and pass the following in the query:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The ID of the destination folder in the `destinationFolderId` parameter.

{% endlist %}


## Changing security groups {#change-sg-set}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. Under **Network settings**, select security groups for cluster network traffic.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-my }} cluster update --help
      ```

   1. Specify the security groups in the update cluster command:

      ```bash
      {{ yc-mdb-my }} cluster update <cluster name> \
        --security-group-ids <security group list>
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. In the {{ mmy-name }} cluster description, change the `security_group_ids` parameter value:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster name>" {
        ...
        security_group_ids = ["<security group ID list>"]
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * The list of security group IDs in the `securityGroupIds` parameter.
   * List of settings to update (`securityGroupIds` in this case) in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect.md#configure-security-groups) to connect to the cluster.

{% endnote %}

