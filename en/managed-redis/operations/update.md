# Changing cluster settings

After creating a cluster, you can:

* [Change the cluster name and description](#change-name-and-description).

* [Change the host class](#change-resource-preset).

* [Increase the size of {{ RD }} host disks](#change-disk-size).

* [Configure](#change-redis-config) {{ RD }} according to the [{{ RD }} documentation](https://redis.io/documentation). Supported settings are listed [in the API reference](../api-ref/Cluster/update.md).

## Change the cluster name and description {#change-name-and-description}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mrd-name }}**.
  2. Select the cluster and click **Edit cluster** at the top of the page.
  3. Under **Basic parameters**, enter a new name and description for the cluster.
  4. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [host class](../concepts/instance-types.md) for the cluster:

  1. View a description of the CLI's update cluster command:

     ```
     $ {{ yc-mdb-rd }} cluster update --help
     ```

  1. Specify a new name and description in the cluster update command:

     ```
     $ {{ yc-mdb-rd }} cluster update <cluster name> \
          --cluster-name <new cluster name> \
          --description <new cluster description>
     ```

- API

  To change the cluster name and description, use the API [update](../api-ref/Cluster/update.md) method: pass the values in the `name` and `description` request parameters.

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

     ```
     $ {{ yc-mdb-rd }} cluster update --help
     ```

  1. Request a list of available host classes (the `ZONES` column specifies the availability zones where you can select the appropriate class):

     
     ```bash
     $ {{ yc-mdb-rd }} resource-preset list
     
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

     ```
     $ {{ yc-mdb-rd }} cluster update <cluster name>
          --resource-preset <class ID>
     ```

     {{ mrd-short-name }} will run the update host class command for the cluster.

- API

  You can change the [host class](../concepts/instance-types.md) using the API [update](../api-ref/Cluster/update.md) method: pass the necessary values in the `configSpec.resources.resourcePresetId` request parameter.

  To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset` resources.

{% endlist %}

## Increase the size of host disks {{ RD }} {#change-disk-size}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mrd-name }}**.
  1. Select the cluster and click **Edit cluster** at the top of the page.
  1. Under **Host class**, set the size of the {{ RD }} host disks in the **Disk size** field. You can only increase hard disk size.
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

- API

  You can change the {{ RD }} host disk size using the API [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the `configSpec.resources.diskSize` request parameter.

  Make sure the cloud quota is sufficient to increase the disk size: open the [Quotas]({{ link-console-quotas }}) page for your cloud and check that the **Managed Databases** section still has space available in the **hddSpace** line.

{% endlist %}

## Changing settings {{ RD }} {#change-redis-config}

You can change the DBMS settings of the hosts in your cluster. All supported settings are described [in the API reference](../api-ref/Cluster/update.md).

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mrd-name }}**.
  1. Select the cluster and click **Edit cluster** at the top of the page.
  1. Under **DBMS settings**, click **Settings**.
  1. Configure the available parameters according to the [{{ RD }} documentation](https://redis.io/documentation).
  1. Click **Save**.

- API

  You can change the DBMS settings for a cluster using the API [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the `configSpec.redisConfig_5_0` request parameter.

{% endlist %}

