# Changing {{ RD }} cluster settings

After creating a cluster, you can:

* [Change the cluster name and description](#change-name-and-description).

* [Change the host class](#change-resource-preset).


* [Increase storage size](#change-disk-size).


* Configure [{{ RD }} servers](#change-redis-config) as described in the [{{ RD }} documentation](https://redis.io/documentation). For a list of supported settings, see [{#T}](../concepts/settings-list.md) and the [API reference](../api-ref/Cluster/update.md).

* [Change additional cluster settings](#change-additional-settings).

* [Move a cluster](#move-cluster) to another folder.


* [Changing security groups](#change-sg-set).


{% note info %}

For information about how to update the {{ RD }} cluster version, see [{#T}](cluster-version-update.md).

{% endnote %}

## Change the cluster name and description {#change-name-and-description}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Select the desired cluster.
   1. At the top of the page, click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, enter a new name and description for the cluster.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the [host class](../concepts/instance-types.md) for the cluster:

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-rd }} cluster update --help
      ```

   1. Specify a new name and description in the cluster update command:

      ```bash
      {{ yc-mdb-rd }} cluster update <cluster ID or name> \
        --new-name <new cluster name> \
        --description <new cluster description>
      ```

- {{ TF }}

   {% note alert %}

   Do not change the cluster name using {{ TF }}. This will delete the existing cluster and create a new one.

   {% endnote %}

   To update the cluster description:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. In the {{ mrd-name }} cluster description, change the `description` parameter value:

      ```hcl
      resource "yandex_mdb_redis_cluster" "<cluster name>" {
        name        = "<cluster name>"
        description = "<cluster new description>"
        ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

   To change a cluster's name and description, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterID` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * New cluster name in the `name` parameter.
   * New cluster description in the `description` parameter.
   * List of fields to update (in this case, `name` and `description`) in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing the host class {#change-resource-preset}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Select the desired cluster.
   1. At the top of the page, click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**:

      * Select a platform in the **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** field.
      * Select the **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** of virtual machine that hosts will be deployed on:
         * `high-memory`: More RAM per 1 vCPU.
         * `burstable`: Only a guaranteed share of vCPU performance. VMs with a guaranteed share of less than 100% ensure the specified level of performance with a possible temporary performance increase up to 100%. Clusters with such hosts are good for tasks that don't require guaranteed permanent performance (for example, testing).
      * Modify the host configuration.

   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the [host class](../concepts/instance-types.md) for the cluster:

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-rd }} cluster update --help
      ```

   1. Request a list of available host classes (the `ZONES` column specifies the availability zones where you can select the appropriate class):

      
      ```bash
      {{ yc-mdb-rd }} resource-preset list
      ```

      Result:

      
      ```text
      +-------------+--------------------------------+----------+
      |     ID      |            ZONE IDS            |  MEMORY  |
      +-------------+--------------------------------+----------+
      | b1.nano     | {{ region-id }}-a, {{ region-id }}-b,  | 2.0 GB   |
      |             | {{ region-id }}-c                  |          |
      | b1.small    | {{ region-id }}-a, {{ region-id }}-b,  | 4.0 GB   |
      |             | {{ region-id }}-c                  |          |
      | hm1.nano    | {{ region-id }}-a, {{ region-id }}-b,  | 8.0 GB   |
      |             | {{ region-id }}-c                  |          |
      | hm1.micro   | {{ region-id }}-a, {{ region-id }}-b,  | 12.0 GB  |
      | ...                                                     |
      +-----------+----------------------------------+----------+
      ```




   1. Specify the class in the update cluster command:

      ```bash
      {{ yc-mdb-rd }} cluster update <cluster ID or name> \
        --resource-preset <host class ID>
      ```

      {{ mrd-short-name }} will run the update host class command for the cluster.

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. In the {{ mrd-name }} cluster description, change the `resource_preset_id` parameter value under `resources`:

      ```hcl
      resource "yandex_mdb_redis_cluster" "<cluster name>" {
        ...
        resources {
          resource_preset_id = "<host class>"
          ...
          }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

   To change the host class, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * New host class in the `configSpec.resources.resourcePresetId` parameter.

      To get a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) REST API method for the [ResourcePreset](../api-ref/ResourcePreset/index.md) resource or the [ResourcePresetService/List](../api-ref/grpc/resource_preset_service.md#List) gRPC API call.

   * List of fields to update (in this case, `configSpec.resources.resourcePresetId`) in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Increasing storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Management console

   To increase the cluster storage size:

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Select the desired cluster.
   1. At the top of the page, click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. Edit the settings in the **{{ ui-key.yacloud.mdb.forms.section_disk }}** section.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To increase storage size of {{ RD }} hosts:

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-rd }} cluster update --help
      ```

   1. Specify the desired storage size in the update cluster command.It must be at least as large as the current `disk_size` value in the cluster properties.

      ```bash
      {{ yc-mdb-rd }} cluster update <cluster ID or name> \
        --disk-size <storage size in GB>
      ```

      If all the criteria are met, {{ mrd-short-name }} starts increasing the size of the {{ RD }} host disks.

- {{ TF }}

   To increase the cluster storage size:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. In the {{ mrd-name }} cluster description, change the `disk_size` parameter value under `resources`:

      ```hcl
      resource "yandex_mdb_redis_cluster" "<cluster name>" {
        ...
        resources {
          disk_size = <storage size in GB>
          ...
          }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

   To increase the cluster storage size, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * New storage size in the `configSpec.resources.diskSize` parameter.
   * List of cluster configuration fields to update in the `updateMask` parameter (in this case, `configSpec.resources.diskSize`).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing {{ RD }} settings {#change-redis-config}

You can change the DBMS settings of the hosts in your cluster. All supported settings are described in [{#T}](../concepts/settings-list.md) and the [API reference](../api-ref/Cluster/update.md).

{% list tabs %}

- Management console

   To update the [DBMS settings](../concepts/settings-list.md) for the cluster:

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Select the desired cluster.
   1. At the top of the page, click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.
   1. Configure the available parameters according to the [{{ RD }} documentation](https://redis.io/documentation).
   1. Click **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.

- {{ TF }}

   To update the [DBMS settings](../concepts/settings-list.md) for the cluster:

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. In the {{ mrd-name }} cluster description, change the values of the parameters under `config`:

      ```hcl
      resource "yandex_mdb_redis_cluster" "<cluster name>" {
        ...
        config {
          password         = "<password>"
          timeout          = <time in seconds before disabling inactive clients>
          maxmemory_policy = "<memory management policy when there is not enough memory>"
          ...
        }
      }
      ```

      {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

   To change {{ RD }} settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * Required {{ RD }} setting values in the `configSpec.redisConfig_<{{ RD }} version>` parameter.
   * List of cluster configuration fields to update in the `UpdateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Select the desired cluster.
   1. At the top of the page, click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. Change additional cluster settings:

      {% include [mrd-extra-settings](../../_includes/mdb/mrd-extra-settings-web-console.md) %}

   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change additional cluster settings:

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-rd }} cluster update --help
      ```

   1. Run the following command with a list of settings to update:

      ```bash
      {{ yc-mdb-rd }} cluster update <cluster ID or name> \
          --backup-window-start <backup start time> \
          --maintenance-window type=<maintenance type: anytime or weekly>,`
                              `day=<day of week for weekly>,`
                              `hour=<hour for weekly> \
          --deletion-protection=<cluster deletion protection: true or false>
      ```

   You can change the following settings:

   {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

   * `--maintenance-window`: Settings for the [maintenance window](../concepts/maintenance.md) (including those for disabled clusters):

      {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

   * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   You can [retrieve the cluster name with a list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To change additional cluster settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-data.md) %}

   * List of cluster configuration fields to be changed in the `updateMask` parameter.

   {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Click the ![image](../../_assets/horizontal-ellipsis.svg) icon to the right of the cluster you wish to move.
   1. Select **{{ ui-key.yacloud.mdb.clusters.button_action-move }}**.
   1. Select the folder you want to move the cluster to.
   1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To move a cluster:

   1. View a description of the CLI move cluster command:

      ```bash
      {{ yc-mdb-rd }} cluster move --help
      ```

   1. Specify the destination folder in the move cluster command:

      ```bash
      {{ yc-mdb-rd }} cluster move <cluster ID> \
         --destination-folder-name=<destination folder name>
      ```

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To move a cluster, use the [move](../api-ref/Cluster/move.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Move](../api-ref/grpc/cluster_service.md#Move) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * ID of the destination folder in the `destinationFolderId` parameter.

{% endlist %}


## Changing security groups {#change-sg-set}

{% note info %}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Select the desired cluster.
   1. At the top of the page, click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select security groups for cluster network traffic.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

   1. View a description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-rd }} cluster update --help
      ```

   1. Specify the security groups in the update cluster command:

      ```bash
      {{ yc-mdb-rd }} cluster update <cluster ID or name> \
        --security-group-ids <security group list>
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](./cluster-create.md).

   1. In the {{ mrd-name }} cluster description, change the `security_group_ids` parameter value:

      ```hcl
      resource "yandex_mdb_redis_cluster" "<cluster name>" {
        ...
        security_group_ids = ["<security group ID list>"]
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

   To update security groups, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * List of security group IDs in the `securityGroupIds` parameter.
   * List of settings to update (in this case, `securityGroupIds`) in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect/index.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

