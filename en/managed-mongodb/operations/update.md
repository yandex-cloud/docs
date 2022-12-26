# Changing {{ MG }} cluster settings

After creating a cluster, you can:

- [Change the host class](#change-resource-preset).

- [{#T}](#change-disk-size).

- Configure [{{ MG }} servers](#change-mongod-config) according to the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/configuration-options/).

- [Change additional cluster settings](#change-additional-settings).

- [Move a cluster](#move-cluster) to another folder.


- [{#T}](#change-sg-set).


## Changing the host class {#change-resource-preset}

{% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.

   1. Select the cluster and click **Edit cluster** in the top panel. 

   1. {% include [mmg-settings-host-class](../../_includes/mdb/mmg/settings-host-class.md) %}

   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the [host class](../concepts/instance-types.md) for the cluster:

   1. View a description of the CLI's update cluster command:

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



   1. Specify the class in the update cluster command:

      ```
      {{ yc-mdb-mg }} cluster update <cluster name>
        --mongod-resource-preset <class ID>
      ```

      {{ mmg-short-name }} will run the update host class command for the cluster.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mmg-name }} cluster description, change the `resource_preset_id` parameter value under `resources`:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
        ...
        resources {
            resource_preset_id = "<class of {{ MG }} hosts>"
            ...
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * Host class in the `configSpec.mongodbSpec_<{{ MG }} version>.mongod.resources.resourcePresetId` parameter.

      To retrieve a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset` resources.

   * List of settings to update in the `updateMask` parameter.

   {% [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Increasing storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Management console

   To increase a cluster's storage size:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel. 
   1. Under **Storage size**, specify the required value.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To increase a cluster's storage size:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-mg }} cluster update --help
      ```

   1. Specify the desired storage size in the update cluster command.It must be at least as large as the current `disk_size` value in the cluster properties.

      ```bash
      {{ yc-mdb-mg }} cluster update <cluster ID or name> \
        --mongod-disk-size <storage size in GB>
      ```

      If all these conditions are met, {{ mmg-short-name }} launches the operation to increase storage space.

- {{ TF }}

   To increase a cluster's storage size:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mmg-name }} cluster description, change the `disk_size` parameter value under `resources`:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
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

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

   To increase a cluster's storage size, use the API [update](../api-ref/Cluster/update.md) method and pass in the call:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * New storage size in the `configSpec.mongodbSpec_<{{ MG }} version>.mongod.resources.diskSize` parameter.
   * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing {{ MG }} settings {#change-mongod-config}

You can change the DBMS settings of the hosts in your cluster.

{% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel. 
   1. To change the [{{ MG }} settings](../concepts/settings-list.md#dbms-cluster-settings), click **Configure** under **DBMS settings**.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update the [{{ MG }} settings](../concepts/settings-list.md#dbms-cluster-settings) for a cluster, run the command:

   ```
   {{ yc-mdb-mg }} cluster update-config
   ```

   For example, to set [net.maxIncomingConnections](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-net.maxIncomingConnections) to `4096`, run the following command:

   ```
   {{ yc-mdb-mg }} cluster update-config <cluster name> \
      --set net.max_incoming_connections=4096
   ```

   {{ mmg-short-name }} will run the update DBMS settings command for the cluster. If the setting being changed is only applied when the database is restarted, {{ mmg-short-name }} sequentially restarts the database on all the cluster hosts.

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * Target {{ MG }} setting values in the `configSpec.mongodbSpec_<{{ MG }} version>.mongod.config` parameter.

      All the supported settings are described in the [API reference](../api-ref/Cluster/update.md) and in [{#T}](../concepts/settings-list.md).

   * List of cluster settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel. 
   1. Change additional cluster settings:

      {% include [mmg-extra-settings](../../_includes/mdb/mmg-extra-settings.md) %}

   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change additional cluster settings:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-mg }} cluster update --help
      ```

   1. Run the command with a list of settings to update:

      ```bash
      {{ yc-mdb-mg }} cluster update <cluster ID or name> \
       --backup-retain-period-days=<retain period> \
       --backup-window-start <backup start time> \
        --maintenance-window type=<maintenance type: anytime or weekly>,`
                           `day=<day of the week for the weekly type>,`
                           `hour=<hour or the day for the weekly type>
      ```

   You can change the following settings:

   * `--backup-retain-period`: The retention period for automatic backups (in days)
      .
      

      The `<retention period>` parameter value must be in the range from {{ mmg-backup-retention-min }} to {{ mmg-backup-retention-max }} (the default value is {{ mmg-backup-retention }}). This feature is in the [Preview stage](../../overview/concepts/launch-stages.md). For more information, see [{#T}](../concepts/backup.md).


      Changing the retention period affects both new automatic backups and existing backups.

      For example, if the original retention period was 7 days and the remaining lifetime of a separate automatic backup is 1 day, then when the retention period increases to 9 days, the remaining lifetime of this backup becomes 3 days.

   {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

   * `--maintenance-window`: Settings for the [maintenance window](../concepts/maintenance.md) (including disabled clusters):

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

   * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

      {% include [deletion-protection-limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

   You can find out the cluster ID and name in a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. To change the backup start time, add a block named `backup_window_start` to the {{ mmg-name }} cluster description under `cluster_config`:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
        ...
        cluster_config {
          backup_window_start {
            hours   = <backup start hour>
            minutes = <backup start minute>
          }
          ...
        }
        ...
      }
      ```

   1. To allow access from [{{ datalens-full-name }}](../../datalens/concepts/index.md), add a block named `access` under `cluster_config` to the {{ mmg-name }} cluster description:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
        ...
        cluster_config {
          ...
          access {
            data_lens = <access from DataLens: true or false>
          }
        ...
      }
      ```

   1. {% include [maintenance-window](../../_includes/mdb/mmg/terraform/maintenance-window.md) %}

   1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
        ...
        deletion_protection = <protect cluster from deletion: true or false>
      }
      ```

      {% include [deletion-protection-limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * The new backup start time, in the `configSpec.backupWindowStart` parameter.
   * Settings for access from other services in the `configSpec.access` parameter.
   * Settings for the [maintenance window](../concepts/maintenance.md) (including for disabled clusters) in the `maintenanceWindow` parameter.
   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion-protection-limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

   * List of cluster configuration fields to update in the `UpdateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mmg-name }}**.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon to the right of the cluster you want to move.
   1. Click **Move**.
   1. Select the folder you want to move the cluster to.
   1. Click **Move**.

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
      {{ yc-mdb-mg }} cluster move <cluster ID> \
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

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel. 
   1. Under **Network settings**, select security groups for cluster network traffic.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-mg }} cluster update --help
      ```

   1. Specify the security groups in the update cluster command:

      ```bash
      {{ yc-mdb-mg }} cluster update <cluster ID or name> \
        --security-group-ids <security group list>
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. In the {{ mmg-name }} cluster description, change the `security_group_ids` parameter value:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
        ...
        security_group_ids = [ <List of security group IDs> ]
        ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   - The list of security group IDs in the `securityGroupIds` parameter.
   - List of cluster configuration fields to update in the `UpdateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect/index.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

