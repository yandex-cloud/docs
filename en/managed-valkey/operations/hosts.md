# Managing {{ VLK }} cluster hosts

You can add and remove cluster hosts, as well as manage their settings. To learn how to move cluster hosts to a different [availability zone](../../overview/concepts/geo-scope.md), see [this guide](host-migration.md).

## Getting a list of cluster hosts {#list}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster hosts, run this command:

  ```bash
  {{ yc-mdb-rd }} host list \
    --cluster-name=<cluster_name>
  ```

  Result:

  
  ```text
  +---------------------------------+----------------------+------------+---------+--------+-------------------+
  |              NAME               |      CLUSTER ID      | SHARD NAME |  ROLE   | HEALTH |      ZONE ID      |
  +---------------------------------+----------------------+------------+---------+--------+-------------------+
  | rc1a-...caf.{{ dns-zone }} | c9qb2q230gg1******** | shard1     | MASTER  | ALIVE  | {{ region-id }}-a     |
  | rc1b-...bgc.{{ dns-zone }} | c9qb2q230gg1******** | shard1     | REPLICA | ALIVE  | {{ region-id }}-b     |
  +---------------------------------+----------------------+------------+---------+--------+-------------------+
  ```


  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.ListHosts](../api-ref/Cluster/listHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>/hosts'
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.redis.v1.ListClusterHostsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.ListHosts](../api-ref/grpc/Cluster/listHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.ListHosts
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.redis.v1.ListClusterHostsResponse) to make sure your request was successful.

{% endlist %}

## Creating a host {#add}

The number of hosts in {{ mrd-name }} clusters is limited by the CPU and RAM quotas allocated to database clusters in your cloud. To check the resources currently in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.


{% note info %}

You can configure public access to hosts only for clusters created with TLS enabled.

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

  To create a host:
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
  1. Specify the following host settings:
     * Availability zone.

     
     * Subnet (if the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md)).


     * [Host priority for promotion to master](../concepts/replication.md#master-failover).

     
     * Configure public access to the host, if required.


     * If you are adding a host to a sharded cluster, select a shard.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a host:

  
  1. To choose a subnet for your new host, get the list of all cluster subnets:

     ```bash
     yc vpc subnet list
	   ```

	 Result:

     ```text
     +----------------------+-----------+-----------------------+---------------+------------------+
     |          ID          |   NAME    |       NETWORK ID      |     ZONE      |      RANGE       |
     +----------------------+-----------+-----------------------+---------------+------------------+
     | b0cl69a2b4c6******** | default-d | enp6rq72rndgr******** | {{ region-id }}-d | [172.16.0.0/20]  |
     | e2lkj9qwe762******** | default-b | enp6rq72rndgr******** | {{ region-id }}-b | [10.10.0.0/16]   |
     | e9b0ph42bn96******** | a-2       | enp6rq72rndgr******** | {{ region-id }}-a | [172.16.32.0/20] |
     | e9b9v22r88io******** | default-a | enp6rq72rndgr******** | {{ region-id }}-a | [172.16.16.0/20] |
     +----------------------+-----------+-----------------------+---------------+------------------+
     ```

     If the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md).


  1. See the description of the CLI command for adding hosts:

     ```bash
     {{ yc-mdb-rd }} host add --help
     ```

  1. Run this command to add a host:

     
     ```bash
     {{ yc-mdb-rd }} host add \
       --cluster-name=<cluster_name> \
       --host zone-id=<availability_zone>,`
         `subnet-id=<subnet_ID>,`
         `assign-public-ip=<public_access>,`
         `replica-priority=<host_priority>,`
         `shard-name=<shard_name>
     ```
     

     Where:
     * `--cluster-name`: {{ mrd-name }} cluster name. You can get it with the [list of clusters in a folder](cluster-list.md#list-clusters).
     * `--host`: Host settings:
       * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
       * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify it if the selected availability zone has two or more subnets.
       * `assign-public-ip`: Internet access to the host via a public IP address, `true` or `false`.
       * `replica-priority`: Host priority for promotion to master if the [primary master fails](../concepts/replication.md#master-failover). It is only available for non-sharded clusters.
       * `shard-name`: Name of the shard to which you are adding the new host if the cluster is sharded.

- {{ TF }} {#tf}

  To create a host:
  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating a cluster](cluster-create.md).
  1. Add a `host` section to the {{ mrd-name }} cluster description:

     
     ```hcl
     resource "yandex_mdb_redis_cluster_v2" "<cluster_name>" {
       ...
       host {
         zone             = "<availability_zone>"
         subnet_id        = "<subnet_ID>"
         assign_public_ip = <public_access>
         replica_priority = <host_priority>
         shard_name       = "<shard_name>"
       }
     }
     ```

     Where `assign_public_ip` is public access to the host, `true` or `false`.


  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mrd }}).

  {% include [Terraform timeouts](../../_includes/mdb/mvk/terraform/timeouts.md) %}

