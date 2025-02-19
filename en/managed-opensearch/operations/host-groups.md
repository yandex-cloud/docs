---
title: Managing {{ OS }} host groups in {{ mos-full-name }}
description: You can get a list of {{ OS }} cluster hosts and add, edit, or delete cluster host groups.
keywords:
  - Managing OpenSearch host groups
  - OpenSearch host groups
  - OpenSearch
---

# Managing {{ OS }} host groups


In a {{ mos-name }} cluster, you can manage [host groups](../concepts/host-roles.md):

* [Getting a list of host groups in a cluster](#list-groups).
* [Creating a host group](#add-host-group).
* [Updating the configuration of a host group](#update-host-group), including adding new hosts to it or removing them.
* [Deleting a host group](#delete-host-group).

You can also get a list of [cluster hosts](#list-hosts).

For information about migrating host groups in a {{ mos-name }} cluster to a different [availability zone](../../overview/concepts/geo-scope.md), see [this guide](host-migration.md).

## Getting a list of host groups in a cluster {#list-groups}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Click the name of the cluster you need and select the ![host-groups.svg](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}** tab.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of host groups in a cluster, request information about the {{ OS }} cluster:

    ```bash
    {{ yc-mdb-os }} cluster get <cluster_name_or_ID>
    ```

    You can find the list of host groups in the `config.opensearch.node_groups` and `config.dashboards.node_groups` parameters.

    You can request the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Get](../api-ref/Cluster/get.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>'
        ```

        You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. View the [server response](../api-ref/Cluster/get.md#yandex.cloud.mdb.opensearch.v1.Cluster) to make sure the request was successful.

        Available host groups are specified in the `nodeGroups` parameters.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Use the [ClusterService.Get](../api-ref/grpc/Cluster/get.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.opensearch.v1.ClusterService.Get
        ```

        You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.opensearch.v1.Cluster) to make sure the request was successful.

        Available host groups are specified in the `nodeGroups` parameters.

{% endlist %}

## Creating a host group {#add-host-group}

The following limitations apply when creating host groups:

* A {{ mos-name }} cluster may contain only one `Dashboards` host group.
* If you are adding a group of `{{ OS }}` hosts and assigning the `MANAGER` role to the hosts, make sure there are at least three hosts with this role.

To create a host group:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Click the name of the cluster you need and select the ![host-groups.svg](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}** tab.
    1. Click **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_add-node-group }}**.
    1. Specify the group parameters:

        * [Group type](../concepts/host-roles.md): `{{ OS }}` or `Dashboards`.
        * Name. It must be unique within the cluster.
        * For a `{{ OS }}` host group, select a [host role](../concepts/host-roles.md).
        * Platform, host type, and host class.

            The host class defines the technical characteristics of virtual machines that {{ OS }} nodes are deployed on. All available options are listed under [Host classes](../concepts/instance-types.md).

        * [Disk type](../concepts/storage.md) and data storage size.

            {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

        * (Optional) Under **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}**, configure the automatic increase of disk size:

            {% include [console-autoscaling](../../_includes/mdb/mos/console_autoscaling.md) %}

        * Host distribution across availability zones and subnets.

        * Number of hosts to create.

        
        * Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if you want to allow [connecting](connect.md) to hosts over the internet.


    1. Click **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_create-node-group }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a host group, run this command:

    ```bash
    {{ yc-mdb-os }} node-group add --cluster-name <cluster_name> \
       --opensearch-node-group name=<{{ OS }}_host_group_name>,`
                              `resource-preset-id=<host_class>,`
                              `disk-size=<disk_size_in_bytes>,`
                              `disk-type-id=<disk_type>,`
                              `hosts-count=<number_of_hosts_in_group>,`
                              `zone-ids=<availability_zones>,`
                              `subnet-names=<subnet_names>,`
                              `assign-public-ip=<assign_public_address:_true_or_false>,`
                              `roles=<host_roles> \
       --dashboards-node-group name=<Dashboards_host_group_name>,`
                              `resource-preset-id=<host_class>,`
                              `disk-size=<disk_size_in_bytes>,`
                              `disk-type-id=<disk_type>,`
                              `hosts-count=<number_of_hosts_in_group>,`
                              `zone-ids=<availability_zones>,`
                              `subnet-names=<subnet_names>,`
                              `assign-public-ip=<assign_public_address:_true_or_false>
    ```

    Specify the required parameters in the command depending on what type of host group you want to create:

    {% include [cli-for-os-and-dashboards-groups](../../_includes/managed-opensearch/cli-for-os-and-dashboards-groups.md) %}

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ mos-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mos }}).

    1. To create a group of `{{ OS }}` hosts, add the `node_groups` section to `opensearch`:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
          ...
          config {
            opensearch {
              ...
              node_groups {
                name             = "<virtual_host_group_name>"
                assign_public_ip = <public_access>
                hosts_count      = <number_of_hosts>
                zone_ids         = ["<list_of_availability_zones>"]
                subnet_ids       = ["<list_of_subnet_IDs>"]
                roles            = ["<role_list>"]
                resources {
                  resource_preset_id = "<host_class>"
                  disk_size          = <storage_size_in_bytes>
                  disk_type_id       = "<disk_type>"
                }
              }
            }
            ...
          }
        }
        ```

        Where:

        * `assign_public_ip`: Public access to the host, `true` or `false`.
        * `roles`: `DATA` and `MANAGER` host roles.

    1. To create a group of `Dashboards` hosts, add the `dashboards` section to `config`:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
          ...
          config {
            ...
            dashboards {
              node_groups {
               name             = "<virtual_host_group_name>"
                assign_public_ip = <public_access>
                hosts_count      = <number_of_hosts>
                zone_ids         = ["<list_of_availability_zones>"]
                subnet_ids       = ["<list_of_subnet_IDs>"]
                resources {
                  resource_preset_id = "<host_class>"
                  disk_size          = <storage_size_in_bytes>
                  disk_type_id       = "<disk_type>"
                }
              }
            }
          }
        }
        ```

        Where `assign_public_ip` is public access to the host, `true` or `false`.

        A cluster may contain only one `Dashboards` host group.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mos/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and add the following contents to it:

        
        ```json
        {
            "nodeGroupSpec": {
                "name": "<host_group_name>",
                "resources": {
                    "resourcePresetId": "<host_class>",
                    "diskSize": "<storage_size_in_bytes>",
                    "diskTypeId": "<disk_type>"
                },
                "roles": ["<role_1>","<role_2>"],
                "hostsCount": "<number_of_hosts>",
                "zoneIds": [
                    "<availability_zone_1>",
                    "<availability_zone_2>",
                    "<availability_zone_3>"
                ],
                "subnetIds": [
                    "<subnet_1_ID>",
                    "<subnet_2_ID>",
                    "<subnet_3_ID>"
                ],
                "assignPublicIp": <public_host_address:_true_or_false>,
                "diskSizeAutoscaling": {
                    "plannedUsageThreshold": "<scheduled_increase_percentage>",
                    "emergencyUsageThreshold": "<immediate_increase_percentage>",
                    "diskSizeLimit": "<maximum_storage_size_in_bytes>"
                }
            }
        }
        ```


        Where `nodeGroups` represent the host settings:

        * `name`: Host group name.
        * `resources`: Cluster resources:

            * `resourcePresetId`: [Host class](../concepts/instance-types.md).
            * `diskSize`: Disk size in bytes.
            * `diskTypeId`: [Disk type](../concepts/storage.md).

        * `roles` (`{{ OS }}` hosts only): List of [host roles](../concepts/host-roles.md), `DATA` or `MANAGER`. You can assign one or both roles for a group.
        * `hostsCount`: Number of hosts per group. Minimum number of `DATA` and `Dashboards` hosts: one; minimum number of `MANAGER` hosts: three.
        * `zoneIds`: List of availability zones the cluster hosts are located in.
        * `subnetIds`: List of subnet IDs.

        
        * `assignPublicIp`: Permission to [connect](connect.md) to the host from the internet.


        * `diskSizeAutoscaling`: Automatic storage size increase settings:

            * `plannedUsageThreshold`: Storage utilization percentage to trigger a storage increase during the next maintenance window.

                Use a percentage value between `0` and `100`. The default value is `0` (automatic increase is disabled).

                If you have set this parameter, [configure the maintenance window schedule](update.md#change-additional-settings) before creating a host group.

            * `emergencyUsageThreshold`: Storage utilization percentage to trigger an immediate storage increase.

                Use a percentage value between `0` and `100`. The default value is `0` (automatic increase is disabled). This parameter value must be greater than or equal to `plannedUsageThreshold`.

            * `diskSizeLimit`: Maximum storage size, in bytes, that can be set when utilization reaches one of the specified percentages.

    1. To create an `{{ OS }}` host group:

        1. Use the [Cluster.AddOpenSearchNodeGroup](../api-ref/Cluster/addOpenSearchNodeGroup.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request POST \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/opensearch/node_groups' \
                --data "@body.json"
            ```

            You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        1. View the [server response](../api-ref/Cluster/addOpenSearchNodeGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

    1. To create a `Dashboards` host group:

        1. Use the [Cluster.AddDashboardsNodeGroup](../api-ref/Cluster/addDashboardsNodeGroup.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request POST \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/dashboards/node_groups' \
                --data "@body.json"
            ```

            You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        1. View the [server response](../api-ref/Cluster/addDashboardsNodeGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Create a file named `body.json` and add the following contents to it:

        
        ```json
        {
            "node_group_spec": {
                "name": "<host_group_name>",
                "resources": {
                    "resource_preset_id": "<host_class>",
                    "disk_size": "<storage_size_in_bytes>",
                    "disk_type_id": "<disk_type>"
                },
                "roles": ["<role_1>","<role_2>"],
                "hosts_count": "<number_of_hosts>",
                "zone_ids": [
                    "<availability_zone_1>",
                    "<availability_zone_2>",
                    "<availability_zone_3>"
                ],
                "subnet_ids": [
                    "<subnet_1_ID>",
                    "<subnet_2_ID>",
                    "<subnet_3_ID>"
                ],
                "assign_public_ip": <public_host_address:_true_or_false>,
                "disk_size_autoscaling": {
                    "planned_usage_threshold": "<scheduled_increase_percentage>",
                    "emergency_usage_threshold": "<immediate_increase_percentage>",
                    "disk_size_limit": "<maximum_storage_size_in_bytes>"
                }
            }
        }
        ```


        Where `node_groups` represent the host settings:

        * `name`: Host group name.
        * `resources`: Cluster resources:

            * `resource_preset_id`: [Host class](../concepts/instance-types.md).
            * `disk_size`: Disk size in bytes.
            * `disk_type_id`: [Disk type](../concepts/storage.md).

        * `roles` (`{{ OS }}` hosts only): List of [host roles](../concepts/host-roles.md), `DATA` or `MANAGER`. You can assign one or both roles for a group.
        * `hosts_count`: Number of hosts per group. Minimum number of `DATA` and `Dashboards` hosts: one; minimum number of `MANAGER` hosts: three.
        * `zone_ids`: List of availability zones the cluster hosts are located in.
        * `subnet_ids`: List of subnet IDs.

        
        * `assign_public_ip`: Permission to [connect](connect.md) to the host from the internet.


        * `disk_size_autoscaling`: Automatic storage size increase settings:

            * `planned_usage_threshold`: Storage utilization percentage to trigger a storage increase during the next maintenance window.

                Use a percentage value between `0` and `100`. The default value is `0` (automatic increase is disabled).

                If you have set this parameter, [configure the maintenance window schedule](update.md#change-additional-settings) before creating a host group.

            * `emergency_usage_threshold`: Storage utilization percentage to trigger an immediate storage increase.

                Use a percentage value between `0` and `100`. The default value is `0` (automatic increase is disabled). This parameter value must be greater than or equal to `planned_usage_threshold`.

            * `disk_size_limit`: Maximum storage size, in bytes, that can be set when utilization reaches one of the specified percentages.

    1. To create an `{{ OS }}` host group:

        1. Use the [ClusterService.AddOpenSearchNodeGroup](../api-ref/grpc/Cluster/addOpenSearchNodeGroup.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d @ \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.opensearch.v1.ClusterService.AddOpenSearchNodeGroup \
                < body.json
            ```

        1. View the [server response](../api-ref/grpc/Cluster/addDashboardsNodeGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

    1. To create a `Dashboards` host group:

        1. Use the [ClusterService.AddDashboardsNodeGroup](../api-ref/grpc/Cluster/addDashboardsNodeGroup.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d @ \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.opensearch.v1.ClusterService.AddDashboardsNodeGroup \
                < body.json
            ```

        1. View the [server response](../api-ref/grpc/Cluster/addDashboardsNodeGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Updating a host group configuration {#update-host-group}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Click the name of the cluster you need and select the ![host-groups.svg](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}** tab.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the appropriate group and select **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_edit }}**.
    1. Change host group settings:

        * [Host roles](../concepts/host-roles.md) (for `{{ OS }}` host groups only).
        * Platform, host type, and host class.

            The host class defines the technical characteristics of virtual machines that {{ OS }} nodes are deployed on. All available options are listed under [Host classes](../concepts/instance-types.md).

        * Disk size.

            Disk resizing increments depend on disk type:

            * Network HDD and SSD storage: In increments of 1 GB.

            * Local SSD storage:
                * For **Intel Cascade Lake**: In increments of 100 GB.
                * For **Intel Ice Lake**: In increments of {{ local-ssd-v3-step }}.
            * Non-replicated SSD storage: In increments of 93 GB.

        * (Optional) Under **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}**, configure the automatic increase of disk size:

            {% include [console-autoscaling](../../_includes/mdb/mos/console_autoscaling.md) %}

        * Host distribution across availability zones and subnets.

        * Number of hosts.

        * Public access to hosts.

    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the configuration of a host group, run the command:

    ```bash
    {{ yc-mdb-os }} node-group update --cluster-name <cluster_name> \
       --node-group-name <host_group_name> \
       --resource-preset-id <host_class> \
       --disk-size <disk_size_in_bytes> \
       --hosts-count <number_of_hosts_in_group> \
       --roles <host_roles>
    ```

    Specify the required parameters in the command depending on what type of host group configuration you need:

    * `--node-group-name`: Name of the host group you need to update.
    * `--resource-preset-id`: New host class. that defines the configuration of virtual machines the {{ OS }} nodes will be deployed on. All available options are listed under [Host classes](../concepts/instance-types.md).
    * `--disk-size`: New disk size in bytes. Minimum and maximum values depend on the selected host class.
    * `--hosts-count`: New number of hosts in the group.
    * `--roles`: New [host roles](../../managed-opensearch/concepts/host-roles.md). The possible values are:

      * `data`: Assigns the `DATA` role only.
      * `manager`: Assigns the `MANAGER` role only.
      * `data+manager` or `manager+data`: Assigns both roles.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ mos-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mos }}).

    1. To update the configuration of an `{{ OS }}` host group, edit the parameters of the required `node_groups` section in the `opensearch` section:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
          ...
          opensearch {
            ...
            node_groups {
              name             = "<virtual_host_group_name>"
              assign_public_ip = <public_access>
              hosts_count      = <number_of_hosts>
              roles            = ["<role_list>"]
              resources {
                resource_preset_id = "<host_class>"
                disk_size          = <storage_size_in_bytes>
                disk_type_id       = "<disk_type>"
              }
            }
            ...
          }
        }
        ```

        Where:

        * `assign_public_ip`: Public access to the host, `true` or `false`.
        * `roles`: `DATA` and `MANAGER` host roles.

    1. To update the configuration of a `Dashboards` host group, edit the `dashboards` section parameters:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
          ...
          dashboards {
            node_groups {
              name             = "<virtual_host_group_name>"
              assign_public_ip = <public_access>
              hosts_count      = <number_of_hosts>
              resources {
                resource_preset_id = "<host_class>"
                disk_size          = <storage_size_in_bytes>
                disk_type_id       = "<disk_type>"
              }
            }
          }
        }
        ```

        Where `assign_public_ip` is public access to the host, `true` or `false`.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and add the following contents to it:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        
        ```json
        {
            "updateMask": "resources,hostsCount,zoneIds,subnetIds,assignPublicIp,diskSizeAutoscaling",
            "nodeGroupSpec": {
                "resources": {
                    "resourcePresetId": "<host_class>",
                    "diskSize": "<storage_size_in_bytes>",
                    "diskTypeId": "<disk_type>"
                },
                "hostsCount": "<number_of_hosts>",
                "zoneIds": [
                    "<availability_zone_1>",
                    "<availability_zone_2>",
                    "<availability_zone_3>"
                ],
                "subnetIds": [
                    "<subnet_1_ID>",
                    "<subnet_2_ID>",
                    "<subnet_3_ID>"
                ],
                "assignPublicIp": <public_host_address:_true_or_false>,
                "diskSizeAutoscaling": {
                    "plannedUsageThreshold": "<scheduled_increase_percentage>",
                    "emergencyUsageThreshold": "<immediate_increase_percentage>",
                    "diskSizeLimit": "<maximum_storage_size_in_bytes>"
                }
            }
        }
        ```


        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.
        * `nodeGroups`: Host settings:

            * `resources`: Cluster resources:

                * `resourcePresetId`: [Host class](../concepts/instance-types.md).
                * `diskSize`: Disk size in bytes.
                * `diskTypeId`: [Disk type](../concepts/storage.md).

            * `hostsCount`: Number of hosts per group. Minimum number of `DATA` and `Dashboards` hosts: one; minimum number of `MANAGER` hosts: three.
            * `zoneIds`: List of availability zones the cluster hosts are located in.
            * `subnetIds`: List of subnet IDs.

            
            * `assignPublicIp`: Permission to [connect](connect.md) to the host from the internet.


            * `diskSizeAutoscaling`: Automatic storage size increase settings:

                * `plannedUsageThreshold`: Storage utilization percentage to trigger a storage increase during the next maintenance window.

                    Use a percentage value between `0` and `100`. The default value is `0` (automatic increase is disabled).

                    If you have set this parameter, [configure the maintenance window schedule](update.md#change-additional-settings) before creating a host group.

                * `emergencyUsageThreshold`: Storage utilization percentage to trigger an immediate storage increase.

                    Use a percentage value between `0` and `100`. The default value is `0` (automatic increase is disabled). This parameter value must be greater than or equal to `plannedUsageThreshold`.

                * `diskSizeLimit`: Maximum storage size, in bytes, that can be set when utilization reaches one of the specified percentages.

    1. To update an `{{ OS }}` host group configuration:

        1. Use the [Cluster.UpdateOpenSearchNodeGroup](../api-ref/Cluster/updateOpenSearchNodeGroup.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/opensearch/node_groups/<host_group_name>' \
                --data "@body.json"
            ```

            You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters). You can request the name of the host group with [cluster details](cluster-list.md#get-cluster).

        1. View the [server response](../api-ref/Cluster/updateOpenSearchNodeGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

    1. To update a `Dashboards` host group configuration:

        1. Use the [Cluster.UpdateDashboardsNodeGroup](../api-ref/Cluster/updateDashboardsNodeGroup.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/dashboards/node_groups/<host_group_name>' \
                --data "@body.json"
            ```

            You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters). You can request the name of the host group with [cluster details](cluster-list.md#get-cluster).

        1. View the [server response](../api-ref/Cluster/updateDashboardsNodeGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Create a file named `body.json` and add the following contents to it:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        
        ```json
        {
            "cluster_id": "<cluster_ID>",
            "name": "<host_group_name>",
            "update_mask": {
                "paths": [
                    "resources",
                    "hosts_count",
                    "zone_ids",
                    "subnet_ids",
                    "assign_public_ip"
                ]
            },
            "node_group_spec": {
                "resources": {
                    "resource_preset_id": "<host_class>",
                    "disk_size": "<storage_size_in_bytes>",
                    "disk_type_id": "<disk_type>"
                },
                "hosts_count": "<number_of_hosts>",
                "zone_ids": [
                    "<availability_zone_1>",
                    "<availability_zone_2>",
                    "<availability_zone_3>"
                ],
                "subnet_ids": [
                    "<subnet_1_ID>",
                    "<subnet_2_ID>",
                    "<subnet_3_ID>"
                ],
                "assign_public_ip": <public_host_address:_true_or_false>,
                "disk_size_autoscaling": {
                    "planned_usage_threshold": "<scheduled_increase_percentage>",
                    "emergency_usage_threshold": "<immediate_increase_percentage>",
                    "disk_size_limit": "<maximum_storage_size_in_bytes>"
                }
            }
        }
        ```


        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.
        * `node_groups`: Host settings:

            * `resources`: Cluster resources:

                * `resource_preset_id`: [Host class](../concepts/instance-types.md).
                * `disk_size`: Disk size in bytes.
                * `disk_type_id`: [Disk type](../concepts/storage.md).

            * `hosts_count`: Number of hosts per group. Minimum number of `DATA` and `Dashboards` hosts: one; minimum number of `MANAGER` hosts: three.
            * `zone_ids`: List of availability zones the cluster hosts are located in.
            * `subnet_ids`: List of subnet IDs.

            
            * `assign_public_ip`: Permission to [connect](connect.md) to the host from the internet.


            * `disk_size_autoscaling`: Automatic storage size increase settings:

                * `planned_usage_threshold`: Storage utilization percentage to trigger a storage increase during the next maintenance window.

                    Use a percentage value between `0` and `100`. The default value is `0` (automatic increase is disabled).

                    If you have set this parameter, [configure the maintenance window schedule](update.md#change-additional-settings) before creating a host group.

                * `emergency_usage_threshold`: Storage utilization percentage to trigger an immediate storage increase.

                    Use a percentage value between `0` and `100`. The default value is `0` (automatic increase is disabled). This parameter value must be greater than or equal to `planned_usage_threshold`.

                * `disk_size_limit`: Maximum storage size, in bytes, that can be set when utilization reaches one of the specified percentages.

    1. To update an `{{ OS }}` host group configuration:

        1. Use the [ClusterService.UpdateOpenSearchNodeGroup](../api-ref/grpc/Cluster/updateOpenSearchNodeGroup.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d @ \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.opensearch.v1.ClusterService.UpdateOpenSearchNodeGroup \
                < body.json
            ```

            You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters). You can request the name of the host group with [cluster details](cluster-list.md#get-cluster).

        1. View the [server response](../api-ref/grpc/Cluster/updateOpenSearchNodeGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

    1. To update a `Dashboards` host group configuration:

        1. Use the [ClusterService.UpdateDashboardsNodeGroup](../api-ref/grpc/Cluster/updateDashboardsNodeGroup.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d @ \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.opensearch.v1.ClusterService.UpdateDashboardsNodeGroup \
                < body.json
            ```

            You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters). You can request the name of the host group with [cluster details](cluster-list.md#get-cluster).

        1. View the [server response](../api-ref/grpc/Cluster/updateDashboardsNodeGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Deleting a host group {#delete-host-group}

When deleting a host group, the following limitation applies: you cannot delete a single host group with the `DATA` role.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Click the name of the cluster you need and select the ![host-groups.svg](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}** tab.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the appropriate group and select **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To delete a host group, run the command:

    ```bash
    {{ yc-mdb-os }} node-group delete --cluster-name <cluster_name> \
       --node-group-name <host_group_name>
    ```

    In the command, specify the host group you want to delete.

- {{ TF }} {#tf}

    To remove a host group from a cluster:

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ mos-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mos }}).

    1. To delete an `{{ OS }}` host group, remove the corresponding `node_groups` section from the `opensearch` section.

    1. To delete a `Dashboards` host group, remove the `dashboards` section.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the deletion of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. To delete an `{{ OS }}` host group:

        1. Use the [Cluster.DeleteOpenSearchNodeGroup](../api-ref/Cluster/deleteOpenSearchNodeGroup.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request DELETE \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/opensearch/node_groups/<host_group_name>'
            ```

            You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters). You can request the name of the host group with [cluster details](cluster-list.md#get-cluster).

        1. View the [server response](../api-ref/Cluster/deleteOpenSearchNodeGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

    1. To delete a `Dashboards` host group:

        1. Use the [Cluster.DeleteDashboardsNodeGroup](../api-ref/Cluster/deleteDashboardsNodeGroup.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request DELETE \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/dashboards/node_groups/<host_group_name>'
            ```

            You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters). You can request the name of the host group with [cluster details](cluster-list.md#get-cluster).

        1. View the [server response](../api-ref/Cluster/deleteDashboardsNodeGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. To delete an `{{ OS }}` host group:

        1. Use the [ClusterService.DeleteOpenSearchNodeGroup](../api-ref/grpc/Cluster/deleteOpenSearchNodeGroup.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                        "cluster_id": "<cluster_ID>",
                        "name": "<host_group_name>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.opensearch.v1.ClusterService.DeleteOpenSearchNodeGroup
            ```

            You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters). You can request the name of the host group with [cluster details](cluster-list.md#get-cluster).

        1. View the [server response](../api-ref/grpc/Cluster/deleteOpenSearchNodeGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

    1. To delete a `Dashboards` host group:

        1. Use the [ClusterService.DeleteDashboardsNodeGroup](../api-ref/grpc/Cluster/deleteDashboardsNodeGroup.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                        "cluster_id": "<cluster_ID>",
                        "name": "<host_group_name>"
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.opensearch.v1.ClusterService.DeleteDashboardsNodeGroup
            ```

            You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters). You can request the name of the host group with [cluster details](cluster-list.md#get-cluster).

        1. View the [server response](../api-ref/grpc/Cluster/deleteDashboardsNodeGroup.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Getting a list of cluster hosts {#list-hosts}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Click the cluster name and select the ![hosts](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.ListHosts](../api-ref/Cluster/listHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/hosts'
      ```

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.opensearch.v1.ListClusterHostsResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.ListHosts](../api-ref/grpc/Cluster/listHosts.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.opensearch.v1.ClusterService.ListHosts
      ```

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.opensearch.v1.ListClusterHostsResponse) to make sure the request was successful.

{% endlist %}
