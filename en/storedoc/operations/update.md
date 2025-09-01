---
title: How to change {{ SD }} cluster settings in {{ mmg-full-name }}
description: Follow this guide to change {{ SD }} cluster settings.
---

# Updating {{ SD }} cluster settings 

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).
* [Change the disk type and increase the storage size](#change-disk-size).
* [Configure](#change-mongod-config) {{ SD }} servers as described in the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/configuration-options/).
* [Change additional cluster settings](#change-additional-settings).
* [Move a cluster](#move-cluster) to another folder.
* [Edit security groups](#change-sg-set).

To move a cluster to a different availability zone, follow [this guide](host-migration.md). You will thus move the cluster hosts.

## Changing the host class {#change-resource-preset}

{% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

When changing the host class:

* Your single-host cluster will be unavailable for a few minutes with database connections terminated.
* A multi-host cluster will get a new [primary replica](../concepts/replication.md). Its hosts will be stopped and updated one by one. Once stopped, a host will be unavailable for a few minutes.

We recommend changing the host class only when the cluster has no active workload.

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **Yandex StoreDoc**.

  1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.

  1. {% include [mmg-settings-host-class](../../_includes/mdb/mmg/settings-host-class.md) %}

  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [host class](../concepts/instance-types.md) for the cluster:

  1. View the description of the CLI command to update a cluster:

      ```bash
      {{ yc-mdb-mg }} cluster update --help
      ```

  1. Request a list of available host classes (the `ZONE IDS` column specifies the availability zones where you can select the appropriate class):

     
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



  1. Specify the class in the update cluster command. When changing the class, keep in mind the host role: it depends on the [sharding type](../concepts/sharding.md#shard-management). You can use parameters for hosts with different roles in a single command.

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

      {{ mmg-short-name }} will run the update host class command for the cluster.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.
  
      For more information about creating this file, see [Creating clusters](cluster-create.md).
  
  1. In the {{ mmg-name }} cluster description, change the `resource_preset_id` parameter value for `resources_mongod`, `resources_mongoinfra`, `resources_mongos`, or `resources_mongocfg`. The resource type depends on the [sharding type](../concepts/sharding.md#shard-management).

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

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
 
  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

      * `updateMask`: List of parameters to update as a single string, separated by commas.

          Only one parameter is provided in this case.

      * `configSpec.mongodb.<Yandex_StoreDoc_host_type>.resources.resourcePresetId`: New [host class](../concepts/instance-types.md).

        {{ SD }} host type depends on the [sharding type](../concepts/sharding.md). Possible values: `mongod`, `mongocfg`, `mongos`, and `mongoinfra`. For a non-sharded cluster, use `mongod`.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.

          Only one parameter is provided in this case.

      * `config_spec.mongodb.<{{ MG }}_host_type>.resources.resourcepresetid`: New host class.
      
        {{ MG }} host type depends on the [sharding type](../concepts/sharding.md). Possible values: `mongod`, `mongocfg`, `mongos`, and `mongoinfra`. For a non-sharded cluster, use `mongod`.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Change the disk type and increase the storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  To change the disk type and  increase the storage size for a cluster:

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **Yandex StoreDoc**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

      * Select the [disk type](../concepts/storage.md).
      * Specify the required disk size.

  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the disk type and increase the storage size for a cluster:

  1. View the description of the CLI command to update a cluster:

      ```bash
      {{ yc-mdb-mg }} cluster update --help
      ```

  1. Specify the [disk type](../concepts/instance-types.md) and required storage size in the cluster update command (at least as large as `disk_size` in the cluster properties).

      When increasing the storage size, keep in mind the host role: it depends on the [sharding type](../concepts/sharding.md#shard-management). You can use parameters for hosts with different roles in a single command.

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

  To change the disk type and increase the storage size for a cluster:

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

  1. In the {{ mmg-name }} cluster description, change the values of the `disk_type_id` and `disk_size` parameters for the following resources: `resources_mongod`, `resources_mongoinfra`, `resources_mongos`, and `resources_mongocfg`. The resource type depends on the [sharding type](../concepts/sharding.md#shard-management).

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

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

    {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>' \
          --data '{
                    "updateMask": "configSpec.mongodb.<{{ MG }}_host_type>.resources.diskTypeId,configSpec.mongodb.<{{ MG }}_host_type>.resources.diskSize",
                    "configSpec": {
                      "mongodb": { 
                        "<{{ MG }}_host_type>": {
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

      * `updateMask`: List of parameters to update as a single string, separated by commas.
      
      * `configSpec.mongodb.<{{ MG }}_host_type>.resources`: Storage parameters:

          * `diskTypeId`: [Disk type](../concepts/storage.md).
          * `diskSize`: New storage size in bytes.

        {{ MG }} host type depends on the [sharding type](../concepts/sharding.md). Possible values: `mongod`, `mongocfg`, `mongos`, and `mongoinfra`. For a non-sharded cluster, use `mongod`.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
                    "config_spec.mongodb.<{{ MG }}_host_type>.resources.disk_type_id",
                    "config_spec.mongodb.<{{ MG }}_host_type>.resources.disk_size"
                  ]
                },
                "config_spec": {
                  "mongodb": {
                    "<{{ MG }}_host_type>": {
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

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.

      * `config_spec.mongodb.<{{ MG }}_host_type>.resources.disk_size`: Storage parameters:

          * `disk_type_id`: [Disk type](../concepts/storage.md).
          * `disk_size`: New storage size in bytes.

        The {{ MG }} host type depends on the [sharding type](../concepts/sharding.md). Possible values: `mongod`, `mongocfg`, `mongos`, and `mongoinfra`. For a non-sharded cluster, use `mongod`.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Changing {{ MG }} settings {#change-mongod-config}

You can change the DBMS settings of the hosts in your cluster.

{% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **Yandex StoreDoc**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
  1. To change the [{{ MG }} settings](../concepts/settings-list.md#dbms-cluster-settings), click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** under **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update the [{{ MG }} settings](../concepts/settings-list.md#dbms-cluster-settings) for a cluster, run the command:

  ```bash
  {{ yc-mdb-mg }} cluster update-config
  ```

  For example, to set [net.maxIncomingConnections](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-net.maxIncomingConnections) to `4096`, run the following command:

  ```bash
  {{ yc-mdb-mg }} cluster update-config <cluster_name> \
     --set net.max_incoming_connections=4096
  ```

  {{ mmg-short-name }} will run the update DBMS settings command for the cluster. If the setting being changed is only applied when the database is restarted, {{ mmg-short-name }} will restart the database instances on all cluster hosts, one by one.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>' \
          --data '{
                    "updateMask": "configSpec.mongodb.<{{ MG }}_host_type>.config.<setting_1>,configSpec.mongodb.<{{ MG }}_host_type>.config.<setting_2>,...,configSpec.mongodb.<{{ MG }}_host_type>.config.<setting_N>",
                    "configSpec": {
                      "mongodb": {    
                        "<{{ MG }}_host_type>": {
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

      * `updateMask`: List of parameters to update as a single string, separated by commas.

      * `configSpec.mongodb.<{{ MG }}_host_type>.config`: List of {{ MG }} settings. Use a separate line for each setting; separate them by commas. All supported settings are described in the [API reference](../api-ref/Cluster/update.md) and in [{#T}](../concepts/settings-list.md).

        {{ MG }} host type depends on the [sharding type](../concepts/sharding.md). Possible values: `mongod`, `mongocfg`, `mongos`, and `mongoinfra`. For a non-sharded cluster, use `mongod`.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
                    "config_spec.mongodb.<{{ MG }}_host_type>.config.<setting_1>",
                    "config_spec.mongodb.<{{ MG }}_host_type>.config.<setting_2>",
                    ...
                    "config_spec.mongodb.<{{ MG }}_host_type>.config.<setting_N>"
                  ]
                },
                "config_spec": {
                  "mongodb": {
                    "<{{ MG }}_host_type>": {
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

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.

      * `config_spec.mongodb.<{{ MG }}_host_type>.config`: List of {{ MG }} settings. Use a separate line for each setting; separate them by commas. All supported settings are described in the [API reference](../api-ref/grpc/Cluster/update.md) and in [{#T}](../concepts/settings-list.md).

        {{ MG }} host type depends on the [sharding type](../concepts/sharding.md). Possible values: `mongod`, `mongocfg`, `mongos`, and `mongoinfra`. For a non-sharded cluster, use `mongod`.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **Yandex StoreDoc**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Change additional cluster settings:

     {% include [mmg-extra-settings](../../_includes/mdb/mmg-extra-settings.md) %}
     
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change additional cluster settings:

    1. View the description of the CLI command to update a cluster:

        ```bash
        {{ yc-mdb-mg }} cluster update --help
        ```

    1. Run the following command with the list of settings to update:

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

    You can change the following settings:

    * `--backup-retain-period`: Automatic backup retention period, in days.
      
      The `<retention_period>` parameter value must be in the range from {{ mmg-backup-retention-min }} to {{ mmg-backup-retention-max }} (the default value is {{ mmg-backup-retention }}). This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage. For more information, see [Backups](../concepts/backup.md).


      Changing the retention period affects both new automatic backups and existing backups.

      For example, if the original retention period was 7 days, and the remaining lifetime of a separate automatic backup is 1 day, then increasing the retention period to 9 days will change the remaining lifetime of this backup to 3 days.

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    * `--maintenance-window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters), where `type` is the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * `--performance-diagnostics`: Specify this parameter to use the [Performance diagnostics](performance-diagnostics.md) tool in the cluster. This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage.

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    You can get the cluster ID and name with the [list of clusters](cluster-list.md#list-clusters) in the folder.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.
      
       For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. To change the backup start time, add a `backup_window_start` section to the {{ mmg-name }} cluster description under `cluster_config`:
  
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

        Where `hours` and `minutes` are the backup start hour and minute.

    1. {% include [Maintenance window](../../_includes/mdb/mmg/terraform/maintenance-window.md) %}

    1. To protect your cluster against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
          ...
          deletion_protection = <protect_cluster_from_deletion>
        }
        ```

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

        To disable the protection, set the value to `false`.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and add the following contents to it:

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

      * `updateMask`: List of parameters to update as a single string, separated by commas.
      * `configSpec`: Cluster settings:

        * `backupWindowStart`: [Backup](../concepts/backup.md) window settings.

          In this parameter, specify the backup start time:

          * `hours`: Between `0` and `23` hours.
          * `minutes`: Between `0` and `59` minutes.
          * `seconds`: Between `0` and `59` seconds.
          * `nanos`: Between `0` and `999999999` nanoseconds.

        * `backupRetainPeriodDays`: Backup retention in days.

        * `performanceDiagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:
          * `profilingEnabled`: Enable [profiler](tools.md#explore-profiler), `true` or `false`.

      * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters). In `maintenanceWindow`, provide one of the two parameters:

        * `anytime`: Maintenance can take place at any time.
        * `weeklyMaintenanceWindow`: Maintenance takes place once a week at the specified time:

          * `day`: Day of week, in `DDD` format.
          * `hour`: Hour, in `HH` format. The values range from `1` to `24` hours.

      * `deletionProtection`: Cluster protection from accidental deletion, `true` or `false`.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}
        
    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>' \
            --data "@body.json"
        ```

       You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Create a file named `body.json` and add the following contents to it:

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

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.
      * `config_spec`: Cluster settings:

        * `backup_window_start`: [Backup](../concepts/backup.md) window settings.

          In this parameter, specify the backup start time:

          * `hours`: Between `0` and `23` hours.
          * `minutes`: Between `0` and `59` minutes.
          * `seconds`: Between `0` and `59` seconds.
          * `nanos`: Between `0` and `999999999` nanoseconds.

        * `backup_retain_period_days`: Backup retention in days.

        * `performance_diagnostics`: [Statistics collection](performance-diagnostics.md#activate-stats-collector) settings:

          * `profiling_enabled`: Enable [profiler](tools.md#explore-profiler), `true` or `false`.

      * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters). In `maintenance_window`, provide one of the two parameters:

        * `anytime`: Maintenance can take place at any time.
        * `weekly_maintenance_window`: Maintenance takes place once a week at the specified time:

          * `day`: Day of week, in `DDD` format.
          * `hour`: Hour, in `HH` format. The values range from `1` to `24` hours.

      * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`.

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

  1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

  1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the folder dashboard and select **Yandex StoreDoc**.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the cluster you want to move.
    1. Select **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.
    1. Select a folder you want to move the cluster to.
    1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To move a cluster:

    1. View the description of the CLI move cluster command:

        ```bash
        {{ yc-mdb-mg }} cluster move --help
        ```

    1. Specify the destination folder in the move cluster command:

        ```bash
        {{ yc-mdb-mg }} cluster move <cluster_name_or_ID> \
           --destination-folder-name=<destination_folder_name>
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](./cluster-create.md).

    1. In the {{ mmg-name }} cluster description, edit or add the `folder_id` parameter value:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
          ...
          folder_id = "<destination_folder_ID>"
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

    {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Move](../api-ref/Cluster/move.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

      Where `destinationFolderId` is the ID of the folder you want to move your cluster to. You can fetch this ID together with the [list of folders](../../resource-manager/operations/folder/get-id.md) in the cloud.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/move.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Move](../api-ref/grpc/Cluster/move.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

      Where `destination_folder_id` is the ID of the folder you want to move your cluster to. You can fetch this ID together with the [list of folders](../../resource-manager/operations/folder/get-id.md) in the cloud.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/move.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}


## Editing security groups {#change-sg-set}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **Yandex StoreDoc**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select security groups for cluster network traffic.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

    1. View the description of the CLI command to update a cluster:

        ```bash
        {{ yc-mdb-mg }} cluster update --help
        ```

    1. Specify the security groups in the update cluster command:

        ```bash
        {{ yc-mdb-mg }} cluster update <cluster_name_or_ID> \
          --security-group-ids <list_of_security_group_IDs>
        ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.
      
       For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. In the {{ mmg-name }} cluster description, change the `security_group_ids` parameter value:
  
        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
          ...
          security_group_ids = [ <list_of_security_group_IDs> ]
          ...
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmg }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

      * `updateMask`: List of parameters to update as a single string, separated by commas.

          Only one parameter is provided in this case.

      * `securityGroupIds`: List of [security group](../concepts/network.md#security-groups) IDs.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.

          Only one parameter is provided in this case.

      * `security_group_ids`: List of [security group](../concepts/network.md#security-groups) IDs.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect/index.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

