# Changing cluster settings

After creating a cluster, you can:

- [{#T}](#change-name-and-description).

- [{#T}](#change-resource-preset).

- [{#T}](#change-disk-size).

- [Configure](#change-redis-config) {{ RD }} servers according to the [{{ RD }} documentation](https://redis.io/documentation). For a list of supported settings, see the [{#T}](../concepts/settings-list.md) section and the [API reference](../api-ref/Cluster/update.md).

- [{#T}](#change-additional-settings).

- [{#T}](#change-sg-set).

{% note info %}

For information about how to update the {{ RD }} cluster version, see [{#T}](cluster-version-update.md).

{% endnote %}

## Change the cluster name and description {#change-name-and-description}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mrd-name }}**.
  1. Select the cluster and click **Edit cluster** at the top of the page.
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
     {{ yc-mdb-rd }} cluster update <cluster name or ID> \
          --cluster-name <new cluster name> \
          --description <new cluster description>
     ```

- {{ TF }}

    {% note alert %}

    Do not change the cluster name using {{ TF }}. This will delete the existing cluster and create a new one.

    {% endnote %}

    To update the cluster description:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](./cluster-create.md).

    1. In the {{ mrd-name }} cluster description, change the `description` parameter value:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<cluster name>" {
          name        = "<cluster name>"
          description = "<new cluster description>"
          ...
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [provider documentation {{ TF }}]({{ tf-provider-mrd }}).

- API

  Use the API [update](../api-ref/Cluster/update.md) method: pass the requisite values in the `name` and `description` parameters.

{% endlist %}

## Changing the host class {#change-resource-preset}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mrd-name }}**.
  1. Select the cluster and click **Edit cluster** at the top of the page.
  1. Under **Host class**, specify:
     * **Type**: Type of virtual machine that hosts are deployed on:
        * `high-memory`: More RAM per 1 vCPU.
        * `burstable`: Only a guaranteed share of vCPU performance. VMs with a guaranteed share of less than 100% ensure the specified level of performance with a possible temporary performance increase up to 100%. Clusters with such hosts are good for tasks that don't require guaranteed permanent performance (such as for testing).
     * **RAM**: Amount of RAM available to {{ RD }} on the host.
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
     {{ yc-mdb-rd }} cluster update <cluster name or ID> \
         --resource-preset <host class ID>
     ```

     {{ mrd-short-name }} will run the update host class command for the cluster.

- {{ TF }}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](./cluster-create.md).

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

    For more information, see [provider documentation {{ TF }}]({{ tf-provider-mrd }}).

- API

  Use the API [update](../api-ref/Cluster/update.md) method and pass the requisite values in the `configSpec.resources.resourcePresetId` parameter.

  To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset` resources.

{% endlist %}

## Increase the size of {{ RD }} host disks {#change-disk-size}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mrd-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Under **Storage size**, specify the required value.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To increase the size of {{ RD }} host disks:

  1. View a description of the CLI's update cluster command:

     ```
     $ {{ yc-mdb-rd }} cluster update --help
     ```

  1. Make sure the cloud quota is sufficient to increase the disk size: open the [Quotas]({{ link-console-quotas }}) page for your cloud and check that the **Managed Databases** section still has space available in the **hddSpace** line.

  1. Specify the disk size in GB in the update cluster command. The new size must be bigger than the previous one.

     ```
     $ {{ yc-mdb-rd }} cluster update <cluster name>
          --disk-size <disk size in GB>
     ```

     {% note info %}

     The maximum disk size depends on the [host class](../concepts/instance-types.md).

     {% endnote %}

     If all the criteria are met, {{ mrd-short-name }} starts increasing the size of the {{ RD }} host disks.

- {{ TF }}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](./cluster-create.md).

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

    For more information, see [provider documentation {{ TF }}]({{ tf-provider-mrd }}).

- API

  Use the API [update](../api-ref/Cluster/update.md) method and pass the requisite values in the `configSpec.resources.diskSize` parameter.

  Make sure the cloud quota is sufficient to increase the disk size: open the [Quotas]({{ link-console-quotas }}) page for your cloud and check that the **Managed Databases** section still has space available in the **hddSpace** line.

{% endlist %}

## Changing {{ RD }} settings {#change-redis-config}

You can change the DBMS settings of the hosts in your cluster. All supported settings are described in the [{#T}](../concepts/settings-list.md) section and the [API reference](../api-ref/Cluster/update.md).

{% list tabs %}

- Management console

  To modify the DBMS settings for a cluster:
  1. Go to the folder page and select **{{ mrd-name }}**.
  1. Select the cluster and click **Edit cluster** at the top of the page.
  1. Under **DBMS settings**, click **Settings**.
  1. Configure the available parameters according to the [{{ RD }} documentation](https://redis.io/documentation).
  1. Click **Save**.

- {{ TF }}

    To update the [DBMS settings](../concepts/settings-list.md) for the cluster:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](./cluster-create.md).

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

    For more information, see [provider documentation {{ TF }}]({{ tf-provider-mrd }}).

- API

  You can change the DBMS settings for a cluster using the API [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the `configSpec.redisConfig_5_0` request parameter.

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mrd-name }}**.

  1. Select the cluster and click **Edit cluster** in the top panel.

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
        {{ yc-mdb-rd }} cluster update <cluster name or ID> \
            --backup-window-start <backup start time> \
            --maintenance-window type=<weekly or anytime> \
            --deletion-protection=<protect cluster from deletion: true or false>
        ```

    You can change the following settings:

    {% include [backup-window-start](../../_includes/mdb/cli-additional-settings/backup-window-start.md) %}

    {% include [maintenance-window](../../_includes/mdb/cli-additional-settings/maintenance-window.md) %}

    {% include [deletion-protection-db](../../_includes/mdb/cli-additional-settings/deletion-protection-db.md) %}

    You can get the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Changing security groups {#change-sg-set}

{% list tabs %}

- Management console
    1. Go to the folder page and select **{{ mrd-name }}**.
    1. Select the cluster and click **Edit cluster** in the top panel.
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
        {{ yc-mdb-rd }} cluster update <cluster name or ID> \
           --security-group-ids <list of security groups>
        ```

- {{ TF }}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](./cluster-create.md).

    1. In the {{ mrd-name }} cluster description, change the `security_group_ids` parameter value:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<cluster name>" {
          ...
          security_group_ids = [<list of security group IDs>]
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [provider documentation {{ TF }}]({{ tf-provider-mrd }}).

- API

    Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
    - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
    - The list of groups in the `securityGroupIds` parameter.
    - The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](./connect/index.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

