# Managing {{ MG }} cluster hosts

You can add and remove [cluster hosts](../concepts/index.md), resync the hosts, and [manage {{ MG }} settings](update.md) for individual clusters. To learn how to move your cluster hosts to a different availability zone, see [this guide](host-migration.md).

## Getting a list of cluster hosts {#list-hosts}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of the {{ mmg-name }} cluster.
  1. Select the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of {{ mmg-name }} cluster hosts, run this command:

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

  You can request the {{ mmg-name }} cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.ListHosts](../api-ref/Cluster/listHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<cluster_ID>/hosts'
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.mongodb.v1.ListClusterHostsResponse) to make sure the request was successful.

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
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mongodb.v1.ClusterService.ListHosts
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.mongodb.v1.ListClusterHostsResponse) to make sure the request was successful.    

{% endlist %}

## Adding a host {#add-host}

The number of hosts in {{ mmg-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud). To check the resources currently in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ mmg-name }}**.

You can add different types of hosts to a {{ mmg-name }} cluster. Their number depends on the [sharding type](../concepts/sharding.md#shard-management):

{#hosts-table}

Sharding type | MONGOD | MONGOINFRA | MONGOS | MONGOCFG
--- | --- | --- | --- | ---
No sharding | ⩾ 1 | — | — | —
Standard | ⩾ 1 | ⩾ 3 | — | —
Advanced | ⩾ 1 | — | ⩾ 2 | ⩾ 3

{% list tabs group=instructions %}

- Management console {#console}

  To add a host to your {{ mmg-name }} cluster:
  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of the {{ mmg-name }} cluster you need and go to the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
  1. Specify the host parameters:
     * [Availability zone](../../overview/concepts/geo-scope.md).
     * [Subnet](../../vpc/concepts/network.md#subnet) (if the required subnet is not on the list, create it).
     * Select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if the host must be accessible from outside {{ yandex-cloud }}.
     * Host type and shard name, if sharding is enabled for the {{ mmg-name }} cluster.
  1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add a host to your {{ mmg-name }} cluster:
  1. Request a list of {{ mmg-name }} cluster subnets to select a [subnet](../../vpc/concepts/network.md#subnet) for the new host:

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

     If the required subnet is not in the list, create it.
  1. View a description of the CLI command for adding a host:

     ```bash
     {{ yc-mdb-mg }} host add --help
     ```

  1. Run the add host command:

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

      * `--cluster-name`: Cluster name. You can get it with the [list of clusters in a folder](cluster-list.md#list-clusters).
      * `--host`: Host parameters:
          * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
          * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). You need to specify it if the [availability zone](../../overview/concepts/geo-scope.md) contains more than one subnet; otherwise, {{ mmg-name }} will automatically select the only subnet there is.
          * `assign-public-ip`: Internet access to the host via a public IP address, `true` or `false`.
          * `hidden`: Hide host, `true` or `false`. If the host is hidden, only direct connections will be able to read from it (for example, to make backups from it without adding load to the cluster).
          * `secondary-delay-secs`: Replica's lag behind the master in seconds. It can be useful for data recovery in case of invalid operations.
          * `priority`: [Host priority for assignment as a master](../concepts/replication.md#master-failover).

      {{ mmg-name }} will run the add host operation.

- {{ TF }} {#tf}

  To add a host to your {{ mmg-name }} cluster:
  1. Open the current {{ TF }} configuration file that defines your infrastructure.

     For more information about creating this file, see [Creating clusters](cluster-create.md).
  1. Add the following to the {{ mmg-name }} cluster description:
     * Resources corresponding to the sharding type, if you are adding a host to a sharded cluster:
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

     * `host`: Host parameters:
       * `role`: Replica type (`PRIMARY` or `SECONDARY`).
       * `zone_id`: Availability zone.
       * `subnet_id`: ID of a subnet in the selected availability zone.
       * `assign_public_ip`: Public access to the host, `true` or `false`.
       * `shard_name`: Shard name in a sharded cluster.
       * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`.
       * `host_parameters`: Additional host parameters:
           * `hidden`: Hide host, `true` or `false`. If the host is hidden, only direct connections will be able to read from it (for example, to make backups from it without adding load to the cluster).
           * `secondary_delay_secs`: Replica's lag behind the master in seconds. It can be useful for data recovery in case of invalid operations.
           * `priority`: [Host priority for assignment as a master](../concepts/replication.md#master-failover).

  1. Make sure the settings are correct.
  
     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.AddHosts](../api-ref/Cluster/addHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

      Where `hostSpecs` sets the host parameters:

      * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
      * `subnetId`: [Subnet ID](../../vpc/concepts/network.md#subnet).
      * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.
      * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`. For a non-sharded cluster, use `MONGOD`.
      * `shardName`: Shard name in a sharded cluster.
      * `hidden`: Hide host, `true` or `false`. If the host is hidden, only direct connections will be able to read from it (for example, to make backups from it without adding load to the cluster).
      * `secondaryDelaySecs`: Replica's lag behind the master in seconds. It can be useful for data recovery in case of invalid operations.
      * `priority`: * `hidden`: Hide host, `true` or `false`. If the host is hidden, only direct connections will be able to read from it (for example, to make backups from it without adding load to the cluster).
      * `secondaryDelaySecs`: Replica's lag behind the master in seconds. It can be useful for data recovery in case of invalid operations.
      * `priority`: [Host priority for assignment as a master](../concepts/replication.md#master-failover).
      * `tags`: Host tags.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.AddHosts](../api-ref/grpc/Cluster/addHosts.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

      Where `host_specs` sets the host parameters:

      * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
      * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet).
      * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
      * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`. For a non-sharded cluster, use `MONGOD`.
      * `shard_name`: Shard name in a sharded cluster.
      * `hidden`: Hide host, `true` or `false`. If the host is hidden, only direct connections will be able to read from it (for example, to make backups from it without adding load to the cluster).
      * `secondaryDelaySecs`: Replica's lag behind the master in seconds. It can be useful for data recovery in case of invalid operations.
      * `priority`: [Host priority for assignment as a master](../concepts/replication.md#master-failover).
      * `tags`: Host tags.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}


{% note warning %}

If you cannot [connect](connect/index.md) to the host you added, check that the {{ mmg-name }} cluster [security group](../concepts/network.md#security-groups) is configured correctly for the host's subnet.

{% endnote %}


## Changing a host {#update}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the parameters of a host in a cluster, run the command below:

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

    * `--cluster-name`: Cluster name. You can get it with the [list of clusters in a folder](cluster-list.md#list-clusters).
    * `--host`: Host parameters:
        * `hostname`: Name of the host you are editing. You can request it with the [list of hosts in the cluster](#list).
        * `assign-public-ip`: Internet access to the host via a public IP address, `true` or `false`.
        * `hidden`: Hide host, `true` or `false`. If the host is hidden, only direct connections will be able to read from it (for example, to make backups from it without adding load to the cluster).
        * `secondary-delay-secs`: Replica's lag behind the master in seconds. It can be useful for data recovery in case of invalid operations.
        * `priority`: [Host priority for assignment as a master](../concepts/replication.md#master-failover).

- {{ TF }} {#tf}

    To change the parameters of the cluster host:

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

    1. In the {{ mpg-name }} cluster description, change the attributes of the `host` block corresponding to the host you are updating.

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

    * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
    * `host_parameters`: Additional host parameters:
        * `hidden`: Hide host, `true` or `false`. If the host is hidden, only direct connections will be able to read from it (for example, to make backups from it without adding load to the cluster).
        * `secondary_delay_secs`: Replica's lag behind the master in seconds. It can be useful for data recovery in case of invalid operations.
        * `priority`: [Host priority for assignment as a master](../concepts/replication.md#master-failover).

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.updateHosts](../api-ref/Cluster/updateHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

        Where `updateHostSpecs` sets the host parameters:

        * `updateMask`: List of parameters to update as a single string, separated by commas.
        * `hostName`: Name of the host you are editing. You can request it with the [list of hosts in the cluster](#list-hosts).
        * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.
        * `hidden`: Hide host, `true` or `false`. If the host is hidden, only direct connections will be able to read from it (for example, to make backups from it without adding load to the cluster).
        * `secondaryDelaySecs`: Replica's lag behind the master in seconds. It can be useful for data recovery in case of invalid operations.
        * `priority`: [Host priority for assignment as a master](../concepts/replication.md#master-failover).

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/updateHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService/UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

        Where `update_host_specs` sets the host parameters:

        * `update_mask`: List of parameters to update as a single string, separated by commas.
        * `host_name`: Name of the host you are editing. You can request it with the [list of hosts in the cluster](#list-hosts).
        * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
        * `hidden`: Hide host, `true` or `false`. If the host is hidden, only direct connections will be able to read from it (for example, to make backups from it without adding load to the cluster).
        * `secondary_delay_secs`: Replica's lag behind the master in seconds. It can be useful for data recovery in case of invalid operations.
        * `priority`: [Host priority for assignment as a master](../concepts/replication.md#master-failover).

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/updateHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Removing a host {#remove-host}

You can remove a `MONGOD` host from a {{ mmg-name }} cluster if it is not the only host in it. To replace a single host, first create a new host and then remove the old one.

If the host you are removing is a primary one, {{ mmg-name }} will automatically select a new primary replica.

From a [sharded {{ mmg-name }} cluster](../operations/shards.md#enable), you may remove the `MONGOS`, `MONGOCFG`, or `MONGOINFRA` hosts that exceed the [minimum number](#hosts-table) needed for sharding.

{% list tabs group=instructions %}

- Management console {#console}

  To remove a host from a {{ mmg-name }} cluster:
  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of the {{ mmg-name }} cluster you need and select the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host's row and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, check **Delete host** and click **{{ ui-key.yacloud.mdb.cluster.hosts.popup-confirm_button }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a host from the {{ mmg-name }} cluster, run:

  ```bash
  {{ yc-mdb-mg }} host delete <host_name>
    --cluster-name <cluster_name>
  ```

  You can request the host name with a list of [{{ mmg-name }} cluster hosts](#list-hosts) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  To remove a host from a {{ mmg-name }} cluster:
  1. Open the current {{ TF }} configuration file that defines your infrastructure.

     For more information about creating this file, see [Creating clusters](cluster-create.md).
  1. Delete the corresponding `host` block from the {{ mmg-name }} cluster description.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Type `yes` and press **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.DeleteHosts](../api-ref/Cluster/deleteHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

      Where `hostNames` is an array with the names of hosts to delete. To find out the host name, [get a list of hosts in the cluster](#list-hosts).

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

      Where `host_names` is an array with the names of hosts to delete. To find out the host name, [get a list of hosts in the cluster](#list-hosts).

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Starting host resync {#resetup}

To [resync a host](https://docs.mongodb.com/manual/tutorial/resync-replica-set-member/) with other replicas in the {{ mmg-name }} cluster or shard, run forced resync. The operation can be applied to only one `MONGOD` host at a time and only for {{ mmg-name }} clusters with more than two replicas, regardless of the host class and type. Resync also lets you remove the collections and documents that were marked as deleted from the host's storage.

During this operation:
1. The host stops accepting write requests. If the host was a `PRIMARY` replica, {{ mmg-name }} will try to [make it a `SECONDARY` replica](https://docs.mongodb.com/manual/reference/method/rs.stepDown/#rs.stepDown). If the operation fails, it is aborted.
1. The {{ MG }} instance on the host stops, and all data is deleted.
1. The {{ MG }} instance restarts and downloads data from replica hosts again.
1. Once the host has synced with other replicas in the {{ mmg-name }} cluster, it becomes a secondary replica.

   {% note info %}

   * During syncing, the host cannot fully respond to any request, because it has only a part of the {{ mmg-name }} cluster data.
   * Estimated sync rate: 300 GB per day or more.

   {% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To forcibly resync a host:
  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of the {{ mmg-name }} cluster you need and select the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host's row and select **{{ ui-key.yacloud.mdb.clusters.button_action-resetup }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To forcibly resync a host, run the following command:

  ```bash
  {{ yc-mdb-mg }} hosts resetup <host_name>
     --cluster-name <cluster_name>
  ```

  You can get the host name with a [list of hosts in the folder](hosts.md#list-hosts). You can request the {{ mmg-name }} cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.ResetupHosts](../api-ref/Cluster/resetupHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

      Where `hostNames` is an array with the names of hosts to re-sync. To find out the host name, [get a list of hosts in the cluster](#list-hosts).

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/resetupHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.ResetupHosts](../api-ref/grpc/Cluster/resetupHosts.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

      Where `host_names` is an array with the names of hosts to re-sync. To find out the host name, [get a list of hosts in the cluster](#list-hosts).

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/resetupHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Restarting a host {#restart}

You can manually restart {{ mmg-name }} cluster hosts.

Restarting a host may make a {{ mmg-name }} cluster or [shard](../concepts/sharding.md) temporarily unavailable:
* If there is a single host in the cluster.
* If the host is the [primary replica](../concepts/replication.md).

When the primary replica is restarted, there is no automatic switch-over. To make sure the {{ mmg-name }} cluster remains available, [switch the cluster's primary replica](stepdown.md) before it is restarted.

{% note info %}

You can only restart one host at a time.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To restart a host:
  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the name of the {{ mmg-name }} cluster you need and select the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host's row and select **{{ ui-key.yacloud.mdb.cluster.hosts.action_restart-host }}**.
  1. Confirm the host restart.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To restart a host, run the command:

  ```bash
  {{ yc-mdb-mg }} hosts restart <host_name> \
    --cluster-name <cluster_name>
  ```

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.RestartHosts](../api-ref/Cluster/restartHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

      Where `hostNames` is an array with the names of hosts to restart. To find out the host name, [get a list of hosts in the cluster](#list-hosts).

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/restartHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService.RestartHosts](../api-ref/grpc/Cluster/restartHosts.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

      Where `host_names` is an array with the names of hosts to restart. To find out the host name, [get a list of hosts in the cluster](#list-hosts).

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/restartHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}
