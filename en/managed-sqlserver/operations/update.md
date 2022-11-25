# Changing cluster settings

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).
* [{#T}](#change-disk-size).
* [Update {{ MS }} settings](#change-sqlserver-config) according to the {{ MS }} documentation.
* [{#T}](#change-additional-settings).
{% if audience == "draft" %}
* [Move a cluster](#move-cluster) to another folder.
{% endif %}
* [Change cluster security groups](#change-sg-set).
* [{#T}](#service-account).

{% note warning %}

You can't use SQL commands to change {{ MS }} settings, including managing server-level objects, such as `Linked Server`, `Login`, `Credential`, `SQL Server Agent Job`, `Maintenance Plan`, `Audit`, `Polybase`, `Replication`, `Backup devices`, `Server Triggers`, and `Extended events`.

{% endnote %}

## Changing the host class {#change-resource-preset}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. Select a new [host class](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing hosts change, too.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the [host class](../concepts/instance-types.md) for the cluster:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-ms }} cluster update --help
      ```

   1. Request a list of available host classes (the `ZONES IDS` column specifies the availability zones where you can select the appropriate class):

      ```bash
      {{ yc-mdb-ms }} resource-preset list
      ```

      Result:

      ```text
      +---------------+--------------------------------+-------+----------+
      |      ID       |            ZONE IDS            | CORES |  MEMORY  |
      +---------------+--------------------------------+-------+----------+
      | hm2.128xlarge | {{ region-id }}-a, {{ region-id }}-b,  |     8 | 128.0 GB |
      |               | {{ region-id }}-c                  |       |          |
      | hm2.160xlarge | {{ region-id }}-a, {{ region-id }}-b,  |    10 | 160.0 GB |
      |               | {{ region-id }}-c                  |       |          |
      | ...                                                               |
      +---------------+--------------------------------+-------+----------+
      ```

   1. Specify the class in the update cluster command:

      ```bash
      {{ yc-mdb-ms }} cluster update <cluster ID or name> \
         --resource-preset=<host class>
      ```

      You can find out the cluster ID and name in a [list of clusters in the folder](cluster-list.md#list-clusters).

      {{ mms-short-name }} will run the update host class command for the cluster.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. In the {{ mms-name }} cluster description, change the `resource_preset_id` parameter value under `resources`:

      ```hcl
      resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
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

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mms }}).

   {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

   * New host class, in the `configSpec.resources.resourcePresetId` parameter.

      To retrieve a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the [ResourcePreset](../api-ref/ResourcePreset) object.

   * List of cluster configuration fields to update in the `updateMask` parameter (`configSpec.resources.resourcePresetId` in this case).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Increasing storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Management console

   To increase the storage size for a cluster:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. Edit the settings in the **Storage** section.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To increase the storage size for a cluster:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-ms }} cluster update --help
      ```

   1. Specify the desired storage size in the update cluster command:

      ```bash
      {{ yc-mdb-ms }} cluster update <cluster ID or name> \
         --disk-size <storage size, GB>
      ```

      You can find out the cluster ID and name in a [list of clusters in the folder](cluster-list.md#list-clusters).

      If all these conditions are met, {{ mms-short-name }} launches the operation to increase storage space.

- {{ TF }}

   To increase the storage size for a cluster:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. In the {{ mms-name }} cluster description, change the `disk_size` parameter value under `resources`:

      ```hcl
      resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
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

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mms }}).

   {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

   To increase the storage size for a cluster, use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * New storage size (bytes) in the `configSpec.resources.diskSize` parameter.
   * List of cluster configuration fields to update in the `updateMask` parameter (`configSpec.resources.diskSize` in this case).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing {{ MS }} settings {#change-sqlserver-config}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. Under **DBMS settings**, click **Settings**.
   1. Edit the settings and click **Save**.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change {{ MS }} settings:

   1. View the full list of settings specified for the cluster:

      ```bash
      {{ yc-mdb-ms }} cluster get <cluster ID or name> --full
      ```

      You can find out the cluster ID and name in a [list of clusters in the folder](cluster-list.md#list-clusters).

   1. View a description of the CLI's update cluster configuration command:

      ```bash
      {{ yc-mdb-ms }} cluster update-config --help
      ```

   1. Set the required parameter values:

      ```bash
      {{ yc-mdb-ms }} cluster update-config <cluster ID or name> \
           --set <parameter1 name>=<value1>,...
      ```

      {{ mms-short-name }} runs the update cluster settings operation.

      All the supported parameters are listed in the [description of settings for{{ MS }}](../concepts/settings-list.md).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. Edit the {{ mms-name }} cluster description to modify the parameters under `sqlserver_config`:

      ```hcl
      resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
        ...
        sqlserver_config {
          ...
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mms }}).

   {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Required values in the `configSpec.sqlserverConfig_<{{ MS }} version>` parameter.

      A list of variable settings is provided in the [API description](../api-ref/Cluster/update.md) and in [{#T}](../concepts/settings-list.md).

   * List of cluster configuration fields to update in the `UpdateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. Select the cluster and click **Edit** at the top of the page.
   1. Change additional cluster settings:

      {% include [extra-settings](../../_includes/mdb/mms/extra-settings.md) %}

   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change additional cluster settings:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-ms }} cluster update --help
      ```

   1. Run the command with a list of settings to update:

      ```bash
      {{ yc-mdb-ms }} cluster update <cluster ID or name> \
         --backup-window-start=<backup start time> \
         --deletion-protection=<cluster deletion protection: true or false>
      ```

      You can change the following settings:

      {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

      * {% include [deletion-protection](../../_includes/mdb/cli/deletion-protection.md) %}

         {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      You can find out the cluster ID and name in a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. To change the backup start time, add a `backup_window_start` block to the {{ mms-name }} cluster description:

      ```hcl
      resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
        ...
        backup_window_start {
          hours   = <backup start hour>
          minutes = <backup start minute>
        }
        ...
      }
      ```

   1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

      ```hcl
      resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
        ...
        deletion_protection = <protect cluster from deletion: true or false>
      }
      ```

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mms }}).

   {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The new backup start time, in the `configSpec.backupWindowStart` parameter.
   * List of cluster configuration fields to update in the `updateMask` parameter (`configSpec.backupWindowStart` in this case).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% if audience == "draft" %}

## Moving a cluster {#move-cluster}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon to the right of the row of the cluster that you want to move.
   1. Click **Move**.
   1. Select the folder you want to move the cluster to.
   1. Click **Move**.

- API

   Use the [move](../api-ref/Cluster/move.md) API method and pass the following in the query:
   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The ID of the destination folder in the `destinationFolderId parameter`.

{% endlist %}

{% endif %}

## Changing security groups {#change-sg-set}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. Select the cluster and click **Edit cluster** in the top panel.
   1. Under **Network settings**, select security groups for cluster network traffic.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-ms }} cluster update --help
      ```

   1. Specify the security groups in the update cluster command:

      ```bash
      {{ yc-mdb-ms }} cluster update <cluster ID or name> \
         --security-group-ids <security group list>
      ```

      You can query the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. In the {{ mms-name }} cluster description, change the `security_group_ids` parameter value:

      ```hcl
      resource "yandex_mdb_sqlserver_cluster" "<cluster name>" {
        ...
        security_group_ids = ["<security group ID list>"]
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mms }}).

   {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The list of security group IDs in the `securityGroupIds` parameter.
   * List of settings to update in the `updateMask` parameter.

   {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

## Linking a service account {#service-account}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. In the line with the desired cluster, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Edit cluster**.
   1. Under **Basic parameters**, select the existing service account from the list or create a new one.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To link a [service account](../../iam/concepts/users/service-accounts.md) to a cluster:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-ms }} cluster update --help
      ```

   1. Pass the service account ID in the `--service-account-id` parameter of the cluster update command:

      ```bash
      {{ yc-mdb-ms }} cluster update <cluster name or ID> \
         --service-account-id=<service account ID>
      ```

      You can query the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters). To retrieve a service account ID, follow the [instructions](../../iam/operations/sa/get-id.md).

- API

   To link a [service account](../../iam/concepts/users/service-accounts.md) to a cluster, use the API [update](../api-ref/Cluster/update.md) method and pass the following in the call:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Service account ID, in the `serviceAccountId` parameter. To retrieve the ID, follow the [instructions](../../iam/operations/sa/get-id.md).
   * List of settings to update in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
