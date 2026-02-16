# Managing {{ SD }} cluster hosts

You can add or remove [cluster hosts](../concepts/index.md), restart host synchronization, and [manage {{ SD }} cluster settings](update.md). To learn how to migrate your cluster hosts to a different availability zone, see [this guide](host-migration.md).

## Getting a list of cluster hosts {#list-hosts}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. Click the name of the {{ mmg-name }} cluster.
  1. Select the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get the list of {{ mmg-name }} cluster hosts, run this command:

  ```bash
  {{ yc-mdb-mg }} host list \
    --cluster-name <cluster_name>
  ```

  Result:

  ```text
  +----------------------------+----------------------+--------+------------+--------------+----------+---------------+-----------+
  |           NAME             |      CLUSTER ID      |  TYPE  | SHARD NAME |     ROLE     |  HEALTH  |    ZONE ID    | PUBLIC IP |
  +----------------------------+----------------------+--------+------------+--------------+----------+---------------+-----------+
  | rc1b...{{ dns-zone }} | c9qp71dk1q1w******** | MONGOD | rs01       | PRIMARY      | ALIVE    | {{ region-id }}-b | false     |
  | rc1a...{{ dns-zone }} | c9qp71dk1q1w******** | MONGOD | rs01       | SECONDARY    | ALIVE    | {{ region-id }}-a | false     |
  +----------------------------+----------------------+--------+------------+--------------+----------+---------------+-----------+
  ```

  You can get the {{ mmg-name }} cluster name from the [list of clusters in your folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.ListHosts](../api-ref/Cluster/listHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/hosts'
        ```

        You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.mongodb.v1.ListClusterHostsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.ListHosts](../api-ref/grpc/Cluster/listHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mongodb.v1.ClusterService.ListHosts
        ```

        You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.mongodb.v1.ListClusterHostsResponse) to make sure your request was successful.    

{% endlist %}

## Adding a host {#add-host}

The number of hosts in {{ mmg-name }} clusters is limited by the CPU and memory quotas allocated to the database clusters in your[cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud). To review current resource usage, open the [Quotas]({{ link-console-quotas }}) page and find the **{{ mmg-name }}** section.

