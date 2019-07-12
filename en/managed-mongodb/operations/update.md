# Changing cluster settings

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).

* [Increase the storage size](#change-disk-size) (available only for network storage, `network-hdd` and `network-nvme`).

* [Configure the servers](#change-mongod-config) MongoDB as described in the [documentation MongoDB](https://docs.mongodb.com/v3.6/reference/configuration-options/).

## Change the host class {#change-resource-preset}

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [host class](../concepts/instance-types.md) for the cluster:

  1. View the description of the CLI's update cluster command:

      ```
      $ yc managed-mongodb cluster update --help
      ```

  2. Request a list of available host classes (the `ZONES` column specifies the availability zones where you can select the appropriate class):

      ```bash
      $ yc managed-mongodb resource-preset list

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

  3. Specify the class in the update cluster command:

      ```
      $ yc managed-mongodb cluster update <cluster name>
           --mongod-resource-preset <class ID>
      ```

      Managed Service for MongoDB will run the update host class command for the cluster.

- API

  You can change the cluster [host class](../concepts/instance-types.md) using the API's [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the request parameter `configSpec.mongodbSpec_3_6.mongod.config.resourcePresetId`.

  To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset` resources.

{% endlist %}

## Increasing the storage size {#change-disk-size}

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To increase the storage size for a cluster:

  1. View the description of the CLI's update cluster command:

      ```
      $ yc managed-mongodb cluster update --help
      ```

  2. Make sure the cloud's quota is sufficient to increase the storage size: open the [Quotas](https://console.cloud.yandex.com/cloud?section=quotas
  ) page for your cloud and check that the Yandex Managed Service for MongoDB section still has space remaining in the **space** line.

  3. Make sure the required cluster is using network storage (it is not yet possible to increase the size of local storage). To do this, request information about the cluster and find the `disk_type_id` field: it should be set to `network-hdd` or `network-nvme`:

      ```
      $ yc managed-mongodb cluster get <cluster name>

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
              disk_type_id: network-nvme
      ...
      ```

  4. Specify the required amount of storage in the update cluster command (it must be at least as large as `disk_size` in the cluster properties):

      ```
      $ yc managed-mongodb cluster update <cluster name>
           --mongod-disk-size <storage size in GB>
      ```

      If all requirements are met, Managed Service for MongoDB runs the operation to increase the storage size.

- API

  You can change the storage size for a cluster using the API [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the request parameter `configSpec.mongodbSpec_3_6.mongod.resources.diskSize`.

  Make sure the cloud's quota is sufficient to increase the storage size: open the [Quotas](https://console.cloud.yandex.com/cloud?section=quotas
  ) page for your cloud and check that the Yandex Managed Service for MongoDB section still has space remaining in the **space** line.

{% endlist %}

## Changing MongoDB {#change-mongod-config} settings

You can change the DBMS settings of the hosts in your cluster. All supported settings are described [in the API reference](../api-ref/Cluster/update.md).

{% list tabs %}

- API

  You can change the DBMS settings for a cluster using the API [update](../api-ref/Cluster/update.md) method: pass the appropriate values in the request parameter `configSpec.mongodbSpec_3_6.mongod.config.resourcePresetId`.

{% endlist %}

