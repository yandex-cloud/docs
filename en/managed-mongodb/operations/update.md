# Changing cluster settings

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).

* [Increase the storage size](#change-disk-size) (available only for network storage, `network-hdd`, and `network-ssd`).

* [Configure {{ MG }} servers](change-mongod-config) according to the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/configuration-options/).

* [Change additional cluster settings](#change-additional-settings).

## Change the host class {#change-resource-preset}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. To change the class of {{ MG }} hosts, under **Host class**, select the required class.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [host class](../concepts/instance-types.md) for the cluster:

  1. View a description of the CLI's update cluster command:

      ```
      $ {{ yc-mdb-mg }} cluster update --help
      ```

  1. Request a list of available host classes (the `ZONES` column specifies the availability zones where you can select the appropriate class):

     
     ```bash
     $ {{ yc-mdb-mg }} resource-preset list
     
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
      $ {{ yc-mdb-mg }} cluster update <cluster name>
           --mongod-resource-preset <class ID>
      ```

      {{ mmg-short-name }} will run the update host class command for the cluster.

- API

  You can change the cluster [host class](../concepts/instance-types.md) using the API's [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the request parameter `configSpec.mongodbSpec_4_2.mongod.resources.resourcePresetId`.

  To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset` resources.

{% endlist %}

## Increasing storage size {#change-disk-size}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmg-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Under **Storage size**, specify the required value.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To increase the storage size for a cluster:

  1. View a description of the CLI's update cluster command:

      ```
      $ {{ yc-mdb-mg }} cluster update --help
      ```

  1. Make sure the cloud's quota is sufficient to increase the storage size: open the [Quotas]({{ link-console-quotas }}) page for your cloud and check that the {{ mmg-full-name }} section still has space available in the **space** line.

  1. Make sure the required cluster is using network storage (it is not yet possible to increase the size of local storage). To do this, request information about the cluster and find the `disk_type_id` field: it should be set to `network-hdd` or `network-ssd`:

      ```
      $ {{ yc-mdb-mg }} cluster get <cluster name>
      
      id: c7qkvr3u78qiopj3u4k2
      folder_id: b1g0ftj57rrjk9thribv
      ...
      config:
        mongodb_4_4:
          mongod:
            config:
              user_config: {}
            resources:
              resource_preset_id: s1.micro
              disk_size: "21474836480"
              disk_type_id: network-ssd
      ...
      ```

  1. Specify the required amount of storage in the update cluster command (it must be at least as large as `disk_size` in the cluster properties):

      ```
      $ {{ yc-mdb-mg }} cluster update <cluster name>
           --mongod-disk-size <storage size in GB>
      ```

      If all these conditions are met, {{ mmg-short-name }} launches the operation to increase storage space.

- API

  You can change the storage size for a cluster using the API [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the request parameter `configSpec.mongodbSpec_4_2.mongod.resources.diskSize`.

  Make sure the cloud's quota is sufficient to increase the storage size: open the [Quotas]({{ link-console-quotas }}) page for your cloud and check that the {{ mmg-full-name }} section still has space available in the **space** line.

{% endlist %}

## Changing {{ MG }} settings {#change-mongod-config}

You can change the DBMS settings of the hosts in your cluster.

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmg-name }}**.

  1. Select the cluster and click **Edit cluster** in the top panel.

  1. Change the {{ MG }} settings by clicking **Configure** under **DBMS settings**:

      {% include [mmg-dbms-settings](../../_includes/mdb/mmg-dbms-settings.md) %}

  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the DBMS settings for a cluster, use the command:

  ```
  $ {{ yc-mdb-mg }} cluster update-config
  ```

  For example, to set [net.maxIncomingConnections](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-net.maxIncomingConnections) to `4096`, run the following command:

  ```
  $ {{ yc-mdb-mg }} cluster update-config <cluster name>
      --set net.max_incoming_connections=4096
  ```

  {{ mmg-short-name }} will run the update DBMS settings command for the cluster. If the setting being changed is only applied when the database is restarted, {{ mmg-short-name }} sequentially restarts the database on all the cluster hosts.

- API

  You can update DBMS settings for a cluster using the API [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the request parameter `configSpec.mongodbSpec_4_2.mongod.config`.

  All supported settings are described [in the API reference](../api-ref/Cluster/update.md).

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mmg-name }}**.

  1. Select the cluster and click **Edit cluster** in the top panel.

  1. Change additional cluster settings:

     {% include [mmg-extra-settings](../../_includes/mdb/mmg-extra-settings.md) %}

  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Change additional cluster settings:

  - To set the [backup](cluster-backups.md) start time, run the following command:

    ```
    $ {{ yc-mdb-mg }} cluster update "<cluster name>" --backup-window-start="<time>"
    ```

    Time is specified in UTC format `HH:MM:SS`. If the time is not set, the backup will start at 22:00 UTC.

  - To set the retention period for automatic backups (in days), run the following command:

    ```
    $ {{ yc-mdb-mg }} cluster update "<cluster name>" --backup-retain-period-days="<retention period>"
    ```

    The parameter `--backup-retain-period-days` must be in the range from {{ mmg-backup-retention-min }} to {{ mmg-backup-retention-max }} (default value is {{ mmg-backup-retention }}). If an automatic backup expires, it is deleted. This feature is at the [Preview stage](../../overview/concepts/launch-stages.md). For more information, see [{#T}](../concepts/backup.md).

    Changing the retention period affects both new automatic backups and existing backups: when you increase/decrease the retention period, the lifetime for existing backups increases/decreases.

    For example, if the original retention period was 7 days and the remaining lifetime of a separate automatic backup is 1 day, then when the retention period increases to 9 days, the remaining lifetime of this backup becomes 3 days.

  You can get the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

