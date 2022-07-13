# Changing cluster settings

After creating a cluster, you can:

* [{#T}](#change-name-and-description).

* [{#T}](#change-resource-preset).

* [{#T}](#change-disk-size)  (unavailable for non-replicated SSD [storage](../concepts/storage.md)).

* Configure [{{ RD }} servers](#change-redis-config) according to the [{{ RD }} documentation](https://redis.io/documentation). For a list of supported settings, see [{#T}](../concepts/settings-list.md) and the [API reference](../api-ref/Cluster/update.md).

* [{#T}](#change-additional-settings).

* [Move a cluster](#move-cluster) to another folder.

* [{#T}](#change-sg-set).

{% note info %}

For information about how to update the {{ RD }} cluster version, see [{#T}](cluster-version-update.md).

{% endnote %}

## Change the cluster name and description {#change-name-and-description}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the desired cluster.
   1. Select **{{ mrd-name }}**.
   1. Select the desired cluster.
   1. At the top of the page, click **Edit cluster**.
   1. Under **Basic parameters**, enter a new name and description for the cluster.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the [host class](../concepts/instance-types.md) for the cluster:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-rd }} cluster update --help
      ```

   1. Specify a new name and description in the cluster update command:

      ```bash
      {{ yc-mdb-rd }} cluster update <cluster ID or name> \
        --cluster-name <cluster new name> \
        --description <cluster new description>
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

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

   Use the API [update](../api-ref/Cluster/update.md) method: pass the requisite values in the `name` and `description` parameters.

{% endlist %}

## Changing the host class {#change-resource-preset}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing the cluster to restore.
   1. Select **{{ mrd-name }}**.
   1. Select the desired cluster.
   1. At the top of the page, click **Edit cluster**.
   1. Under **Host class**:

      * Choose a **Platform**.
      * Select the **Type** of virtual machine that hosts will be deployed on:
         * `high-memory`: More RAM per 1 vCPU.
         * `burstable`: Only a guaranteed share of vCPU performance. VMs with a guaranteed share of less than 100% ensure the specified level of performance with a possible temporary performance increase up to 100%. Clusters with such hosts are good for tasks that don't require guaranteed permanent performance (for example, testing).
      * Modify the host configuration.

   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the [host class](../concepts/instance-types.md) for the cluster:

   1. View a description of the CLI's update cluster command:

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
      | b1.nano     | ru-central1-a, ru-central1-b,  | 2.0 GB   |
      |             | ru-central1-c                  |          |
      | b1.small    | ru-central1-a, ru-central1-b,  | 4.0 GB   |
      |             | ru-central1-c                  |          |
      | hm1.nano    | ru-central1-a, ru-central1-b,  | 8.0 GB   |
      |             | ru-central1-c                  |          |
      | hm1.micro   | ru-central1-a, ru-central1-b,  | 12.0 GB  |
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

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

   Use the API [update](../api-ref/Cluster/update.md) method and pass the requisite values in the `configSpec.resources.resourcePresetId` parameter.

   To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for `ResourcePreset` resources.

{% endlist %}

## Increasing storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Management console

   To increase a cluster's storage size:

   1. In the [management console]({{ link-console-main }}), select the folder containing the cluster to restore.
   1. Select **{{ mrd-name }}**.
   1. Select the desired cluster.
   1. At the top of the page, click **Edit cluster**.
   1. Under **Storage size**, specify the required value.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To increase storage size of {{ RD }} hosts:

   1. View a description of the CLI's update cluster command:

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

   To increase a cluster's storage size:

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

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

   To increase a cluster's storage size, use the API [update](../api-ref/Cluster/update.md) method and pass the required values in in the call using the `configSpec.resources.diskSize` parameter.

{% endlist %}

## Changing {{ RD }} settings {#change-redis-config}

You can change the DBMS settings of the hosts in your cluster. All supported settings are described in [{#T}](../concepts/settings-list.md) and the [API reference](../api-ref/Cluster/update.md).

{% list tabs %}

- Management console

   To modify the DBMS settings for a cluster:

   1. In the [management console]({{ link-console-main }}), select the folder containing the cluster to restore.
   1. Select **{{ mrd-name }}**.
   1. Select the desired cluster.
   1. At the top of the page, click **Edit cluster**.
   1. Under **DBMS settings**, click **Settings**.
   1. Configure the available parameters according to the [{{ RD }} documentation](https://redis.io/documentation).
   1. Click **Save**.

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

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

   You can change the DBMS settings for a cluster using the API [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the `configSpec.redisConfig_5_0` request parameter.

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing the cluster to restore.
   1. Select **{{ mrd-name }}**.
   1. Select the desired cluster.
   1. At the top of the page, click **Edit cluster**.
   1. Change additional cluster settings:

      {% include [mrd-extra-settings](../../_includes/mdb/mrd-extra-settings-web-console.md) %}

   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change additional cluster settings:

   1. View a description of the CLI's update cluster command:

      ```bash
      {{ yc-mdb-rd }} cluster update --help
      ```

   1. Run the command with a list of settings to update:

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

   * {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window.md) %}

   * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

      {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

   You can [retrieve the cluster name with a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mrd-name }}**.
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
      {{ yc-mdb-rd }} cluster move --help
      ```

   1. Specify the destination folder in the move cluster command:

      ```bash
      {{ yc-mdb-rd }} cluster move <cluster ID> \
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

   1. In the [management console]({{ link-console-main }}), select the folder containing the cluster to restore.
   1. Select **{{ mrd-name }}**.
   1. Select the desired cluster.
   1. At the top of the page, click **Edit cluster**.
   1. Under **Network settings**, select security groups for cluster network traffic.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

   1. View a description of the CLI's update cluster command:

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
        security_group_ids  = ["<security group ID list>"]
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

   {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
   * The list of groups in the `securityGroupIds` parameter.
   * The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect/index.md#configuring-security-groups) to connect to the cluster.

{% endnote %}