- REST API {#api}

    {% include [rest-add-hosts](../../_includes/mdb/mvk/api/rest-add-hosts.md) %}

- gRPC API {#grpc-api}

    {% include [grpc-add-hosts](../../_includes/mdb/mvk/api/grpc-add-hosts.md) %}

{% endlist %}


{% note warning %}

If you cannot [connect](connect/index.md) to the host you added, check that the cluster [security group](../concepts/network.md#security-groups) is properly configured for the subnet containing your host.

{% endnote %}


## Updating a host {#update}


{% include [mrd-public-access](../../_includes/mdb/mvk/note-public-access.md) %}


{% list tabs group=instructions %}

- Management console {#console}

  To change the cluster host settings:
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host row and select **{{ ui-key.yacloud.common.edit }}**.

  
  1. Specify new host settings:

      1. Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** to make the host accessible from outside {{ yandex-cloud }}, if required.
      1. Specify [host priority for promotion to master](../concepts/replication.md#master-failover).


  1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the host settings, run this command:

  
  ```bash
  {{ yc-mdb-rd }} host update <host_name> \
    --cluster-name=<cluster_name> \
    --assign-public-ip=<public_access> \
    --replica-priority=<host_priority>
  ```


  Where `--assign-public-ip` is public access to the host, `true` or `false`.

  You can get the host name with the [list of cluster hosts](#list), and the cluster name, with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  To change the cluster host settings:
  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating a cluster](cluster-create.md).
  1. In the {{ mrd-name }} cluster description, change the attributes of the `host` section referring to the host you want to update.

     
     ```hcl
     resource "yandex_mdb_redis_cluster_v2" "<cluster_name>" {
       ...
       host {
         zone             = "<availability_zone>"
         subnet_id        = "<subnet_ID>"
         assign_public_ip = <public_access>
         replica_priority = <host_priority>
         shard_name       = "<shard_name>"
       }
     }
     ```

     Where `assign_public_ip` is public access to the host, `true` or `false`.


  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mrd }}).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.UpdateHosts](../api-ref/Cluster/updateHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        
        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>/hosts:batchUpdate' \
            --data '{
                      "updateHostSpecs": [
                        {
                          "hostName": "<host_name>",
                          "replicaPriority": "<host_priority>",
                          "assignPublicIp": <public_access_to_cluster_host>,
                          "updateMask": "replicaPriority,assignPublicIp"
                        }
                      ]
                    }'
        ```


        Where `updateHostSpecs` sets the host parameters:

        * `hostName`: Name of the host you need to update. To find out the name, [get the list of hosts in the cluster](#list).
        * `replicaPriority`: Host priority for promotion to master if the [primary master fails](../concepts/replication.md#master-failover).
        * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`. You can only enable public access if your cluster supports TLS.
        * `updateMask`: Comma-separated list of settings you want to update.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/updateHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        
        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_host_specs": [
                    {
                      "host_name": "<host_name>",
                      "replica_priority": "<host_priority>",
                      "assign_public_ip": <public_access_to_cluster_host>,
                      "update_mask": {
                        "paths": ["replica_priority", "assign_public_ip"]
                      }
                    }
                  ] 
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.UpdateHosts
        ```


        Where `update_host_specs` sets the host parameters:

        * `host_name`: Name of the host you need to update. To find out the name, [get the list of hosts in the cluster](#list).
        * `replica_priority`: Host priority for promotion to master if the [primary master fails](../concepts/replication.md#master-failover).
        * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`. You can only enable public access if your cluster supports TLS.
        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/updateHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


{% note warning %}

If you cannot [connect](connect/index.md) to the host you added, check that the cluster [security group](../concepts/network.md#security-groups) is properly configured for the subnet containing your host.

{% endnote %}


## Deleting a host {#remove}

You can delete a host from a {{ VLK }} cluster as long as it is not the only host in the cluster. To replace the only host, first create a new host and then delete the old one.

If you are deleting the master host, {{ mrd-name }} will automatically promote another replica to master.

You cannot delete a host if the number of hosts in the cluster or shard is equal to the minimum allowed. For more information, see [Quotas and limits](../concepts/limits.md#mrd-limits).

{% list tabs group=instructions %}

- Management console {#console}

  To delete a host from a cluster:
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
  1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, enable **Delete host** and click **{{ ui-key.yacloud.mdb.cluster.hosts.popup-confirm_button }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a host from a cluster, run this command:

  ```bash
  {{ yc-mdb-rd }} host delete <host_name> \
    --cluster-name=<cluster_name>
  ```

  You can get the host name with the [list of cluster hosts](#list), and the cluster name, with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  To delete a host from a cluster:
  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating a cluster](cluster-create.md).
  1. Delete the `host` section from the {{ mrd-name }} cluster description.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Type `yes` and press **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mrd }}).

  {% include [Terraform timeouts](../../_includes/mdb/mvk/terraform/timeouts.md) %}

- REST API {#api}

    {% include [rest-remove-hosts](../../_includes/mdb/mvk/api/rest-remove-hosts.md) %}

- gRPC API {#grpc-api}

    {% include [grpc-remove-hosts](../../_includes/mdb/mvk/api/grpc-remove-hosts.md) %}

{% endlist %}
