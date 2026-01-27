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

* [Get a list of host groups in a cluster](#list-groups).
* [Create a host group](#add-host-group).
* [Update the configuration of a host group](#update-host-group), including adding new hosts to it or removing them.
* [Delete a host group](#delete-host-group).

You can also [get a list of cluster hosts](#list-hosts).

For information about migrating host groups in a {{ mos-name }} cluster to a different [availability zone](../../overview/concepts/geo-scope.md), see [this guide](host-migration.md).

## Getting a list of host groups in a cluster {#list-groups}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder page.
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}** service.
    1. Locate the cluster you need in the list, click its name, and select the ![host-groups.svg](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}** tab.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of host groups in a cluster, get the {{ OS }} cluster details:

    ```bash
    {{ yc-mdb-os }} cluster get <cluster_name_or_ID>
    ```

    You can find the list of host groups in the `config.opensearch.node_groups` and `config.dashboards.node_groups` parameters.

    You can get the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Get](../api-ref/Cluster/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>'
        ```

        You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. Check the [server response](../api-ref/Cluster/get.md#yandex.cloud.mdb.opensearch.v1.Cluster) to make sure your request was successful.

        You can find available host groups in the `nodeGroups` parameters.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Call the [ClusterService.Get](../api-ref/grpc/Cluster/get.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

        You can get the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/get.md#yandex.cloud.mdb.opensearch.v1.Cluster) to make sure your request was successful.

        You can find available host groups in the `nodeGroups` parameters.

{% endlist %}

## Creating a host group {#add-host-group}

The following limitations apply when creating host groups:

* A {{ mos-name }} cluster may contain only one `Dashboards` host group.
* If you are adding a group of `{{ OS }}` hosts with the `MANAGER` role, make sure there are at least three hosts with this role.

To create a host group:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder page.
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}** service.
    1. Locate the cluster you need in the list, click its name, and select the ![host-groups.svg](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}** tab.
    1. Click **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_add-node-group }}**.
    1. Specify the group parameters:

        * [Group type](../concepts/host-roles.md): `{{ OS }}` or `Dashboards`.
        * Name. It must be unique within the cluster.
        * For an `{{ OS }}` host group, select the [host role](../concepts/host-roles.md).
        * Platform, host type, and host class.

            The host class defines the specifications of virtual machines {{ OS }} nodes will be deployed on. All available options are listed under [Host classes](../concepts/instance-types.md).

        * [Disk type](../concepts/storage.md) and data storage size.

            {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

        * Optionally, set up automatic storage expansion:

            {% include [console-autoscaling](../../_includes/mdb/mos/console_autoscaling.md) %}

        * Host distribution across availability zones and subnets.

        * Number of hosts to create.

        
        * Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if you want to allow [connections](connect.md) to hosts over the internet.


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
                              `assign-public-ip=<allow_public_access_to_hosts>,`
                              `roles=<host_roles> \
       --dashboards-node-group name=<Dashboards_host_group_name>,`
                              `resource-preset-id=<host_class>,`
                              `disk-size=<disk_size_in_bytes>,`
                              `disk-type-id=<disk_type>,`
                              `hosts-count=<number_of_hosts_in_group>,`
                              `zone-ids=<availability_zones>,`
                              `subnet-names=<subnet_names>,`
                              `assign-public-ip=<allow_public_access_to_hosts>
    ```

    Specify the required parameters in the command depending on what type of host group you want to create:

    {% include [cli-for-os-and-dashboards-groups](../../_includes/managed-opensearch/cli-for-os-and-dashboards-groups.md) %}

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

        For a complete list of adjustable configuration fields for a {{ mos-name }} cluster, see the [{{ TF }} provider guide]({{ tf-provider-mos }}).

    1. To create a group of `{{ OS }}` hosts, add the `node_groups` section to `opensearch`:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
          ...
          config {
            opensearch {
              ...
              node_groups {
                name             = "<virtual_host_group_name>"
                assign_public_ip = <allow_public_access_to_hosts>
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
        * `roles`: Host roles, `DATA` and `MANAGER`.

    1. To create a group of `Dashboards` hosts, add the `dashboards` section to `config`:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
          ...
          config {
            ...
            dashboards {
              node_groups {
               name             = "<virtual_host_group_name>"
                assign_public_ip = <allow_public_access_to_hosts>
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

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        
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
                "assignPublicIp": <allow_public_access_to_hosts>,
                "diskSizeAutoscaling": {
                    "plannedUsageThreshold": "<scheduled_expansion_percentage>",
                    "emergencyUsageThreshold": "<immediate_expansion_percentage>",
                    "diskSizeLimit": "<maximum_storage_size_in_bytes>"
                }
            }
        }
        ```


        Where `nodeGroups` contain the host settings:

        * `name`: Host group name.
        * `resources`: Cluster resources:

            * `resourcePresetId`: [Host class](../concepts/instance-types.md).
            * `diskSize`: Disk size, in bytes.
            * `diskTypeId`: [Disk type](../concepts/storage.md).

        * `roles` (`{{ OS }}` hosts only): List of [host roles](../concepts/host-roles.md), `DATA` or `MANAGER`. You can assign one or both roles for a group.
        * `hostsCount`: Number of hosts per group. The minimum number of `DATA` and `Dashboards` hosts is one; while the minimum number of `MANAGER` hosts is three.
        * `zoneIds`: List of availability zones the cluster hosts are located in.
        * `subnetIds`: List of subnet IDs.

        
        * `assignPublicIp`: Permission to [connect](connect.md) to the host from the internet, `true` or `false`.


        * `diskSizeAutoscaling`: Automatic storage expansion settings:

            * `plannedUsageThreshold`: Storage usage percentage to trigger a storage expansion during the next maintenance window.

                Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled.

                If you set this condition, [configure the maintenance window schedule](update.md#change-additional-settings) before creating your host group.

            * `emergencyUsageThreshold`: Storage usage percentage to trigger an immediate storage expansion.

                Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled.

                {% note warning %}

                If you specify both thresholds, `emergencyUsageThreshold` must not be less than `plannedUsageThreshold`.

                {% endnote %}

            * `diskSizeLimit`: Maximum storage size, in bytes, to set when storage usage reaches one of the specified thresholds.

            
            {% include [warn-storage-resize](../../_includes/mdb/mos/warn-storage-resize.md) %}


    1. To create an `{{ OS }}` host group:

        1. Call the [Cluster.AddOpenSearchNodeGroup](../api-ref/Cluster/addOpenSearchNodeGroup.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

            ```bash
            curl \
                --request POST \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/opensearch/node_groups' \
                --data "@body.json"
            ```

            You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        1. View the [server response](../api-ref/Cluster/addOpenSearchNodeGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

    1. To create a `Dashboards` host group:

        1. Call the [Cluster.AddDashboardsNodeGroup](../api-ref/Cluster/addDashboardsNodeGroup.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

            ```bash
            curl \
                --request POST \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/dashboards/node_groups' \
                --data "@body.json"
            ```

            You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        1. Check the [server response](../api-ref/Cluster/addDashboardsNodeGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Create a file named `body.json` and paste the following code into it:

        
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
                "assign_public_ip": <allow_public_access_to_hosts>,
                "disk_size_autoscaling": {
                    "planned_usage_threshold": "<scheduled_expansion_percentage>",
                    "emergency_usage_threshold": "<immediate_expansion_percentage>",
                    "disk_size_limit": "<maximum_storage_size_in_bytes>"
                }
            }
        }
        ```


        Where `node_groups` contain the host settings:

        * `name`: Host group name.
        * `resources`: Cluster resources:

            * `resource_preset_id`: [Host class](../concepts/instance-types.md).
            * `disk_size`: Disk size, in bytes.
            * `disk_type_id`: [Disk type](../concepts/storage.md).

        * `roles` (`{{ OS }}` hosts only): List of [host roles](../concepts/host-roles.md), `DATA` or `MANAGER`. You can assign one or both roles for a group.
        * `hosts_count`: Number of hosts per group. The minimum number of `DATA` and `Dashboards` hosts is one; while the minimum number of `MANAGER` hosts is three.
        * `zone_ids`: List of availability zones the cluster hosts are located in.
        * `subnet_ids`: List of subnet IDs.

        
        * `assign_public_ip`: Permission to [connect](connect.md) to the host from the internet, `true` or `false`.


        * `disk_size_autoscaling`: Automatic storage expansion settings:

            * `planned_usage_threshold`: Storage usage percentage to trigger a storage expansion during the next maintenance window.

                Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled.

                If you set this condition, [configure the maintenance window schedule](update.md#change-additional-settings) before creating your host group.

            * `emergency_usage_threshold`: Storage usage percentage to trigger an immediate storage expansion.

                Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled.

                {% note warning %}

                If you specify both thresholds, `emergency_usage_threshold` must not be less than `planned_usage_threshold`.

                {% endnote %}

            * `disk_size_limit`: Maximum storage size, in bytes, to set when storage usage reaches one of the specified thresholds.

            
            {% include [warn-storage-resize](../../_includes/mdb/mos/warn-storage-resize.md) %}


    1. To create a `{{ OS }}` host group:

        1. Call the [ClusterService.AddOpenSearchNodeGroup](../api-ref/grpc/Cluster/addOpenSearchNodeGroup.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

        1. View the [server response](../api-ref/grpc/Cluster/addDashboardsNodeGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

    1. To create a `Dashboards` host group:

        1. Call the [ClusterService.AddDashboardsNodeGroup](../api-ref/grpc/Cluster/addDashboardsNodeGroup.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

        1. Check the [server response](../api-ref/grpc/Cluster/addDashboardsNodeGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Updating a host group configuration {#update-host-group}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder page.
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}** service.
    1. Locate the cluster you need in the list, click its name, and select the ![host-groups.svg](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}** tab.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the group you need and select **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_edit }}**.
    1. Change the host group settings:

        * [Host roles](../concepts/host-roles.md) (for `{{ OS }}` host groups only).
        * Platform, host type, and host class.

            The host class defines the specifications of virtual machines {{ OS }} nodes will be deployed on. All available options are listed under [Host classes](../concepts/instance-types.md).

        * Disk size.

            Disk resizing increments depend on the disk type:

            * Network HDDs and SSDs: In increments of 1 GB.

            * Local SSDs:
                * For **Intel Cascade Lake**: In increments of 100 GB.
                * For **Intel Ice Lake**: In increments of {{ local-ssd-v3-step }}.
            * Non-replicated SSDs: In increments of 93 GB.

        * Optionally, set up automatic storage expansion:

            {% include [console-autoscaling](../../_includes/mdb/mos/console_autoscaling.md) %}

        * Host distribution across availability zones and subnets.

        * Number of hosts.

        
        * Public access to hosts.


    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To update the configuration of a host group, run this command:

    ```bash
    {{ yc-mdb-os }} node-group update --cluster-name <cluster_name> \
       --node-group-name <host_group_name> \
       --resource-preset-id <host_class> \
       --disk-size <disk_size_in_bytes> \
       --hosts-count <number_of_hosts_in_group> \
       --roles <host_roles>
    ```

    Specify the required parameters in the command depending on the type of host group configuration you need:

    * `--node-group-name`: Name of the host group you need to update.
    * `--resource-preset-id`: New host class. that defines the specifications of virtual machines the {{ OS }} nodes will be deployed on. All available options are listed under [Host classes](../concepts/instance-types.md).
    * `--disk-size`: New disk size, in bytes. The minimum and maximum values depend on the selected host class.
    * `--hosts-count`: New number of hosts in the group.
    * `--roles`: New [host roles](../../managed-opensearch/concepts/host-roles.md). The possible values are:

      * `data`: Assigns the `DATA` role only.
      * `manager`: Assigns the `MANAGER` role only.
      * `data+manager` or `manager+data`: Assigns both roles.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

        For a complete list of adjustable configuration fields for a {{ mos-name }} cluster, see the [{{ TF }} provider guide]({{ tf-provider-mos }}).

    1. To update the configuration of an `{{ OS }}` host group, edit the parameters of the `node_groups` section under `opensearch`:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
          ...
          opensearch {
            ...
            node_groups {
              name             = "<virtual_host_group_name>"
              assign_public_ip = <allow_public_access_to_hosts>
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
        * `roles`: Host roles, `DATA` and `MANAGER`.

    1. To update the configuration of a `Dashboards` host group, edit the `dashboards` section parameters:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
          ...
          dashboards {
            node_groups {
              name             = "<virtual_host_group_name>"
              assign_public_ip = <allow_public_access_to_hosts>
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

        {% include [Terraform timeouts](../../_includes/mdb/mos/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

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
                "assignPublicIp": <allow_public_access_to_hosts>,
                "diskSizeAutoscaling": {
                    "plannedUsageThreshold": "<scheduled_expansion_percentage>",
                    "emergencyUsageThreshold": "<immediate_expansion_percentage>",
                    "diskSizeLimit": "<maximum_storage_size_in_bytes>"
                }
            }
        }
        ```


        Where:

        * `updateMask`: Comma-separated string of settings you want to update.
        * `nodeGroups`: Host settings:

            * `resources`: Cluster resources:

                * `resourcePresetId`: [Host class](../concepts/instance-types.md).
                * `diskSize`: Disk size, in bytes.
                * `diskTypeId`: [Disk type](../concepts/storage.md).

            * `hostsCount`: Number of hosts in the group. The minimum number of `DATA` and `Dashboards` hosts is one; while the minimum number of `MANAGER` hosts is three.
            * `zoneIds`: List of availability zones the cluster hosts are located in.
            * `subnetIds`: List of subnet IDs.

            
            * `assignPublicIp`: Permission to [connect](connect.md) to the host from the internet, `true` or `false`.


            * `diskSizeAutoscaling`: Automatic storage expansion settings:

                * `plannedUsageThreshold`: Storage usage percentage to trigger a storage expansion during the next maintenance window.

                    Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled.

                    If you set this condition, [configure the maintenance window schedule](update.md#change-additional-settings) before creating your host group.

                * `emergencyUsageThreshold`: Storage usage percentage to trigger an immediate storage expansion.

                    Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled.

                    {% note warning %}

                    If you specify both thresholds, `emergencyUsageThreshold` must not be less than `plannedUsageThreshold`.

                    {% endnote %}

                * `diskSizeLimit`: Maximum storage size, in bytes, to set when storage usage reaches one of the specified thresholds.

                
                {% include [warn-storage-resize](../../_includes/mdb/mos/warn-storage-resize.md) %}


    1. To update an `{{ OS }}` host group configuration:

        1. Call the [Cluster.UpdateOpenSearchNodeGroup](../api-ref/Cluster/updateOpenSearchNodeGroup.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/opensearch/node_groups/<host_group_name>' \
                --data "@body.json"
            ```

            You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters). You can get the host group name with [cluster details](cluster-list.md#get-cluster).

        1. View the [server response](../api-ref/Cluster/updateOpenSearchNodeGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

    1. To update a `Dashboards` host group configuration:

        1. Call the [Cluster.UpdateDashboardsNodeGroup](../api-ref/Cluster/updateDashboardsNodeGroup.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/dashboards/node_groups/<host_group_name>' \
                --data "@body.json"
            ```

            You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters). You can get the host group name with [cluster details](cluster-list.md#get-cluster).

        1. View the [server response](../api-ref/Cluster/updateDashboardsNodeGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Create a file named `body.json` and paste the following code into it:

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
                "assign_public_ip": <allow_public_access_to_hosts>,
                "disk_size_autoscaling": {
                    "planned_usage_threshold": "<scheduled_expansion_percentage>",
                    "emergency_usage_threshold": "<immediate_expansion_percentage>",
                    "disk_size_limit": "<maximum_storage_size_in_bytes>"
                }
            }
        }
        ```


        Where:

        * `update_mask`: List of parameters to update as an array of strings (`paths[]`).
        * `node_groups`: Host settings:

            * `resources`: Cluster resources:

                * `resource_preset_id`: [Host class](../concepts/instance-types.md).
                * `disk_size`: Disk size, in bytes.
                * `disk_type_id`: [Disk type](../concepts/storage.md).

            * `hosts_count`: Number of hosts in the group. The minimum number of `DATA` and `Dashboards` hosts is one; while the minimum number of `MANAGER` hosts is three.
            * `zone_ids`: List of availability zones the cluster hosts are located in.
            * `subnet_ids`: List of subnet IDs.

            
            * `assign_public_ip`: Permission to [connect](connect.md) to the host from the internet, `true` or `false`.


            * `disk_size_autoscaling`: Automatic storage expansion settings:

                * `planned_usage_threshold`: Storage usage percentage to trigger a storage expansion during the next maintenance window.

                    Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled.

                    If you set this condition, [configure the maintenance window schedule](update.md#change-additional-settings) before creating your host group.

                * `emergency_usage_threshold`: Storage usage percentage to trigger an immediate storage expansion.

                    Use a value between `0` and `100`%. The default value is `0`, i.e., automatic expansion is disabled.

                    {% note warning %}

                    If you specify both thresholds, `emergency_usage_threshold` must not be less than `planned_usage_threshold`.

                    {% endnote %}

                * `disk_size_limit`: Maximum storage size, in bytes, to set when storage usage reaches one of the specified thresholds.

                
                {% include [warn-storage-resize](../../_includes/mdb/mos/warn-storage-resize.md) %}


    1. To update a `{{ OS }}` host group configuration:

        1. Call the [ClusterService.UpdateOpenSearchNodeGroup](../api-ref/grpc/Cluster/updateOpenSearchNodeGroup.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

            You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters). You can get the host group name with [cluster details](cluster-list.md#get-cluster).

        1. View the [server response](../api-ref/grpc/Cluster/updateOpenSearchNodeGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

    1. To update a `Dashboards` host group configuration:

        1. Call the [ClusterService.UpdateDashboardsNodeGroup](../api-ref/grpc/Cluster/updateDashboardsNodeGroup.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

            You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters). You can get the host group name with [cluster details](cluster-list.md#get-cluster).

        1. View the [server response](../api-ref/grpc/Cluster/updateDashboardsNodeGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Deleting a host group {#delete-host-group}

When deleting a host group, the following limitation applies: you cannot delete a single host group with the `DATA` role.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder page.
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}** service.
    1. Locate the cluster you need in the list, click its name, and select the ![host-groups.svg](../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}** tab.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the group you need and select **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To delete a host group, run this command:

    ```bash
    {{ yc-mdb-os }} node-group delete --cluster-name <cluster_name> \
       --node-group-name <host_group_name>
    ```

    In the command, specify the host group you want to delete.

- {{ TF }} {#tf}

    To delete a host group from a cluster:

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

        For a complete list of adjustable configuration fields for a {{ mos-name }} cluster, see the [{{ TF }} provider guide]({{ tf-provider-mos }}).

    1. To delete an `{{ OS }}` host group, remove its `node_groups` section from `opensearch`.

    1. To delete a `Dashboards` host group, remove the `dashboards` section.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm deleting the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mos/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. To delete an `{{ OS }}` host group:

        1. Call the [Cluster.DeleteOpenSearchNodeGroup](../api-ref/Cluster/deleteOpenSearchNodeGroup.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

            ```bash
            curl \
                --request DELETE \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/opensearch/node_groups/<host_group_name>'
            ```

            You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters). You can get the host group name with [cluster details](cluster-list.md#get-cluster).

        1. View the [server response](../api-ref/Cluster/deleteOpenSearchNodeGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

    1. To delete a `Dashboards` host group:

        1. Call the [Cluster.DeleteDashboardsNodeGroup](../api-ref/Cluster/deleteDashboardsNodeGroup.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

            ```bash
            curl \
                --request DELETE \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/dashboards/node_groups/<host_group_name>'
            ```

            You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters). You can get the host group name with [cluster details](cluster-list.md#get-cluster).

        1. View the [server response](../api-ref/Cluster/deleteDashboardsNodeGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. To delete a `{{ OS }}` host group:

        1. Call the [ClusterService.DeleteOpenSearchNodeGroup](../api-ref/grpc/Cluster/deleteOpenSearchNodeGroup.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

            You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters). You can get the host group name with [cluster details](cluster-list.md#get-cluster).

        1. View the [server response](../api-ref/grpc/Cluster/deleteOpenSearchNodeGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

    1. To delete a `Dashboards` host group:

        1. Call the [ClusterService.DeleteDashboardsNodeGroup](../api-ref/grpc/Cluster/deleteDashboardsNodeGroup.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

            You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters). You can get the host group name with [cluster details](cluster-list.md#get-cluster).

        1. View the [server response](../api-ref/grpc/Cluster/deleteDashboardsNodeGroup.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Getting a list of cluster hosts {#list-hosts}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder page.
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}** service.
    1. Click the cluster name and select the ![hosts](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.ListHosts](../api-ref/Cluster/listHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/hosts'
      ```

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.opensearch.v1.ListClusterHostsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.ListHosts](../api-ref/grpc/Cluster/listHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.opensearch.v1.ListClusterHostsResponse) to make sure your request was successful.

{% endlist %}
