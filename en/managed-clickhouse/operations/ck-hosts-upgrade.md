---
title: Changing the coordination service from embedded {{ CK }} to {{ CK }} on separate hosts
description: Follow this guide to change the coordination service from embedded {{ CK }} to {{ CK }} on separate hosts.
---

# Changing the coordination service from embedded {{ CK }} to {{ CK }} on separate hosts

If using embedded {{ CK }} as a coordination service, you can change it to {{ CK }} on separate hosts. Once you enable {{ CK }} on separate hosts, you cannot disable it or switch back to embedded {{ CK }}.

{% note warning %}

{{ CK }} hosts are counted towards the cloud [resource quota]({{ link-console-quotas }}) and the [cluster cost](../pricing.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the coordination service:

  1. View the command description:

      ```bash
      {{ yc-mdb-ch }} cluster add-zookeeper --help
      ```

  1. In the command, specify the following host parameters:

      
      ```bash
      {{ yc-mdb-ch }} cluster add-zookeeper \
        --name <cluster_name> \
        --resource-preset <host_class> \
        --disk-type <disk_type> \
        --disk-size <storage_size> \
        --host type=keeper,`
              `zone-id=<availability_zone>,`
              `subnet-id=<subnet_ID> \
        --convert-tables-to-replicated <convert_tables>
      ```


      Where:

      * `--resource-preset`: [Host class](../concepts/instance-types.md).
      * `--disk-type`: [Disk type](../concepts/storage.md).
      * `--disk-size`: Storage size, in bytes.

      * `--host`: Host settings:
        * `type`: Host type, `keeper`.
        * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).

        
        * `subnet-id`: Subnet ID. Specify if the selected availability zone has two or more subnets.


        You can add multiple hosts at once. Specify a separate `--host` flag for each host.

      * `--convert-tables-to-replicated`: Convert non-replicated tables to [replicated](../concepts/replication.md#replicated-tables) ones.

      You can get the cluster name from the [list of clusters in your folder](cluster-list.md#list-clusters).

- REST API {#api}

    To change the coordination service:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.AddZookeeper](../api-ref/Cluster/addZookeeper.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        1. Create a file named `body.json` and paste the following code into it:

            
            ```json
            {
              "resources": {
                "resourcePresetId": "<host_class>",
                "diskSize": "<storage_size>",
                "diskTypeId": "<disk_type>"
              },
              "hostSpecs": [
                {
                  "zoneId": "<availability_zone>",
                  "type": "KEEPER",
                  "subnetId": "<subnet_ID>"
                }
              ],
              "convertTablesToReplicated": <convert_tables>
            }
            ```


            Where:

            * `resources`: Host configuration:

               * `resourcePresetId`: [Host class](../concepts/instance-types.md) ID. You can get the list of available host classes with their IDs using the [ResourcePreset.list](../api-ref/ResourcePreset/list.md) method.
               * `diskSize`: Storage size, in bytes.
               * `diskTypeId`: [Disk type](../concepts/storage.md).

            * `hostSpecs`: Host settings as an array of elements, one per host. Each element has the following structure:

                * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
                * `type`: Host type, `KEEPER`.

                
                * `subnetId`: [Subnet](../../vpc/concepts/network.md#subnet) ID.


            * `convertTablesToReplicated`: Convert non-replicated tables to [replicated](../concepts/replication.md#replicated-tables) ones.

            You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        1. Run this request:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>:addZookeeper' \
              --data '@body.json'
            ```

    1. View the [server response](../api-ref/Cluster/addZookeeper.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    To change the coordination service:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.AddZookeeper](../api-ref/grpc/Cluster/addZookeeper.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        1. Create a file named `body.json` and paste the following code into it:

            
            ```json
            {
              "cluster_id": "<cluster_ID>",
              "resources": {
                "resource_preset_id": "<host_class>",
                "disk_size": "<storage_size>",
                "disk_type_id": "<disk_type>"
              },
              "host_specs": [
                {
                  "zone_id": "<availability_zone>",
                  "type": "KEEPER",
                  "subnet_id": "<subnet_ID>",
                }
              ],
              "convert_tables_to_replicated": <convert_tables>
            }
            ```


            Where:

            * `resources`: Host configuration:

               * `resource_preset_id`: [Host class](../concepts/instance-types.md) ID. You can get the list of available host classes with their IDs using the [ResourcePresetService.List](../api-ref/grpc/ResourcePreset/list.md) method.
               * `disk_size`: Storage size, in bytes.
               * `disk_type_id`: [Disk type](../concepts/storage.md).

            * `host_specs`: Host settings as an array of elements, one per host. Each element has the following structure:

                * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
                * `type`: Host type, `KEEPER`.

                
                * `subnet_id`: [Subnet](../../vpc/concepts/network.md#subnet) ID.


            * `convertTablesToReplicated`: Convert non-replicated tables to [replicated](../concepts/replication.md#replicated-tables) ones.

            You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        1. Run this request:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d @ \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.addZookeeper \
              < body.json
            ```

    1. Check the [server response](../api-ref/grpc/Cluster/addZookeeper.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
