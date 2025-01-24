---
title: How to change {{ GP }} cluster settings in {{ mgp-full-name }}
description: Follow this guide to change {{ GP }} cluster settings.
---

# Updating {{ GP }} cluster settings


After creating a cluster, you can:

* [Change the cluster name and description](#change-name-and-description).
* [Change the public access setting](#change-public-access).
* [Change additional cluster settings](#change-additional-settings).
* [Edit the scheduled maintenance operations settings](#change-background-settings).
* [Update settings {{ GP }}](#change-gp-settings) according to the {{ GP }} documentation.
* [Change the host class](#change-resource-preset).
* [Increase storage size](#change-disk-size).

To move a cluster to a different availability zone, [restore it from a backup](cluster-backups.md#restore). While restoring the cluster, specify a new availability zone. You will thus move the cluster hosts.

If you use [external data sources](../concepts/external-tables.md) for PXF operations, [learn how to configure the protocol](./pxf/settings.md). This will allow you to optimize operations with external data.

## Changing the cluster name and description {#change-name-and-description}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** at the top of the page.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, enter a new name and description for the cluster.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the name and description of a {{ GP }} cluster:

  1. View the current `name` and `description` of the cluster:

     ```bash
     {{ yc-mdb-gp }} cluster get <cluster_name_or_ID>
     ```

  1. View a description of the update cluster configuration CLI command:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Enter a new name and description for the cluster:

      ```bash
      {{ yc-mdb-gp }} cluster update <cluster_name_or_ID> \
         --new-name <new_cluster_name> \
         --description <new_cluster_description>
      ```

- {{ TF }} {#tf}

    {% note alert %}

    Do not change the cluster name using {{ TF }}. This will delete the existing cluster and create a new one.

    {% endnote %}

    To update the cluster description:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ mgp-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mgp }}).

    1. In the {{ mgp-name }} cluster description, change the `description` attribute value:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<cluster_name>" {
          name        = "<cluster_name>"
          description = "<new_cluster_description>"
          ...
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "name,description",
                      "name": "<new_cluster_name>",
                      "description": "<new_cluster_description>"
                    }'
        ```

        Where `updateMask` is the list of parameters to update as a single string, separated by commas.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ "name", "description" ]
                  },
                  "name": "<new_cluster_name>",
                  "description": "<new_cluster_description>" 
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Where `update_mask` is the list of parameters to update as an array of `paths[]` strings.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Change the public access setting {#change-public-access}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** at the top of the page.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, enable or disable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To сhange the public access setting {{ GP }}:

  1. View a description of the update cluster configuration CLI command:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Configure public access in the `--assign-public-ip` parameter:

      ```bash
      {{ yc-mdb-gp }} cluster update <cluster_name_or_ID> \
         --assign-public-ip=<public_access_to_cluster>
      ```

      Where `assign-public-ip` is public access to the cluster, true or false.

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
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "config.assignPublicIp",
                      "config": {
                        "assignPublicIp": <public_access_to_cluster_hosts>
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            Only one parameter is provided in this case.

        * `assignPublicIp`: Public access to cluster hosts, `true` or `false`.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ "config.assign_public_ip" ]
                  },
                  "config": {
                    "assign_public_ip": <public_access_to_cluster_hosts> 
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Only one parameter is provided in this case.

        * `assign_public_ip`: Public access to cluster hosts, `true` or `false`.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% note tip %}

If you enabled public access to the cluster but cannot access it from the internet:

* Check the [security group settings](./connect#configuring-security-groups).
* Wait a while. It may take some time to enable public access.

{% endnote %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
    1. Change additional cluster settings:

        * {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}
        * **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance](../concepts/maintenance.md) window settings:

            {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

        
        * {% include [Datalens access](../../_includes/mdb/console/datalens-access.md) %}
        * {% include [Query access](../../_includes/mdb/console/query-access.md) %}



        * {% include [Deletion protection](../../_includes/mdb/console/deletion-protection.md) %}

            {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

        * **{{ ui-key.yacloud.greenplum.section_cloud-storage }}**: Enables [hybrid storage](../concepts/hybrid-storage.md).

            You cannot disable hybrid storage after you save your cluster settings.

            {% include [hybrid-storage-description](../../_includes/mdb/mgp/hybrid-storage-description.md) %}

            
            {% include [Cloud storage Preview](../../_includes/mdb/mgp/cloud-storage-preview.md) %}


        * **{{ ui-key.yacloud.mdb.forms.section_pooler }}**: Operation mode and parameters of the [connection pooler](../concepts/pooling.md):

            {% include [Pooling mode](../../_includes/mdb/mgp/pooling-mode.md) %}

    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change additional cluster settings:

    1. View the description of the update cluster CLI command:

        ```bash
        {{ yc-mdb-gp }} cluster update --help
        ```

    1. Run the following command with a list of settings to update:

        
        ```bash
        {{ yc-mdb-gp }} cluster update <cluster_name_or_ID> \
            --backup-window-start <backup_start_time> \
            --datalens-access=<access_from_{{ datalens-name }}> \
            --yandexquery-access=<access_from_Yandex_Query> \
            --maintenance-window type=<maintenance_type>,`
                                `day=<day_of_week>,`
                                `hour=<hour> \
            --deletion-protection
        ```




    You can change the following settings:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    
    * `--datalens-access`: Access to the cluster from [{{ datalens-full-name }}](../../datalens/concepts/index.md), `true` or `false`.

    * `--yandexquery-access`: Access to the cluster from [{{ yq-full-name }}](../../query/concepts/index.md), `true` or `false`.



    * `--maintenance-window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters), where `type` is the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Deletion protection limits db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    You can [get the cluster name with a list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ mgp-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mgp }}).

    1. In the {{ mgp-name }} cluster description, change the values of the required additional settings:

        
        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<cluster_name>" {
          ...
          backup_window_start {
            hours = <backup_period_start>
          }

          maintenance_window {
            type = <maintenance_type>
            day  = <day_of_week>
            hour = <hour>
          }

          access {
            data_lens    = <access_from_{{ datalens-name }}>
            yandex_query = <access_from_Yandex_Query>
          }

          deletion_protection = <deletion_protection>

          cloud_storage {
            enable = <hybrid_storage_use>
          }

          pooler_config {
            pooling_mode             = <operation_mode>
            pool_size                = <size>
            pool_client_idle_timeout = <client_timeout>
          }
        }
        ```




        You can change the following settings:

        * `backup_window_start.hours`: Start of the period for initiating cluster [backup](../concepts/backup.md). It is set in UTC in `HH` format: from `0` to `23`.

        * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters):

            * `type`: Maintenance type. The possible values include:
                * `ANYTIME`: Anytime.
                * `WEEKLY`: On a schedule.
            * `day`: Day of the week in `DDD` format for the `WEEKLY` type, e.g., `MON`.
            * `hour`: Hour UTC in `HH` format for the `WEEKLY` type, e.g., `21`.

        
        * `access.data_lens`: Access to the cluster from [{{ datalens-full-name }}](../../datalens/concepts/index.md), `true` or `false`.

        * `access.yandex_query`: Access to the cluster from [{{ yq-full-name }}](../../query/concepts/index.md), `true` or `false`.



        * `deletion_protection`: Protection of the cluster, its databases, and users against deletion, `true` or `false` value.

            {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

        * `cloud_storage.enable`: Use of [hybrid storage](../concepts/hybrid-storage.md).

            Set to `true` to enable hybrid storage. You cannot disable hybrid storage after you save your cluster settings.

            {% include [hybrid-storage-description](../../_includes/mdb/mgp/hybrid-storage-description.md) %}

            
            {% include [Cloud storage Preview](../../_includes/mdb/mgp/cloud-storage-preview.md) %}


        * `pooler_config`: [Connection pooler](../concepts/pooling.md) settings:

            * `pooling_mode`: Operation mode, `SESSION` or `TRANSACTION`.
            * `pool_size`: Maximum number of client connections.
            * `pool_client_idle_timeout`: Idle timeout for a client connection (in ms).

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and add the following contents to it:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        
        ```json
        {
          "updateMask": "config.backupWindowStart,config.access.dataLens,config.access.yandexQuery,maintenanceWindow,deletionProtection,configSpec.pool.mode,configSpec.pool.size,configSpec.pool.clientIdleTimeout,cloudStorage",
          "config": {
            "backupWindowStart": {
              "hours": "<hours>",
              "minutes": "<minutes>",
              "seconds": "<seconds>",
              "nanos": "<nanoseconds>"
            },
            "access": {
              "dataLens": <access_from_{{ datalens-name }}>,
              "yandexQuery": <access_from_Yandex_Query>
            }
          },
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          },
          "deletionProtection": <cluster_deletion_protection>,
          "configSpec": {
            "pool": {
              "mode": "<operation_mode>",
              "size": "<number_of_client_connections>",
              "clientIdleTimeout": "<client_timeout>"
            }
          },
          "cloudStorage": {
            "enable": <hybrid_storage_use>
          }
        }
        ```




        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

        * `config`: Cluster settings:

            * `backupWindowStart`: [Backup](../concepts/backup.md) window settings.

                In this parameter, specify the backup start time:

                * `hours`: Between `0` and `23` hours.
                * `minutes`: Between `0` and `59` minutes.
                * `seconds`: Between `0` and `59` seconds.
                * `nanos`: Between `0` and `999999999` nanoseconds.

            
            * `access`: Cluster settings for access to the following {{ yandex-cloud }} services:

                * `dataLens`: [{{ datalens-full-name }}](../../datalens/index.yaml), `true` or `false`.
                * `yandexQuery`: [{{ yq-full-name }}](../../query/concepts/index.md), `true` or `false`.



        * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters). Provide one of the two parameters:

            * `anytime`: Maintenance can take place at any time.
            * `weeklyMaintenanceWindow`: Maintenance takes place once a week at the specified time:

                * `day`: Day of week in `DDD` format: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                * `hour`: Hour of day (UTC), from `1` to `24`.

        * `deletionProtection`: Cluster deletion protection, `true` or `false`.

            {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

        * `configSpec.pool`: [Connection pooler](../concepts/pooling.md) settings:

            * `mode`: Operation mode, `SESSION` or `TRANSACTION`.
            * `size`: Maximum number of client connections.
            * `clientIdleTimeout`: Idle timeout for a client connection (in ms).

        * `cloudStorage.enable`: Use of hybrid storage in clusters with {{ GP }} 6.25 or higher. Set it to `true` to enable the {{ yandex-cloud }} [{{ YZ }}](https://github.com/yezzey-gp/yezzey/) extension in a cluster. This extension is used to export [AO and AOCO tables](../tutorials/yezzey.md) from disks within the {{ mgp-name }} cluster to a cold storage in {{ objstorage-full-name }}. This way, the data will be stored in a service bucket in a compressed and encrypted form. This is a [more cost-efficient storage method](../../storage/pricing.md).

            You cannot disable hybrid storage after you save your cluster settings.

            
            {% include [Cloud storage Preview](../../_includes/mdb/mgp/cloud-storage-preview.md) %}


    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>' \
            --data "@body.json"
        ```

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and add the following contents to it:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        
        ```json
        {
          "cluster_id": "<cluster_ID>"
          "update_mask": {
            "paths": [
              "config.backup_window_start",
              "config.access.data_lens",
              "config.access.yandex_query",
              "maintenance_window",
              "deletion_protection",
              "config_spec.pool.mode",
              "config_spec.pool.size",
              "config_spec.pool.client_idle_timeout",
              "cloud_storage"
            ]
          },
          "config": {
            "backup_window_start": {
              "hours": "<hours>",
              "minutes": "<minutes>",
              "seconds": "<seconds>",
              "nanos": "<nanoseconds>"
            },
            "access": {
              "data_lens": <access_from_{{ datalens-name }}>,
              "yandex_query": <access_from_Yandex_Query>
            }
          },
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          },
          "deletion_protection": <cluster_deletion_protection>,
          "config_spec": {
            "pool": {
              "mode": "<operation_mode>",
              "size": "<number_of_client_connections>",
              "client_idle_timeout": "<client_timeout>"
            }
          },
          "cloud_storage": {
            "enable": <hybrid_storage_use>
          }
        }
        ```




        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

        * `config`: Cluster settings:

            * `backup_window_start`: [Backup](../concepts/backup.md) window settings.

                In this parameter, specify the backup start time:

                * `hours`: Between `0` and `23` hours.
                * `minutes`: Between `0` and `59` minutes.
                * `seconds`: Between `0` and `59` seconds.
                * `nanos`: Between `0` and `999999999` nanoseconds.

            
            * `access`: Cluster settings for access to the following {{ yandex-cloud }} services:

                * `data_lens`: [{{ datalens-full-name }}](../../datalens/index.yaml), `true` or `false`.
                * `yandex_query`: [{{ yq-full-name }}](../../query/concepts/index.md), `true` or `false`.



        * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters). Provide one of the two parameters:

            * `anytime`: Maintenance can take place at any time.
            * `weekly_maintenance_window`: Maintenance takes place once a week at the specified time:

                * `day`: Day of week in `DDD` format: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                * `hour`: Hour of day (UTC), from `1` to `24`.

        * `deletion_protection`: Cluster deletion protection, `true` or `false`.

            {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

        * `config_spec.pool`: [Connection pooler](../concepts/pooling.md) settings:

            * `mode`: Operation mode, `SESSION` or `TRANSACTION`.
            * `size`: Maximum number of client connections.
            * `client_idle_timeout`: Idle timeout for a client connection (in ms).

        * `cloud_storage.enable`: Use of hybrid storage in clusters with {{ GP }} 6.25 or higher. Set it to `true` to enable the {{ yandex-cloud }} [{{ YZ }}](https://github.com/yezzey-gp/yezzey/) extension in a cluster. This extension is used to export [AO and AOCO tables](../tutorials/yezzey.md) from disks within the {{ mgp-name }} cluster to a cold storage in {{ objstorage-full-name }}. This way, the data will be stored in a service bucket in a compressed and encrypted form. This is a [more cost-efficient storage method](../../storage/pricing.md).

            You cannot disable hybrid storage after you save your cluster settings.

            
            {% include [Cloud storage Preview](../../_includes/mdb/mgp/cloud-storage-preview.md) %}


        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update \
            < body.json
        ```

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Editing the scheduled maintenance operations settings {#change-background-settings}

You can edit your cluster's [scheduled maintenance operations](../concepts/maintenance.md#regular-ops) settings.

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.greenplum.section_background-activities }}**, change the parameters:

        {% include [background activities](../../_includes/mdb/mgp/background-activities-console.md) %}

    1. Click **{{ ui-key.yacloud.common.save }}**.

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
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.backgroundActivities.analyzeAndVacuum.start,configSpec.backgroundActivities.analyzeAndVacuum.analyzeTimeout,configSpec.backgroundActivities.analyzeAndVacuum.vacuumTimeout",
                      "configSpec": {
                        "backgroundActivities": {
                          "analyzeAndVacuum": {
                            "start": {
                              "hours": "<operation_start_hour>",
                              "minutes": "<operation_start_minute>"
                            },
                            "analyzeTimeout": "<ANALYZE_operation_duration>",
                            "vacuumTimeout": "<VACUUM_operation_duration>"
                          }
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

        * `configSpec.backgroundActivities.analyzeAndVacuum`: Background process management settings:

            * `start.hours`: Start hour of the `VACUUM` operation in UTC. The values range from `0` to `23`, the default one is `19`.
            * `start.minutes`: Start minute of the `VACUUM` operation in UTC. The values range from `0` to `59`, the default one is `0`.
            * `analyzeTimeout`: Maximum duration of the `ANALYZE` operation, in seconds. The values range from `7200` to `86399`, the default one is `36000`. As soon as this period expires, the `ANALYZE` operation will be forced to terminate.
            * `vacuumTimeout`: Maximum duration of the `VACUUM` operation, in seconds. The values range from `7200` to `86399`, the default one is `36000`. As soon as this period expires, the `VACUUM` operation will be forced to terminate.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ 
                      "config_spec.background_activities.analyze_and_vacuum.start",
                      "config_spec.background_activities.analyze_and_vacuum.analyze_timeout",
                      "config_spec.background_activities.analyze_and_vacuum.vacuumTimeout"
                    ]
                  },
                  "config_spec": {
                    "background_activities": {
                      "analyze_and_vacuum": {
                        "start": {
                          "hours": "<operation_start_hour>",
                          "minutes": "<operation_start_minute>"
                        },
                        "analyze_timeout": "<ANALYZE_operation_duration>",
                        "vacuum_timeout": "<VACUUM_operation_duration>"
                      }
                    }
                  } 
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

        * `config_spec.background_activities.analyze_and_vacuum`: Background process management settings:

            * `start.hours`: Start hour of the `VACUUM` operation in UTC. The values range from `0` to `23`, the default one is `19`.
            * `start.minutes`: Start minute of the `VACUUM` operation in UTC. The values range from `0` to `59`, the default one is `0`.
            * `analyze_timeout`: Maximum duration of the `ANALYZE` operation, in seconds. The values range from `7200` to `86399`, the default one is `36000`. As soon as this period expires, the `ANALYZE` operation will be forced to terminate.
            * `vacuum_timeout`: Maximum duration of the `VACUUM` operation, in seconds. The values range from `7200` to `86399`, the default one is `36000`. As soon as this period expires, the `VACUUM` operation will be forced to terminate.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Changing {{ GP }} settings {#change-gp-settings}

You can change the DBMS settings of the hosts in your cluster.

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
  1. Change the [{{ GP }}](../concepts/settings-list.md) settings by clicking **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** under **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
  1. Click **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [{{ GP }}](../concepts/settings-list.md) DBMS settings:

  1. View the full list of settings specified for the cluster:

     ```bash
     {{ yc-mdb-gp }} cluster get <cluster_name_or_ID>
     ```

  1. View a description of the update cluster configuration CLI command:

      ```bash
      {{ yc-mdb-gp }} cluster update-config --help
      ```

  1. Set the required parameter values:

      All supported parameters are listed in the [request format for the update method](../api-ref/Cluster/update.md), in the `greenplumConfig_<Greenplum_version>` field. To specify a parameter name in the CLI call, convert its name from <q>lowerCamelCase</q> to <q>snake_case</q>. For example, convert the `maxConnections` parameter from an API request to `max_connections` for the CLI command:

      ```bash
      {{ yc-mdb-gp }} cluster update-config <cluster_name_or_ID> \
         --set <parameter1_name>=<value1>,<parameter2_name>=<value2>,...
      ```

      {{ mgp-short-name }} runs the update cluster settings operation.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ mgp-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mgp }}).

    1. In the cluster description, edit the [{{ GP }} settings](../concepts/settings-list.md) under `greenplum_config`:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<cluster_name>" {
          ...
          greenplum_config = {
            max_connections         = <maximum_number_of_connections>
            gp_workfile_compression = <true_or_false>
            ...
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.greenplumConfig_<{{ GP }}_version>.<setting_1>,...,configSpec.greenplumConfig_<{{ GP }}_version>.<setting_N>",
                      "configSpec": {
                        "greenplumConfig_<{{ GP }}_version>": {
                          "<setting_1>": "<value_1>",
                          "<setting_2>": "<value_2>",
                          ...
                          "<setting_N>": "<value_N>"
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            In this case, list all the {{ GP }} settings to update.

        * `configSpec.greenplumConfig_<{{ GP }}>`_version: {{ GP }} settings. Use a separate line for each setting; separate them by commas.

            See the [method description](../api-ref/Cluster/update.md#yandex.cloud.mdb.greenplum.v1.UpdateClusterRequest) for the list of {{ GP }} versions available for the parameter. See [{#T}](../concepts/settings-list.md#dbms-cluster-settings) for a description and possible values for each setting.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ 
                      "config_spec.greenplum_config_<{{ GP }}_version>.<setting_1>",
                      "config_spec.greenplum_config_<{{ GP }}_version>.<setting_2>",
                      ...
                      "config_spec.greenplum_config_<{{ GP }}_version>.<setting_N>"
                    ]
                  },
                  "config_spec": {
                    "greenplum_config_<{{ GP }}_version>": {
                      "<setting_1>": "<value_1>",
                      "<setting_2>": "<value_2>",
                      ...
                      "<setting_N>": "<value_N>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            In this case, list all the {{ GP }} settings to update.

        * `config_spec.greenplum_config_<{{ GP }}>`_version: {{ GP }} settings. Use a separate line for each setting; separate them by commas.

            See the [method description](../api-ref/grpc/Cluster/update.md#yandex.cloud.mdb.greenplum.v1.UpdateClusterRequest) for the list of {{ GP }} versions available for the parameter. See [{#T}](../concepts/settings-list.md) for a description and possible values for each setting.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Changing the host class {#change-resource-preset}

You can change the host class for both master hosts and segment hosts. When changing the host class:

* The cluster's primary master host will change.
* Using a [special FQDN](./connect.md#fqdn-master) does not guarantee a stable database connection: user sessions may be terminated.

Changing the segment host class [affects](../concepts/instance-types.md#select-class-segment-hosts) the maximum amount of memory allocated to each {{ GP }} server process.

We recommend changing the host class only when the cluster has no active workload.

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select the required class for {{ GP }} master hosts or segment hosts.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [host class](../concepts/instance-types.md) for the cluster:

  1. View the description of the update cluster CLI command:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Request a list of available classes (the `ZONE IDS` column lists the availability zones where you can select the appropriate class):
     * For master hosts:

        ```bash
        {{ yc-mdb-gp }} resource-preset list master
        ```

     * For segment hosts:

        ```bash
        {{ yc-mdb-gp }} resource-preset list segment
        ```

     
     ```text
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     |     ID      |            ZONE IDS            |           DISK TYPES           | CORES |  MEMORY  | HOST COUNT DIVIDER | MAX SEGMENT IN HOST |
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     | i2.2xlarge  | {{ region-id }}-a, {{ region-id }}-b   | local-ssd,                     |    16 | 128.0 GB |                  1 |                   0 |
     |             |                                | network-ssd-nonreplicated      |       |          |                    |                     |
     | ...                                                                                                                                         |
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     ```


  1. Specify the required classes in the cluster update command:

      ```bash
      {{ yc-mdb-gp }} cluster update <cluster_name_or_ID> \
          --master-config resource-id=<master_host_class_ID> \
          --segment-config resource-id=<segment_host_class_ID>
      ```

      {{ mgp-short-name }} will run the update host class command for the cluster.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mgp-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mgp }}).

  1. In the {{ mgp-name }} cluster description, change the `resource_preset_id` attribute value under `master_subcluster.resources` or `segment_subcluster.resources`:

      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<cluster_name>" {
        ...
        master_subcluster {
          resources {
            resource_preset_id = "<host_class>"
            ...
          }
        }
        segment_subcluster {
          resources {
            resource_preset_id = "<host_class>"
            ...
          }
        }
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "masterConfig.resources.resourcePresetId,segmentConfig.resources.resourcePresetId",
                      "masterConfig": {
                        "resources": {
                          "resourcePresetId": "<host_class>"
                        }
                      },
                      "segmentConfig": {
                        "resources": {
                          "resourcePresetId": "<host_class>"
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

        * `masterConfig.resources.resourcePresetId` and `segmentConfig.resources.resourcePresetId`: New [host class](../concepts/instance-types.md) for master and segment hosts.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ 
                      "master_config.resources.resource_preset_id",
                      "segment_config.resources.resource_preset_id"
                    ]
                  },
                  "master_config": {
                    "resources": {
                      "resource_preset_id": "<host_class>"
                    }
                  },
                  "segment_config": {
                    "resources": {
                      "resource_preset_id": "<host_class>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

        * `master_config.resources.resource_preset_id` and `segment_config.resources.resource_preset_id`: New [host class](../concepts/instance-types.md) for master and segment hosts.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Increasing storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  To increase the cluster storage size:

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Select the cluster you need.
  1. At the top of the page, click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. Edit the settings in the **{{ ui-key.yacloud.mdb.forms.section_storage }}** section.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ mgp-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mgp }}).

    1. In the {{ mgp-name }} cluster description, change the `disk_size` attribute value under `master_subcluster.resources` or `segment_subcluster.resources`:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<cluster_name>" {
          ...
          master_subcluster {
            resources {
              disk_size = <storage_size_in_GB>
              ...
            }
          }
          segment_subcluster {
            resources {
              disk_size = <storage_size_in_GB>
              ...
            }
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "masterConfig.resources.diskSize,segmentConfig.resources.diskSize",
                      "masterConfig": {
                        "resources": {
                          "diskSize": "<storage_size_in_bytes>"
                        }
                      },
                      "segmentConfig": {
                        "resources": {
                          "diskSize": "<storage_size_in_bytes>"
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

        * `masterConfig.resources.diskSize` and `segmentConfig.resources.diskSize`: New disk size in bytes for master and segment hosts.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

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
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ 
                      "master_config.resources.disk_size",
                      "segment_config.resources.disk_size"
                    ]
                  },
                  "master_config": {
                    "resources": {
                      "disk_size": "<storage_size_in_bytes>"
                    }
                  },
                  "segment_config": {
                    "resources": {
                      "disk_size": "<storage_size_in_bytes>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

        * `master_config.resources.disk_size` and `segment_config.resources.disk_size`: New disk size in bytes for master and segment hosts.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
