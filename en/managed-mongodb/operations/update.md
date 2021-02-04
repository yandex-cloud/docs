# Changing cluster settings

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).

* [Increase the storage size](#change-disk-size) (available only for network storage, `network-hdd`, and `network-ssd`).

* [Configure servers](#change-mongod-config) {{ MG }} according to the [{{ MG }} documentation](https://docs.mongodb.com/v3.6/reference/configuration-options/).

## Changing the host class {#change-resource-preset}

{% list tabs %}

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
     | s1.nano   | ru-central1-a, ru-central1-b,  |     1 | 4.0 GB   |
     |           | ru-central1-c                  |       |          |
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

  You can change the cluster [host class](../concepts/instance-types.md) using the API's [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the request parameter `configSpec.mongodbSpec_3_6.mongod.config.resourcePresetId`.

  To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset` resources.

{% endlist %}

## Increasing storage size {#change-disk-size}

{% list tabs %}

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
        mongodb_3_6:
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

      If all these conditions are met, {{ mmg-short-name }}  launches the operation to increase storage space.

- API

  You can change the storage size for a cluster using the API [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the request parameter `configSpec.mongodbSpec_3_6.mongod.resources.diskSize`.

  Make sure the cloud's quota is sufficient to increase the storage size: open the [Quotas]({{ link-console-quotas }}) page for your cloud and check that the {{ mmg-full-name }} section still has space available in the **space** line.

{% endlist %}

## Changing settings {{ MG }} {#change-mongod-config}

You can change the DBMS settings of the hosts in your cluster. All supported settings are described [in the API reference](../api-ref/Cluster/update.md).

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the DBMS settings for a cluster, use the command:

  ```
  $ {{ yc-mdb-mg }} cluster update-config
  ```

  For example, to set [net.maxIncomingConnections](https://docs.mongodb.com/v4.0/reference/configuration-options/#net.maxIncomingConnections) to `4096`, run the following command:

  ```
  $ {{ yc-mdb-mg }} cluster update-config <cluster name>
      --set net.max_incoming_connections=4096
  ```

  {{ mmg-short-name }} will run the update DB configuration command for the cluster. If the setting being changed is only applied when the database is restarted, {{ mmg-short-name }} sequentially restarts the database on all the cluster hosts.

- API

  You can change the DBMS settings for a cluster using the API [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the request parameter `configSpec.mongodbSpec_3_6.mongod.config.resourcePresetId`.

{% endlist %}

