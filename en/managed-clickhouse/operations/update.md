---
title: How to change {{ CH }} cluster settings in {{ mch-full-name }}
description: Follow this guide to change {{ CH }} cluster settings.
---

# Updating {{ CH }} cluster settings

After creating a cluster, you can:

* [Change service account settings](#change-service-account).
* [Change the host class](#change-resource-preset).
* [Increase storage size](#change-disk-size).
* [Enable user and database management via SQL](#SQL-management).
* [Change additional cluster settings](#change-additional-settings).
* [Move the cluster](#move-cluster) to another folder.
* [Change cluster security groups](#change-sg-set).
* [Changing hybrid storage settings](#change-hybrid-storage).

Learn more about other cluster updates:

* [Migrating a cluster to a different availability zone](host-migration.md).
* [Configuring {{ CH }} servers](change-server-level-settings.md) as described in [this {{ CH }} article]({{ ch.docs }}/operations/server-configuration-parameters/settings).
* [Changing {{ CH }} settings at the query level](change-query-level-settings.md).


## Changing service account settings {#change-service-account}


To link your service account to a {{ mch-name }} cluster, [assign](../../iam/operations/roles/grant.md) the [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) role or higher to your {{ yandex-cloud }} account.


{% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    To change the service account settings:

    1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**, select your service account from the list or [create a new one](../../iam/operations/sa/create.md). For more information about setting up a service account, see [{#T}](s3-access.md).

{% endlist %}


## Changing the host class {#change-resource-preset}

{% note info %}

You cannot use {{ ZK }} hosts in clusters with {{ CK }} support. To learn more, see [Replication](../concepts/replication.md).

{% endnote %}

When changing the host class:

* Your single-host cluster will be unavailable for a few minutes with database connections terminated.
* In a multi-host cluster, hosts will be stopped and updated one by one. When stopped, a host will be unavailable for a few minutes.
* Using a [special FQDN](connect/fqdn.md#auto) does not guarantee a stable database connection: user sessions may be terminated.

We recommend changing the host class only when your cluster has no active workload.

The host class affects the RAM amount {{ CH }} can use. For more information, see [Memory management](../concepts/memory-management.md).

The minimum number of cores per {{ ZK }} host depends on the total number of cores on {{ CH }} hosts. To learn more, see [Replication](../concepts/replication.md#zk).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. To change the {{ CH }} host class, select the platform, VM type, and required host class under **{{ ui-key.yacloud.mdb.forms.new_section_resource }}**.
  1. To change the {{ ZK }} host class, select the platform, VM type, and required {{ ZK }} host class under **{{ ui-key.yacloud.mdb.forms.section_zookeeper-resource }}**.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [host class](../concepts/instance-types.md) for a cluster:

  1. View the description of the CLI command to update a cluster:

     ```bash
     {{ yc-mdb-ch }} cluster update --help
     ```

  1. Request a list of available host classes (the `ZONE IDS` column specifies the availability zones where you can select the appropriate class):

     
     ```bash
     {{ yc-mdb-ch }} resource-preset list

     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 8.0 GB   |
     |           | {{ region-id }}-d                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```


  1. Specify the class in the update cluster command:

     ```bash
     {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
        --clickhouse-resource-preset=<class_ID>
     ```

     {{ mch-short-name }} will run the update host class command for the cluster.

  1. To change the class of a {{ ZK }} host, provide the value you need in the `--zookeeper-resource-preset` parameter.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [this guide](cluster-create.md).

    1. In the {{ mch-name }} cluster description, change the value of the `resource_preset_id` parameter in the `clickhouse.resources` and `zookeeper.resources` sections for {{ CH }} and {{ ZK }} hosts, respectively:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          clickhouse {
            resources {
              resource_preset_id = "<{{ CH }}_host_class>"
              ...
            }
          }
          zookeeper {
            resources {
              resource_preset_id = "<{{ ZK }}_host_class>"
              ...
            }
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Request a list of available host classes:

        1. Use the [ResourcePreset.List](../api-ref/ResourcePreset/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/resourcePresets'
            ```

        1. View the [server response](../api-ref/ResourcePreset/list.md#responses) to make sure your request was successful.

    1. Change the host class as appropriate:

        1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

            {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>' \
                --data '{
                          "updateMask": "configSpec.clickhouse.resources.resourcePresetId,configSpec.zookeeper.resources.resourcePresetId",
                          "configSpec": {
                            "clickhouse": {
                              "resources": {
                                "resourcePresetId": "<{{ CH }}_host_class_ID>"
                              }
                            },
                            "zookeeper": {
                              "resources": {
                                "resourcePresetId": "<{{ ZK }}_host_class_ID>"
                              }
                            }
                          }
                        }'
            ```

            Where:

            * `updateMask`: List of parameters to update as a single string, separated by commas.

                Specify the relevant parameters:
                * `configSpec.clickhouse.resources.resourcePresetId`: To change the {{ CH }} host class.
                * `configSpec.zookeeper.resources.resourcePresetId`: To change the {{ ZK }} host class.

                In our request example, we are changing both {{ CH }} and {{ ZK }} host classes.

            * `configSpec.clickhouse.resources.resourcePresetId`: {{ CH }} host class ID.
            * `configSpec.zookeeper.resources.resourcePresetId`: {{ ZK }} host class ID.

            You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters). Earlier, you already obtained the list of available host classes with their IDs.

        1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Request a list of available host classes:

        1. Use the [ResourcePresetService/List](../api-ref/grpc/ResourcePreset/list.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/resource_preset_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.clickhouse.v1.ResourcePresetService.List
            ```

        1. View the [server response](../api-ref/grpc/ResourcePreset/list.md#yandex.cloud.mdb.clickhouse.v1.ListResourcePresetsResponse) to make sure your request was successful.

    1. Change the host class as appropriate:

        1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

            {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<cluster_ID>",
                      "update_mask": {
                        "paths": [
                          "config_spec.clickhouse.resources.resource_preset_id",
                          "config_spec.zookeeper.resources.resource_preset_id"
                        ]
                      },
                      "config_spec": {
                        "clickhouse": {
                          "resources": {
                            "resource_preset_id": "<{{ CH }}_host_class_ID>"
                          }
                        },
                        "zookeeper": {
                          "resources": {
                            "resource_preset_id": "<{{ ZK }}_host_class_ID>"
                          }
                        }
                      }
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
            ```

            Where:

            * `update_mask`: List of parameters to update as an array of `paths[]` strings.

                Specify the relevant parameters:
                * `config_spec.clickhouse.resources.resource_preset_id`: To change the {{ CH }} host class.
                * `config_spec.zookeeper.resources.resource_preset_id`: To change the {{ ZK }} host class.

                In our request example, we are changing both {{ CH }} and {{ ZK }} host classes.

            * `config_spec.clickhouse.resources.resource_preset_id`: {{ CH }} host class ID.
            * `config_spec.zookeeper.resources.resource_preset_id`: {{ ZK }} host class ID.

            You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters). Earlier, you already obtained the list of available host classes with their IDs.

        1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Increasing your storage size {#change-disk-size}

{% note info %}

You cannot use {{ ZK }} hosts in clusters with {{ CK }} support. To learn more, see [Replication](../concepts/replication.md).

{% endnote %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  To increase your cluster storage size:

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, specify the value you need.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To increase your cluster storage size:

  1. View the description of the CLI command to update a cluster:

     ```bash
     {{ yc-mdb-ch }} cluster update --help
     ```

  1. Specify the required storage size in the cluster update command (it must be at least as large as `disk_size` in the cluster properties):

     ```bash
     {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
       --clickhouse-disk-size <storage_size_in_GB>
     ```

  1. To increase the storage size of {{ ZK }} hosts, provide the value you need in the `--zookeeper-disk-size` parameter.

- {{ TF }} {#tf}

  To increase the storage size:

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [this guide](cluster-create.md).

    1. In the {{ mch-name }} cluster description, change the value of the `disk_size` parameter in the `clickhouse.resources` and `zookeeper.resources` sections for {{ CH }} and {{ ZK }} hosts, respectively:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          clickhouse {
            resources {
              disk_size = <storage_size_in_GB>
              ...
            }
          }
          zookeeper {
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

    For more information, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.clickhouse.resources.diskSize,configSpec.zookeeper.resources.diskSize",
                      "configSpec": {
                        "clickhouse": {
                          "resources": {
                            "diskSize": "<storage_size_in_bytes>"
                          }
                        },
                        "zookeeper": {
                          "resources": {
                            "diskSize": "<storage_size_in_bytes>"
                          }
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            Specify the relevant parameters:

            * `configSpec.clickhouse.resources.diskSize`: To increase the storage size of {{ CH }} hosts.
            * `configSpec.zookeeper.resources.diskSize`: To increase the storage size of {{ ZK }} hosts.

            In our request example, we are increasing the storage size for both {{ CH }} and {{ ZK }} hosts.

        * `configSpec.clickhouse.resources.diskSize`: {{ CH }} host storage size, in bytes.
        * `configSpec.zookeeper.resources.diskSize`: {{ ZK }} host storage size, in bytes.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [
                      "config_spec.clickhouse.resources.disk_size",
                      "config_spec.zookeeper.resources.disk_size"
                    ]
                  },
                  "config_spec": {
                    "clickhouse": {
                      "resources": {
                        "disk_size": "<storage_size_in_bytes>"
                      }
                    },
                    "zookeeper": {
                      "resources": {
                        "disk_size": "<storage_size_in_bytes>"
                      }
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Where:
        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Specify the relevant parameters:

            * `config_spec.clickhouse.resources.disk_size`: To increase the storage size of {{ CH }} hosts.
            * `config_spec.zookeeper.resources.disk_size`: To increase the storage size of {{ ZK }} hosts.

            In our request example, we are increasing the storage size for both {{ CH }} and {{ ZK }} hosts.

        * `config_spec.clickhouse.resources.disk_size`: {{ CH }} host storage size, in bytes.
        * `config_spec.zookeeper.resources.disk_size`: {{ ZK }} host storage size, in bytes.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Enabling user and database management via SQL {#SQL-management}

{{ mch-name }} enables managing cluster [users](./cluster-users.md#sql-user-management) and [databases](./databases.md#sql-database-management) via SQL.

{% note alert %}

This disables user and database management through native {{ yandex-cloud }} interfaces, such as management console, CLI, {{ TF }}, and API.

You cannot disable settings for user or database management via SQL once they are enabled.

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. To [manage users via SQL](./cluster-users.md#sql-user-management), enable **{{ ui-key.yacloud.mdb.forms.section_settings }}** under **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** and specify the `admin` password.
  1. To [manage databases via SQL](./databases.md#sql-database-management), enable **{{ ui-key.yacloud.mdb.forms.section_settings }}** and **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** under **{{ ui-key.yacloud.mdb.forms.database_field_sql-database-management }}** and specify the `admin` password.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. To enable [user management via SQL](./cluster-users.md#sql-user-management):

        * Set `--enable-sql-user-management` to `true`.
        * Set a password for `admin` in the `--admin-password` parameter.

        ```bash
        {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
           ...
           --enable-sql-user-management true \
           --admin-password "<admin_user_password>"
        ```

    1. To enable [database management via SQL](./databases.md#sql-database-management):

        * Set `--enable-sql-user-management` and `--enable-sql-database-management` to `true`.
        * Set a password for `admin` in the `--admin-password` parameter.

        ```bash
        {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
           ...
           --enable-sql-user-management true \
           --enable-sql-database-management true \
           --admin-password "<admin_user_password>"
        ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [this guide](cluster-create.md).

    1. {% include [Enable SQL user management with Terraform](../../_includes/mdb/mch/terraform/sql-management-users.md) %}

    1. {% include [Enable SQL database management with Terraform](../../_includes/mdb/mch/terraform/sql-management-databases.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider article]({{ tf-provider-mch }}).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.adminPassword,configSpec.sqlUserManagement,configSpec.sqlDatabaseManagement",
                      "configSpec": {
                        "adminPassword": "<admin_password>",
                        "sqlUserManagement": <user_management_via_SQL>,
                        "sqlDatabaseManagement": <database_management_via_SQL>
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            Specify the relevant parameters:

            * `configSpec.adminPassword`: Password of the `admin` account used for management.
            * `configSpec.sqlUserManagement`: To enable user management via SQL.
            * `configSpec.sqlDatabaseManagement`: To enable database management via SQL.

            In our request example, both user and database management via SQL are enabled.

        * `configSpec.adminPassword`: `admin` password.
        * `configSpec.sqlUserManagement`: User management via SQL, `true` or `false`.
        * `configSpec.sqlDatabaseManagement`: Database management via SQL, `true` or `false`. For that, you also need to enable user management through SQL.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [
                      "config_spec.admin_password",
                      "config_spec.sql_user_management",
                      "config_spec.sql_database_management"
                    ]
                  },
                  "config_spec": {
                    "admin_password": "<admin_password>",
                    "sql_user_management": <user_management_via_SQL>,
                    "sql_database_management": <database_management_via_SQL>
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Specify the relevant parameters:

            * `config_spec.admin_password`: Password of the `admin` account used for management.
            * `config_spec.sql_user_management`: To enable user management via SQL.
            * `config_spec.sql_database_management`: To enable database management via SQL.

            In our request example, both user and database management via SQL are enabled.

        * `config_spec.admin_password`: `admin` user password.
        * `config_spec.sql_user_management`: User management via SQL, `true` or `false`.
        * `config_spec.sql_database_management`: Database management via SQL, `true` or `false`. For that, you also need to enable user management through SQL.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**, change the following additional cluster settings:

     {% include [mch-extra-settings](../../_includes/mdb/mch/extra-settings-web-console.md) %}

  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change additional cluster settings:

    1. View the description of the CLI command to update a cluster:

        ```bash
        {{ yc-mdb-ch }} cluster update --help
        ```

    1. Run the following command with the list of settings to update:

        
        ```bash
        {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
           --backup-window-start <backup_start_time> \
           --backup-retain-period-days <automatic_backup_retention_period> \
           --datalens-access=<true_or_false> \
           --metrika-access=<true_or_false> \
           --serverless-access=<true_or_false> \
           --websql-access=<true_or_false> \
           --yandexquery-access=<true_or_false> \
           --deletion-protection \
           --disk-size-autoscaling clickhouse-disk-size-limit=<maximum_storage_size_in_GB>,`
                                  `clickhouse-planned-usage-threshold=<threshold_for_scheduled_increase_in_percent>,`
                                  `clickhouse-emergency-usage-threshold=<threshold_for_immediate_increase_in_percent>,`
                                  `zookeeper-disk-size-limit=<maximum_storage_size_in_GB>,`
                                  `zookeeper-planned-usage-threshold=<threshold_for_scheduled_increase_in_percent>,`
                                  `zookeeper-emergency-usage-threshold=<threshold_for_immediate_increase_in_percent> \
           --maintenance-window type=<maintenance_type>,`
                               `day=<day_of_week>,`
                               `hour=<hour>
        ```


    You can change the following settings:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    * `--backup-retain-period-days`: Automatic backup retention period, in days.

    * `--datalens-access`: Enables access from {{ datalens-name }}. The default value is `false`. For more information about setting up a connection, see [Connecting from {{ datalens-name }}](datalens-connect.md).

    
    * `--metrika-access`: Enables [data import from AppMetrica to your cluster](https://appmetrica.yandex.com/docs/common/cloud/about.html). The default value is `false`.

    * `--serverless-access`: Enables cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md). The default value is `false`. For more information about setting up access, see [{{ sf-name }}this  article](../../functions/operations/database-connection.md).


    * `--websql-access`: Enables [SQL queries](web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}. The default value is `false`.


    * `--yandexquery-access=true`: Enables cluster access from [{{ yq-full-name }}](../../query/concepts/index.md). This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage. The default value is `false`.

    * {% include [deletion-protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * `--disk-size-autoscaling`: Automatic storage size increase settings:
        
        {% include [disk-size-autoscaling-cli](../../_includes/mdb/mch/disk-size-autoscaling-cli.md) %}
    
    * `--maintenance-window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters), where `type` is the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [this guide](cluster-create.md).

    1. To change the backup start time, add the `backup_window_start` section to the {{ mch-name }} cluster description:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          backup_window_start {
            hours   = <backup_start_hour>
            minutes = <backup_start_minute>
          }
          ...
        }
        ```

    1. To enable cluster access from other services and allow [running SQL queries from the management console](web-sql-query.md) using {{ websql-full-name }}, edit the values of the appropriate fields in the `access` section:

        
        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          access {
            data_lens    = <access_from_{{ datalens-name }}>
            metrika      = <access_from_Metrica_and_AppMetrica>
            serverless   = <access_from_Cloud_Functions>
            web_sql      = <run_SQL_queries_from_management_console>
            yandex_query = <access_from_Yandex_Query>
          }
          ...
        }
        ```


        Where:

        * `data_lens`: Access from {{ datalens-name }}, `true` or `false`.

        
        * `metrika`: Access from Yandex Metrica and AppMetrica, `true` or `false`.
        * `serverless`: Access from {{ sf-name }}, `true` or `false`.


        * `yandex_query`: Access from {{ yq-full-name }}, `true` or `false`.
        * `web_sql`: Execution of SQL queries from the management console, `true` or `false`.

    1. {% include [Maintenance window](../../_includes/mdb/mch/terraform/maintenance-window.md) %}

    1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          deletion_protection = <cluster_deletion_protection>
        }
        ```

        {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        1. Create a file named `body.json` and paste the following code into it:

            
            ```json
            {
              "updateMask": "<list_of_settings_to_update>",
              "configSpec": {
                "backupWindowStart": {
                  "hours": "<hours>",
                  "minutes": "<minutes>",
                  "seconds": "<seconds>",
                  "nanos": "<nanoseconds>"
                },
                "clickhouse": {
                  "diskSizeAutoscaling": {
                    "plannedUsageThreshold": "<threshold_for_scheduled_increase_in_percent>",
                    "emergencyUsageThreshold": "<threshold_for_immediate_increase_in_percent>",
                    "diskSizeLimit": "<maximum_storage_size_in_bytes>"
                  }
                },
                "zookeeper": {
                  "diskSizeAutoscaling": {
                    "plannedUsageThreshold": "<threshold_for_scheduled_increase_in_percent>",
                    "emergencyUsageThreshold": "<threshold_for_immediate_increase_in_percent>",
                    "diskSizeLimit": "<maximum_storage_size_in_bytes>"
                  }
                },
                "access": {
                  "dataLens": <access_from_{{ datalens-name }}>,
                  "webSql": <run_SQL_queries>,
                  "metrika": <import_data_from_AppMetrica>,
                  "serverless": <access_from_{{ sf-full-name }}>,
                  "dataTransfer": <access_from_{{ data-transfer-full-name }}>,
                  "yandexQuery": <access_from_{{ yq-full-name }}>
                }    
              },
              "maintenanceWindow": {
                "anytime": {},
                "weeklyMaintenanceWindow": {
                  "day": "<day_of_week>",
                  "hour": "<hour_UTC>"
                }
              },
              "deletionProtection": <cluster_deletion_protection>
            }
            ```


            Where:

            * `updateMask`: List of parameters to update as a single string, separated by commas.

            * {% include [backup-windows-start-rest](../../_includes/mdb/api/backup-windows-start-rest.md) %}

            * `configSpec.access`: Settings enabling cluster access from other services and [running SQL queries from the management console](web-sql-query.md) using {{ websql-full-name }}:

                {% include [rest-access-settings](../../_includes/mdb/mch/api/rest-access-settings.md) %}

            * `configSpec.clickhouse.diskSizeAutoscaling`: Automatic storage size increase settings for a {{ CH }} subcluster:
            
                {% include [disk-size-autoscaling-rest-ch](../../_includes/mdb/mch/disk-size-autoscaling-rest-ch.md) %}
            
            * `configSpec.zookeeper.diskSizeAutoscaling`: Automatic storage size increase settings for a {{ ZK }} subcluster:
                      
                {% include [disk-size-autoscaling-rest-zk](../../_includes/mdb/mch/disk-size-autoscaling-rest-zk.md) %}
            
            * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters). Select one of these options:

                * `anytime`: At any time (default).
                * `weeklyMaintenanceWindow`: On schedule:
                    * `day`: Day of week in `DDD` format: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                    * `hour`: Time of day (UTC) in `HH` format, from `1` to `24`.

            * `deletionProtection`: Cluster protection from accidental deletion, `true` or `false`. The default value is `false`.

                {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

        1. Run this query:

            ```bash
            curl \
              --request PATCH \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>' \
              --data '@body.json'
            ```

            You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        1. Create a file named `body.json` and paste the following code into it:

            
            ```json
            {
              "cluster_id": "<cluster_ID>",
              "update_mask": {
                "paths": [
                  <list_of_settings_to_update>
                ]
              },
              "config_spec": {
                "backup_window_start": {
                  "hours": "<hours>",
                  "minutes": "<minutes>",
                  "seconds": "<seconds>",
                  "nanos": "<nanoseconds>"
                },
                "clickhouse": {
                  "disk_size_autoscaling": {
                    "planned_usage_threshold": "<threshold_for_scheduled_increase_in_percent>",
                    "emergency_usage_threshold": "<threshold_for_immediate_increase_in_percent>",
                    "disk_size_limit": "<maximum_storage_size_in_bytes>"
                  }
                },
                "zookeeper": {
                  "disk_size_autoscaling": {
                    "planned_usage_threshold": "<threshold_for_scheduled_increase_in_percent>",
                    "emergency_usage_threshold": "<threshold_for_immediate_increase_in_percent>",
                    "disk_size_limit": "<maximum_storage_size_in_bytes>"
                  }
                },
                "access": {
                  "data_lens": <access_from_{{ datalens-name }}>,
                  "web_sql": <run_SQL_queries>,
                  "metrika": <import_data_from_AppMetrica>,
                  "serverless": <access_from_{{ sf-full-name }}>,
                  "data_transfer": <access_from_{{ data-transfer-full-name }}>,
                  "yandex_query": <access_from_{{ yq-full-name }}>
                }
              },
              "maintenance_window": {
                "anytime": {},
                "weekly_maintenance_window": {
                  "day": "<day_of_week>",
                  "hour": "<hour_UTC>"
                }
              },
              "deletion_protection": <cluster_deletion_protection>
            }
            ```


            Where:

            * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            * {% include [backup-windows-start-grpc](../../_includes/mdb/api/backup-windows-start-grpc.md) %}

            * `config_spec.access`: Settings enabling cluster access from other services and [running SQL queries from the management console](web-sql-query.md) using {{ websql-full-name }}:

                {% include [grpc-access-settings](../../_includes/mdb/mch/api/grpc-access-settings.md) %}

            * `config_spec.clickhouse.disk_size_autoscaling`: Automatic storage size increase settings for a {{ CH }} subcluster:
            
                {% include [disk-size-autoscaling-grpc-ch](../../_includes/mdb/mch/disk-size-autoscaling-grpc-ch.md) %}

            * `config_spec.zookeeper.disk_size_autoscaling`: Automatic storage size increase settings for a {{ ZK }} subcluster:
                      
                {% include [disk-size-autoscaling-grpc-zk](../../_includes/mdb/mch/disk-size-autoscaling-grpc-zk.md) %}

            * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters). Select one of these options:

                * `anytime`: At any time (default).
                * `weekly_maintenance_window`: On schedule:
                    * `day`: Day of week in `DDD` format: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                    * `hour`: Time of day (UTC) in `HH` format, from `1` to `24`.

            * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`. The default value is `false`.

                {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

            You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

        1. Run this query:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d @ \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.Update \
              < body.json
            ```

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

### {{ connection-manager-name }} {#conn-man}

If you cluster has no integration with {{ connection-manager-name }}, enable **{{ ui-key.yacloud.mdb.forms.additional-field-connman }}**. It is only available in the [management console]({{ link-console-main }}).

The following resources will be created for each database user:

* [{{ connection-manager-name }} connection](../../metadata-hub/concepts/connection-manager.md) with information about the database connection.

* [{{ lockbox-name }} secret](../../metadata-hub/concepts/secret.md) with the user password. Storing passwords in {{ lockbox-name }} ensures their security.

  The connection and secret will be created for each new database user. To view all connections, select the **{{ ui-key.yacloud.connection-manager.label_connections }}** tab on the cluster page.

  You need the `connection-manager.viewer` role to view connection info. You can [use {{ connection-manager-name }}](../../metadata-hub/operations/connection-access.md) to configure access to connections.

  {% note info %}

  You can use {{ connection-manager-name }} and secrets you create there free of charge.

  {% endnote %}

## Moving a cluster {#move-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the cluster you want to move.
    1. Select **{{ ui-key.yacloud.common.move }}**.
    1. Select the folder you want to move your cluster to.
    1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To move a cluster:

    1. See the description of the CLI command for moving a cluster:

        ```bash
        {{ yc-mdb-ch }} cluster move --help
        ```

    1. Specify the destination folder in that command:

        ```bash
        {{ yc-mdb-ch }} cluster move <cluster_name_or_ID> \
           --destination-folder-name=<destination_folder_name>
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [this guide](./cluster-create.md).

    1. In the {{ mch-name }} cluster description, edit or add the `folder_id` parameter value:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          folder_id = "<destination_folder_ID>"
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider article]({{ tf-provider-mch }}).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Move](../api-ref/Cluster/move.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>:move' \
            --data '{
                      "destinationFolderId": "<destination_folder_ID>"
                    }'
        ```

        Where `destinationFolderId` is the ID of the destination folder to move your cluster to. You can request this ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/move.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Move](../api-ref/grpc/Cluster/move.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "destination_folder_id": "<destination_folder_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Move
        ```

        Where `destination_folder_id` is the ID of the destination folder to move your cluster to. You can request this ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/move.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


## Changing security groups {#change-sg-set}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select security groups for cluster network traffic.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

  1. View the description of the CLI command to update a cluster:

      ```bash
      {{ yc-mdb-ch }} cluster update --help
      ```

  1. Specify the security groups in that command:

      ```bash
      {{ yc-mdb-ch }} cluster update <cluster_name> \
         --security-group-ids <list_of_security_group_IDs>
      ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. Edit the `security_group_ids` value in the cluster description:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          security_group_ids = [ <list_of_cluster_security_group_IDs> ]
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "securityGroupIds",
                      "securityGroupIds": [
                        <list_of_security_group_IDs>
                      ]
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            Here, we only specified a single parameter, `securityGroupIds`.

        * `securityGroupIds`: Array of strings. Each string is a security group ID.

            {% note warning %}

            The list of security groups assigned to the cluster will be completely overwritten by the list in the `securityGroupIds` parameter.

            Before running your request, make sure the list includes all the required security group IDs, including existing ones.

            {% endnote %}

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [
                      "security_group_ids"
                    ]
                  },
                  "security_group_ids": [
                    <list_of_security_group_IDs>
                  ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Where:
        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Here, we only specified a single parameter, `security_group_ids`.

        * `security_group_ids`: Array of strings. Each string is a security group ID.

            {% note warning %}

            The list of security groups assigned to the cluster will be completely overwritten by the list in the `security_group_ids` parameter.

            Before running your request, make sure the list includes all the required security group IDs, including existing ones.

            {% endnote %}

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect/index.md#configuring-security-groups) to connect to the cluster.

{% endnote %}


## Changing hybrid storage settings {#change-hybrid-storage}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change [hybrid storage settings](../concepts/storage.md#hybrid-storage-settings):

  1. View the description of the CLI command to update a cluster:

      ```bash
      {{ yc-mdb-ch }} cluster update --help
      ```

  1. If hybrid storage is disabled in your cluster, enable it:

      ```bash
      {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
          --cloud-storage=true
      ```

      {% include [Hybrid Storage cannot be switched off](../../_includes/mdb/mch/hybrid-storage-cannot-be-switched-off.md) %}

  1. Provide a list of settings to update:

      ```bash
      {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
          --cloud-storage-data-cache=<file_storage> \
          --cloud-storage-data-cache-max-size=<memory_size_in_bytes> \
          --cloud-storage-move-factor=<share_of_free_space> \
          --cloud-storage-prefer-not-to-merge=<merging_data_parts>
      ```

      You can change the following settings:

      {% include [Hybrid Storage settings CLI](../../_includes/mdb/mch/hybrid-storage-settings-cli.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "<list_of_settings_to_update>",
                      "configSpec": {
                        "cloudStorage": {
                          "enabled": <hybrid_storage_use>,
                          "moveFactor": "<share_of_free_space>",
                          "dataCacheEnabled": <temporary_file_storage>,
                          "dataCacheMaxSize": "<maximum_cache_size_for_file_storage>",
                          "preferNotToMerge": <disabling_data_part_merging>
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

        * `configSpec.cloudStorage`: Hybrid storage settings:

            {% include [rest-cloud-storage-settings](../../_includes/mdb/mch/api/rest-cloud-storage-settings.md) %}

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [
                      <list_of_settings_to_update>
                    ]
                  },
                  "config_spec": {
                    "cloud_storage": {
                      "enabled": <hybrid_storage_use>,
                      "move_factor": "<share_of_free_space>",
                      "data_cache_enabled": <temporary_file_storage>,
                      "data_cache_max_size": "<maximum_cache_size_for_file_storage>",
                      "prefer_not_to_merge": <disabling_data_part_merging>
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Where:
        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

        * `config_spec.cloud_storage`: Hybrid storage settings:

            {% include [grpc-cloud-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
