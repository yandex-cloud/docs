---
title: How to update {{ SD }} cluster settings in {{ mmg-full-name }}
description: In this tutorial, you will learn how to update {{ SD }} cluster settings.
---

# Updating {{ SD }} cluster settings 

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).
* [Change the disk type and expand the storage capacity](#change-disk-size).
* [Configure](#change-mongod-config) {{ SD }} servers as per the {{ MG }} documentation.
* [Configure advanced cluster settings](#change-additional-settings).
* [Move the cluster](#move-cluster) to another folder.
* [Update security groups](#change-sg-set).

To move a cluster to a different availability zone, follow [this guide](host-migration.md). Following this procedure, you will move the cluster hosts.

## Changing the host class {#change-resource-preset}

{% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

When changing the host class:

* A single-host cluster will be unavailable for a few minutes and all database connections will be dropped.
* A multi-host cluster will undergo a [primary replica switchover](../concepts/replication.md). The hosts will undergo a rolling update, with each host unavailable for a few minutes while it is stopped and updated.

We recommend changing the host class only when the cluster is idle.

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.

  1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.

  1. Depending on the [sharding type](../concepts/sharding.md#shard-management) you select, go to the section of the cluster resources you need to update: **Resources**, **{{ ui-key.yacloud.mongodb.ClusterForm.ClusterFormBase.section_mongod-resources_ncXUZ }}**, **{{ ui-key.yacloud.mongodb.ClusterForm.ClusterFormBase.section_mongoinfra-resources_13TPT }}**, **{{ ui-key.yacloud.mongodb.ClusterForm.ClusterFormBase.section_mongocfg-resources_1cuU2 }}**, or **{{ ui-key.yacloud.mongodb.ClusterForm.ClusterFormBase.section_mongos-resources_wBGnr }}**.

  
  1. Select:

     * One of the available [platforms](../../compute/concepts/vm-platforms.md).
     * Configuration type: **Memory-optimized**, **cpu-optimized**, **standard**, or **burstable**.
     * [Host class](../../storedoc/concepts/instance-types.md): Defines the technical specifications of the VMs where the DB hosts will be deployed. When you change the host class for the cluster, the characteristics of all existing hosts change, too.


  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the cluster’s [host class](../concepts/instance-types.md):

  1. See the description of the CLI command for updating a cluster:

      ```bash
      {{ yc-mdb-mg }} cluster update --help
      ```

  1. Get the list of available host classes. The `ZONE IDS` column indicates the availability zones supporting each class:

     
     ```bash
     {{ yc-mdb-mg }} resource-preset list

     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 8.0 GB   |
     |           | {{ region-id }}-d                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```



  1. Run the `cluster update` command, providing the required host class: When changing the class, consider the host’s role, which depends on the [sharding type](../concepts/sharding.md#shard-management). A single command supports arguments for multiple host roles.

      * For `MONGOD` hosts:

          ```bash
          {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
             --mongod-resource-preset <class_ID>
          ```

      * For `MONGOINFRA` hosts:

          ```bash
          {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
             --mongoinfra-resource-preset <class_ID>
          ```

      * For `MONGOS` hosts:

          ```bash
          {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
             --mongos-resource-preset <class_ID>
          ```

      * For `MONGOCFG` hosts:

          ```bash
          {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
             --mongocfg-resource-preset <class_ID>
          ```

      {{ mmg-short-name }} will start the host class update operation for your cluster.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.
  
      To learn how to create this file, see [Creating a cluster](cluster-create.md).
  
  1. In the {{ mmg-name }} cluster description, update the value of the `resource_preset_id` argument for `resources_mongod`, `resources_mongoinfra`, `resources_mongos`, and `resources_mongocfg` resources. The resource type depends on the [sharding type](../concepts/sharding.md#shard-management).

      Here is an example:
  
      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
        ...
        resources_mongod {
            resource_preset_id = "<host_class>"
            ...
        }
      }
      ```

  1. Validate your configuration.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm resource changes.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
 
  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mmg }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}


- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>' \
          --data '{
                    "updateMask": "configSpec.mongodb.<Yandex_StoreDoc_host_type>.resources.resourcePresetId",
                    "configSpec": {
                      "mongodb": {
                        "<Yandex_StoreDoc_host_type>": {
                          "resources": {
                            "resourcePresetId": "<host_class>"
                          }
                        }
                      }
                    }
                  }'
      ```

      Where:

      * `updateMask`: Comma-separated list of settings you want to update.

          Here, we provide only one setting.

      * `configSpec.mongodb.<Yandex_StoreDoc_host_type>.resources.resourcePresetId`: New [host class](../concepts/instance-types.md).

        The {{ SD }} host type depends on the [sharding type](../concepts/sharding.md). The possible values are `mongod`, `mongocfg`, `mongos`, and `mongoinfra`. For a non-sharded cluster, use `mongod`.

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "update_mask": {
                  "paths": [
                    "config_spec.mongodb.<Yandex_StoreDoc_host_type>.resources.resource_preset_id"
                  ]
                },
                "config_spec": {
                  "mongodb": {
                    "<Yandex_StoreDoc_host_type>": {
                      "resources": {
                        "resource_preset_id": "<host_class>"
                      }
                    }
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Update
      ```

      Where:

      * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

          Here, we provide only one setting.

      * `config_spec.mongodb.<Yandex_StoreDoc_host_type>.resources.resource_preset_id`: New host class.
      
        The {{ SD }} host type depends on the [sharding type](../concepts/sharding.md). The possible values are `mongod`, `mongocfg`, `mongos`, and `mongoinfra`. For a non-sharded cluster, use `mongod`.

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing the disk type and expanding the storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  To change the disk type and expand the storage size for a cluster:

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Depending on the [sharding type](../concepts/sharding.md#shard-management) you select, go to the section of the cluster resources you need to update: **Resources**, **{{ ui-key.yacloud.mongodb.ClusterForm.ClusterFormBase.section_mongod-resources_ncXUZ }}**, **{{ ui-key.yacloud.mongodb.ClusterForm.ClusterFormBase.section_mongoinfra-resources_13TPT }}**, **{{ ui-key.yacloud.mongodb.ClusterForm.ClusterFormBase.section_mongocfg-resources_1cuU2 }}**, or **{{ ui-key.yacloud.mongodb.ClusterForm.ClusterFormBase.section_mongos-resources_wBGnr }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**:

      * Select the [disk type](../concepts/storage.md).
      * Specify the disk size.

  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the disk type and expand the storage size for a cluster:

  1. See the description of the CLI command for updating a cluster:

      ```bash
      {{ yc-mdb-mg }} cluster update --help
      ```

  1. Specify the [disk type](../concepts/instance-types.md) and the required storage size in the `cluster update` command. The specified storage size must not be less than the `disk_size` cluster setting.

      When expanding storage, consider the host’s role, which depends on the [sharding type](../concepts/sharding.md#shard-management). A single command supports arguments for multiple host roles.

      * For `MONGOD` hosts:

          ```bash
          {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
             --mongod-disk-type <disk_type> \
             --mongod-disk-size <storage_size_in_GB>
          ```

      * For `MONGOINFRA` hosts:

          ```bash
          {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
             --mongoinfra-disk-type <disk_type> \
             --mongoinfra-disk-size <storage_size_in_GB>
          ```

      * For `MONGOS` hosts:

          ```bash
          {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
             --mongos-disk-type <disk_type> \
             --mongos-disk-size <storage_size_in_GB>
          ```

      * For `MONGOCFG` hosts:

          ```bash
          {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
             --mongocfg-disk-type <disk_type> \
             --mongocfg-disk-size <storage_size_in_GB>
          ```

      If all the conditions are met, {{ mmg-short-name }} will start the storage reconfiguration operation.


- {{ TF }} {#tf}

  To change the disk type and expand the storage size for a cluster:

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      To learn how to create this file, see [Creating a cluster](cluster-create.md).

  1. In the {{ mmg-name }} cluster description, change the values of the `disk_type_id` and `disk_size` arguments for the `resources_mongod`, `resources_mongoinfra`, `resources_mongos`, and `resources_mongocfg` resources. The resource type depends on the [sharding type](../concepts/sharding.md#shard-management).

      Here is an example:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
        ...
        resources_mongod {
          disk_type_id = "<disk_type>"
          disk_size    = <storage_size_in_GB>
          ...
        }
      }
      ```

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-mmg }}).

    {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}


- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>' \
          --data '{
                    "updateMask": "configSpec.mongodb.<Yandex_StoreDoc_host_type>.resources.diskTypeId,configSpec.mongodb.<Yandex_StoreDoc_host_type>.resources.diskSize",
                    "configSpec": {
                      "mongodb": { 
                        "<Yandex_StoreDoc_host_type>": {
                          "resources": {
                            "diskTypeId": "<disk_type>",
                            "diskSize": "<storage_size_in_bytes>"
                          }
                        }
                      }
                    }
                  }'
      ``` 

      Where:

      * `updateMask`: Comma-separated list of settings you want to update.
      
      * `configSpec.mongodb.<Yandex_StoreDoc_host_type>.resources`: Storage settings:

          * `diskTypeId`: [Disk type](../concepts/storage.md).
          * `diskSize`: New storage size, in bytes.

        The {{ SD }} host type depends on the [sharding type](../concepts/sharding.md). The possible values are `mongod`, `mongocfg`, `mongos`, and `mongoinfra`. For a non-sharded cluster, use `mongod`.

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "update_mask": {
                  "paths": [
                    "config_spec.mongodb.<Yandex_StoreDoc_host_type>.resources.disk_type_id",
                    "config_spec.mongodb.<Yandex_StoreDoc_host_type>.resources.disk_size"
                  ]
                },
                "config_spec": {
                  "mongodb": {
                    "<Yandex_StoreDoc_host_type>": {
                      "resources": {
                        "disk_type_id": "<disk_type>",
                        "disk_size": "<storage_size_in_bytes>"
                      }
                    }
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Update
      ```

      Where:

      * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

      * `config_spec.mongodb.<Yandex_StoreDoc_host_type>.resources.disk_size`: Storage settings:

          * `disk_type_id`: [Disk type](../concepts/storage.md).
          * `disk_size`: New storage size, in bytes.

        The {{ SD }} host type depends on the [sharding type](../concepts/sharding.md). The possible values are `mongod`, `mongocfg`, `mongos`, and `mongoinfra`. For a non-sharded cluster, use `mongod`.

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing {{ SD }} settings {#change-mongod-config}

You can change the DBMS settings for your cluster hosts.

{% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. To change the [{{ SD }} settings](../concepts/settings-list.md#dbms-cluster-settings), click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** under **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update the [{{ SD }} cluster settings](../concepts/settings-list.md#dbms-cluster-settings), use the following command:

  ```bash
  {{ yc-mdb-mg }} cluster update-config
  ```

  For example, run the command below to set `net.maxIncomingConnections` to `4096`:

  ```bash
  {{ yc-mdb-mg }} cluster update-config <cluster_name> \
     --set net.max_incoming_connections=4096
  ```

  {{ mmg-short-name }} will launch the reconfiguration of the cluster’s DBMS settings. If an updated setting requires a DBMS restart, {{ mmg-short-name }} will perform a rolling restart on all cluster hosts.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>' \
          --data '{
                    "updateMask": "configSpec.mongodb.<Yandex_StoreDoc_host_type>.config.<setting_1>,configSpec.mongodb.<Yandex_StoreDoc_host_type>.config.<setting_2>,...,configSpec.mongodb.<Yandex_StoreDoc_host_type>.config.<setting_N>",
                    "configSpec": {
                      "mongodb": {    
                        "<Yandex_StoreDoc_host_type>": {
                          "config": {
                            "<setting_1>": "<value_1>",
                            "<setting_2>": "<value_2>",
                            ...
                            "<setting_N>": "<value_N>"
                          }
                        }
                      }
                    }
                  }'
      ```

      Where:

      * `updateMask`: Comma-separated list of settings you want to update.

      * `configSpec.mongodb.<Yandex_StoreDoc_host_type>.config`: List of {{ SD }} settings. Enter each setting on a new line, separated by commas. All supported settings are described in the [API reference](../api-ref/Cluster/update.md) and in [{#T}](../concepts/settings-list.md).

        The {{ SD }} host type depends on the [sharding type](../concepts/sharding.md). The possible values are `mongod`, `mongocfg`, `mongos`, and `mongoinfra`. For a non-sharded cluster, use `mongod`.

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "update_mask": {
                  "paths": [
                    "config_spec.mongodb.<Yandex_StoreDoc_host_type>.config.<setting_1>",
                    "config_spec.mongodb.<Yandex_StoreDoc_host_type>.config.<setting_2>",
                    ...
                    "config_spec.mongodb.<Yandex_StoreDoc_host_type>.config.<setting_N>"
                  ]
                },
                "config_spec": {
                  "mongodb": {    
                    "<Yandex_StoreDoc_host_type>": {
                      "config": {
                        "<setting_1>": "<value_1>",
                        "<setting_2>": "<value_2>",
                        ...
                        "<setting_N>": "<value_N>"
                      }
                    }
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Update
      ```

      Where:

      * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

      * `config_spec.mongodb.<Yandex_StoreDoc_host_type>.config`: List of {{ SD }} settings. Enter each setting on a new line, separated by commas. All supported settings are described in the [API reference](../api-ref/grpc/Cluster/update.md) and in [{#T}](../concepts/settings-list.md).

        The {{ SD }} host type depends on the [sharding type](../concepts/sharding.md). The possible values are `mongod`, `mongocfg`, `mongos`, and `mongoinfra`. For a non-sharded cluster, use `mongod`.

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Configuring advanced cluster settings {#change-additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Configure advanced cluster settings:

     {% include [mmg-extra-settings](../../_includes/mdb/mmg-extra-settings.md) %}
     
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change advanced cluster settings:

    1. See the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-mg }} cluster update --help
        ```

    1. Run the following command, providing the list of settings you want to update:

        ```bash
        {{ yc-mdb-mg }} cluster update <cluster_ID_or_name> \
          --backup-retain-period-days=<retention_period> \
          --backup-window-start <backup_start_time> \
          --maintenance-window type=<maintenance_type>,`
                               `day=<day_of_week>,`
                               `hour=<hour> \
          --performance-diagnostics=<enable_diagnostics> \
          --deletion-protection
        ```

    You can update the following settings:

    * `--backup-retain-period`: Retention period for automatic backups, in days.
      
      The `<retention_period>` value must be in the range from {{ mmg-backup-retention-min }} to {{ mmg-backup-retention-max }}. The default value is {{ mmg-backup-retention }}. This feature is in [Preview](../../overview/concepts/launch-stages.md). For more information, see [Backups](../concepts/backup.md).


      Changing the retention period affects both new and existing automatic backups.

      For example, if the original retention period was 7 days, and the remaining lifetime of a specific automatic backup was 1 day, then increasing the retention period to 9 days would make that backup’s remaining lifetime 3 days.

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    * `--maintenance-window`: [Maintenance window](../concepts/maintenance.md) settings that apply to both running and stopped clusters. The `type` setting defines the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * `--performance-diagnostics`: Specify this setting to use the [Performance diagnostics](performance-diagnostics.md) tool in your cluster. This feature is in [Preview](../../overview/concepts/launch-stages.md).

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).


- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.
      
       To learn how to create this file, see [Creating a cluster](cluster-create.md).

    1. To change the backup start time, locate your {{ mmg-name }} cluster description and add the `backup_window_start` section under `cluster_config`:
  
        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
          ...
          cluster_config {
            backup_window_start {
              hours   = <hour>
              minutes = <minute>
            }
            ...
          }
          ...
        }
        ```

        Where `hours` is the hour and `minutes` is the minute of the backup start time.

    1. {% include [Maintenance window](../../_includes/mdb/mmg/terraform/maintenance-window.md) %}

    1. To protect your cluster against accidental deletion, add the `deletion_protection` field set to `true` to your cluster description:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
          ...
          deletion_protection = <protect_cluster_from_deletion>
        }
        ```

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

        To disable deletion protection, set this value to `false`.

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mmg }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}


- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      
      ```json
      {
        "updateMask": "configSpec.backupWindowStart,configSpec.backupRetainPeriodDays,configSpec.performanceDiagnostics,maintenanceWindow,deletionProtection",
        "configSpec": {
          "backupWindowStart":  {
            "hours": "<hours>",
            "minutes": "<minutes>",
            "seconds": "<seconds>",
            "nanos": "<nanoseconds>"
          },
          "backupRetainPeriodDays": "<backup_retention_in_days>",
          "performanceDiagnostics": {
            "profilingEnabled": <enable_profiler>
          }
        }
        "maintenanceWindow": {
          "weeklyMaintenanceWindow": {
            "day": "<day_of_week>",
            "hour": "<hour>"
          }
        },    
        "deletionProtection": <protect_cluster_from_deletion>
      }
      ```
    

      Where:

      * `updateMask`: Comma-separated list of settings you want to update.
      * `configSpec`: Cluster settings:

        * `backupWindowStart`: [Backup](../concepts/backup.md) window settings.

          Here, specify the backup start time:

          * `hours`: Between `0` and `23` hours.
          * `minutes`: Between `0` and `59` minutes.
          * `seconds`: Between `0` and `59` seconds.
          * `nanos`: Between `0` and `999999999` nanoseconds.

        * `backupRetainPeriodDays`: Backup retention time in days.

        * `performanceDiagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:
          * `profilingEnabled`: Enable [profiler](tools.md#explore-profiler), `true` or `false`.

      * `maintenanceWindow`: [Maintenance](../concepts/maintenance.md) window settings, applying to both running and stopped clusters. In `maintenanceWindow`, provide one of the following values:

        * `anytime`: Maintenance can occur at any time.
        * `weeklyMaintenanceWindow`: Maintenance occurs once a week at the specified time:

          * `day`: Day of the week, in `DDD` format.
          * `hour`: Hour of the day, in `HH` format. Allowed values range from `1` to `24` hours.

      * `deletionProtection`: Cluster deletion protection, `true` or `false`.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}
        
    1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>' \
            --data "@body.json"
        ```

       You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Create a file named `body.json` and paste the following code into it:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      
      ```json
      {
        "cluster_id": "<cluster_ID>",
        "update_mask": {
          "paths": [
            "config_spec.backup_window_start",
            "config_spec.backup_retain_period_days",
            "config_spec.performance_diagnostics",
            "maintenance_window",
            "deletion_protection"
          ]
        },
        "config_spec": {
          "backup_window_start": {
            "hours": "<hours>",
            "minutes": "<minutes>",
            "seconds": "<seconds>",
            "nanos": "<nanoseconds>"
          },
          "backup_retain_period_days": "<backup_retention_in_days>",
          "performance_diagnostics": {
            "profiling_enabled": <enable_profiler>
          }
        },
        "maintenance_window": {
          "weekly_maintenance_window": {
            "day": "<day_of_week>",
            "hour": "<hour>"
          }
        },
        "deletion_protection": <protect_cluster_from_deletion>
      }
      ```


      Where:

      * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).
      * `config_spec`: Cluster settings:

        * `backup_window_start`: [Backup](../concepts/backup.md) window settings.

          Here, specify the backup start time:

          * `hours`: Between `0` and `23` hours.
          * `minutes`: Between `0` and `59` minutes.
          * `seconds`: Between `0` and `59` seconds.
          * `nanos`: Between `0` and `999999999` nanoseconds.

        * `backup_retain_period_days`: Backup retention time in days.

        * `performance_diagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:

          * `profiling_enabled`: Enable [profiler](tools.md#explore-profiler), `true` or `false`.

      * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings, applying to both running and stopped clusters. In `maintenance_window`, provide one of the following values:

        * `anytime`: Maintenance can occur at any time.
        * `weekly_maintenance_window`: Maintenance occurs once a week at the specified time:

          * `day`: Day of the week, in `DDD` format.
          * `hour`: Hour of the day, in `HH` format. Allowed values range from `1` to `24` hours.

      * `deletion_protection`: Cluster deletion protection, `true` or `false`.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

  1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Update \
          < body.json
      ```

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the cluster you want to move.
    1. Select **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.
    1. Select the destination folder for your cluster.
    1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To move a cluster:

    1. See the description of the CLI command for moving a cluster:

        ```bash
        {{ yc-mdb-mg }} cluster move --help
        ```

    1. Run the `cluster move` command, providing the destination folder:

        ```bash
        {{ yc-mdb-mg }} cluster move <cluster_name_or_ID> \
           --destination-folder-name=<destination_folder_name>
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).


- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](./cluster-create.md).

    1. In the {{ mmg-name }} cluster description, add or update the `folder_id` argument:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
          ...
          folder_id = "<destination_folder_ID>"
        }
        ```

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-mmg }}).

    {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}


- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.Move](../api-ref/Cluster/move.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>:move' \
          --data '{
                    "destinationFolderId": "<folder_ID>"
                  }'
      ```

      Where `destinationFolderId` is the ID of the target folder for your cluster. You can get it from the [list of your cloud folders](../../resource-manager/operations/folder/get-id.md)

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/move.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.Move](../api-ref/grpc/Cluster/move.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "destination_folder_id": "<folder_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Move
      ```

      Where `destination_folder_id` is the ID of the target folder for your cluster. You can get it from the [list of your cloud folders](../../resource-manager/operations/folder/get-id.md)

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/move.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


## Updating security groups {#change-sg-set}

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
    1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select the security groups that control the cluster’s network traffic.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the list of [security groups](../concepts/network.md#security-groups) for your cluster:

    1. See the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-mg }} cluster update --help
        ```

    1. Run the `cluster update` command, providing the required security groups:

        ```bash
        {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
          --security-group-ids <list_of_security_group_IDs>
        ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.
      
       To learn how to create this file, see [Creating a cluster](cluster-create.md).

    1. Update the `security_group_ids` value in the {{ mmg-name }} cluster description:
  
        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
          ...
          security_group_ids = [ <list_of_security_group_IDs> ]
          ...
        }
        ```

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mmg }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}


- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>' \
          --data '{
                    "updateMask": "securityGroupIds",
                    "securityGroupIds": [
                      "<security_group_1_ID>",
                      "<security_group_2_ID>",
                      ...
                      "<security_group_N_ID>"
                    ]
                  }'
      ```

      Where:

      * `updateMask`: Comma-separated list of settings you want to update.

          Here, we provide only one setting.

      * `securityGroupIds`: List of [security group](../concepts/network.md#security-groups) IDs.

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "update_mask": {
                  "paths": [
                    "security_group_ids"
                  ]
                },
                "security_group_ids": [
                  "<security_group_1_ID>",
                  "<security_group_2_ID>",
                  ...
                  "<security_group_N_ID>"
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.Update
      ```

      Where:

      * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

          Here, we provide only one setting.

      * `security_group_ids`: List of [security group](../concepts/network.md#security-groups) IDs.

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% note warning %}

You may need to [configure security groups](connect/index.md#configuring-security-groups) to enable access to your cluster.

{% endnote %}