You can add hosts of different types to your {{ mmg-name }} cluster. Their number depends on the [sharding type](../concepts/sharding.md#shard-management):

{#hosts-table}

{% include [sharding-and-host-roles-table](../../_includes/mdb/mmg/sharding-and-host-roles-table.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  To add a host to your {{ mmg-name }} cluster:
  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. Click the name of your {{ mmg-name }} cluster and open the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
  1. Specify the following host settings:
     * [Availability zone](../../overview/concepts/geo-scope.md).
     * [Subnet](../../vpc/concepts/network.md#subnet) (if the required subnet is not on the list, create it).

     
     * To make the host accessible from outside {{ yandex-cloud }}, select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.


     * Host type and shard name, if sharding is enabled for the {{ mmg-name }} cluster.
  1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add a host to your {{ mmg-name }} cluster:
  1. To choose a [subnet](../../vpc/concepts/network.md#subnet) for your new host, first get the list of subnets in the {{ mmg-name }} cluster:

     ```bash
     yc vpc subnet list
     ```

     Result:

     ```text
     +----------------------+-----------+-----------------------+---------------+------------------+
     |          ID          |   NAME    |       NETWORK ID      |       ZONE    |      RANGE       |
     +----------------------+-----------+-----------------------+---------------+------------------+
     | b0cl69a2b4c6******** | default-d | enp6rq72rndgr******** | {{ region-id }}-d | [172.16.0.0/20]  |
     | e2lkj9qwe762******** | default-b | enp6rq72rndgr******** | {{ region-id }}-b | [10.10.0.0/16]   |
     | e9b0ph42bn96******** | a-2       | enp6rq72rndgr******** | {{ region-id }}-a | [172.16.32.0/20] |
     | e9b9v22r88io******** | default-a | enp6rq72rndgr******** | {{ region-id }}-a | [172.16.16.0/20] |
     +----------------------+-----------+-----------------------+---------------+------------------+
     ```

     If the required subnet is not on the list, create it.
  1. See the description of the CLI command for adding new hosts:

     ```bash
     {{ yc-mdb-mg }} host add --help
     ```

  1. Run this command to add a host:

      ```bash
      {{ yc-mdb-mg }} host add \
        --cluster-name <cluster_name> \
        --host zone-id=<availability_zone>,`
              `subnet-id=<subnet_ID>,`
              `assign-public-ip=<public_access>,`
              `hidden=<hide_host>,`
              `secondary-delay-secs=<replica_lag_in_seconds>,`
              `priority=<host_priority>
      ```

      Where:

      * `--cluster-name`: Cluster name. You can get it from the [list of clusters in your folder](cluster-list.md#list-clusters).
      * `--host`: Host settings:
          * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). If your [availability zone](../../overview/concepts/geo-scope.md) contains multiple subnets, make sure to specify the subnet ID. If only one exists, {{ mmg-name }} will auto-select it.
          * `assign-public-ip`: Controls whether the host is accessible via a public IP address, `true` or `false`.
          * `hidden`: Determines whether the host is hidden, `true` or `false`. A hidden host is still accessible for read operations, but only through direct connections. This can be useful, for example, for making backups without adding extra load to the cluster.
          * `secondary-delay-secs`: Replica's lag behind the master in seconds. This setting can be useful for data recovery after operational errors.
          * `priority`: [Host priority for master promotion](../concepts/replication.md#master-failover).

      {{ mmg-name }} will start the host addition process.

- {{ TF }} {#tf}

  To add a host to your {{ mmg-name }} cluster:
  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating a cluster](cluster-create.md).
  1. Add the following to the {{ mmg-name }} cluster description:
     * Required resources, based on sharding type, if you are adding a host to a sharded cluster:
       * `resources_mongoinfra` for standard sharding.
       * `resources_mongos` and `resources_mongocfg` for advanced sharding.
     * `host` block.

     ```hcl
     resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
       ...
       resources_mongod {
         resource_preset_id = "<host_class>"
         disk_type_id       = "<disk_type>"
         disk_size          = <storage_size_in_GB>
       }

       resources_mongoinfra { # Add for standard sharding.
         resource_preset_id = "<host_class>"
         disk_type_id       = "<disk_type>"
         disk_size          = <storage_size_in_GB>
       }

       resources_mongos { # Add for advanced sharding.
         resource_preset_id = "<host_class>"
         disk_type_id       = "<disk_type>"
         disk_size          = <storage_size_in_GB>
       }

       resources_mongocfg { # Add for advanced sharding.
         resource_preset_id = "<host_class>"
         disk_type_id       = "<disk_type>"
         disk_size          = <storage_size_in_GB>
       }

       host {
         role             = "<replica_type>"
         zone_id          = "<availability_zone>"
         subnet_id        = "<subnet_ID>"
         assign_public_ip = <public_access>
         shard_name       = "<shard_name>"
         type             = "<host_type>"
         host_parameters {
           hidden               = <hide_host>
           secondary_delay_secs = <replica_lag_in_seconds>
           priority             = <host_priority>
         }
         ...
       }
     }
     ```

     Where:

     * `host`: Host settings:
       * `role`: Replica type, `PRIMARY` or `SECONDARY`.
       * `zone_id`: Availability zone.
       * `subnet_id`: ID of the subnet in the selected availability zone.
       * `assign_public_ip`: Public access to the host, `true` or `false`.
       * `shard_name`: Shard name in a sharded cluster.
       * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`.
       * `host_parameters`: Additional host settings:
           * `hidden`: Determines whether the host is hidden, `true` or `false`. A hidden host is still accessible for read operations, but only through direct connections. This can be useful, for example, for making backups without adding extra load to the cluster.
           * `secondary_delay_secs`: Replica's lag behind the master in seconds. This setting can be useful for data recovery after operational errors.
           * `priority`: [Host priority for master promotion](../concepts/replication.md#master-failover).

  1. Validate your configuration.
  
     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.AddHosts](../api-ref/Cluster/addHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/hosts:batchCreate' \
          --data '{
                    "hostSpecs": [
                      {
                        "zoneId": "<availability_zone>",
                        "subnetId": "<subnet_ID>",
                        "assignPublicIp": <public_access_to_host>,
                        "type": "<host_type>",
                        "shardName": "<shard_name>",
                        "hidden": <hide_host>,
                        "secondaryDelaySecs": "<replica_lag_in_seconds>",
                        "priority": "<host_priority>",
                        "tags": "<host_tags>"
                      }
                    ]
                  }'
      ```

      Where `hostSpecs` are the host settings:

      * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
      * `subnetId`: [Subnet ID](../../vpc/concepts/network.md#subnet).
      * `assignPublicIp`: Controls whether the host is accessible via a public IP address, `true` or `false`.
      * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`. For a non-sharded cluster, use `MONGOD`.
      * `shardName`: Shard name in a sharded cluster.
      * `hidden`: Determines whether the host is hidden, `true` or `false`. A hidden host is still accessible for read operations, but only through direct connections. This can be useful, for example, for making backups without adding extra load to the cluster.
      * `secondaryDelaySecs`: Replica's lag behind the master in seconds. This setting can be useful for data recovery after operational errors.
      * `priority`: Determines whether the host is hidden, `true` or `false`. A hidden host is still accessible for read operations, but only through direct connections. This can be useful, for example, for making backups without adding extra load to the cluster.
      * `secondaryDelaySecs`: Replica's lag behind the master in seconds. This setting can be useful for data recovery after operational errors.
      * `priority`: [Host priority for master promotion](../concepts/replication.md#master-failover).
      * `tags`: Host tags.

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.AddHosts](../api-ref/grpc/Cluster/addHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "host_specs": [
                  {
                    "zone_id": "<availability_zone>",
                    "subnet_id": "<subnet_ID>",
                    "assign_public_ip": <public_access_to_host>,
                    "type": "<host_type>",
                    "shard_name": "<shard_name>",
                    "hidden": <hide_host>,
                    "secondary_delay_secs": "<replica_lag_in_seconds>",
                    "priority": "<host_priority>",
                    "tags": "<host_tags>"
                  }
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.AddHosts
      ```

      Where `host_specs` are the host settings:

      * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
      * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet).
      * `assign_public_ip`: Controls whether the host is accessible via a public IP address, `true` or `false`.
      * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`. For a non-sharded cluster, use `MONGOD`.
      * `shard_name`: Shard name in a sharded cluster.
      * `hidden`: Determines whether the host is hidden, `true` or `false`. A hidden host is still accessible for read operations, but only through direct connections. This can be useful, for example, for making backups without adding extra load to the cluster.
      * `secondaryDelaySecs`: Replica's lag behind the master in seconds. This setting can be useful for data recovery after operational errors.
      * `priority`: [Host priority for master promotion](../concepts/replication.md#master-failover).
      * `tags`: Host tags.

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


{% note warning %}

If you cannot [connect](connect/index.md) to the new host, check the {{ mmg-name }} cluster‘s [security group](../concepts/network.md#security-groups) settings for its subnet.

{% endnote %}


## Updating a host {#update}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To update the cluster host’s settings, run the following command:

    ```bash
    {{ yc-mdb-mg }} host update \
      --cluster-name <cluster_name> \
      --host hostname=<host_name>,`
            `assign-public-ip=<public_access_to_host>,`
            `hidden=<hide_host>,`
            `secondary-delay-secs=<replica_lag_in_seconds>,`
            `priority=<host_priority>
    ```

    Where:

    * `--cluster-name`: Cluster name. You can get it from the [list of clusters in your folder](cluster-list.md#list-clusters).
    * `--host`: Host settings:
        * `hostname`: Target host name. You can get it from the [list of your cluster hosts](#list).
        * `assign-public-ip`: Controls whether the host is accessible via a public IP address, `true` or `false`.
        * `hidden`: Determines whether the host is hidden, `true` or `false`. A hidden host is still accessible for read operations, but only through direct connections. This can be useful, for example, for making backups without adding extra load to the cluster.
        * `secondary-delay-secs`: Replica's lag behind the master in seconds. This setting can be useful for data recovery after operational errors.
        * `priority`: [Host priority for master promotion](../concepts/replication.md#master-failover).

- {{ TF }} {#tf}

    To change the cluster host settings:

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

        For a complete list of configurable {{ mpg-name }} cluster fields, refer to the [{{ TF }} provider guides]({{ tf-provider-mpg }}).

    1. In the {{ mpg-name }} cluster description, change the attributes of the `host` section referring to the host you want to update.

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
          ...
          host {
            assign_public_ip = <public_access_to_host>
            host_parameters {
              hidden               = <hide_host>
              secondary_delay_secs = <replica_lag_in_seconds>
              priority             = <host_priority>
            }
          }
        }
        ```

    Where:

    * `assign_public_ip`: Controls whether the host is accessible via a public IP address, `true` or `false`.
    * `host_parameters`: Additional host settings:
        * `hidden`: Determines whether the host is hidden, `true` or `false`. A hidden host is still accessible for read operations, but only through direct connections. This can be useful, for example, for making backups without adding extra load to the cluster.
        * `secondary_delay_secs`: Replica's lag behind the master in seconds. This setting can be useful for data recovery after operational errors.
        * `priority`: [Host priority for master promotion](../concepts/replication.md#master-failover).

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.updateHosts](../api-ref/Cluster/updateHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/hosts:batchUpdate' \
          --data '{
                    "updateHostSpecs": [
                      {
                        "updateMask": "hostName,assignPublicIp,hidden,secondaryDelaySecs,priority",
                        "hostName": "<host_name>",
                        "assignPublicIp": <public_access_to_host>,
                        "hidden": <hide_host>,
                        "secondaryDelaySecs": "<replica_lag_in_seconds>",
                        "priority": "<host_priority>"
                      }
                    ]
                  }'
        ```

        Where `updateHostSpecs` are the host settings:

        * `updateMask`: Comma-separated list of settings you want to update.
        * `hostName`: Target host name. You can get it from the [list of your cluster hosts](#list-hosts).
        * `assignPublicIp`: Controls whether the host is accessible via a public IP address, `true` or `false`.
        * `hidden`: Determines whether the host is hidden, `true` or `false`. A hidden host is still accessible for read operations, but only through direct connections. This can be useful, for example, for making backups without adding extra load to the cluster.
        * `secondaryDelaySecs`: Replica's lag behind the master in seconds. This setting can be useful for data recovery after operational errors.
        * `priority`: [Host priority for master promotion](../concepts/replication.md#master-failover).

        You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/updateHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService/UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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
                "update_host_specs": [
                  {
                    "update_mask": {
                        "paths": [
                          "assign_public_ip",
                          "hidden",
                          "secondary_delay_secs",
                          "priority"
                        ]
                    },
                    "host_name": "<host_name>",
                    "assign_public_ip": <public_access_to_host>,
                    "hidden": <hide_host>,
                    "secondary_delay_secs": "<replica_lag_in_seconds>",
                    "priority": "<host_priority>"
                  }
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.UpdateHosts
        ```

        Where `update_host_specs` are the host settings:

        * `update_mask`: Comma-separated list of settings you want to update.
        * `host_name`: Target host name. You can get it from the [list of your cluster hosts](#list-hosts).
        * `assign_public_ip`: Controls whether the host is accessible via a public IP address, `true` or `false`.
        * `hidden`: Determines whether the host is hidden, `true` or `false`. A hidden host is still accessible for read operations, but only through direct connections. This can be useful, for example, for making backups without adding extra load to the cluster.
        * `secondary_delay_secs`: Replica's lag behind the master in seconds. This setting can be useful for data recovery after operational errors.
        * `priority`: [Host priority for master promotion](../concepts/replication.md#master-failover).

        You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/updateHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Deleting a host {#remove-host}

You can remove a `MONGOD` host from a {{ mmg-name }} cluster unless it is the cluster’s sole host. In order to replace a sole host, you must first create a new host and then delete the old one.

If the host being removed is the primary replica, {{ mmg-name }} will automatically elect a new primary replica.

In a [sharded {{ mmg-name }} cluster](../operations/shards.md#enable), you can remove the `MONGOS`, `MONGOCFG`, or `MONGOINFRA` hosts, provided you keep the [minimum number](#hosts-table) required for sharding.

{% list tabs group=instructions %}

- Management console {#console}

  To remove a host from a {{ mmg-name }} cluster:
  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. Locate the {{ mmg-name }} cluster you need in the list, click its name, and select the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
  1. Find the host you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in its row, and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, check **Delete host** and click **{{ ui-key.yacloud.mdb.cluster.hosts.popup-confirm_button }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a host from a {{ mmg-name }} cluster, run this command:

  ```bash
  {{ yc-mdb-mg }} host delete <host_name>
    --cluster-name <cluster_name>
  ```

  You can get the host name from the list of [{{ mmg-name }} cluster hosts](#list-hosts) and the cluster name from the list [list of clusters in your folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  To remove a host from a {{ mmg-name }} cluster:
  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating a cluster](cluster-create.md).
  1. Delete the relevant `host` section from the {{ mmg-name }} cluster description.
  1. Validate your configuration.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Type `yes` and press **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.DeleteHosts](../api-ref/Cluster/deleteHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/hosts:batchDelete' \
          --data '{
                    "hostNames": [
                      "<host_name>"
                    ]
                  }'
      ```

      Where `hostNames` is an array containing the host names you want to delete. You can get the host name from the [list of hosts in your cluster](#list-hosts).

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "host_names": [
                  "<host_name>"
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.DeleteHosts
      ```

      Where `host_names` is an array containing the host names you want to delete. You can get the host name from the [list of hosts in your cluster](#list-hosts).

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Starting host resync {#resetup}

To resync a host with other replicas in the {{ mmg-name }} cluster or shard, run a forced resync. This operation can be applied to a single `MONGOD` host at a time and is restricted to {{ mmg-name }} clusters containing more than two replicas. The restriction applies irrespective of host class and type. Resync also frees up the host’s storage by removing collections and documents marked as deleted.

During this operation:
1. The host stops accepting write requests. If the host was a `PRIMARY` replica, {{ mmg-name }} will attempt to demote it to a `SECONDARY` replica. In the event of failure, the operation is aborted.
1. The {{ SD }} instance on the host is stopped, and all its data is deleted.
1. The {{ SD }} instance restarts and re-downloads data from the replicas.
1. Once the host has synced with the other replicas in the {{ mmg-name }} cluster, it is demoted to a secondary replica.

   {% note info %}

   * During synchronization, the host cannot process requests properly, as it holds only a subset of the {{ mmg-name }} cluster’s data.
   * Estimated sync speed is 300 GB per day or more.

   {% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To force a host resync:
  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. Locate the {{ mmg-name }} cluster you need in the list, click its name, and select the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
  1. Find the host you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in its row, and select **{{ ui-key.yacloud.mdb.clusters.button_action-resetup }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To force a host resync, run this command:

  ```bash
  {{ yc-mdb-mg }} hosts resetup <host_name>
     --cluster-name <cluster_name>
  ```

  You can get the host name from the [list of hosts in your folder](hosts.md#list-hosts). You can get the {{ mmg-name }} cluster name from the [list of clusters in your folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.ResetupHosts](../api-ref/Cluster/resetupHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>:resetupHosts' \
          --data '{
                    "hostNames": [
                      "<host_name>"
                    ]
                  }'
      ```

      Where `hostNames` is an array with the names of hosts you want to re-sync. You can get the host name from the [list of hosts in your cluster](#list-hosts).

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/resetupHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.ResetupHosts](../api-ref/grpc/Cluster/resetupHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "host_names": [
                  "<host_name>"
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.ResetupHosts
      ```

      Where `host_names` is an array with the names of hosts you want to re-sync. You can get the host name from the [list of hosts in your cluster](#list-hosts).

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/resetupHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Restarting a host {#restart}

You can manually restart {{ mmg-name }} cluster hosts.

A host restart may result in temporary downtime for the {{ mmg-name }} cluster or [shard](../concepts/sharding.md):
* If your cluster consists of a single host.
* If the host being rebooted is the [primary replica](../concepts/replication.md).

A primary replica restart does not trigger an automatic failover. To prevent {{ mmg-name }} cluster downtime, [switch its primary replica](stepdown.md) before restarting the host.

{% note info %}

You can only restart one host at a time.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To restart a host:
  1. Open the [folder dashboard]({{ link-console-main }}).
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. Locate the {{ mmg-name }} cluster you need in the list, click its name, and select the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
  1. Find the host you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in its row, and select **{{ ui-key.yacloud.mdb.cluster.hosts.action_restart-host }}**.
  1. Confirm host reboot.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To restart a host, run this command:

  ```bash
  {{ yc-mdb-mg }} hosts restart <host_name> \
    --cluster-name <cluster_name>
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.RestartHosts](../api-ref/Cluster/restartHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>:restartHosts' \
          --data '{
                    "hostNames": [
                      "<host_name>"
                    ]
                  }'
      ```

      Where `hostNames` is an array with the names of hosts you want to restart. You can get the host name from the [list of hosts in your cluster](#list-hosts).

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/restartHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.RestartHosts](../api-ref/grpc/Cluster/restartHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "host_names": [
                  "<host_name>"
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.RestartHosts
      ```

      Where `host_names` is an array with the names of hosts you want to restart. You can get the host name from the [list of hosts in your cluster](#list-hosts).

      You can get the cluster ID from the [list of clusters in your folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/restartHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
