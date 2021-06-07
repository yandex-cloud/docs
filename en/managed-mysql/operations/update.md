# Changing cluster settings

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).

* [Increase the storage size](#change-disk-size) (available only for network storage, `network-hdd`, and `network-ssd`).

* [Configure the {{ MY }} servers](#change-mysql-config).

    {% note warning %}

    You can't change {{ MY }} server settings using SQL commands.

    {% endnote %}

* [Change additional cluster settings](#change-additional-settings).

* [{#T}](#change-sg-set).

{% note warning %}

You can't change {{ MY }} server settings using SQL commands.

{% endnote %}

## Change the host class {#change-resource-preset}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. To change the class of {{ MY }} hosts, under **Host class**, select the required class.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [host class](../concepts/instance-types.md) for the cluster:

  1. View a description of the CLI's update cluster command:

      ```
      $ {{ yc-mdb-my }} cluster update --help
      ```

  1. Request a list of available host classes (the `ZONES` column specifies the availability zones where you can select the appropriate class):

     
     ```
     $ {{ yc-mdb-my }} resource-preset list
     
     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | ru-central1-a, ru-central1-b,  |     2 | 8.0 GB   |
     |           | ru-central1-c                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```

  1. Specify the class in the update cluster command:

      ```
      $ {{ yc-mdb-my }} cluster update <cluster name>
           --resource-preset <class ID>
      ```

      {{ mmy-short-name }} will run the update host class command for the cluster.

- API

  You can change the [host class](../concepts/instance-types.md) using the API [update](../api-ref/Cluster/update.md) method: pass the necessary value in the request parameter `configSpec.resources.resourcePresetId`.

  To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset` resources.

{% endlist %}

## Increasing storage size {#change-disk-size}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Under **Storage size**, specify the required value.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To increase the storage size for a cluster:

  1. View a description of the CLI's update cluster command:

      ```
      $ {{ yc-mdb-my }} cluster update --help
      ```

  1. Make sure the cloud's quota is sufficient to increase the storage size: open the [Quotas]({{ link-console-quotas }}) page for your cloud and check that the {{ mmy-full-name }} section still has space available in the **space** line.

  1. Make sure the required cluster is using network storage (it is not yet possible to increase the size of local storage). To do this, request information about the cluster and find the `disk_type_id` field: it should be set to `network-hdd` or `network-ssd`:

      ```
      $ {{ yc-mdb-my }} cluster get <cluster name>
      
      id: c7qkvr3u78qiopj3u4k2
      folder_id: b1g0ftj57rrjk9thribv
      ...
      config:
        ...
        resources:
          resource_preset_id: s1.micro
          disk_size: "10737418240"
          disk_type_id: network-ssd
      ...
      ```

  1. Specify the required amount of storage in the update cluster command (it must be at least as large as `disk_size` in the cluster properties):

      ```
      $ {{ yc-mdb-my }} cluster update <cluster name>
           --disk-size <storage size in GB>
      ```

      If all these conditions are met, {{ mmy-short-name }} launches the operation to increase storage space.

- API

  You can change the storage size for a cluster using the API [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the request parameter `configSpec.resources.diskSize`.

  Make sure the cloud's quota is sufficient to increase the storage size: open the [Quotas]({{ link-console-quotas }}) page for your cloud and check that the {{ mmy-full-name }} section still has space available in the **space** line.

{% endlist %}

## Changing {{ MY }} settings {#change-mysql-config}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmy-name }}**.

  1. Select the cluster and click **Edit cluster** in the top panel.

  1. Change the {{ MY }} settings by clicking **Configure** under **DBMS settings**:

     {% include [mmy-dbms-settings](../../_includes/mdb/mmy-dbms-settings.md) %}

  1. Click **Save**.

  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change {{ MY }} server settings:

  1. View the description of the CLI's update cluster configuration command:

      ```
      $ {{ yc-mdb-my }} cluster update-config --help
      ```

  1. Set the required parameter values.

     All supported parameters are listed in [the request format for the update method](../api-ref/Cluster/update.md), in the `mysql_config_5_7` field. To specify the parameter name in the CLI's call, convert the name from <q>lowerCamelCase</q> to <q>snake_case</q>. For example, the `logMinDurationStatement` parameter from an API request should be converted to `log_min_duration_statement` for the CLI command:

     ```
     $ {{ yc-mdb-my }} cluster update-config <cluster name>
          --set log_min_duration_statement=100,<parameter name>=<value>,...
     ```

     {{ mmy-short-name }} runs the update cluster settings operation.

- API

  You can change the DBMS settings for a cluster using the API [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the request parameter `configSpec.mysql_config_5_7`.

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmy-name }}**.

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
            --maintenance-window type=<weekly or anytime> \
            --websql-access=<true or false>
        ```

    You can change the following settings:

    {% include [backup-window-start](../../_includes/mdb/cli-additional-settings/backup-window-start.md) %}
    * `--datalens-access`: Enables DataLens access. Default value: `false`. For more information about how to connect to DataLens, see [{#T}](datalens-connect.md).

    {% include [maintenance-window](../../_includes/mdb/cli-additional-settings/maintenance-window.md) %}
    * `--websql-access`: Enables [SQL queries](web-sql-query.md) to be run from the management console. Default value: `false`.

    You can get the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the required values in the `configSpec.access` and `configSpec.backupWindowStart` request parameters.

{% endlist %}

## Changing security groups {#change-sg-set}

{% list tabs %}

- Management console
    1. Go to the folder page and select **{{ mmy-name }}**.
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
           --security-group-ids <list of security groups>
        ```

- API

    To edit the list of cluster [security groups](../concepts/network.md#security-groups), use the `update` API method and pass the following in the request:
    * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md).
    * The list of groups in the `securityGroupIds` parameter.
    * The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect.md#configure-security-groups) to connect to the cluster.

{% endnote %}

