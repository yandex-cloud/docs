# Changing cluster settings

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).

* [Increase the storage size](#change-disk-size) (available only for network storage, `network-hdd`, and `network-ssd`).

* [Configure the {{ MY }} servers](#change-mysql-config).

* [Change additional cluster settings](#change-additional-settings).

## Changing the host class {#change-resource-preset}

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

  1. Make sure the required cluster uses network storage (it's currently not possible to increase the size of local storage). To do this, request information about the cluster and find the `disk_type_id` field: it should be set to `network-hdd` or `network-ssd`:

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

  1. View a description of the CLI's update cluster configuration command:

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

- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the required values in the `configSpec.access` and `configSpec.backupWindowStart` request parameters.

{% endlist %}

