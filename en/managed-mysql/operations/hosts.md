---
title: Managing {{ MY }} cluster hosts
description: In this guide, you will learn how to manage {{ MY }} cluster hosts and their settings.
---

# Managing {{ MY }} cluster hosts

You can add and remove cluster hosts, as well as manage their settings. To learn how to move cluster hosts to a different [availability zone](../../overview/concepts/geo-scope.md), see [this guide](host-migration.md).

## Getting a list of cluster hosts {#list}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster hosts, run this command:

  ```bash
  {{ yc-mdb-my }} host list \
     --cluster-name=<cluster_name>
  ```

  Result:

  ```text
  +----------------------------+----------------------+---------+--------+---------------+
  |            NAME            |      CLUSTER ID      |  ROLE   | HEALTH |    ZONE ID    |
  +----------------------------+----------------------+---------+--------+---------------+
  | rc1b...{{ dns-zone }} | c9q5k4ve7ev4******** | MASTER  | ALIVE  | {{ region-id }}-b |
  | rc1a...{{ dns-zone }} | c9q5k4ve7ev4******** | REPLICA | ALIVE  | {{ region-id }}-a |
  +----------------------------+----------------------+---------+--------+---------------+
  ```

  You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.listHosts](../api-ref/Cluster/listHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/hosts'
      ```

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.mysql.v1.ListClusterHostsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService/ListHosts](../api-ref/grpc/Cluster/listHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.ListHosts
      ```

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.mysql.v1.ListClusterHostsResponse) to make sure your request was successful.

{% endlist %}

## Adding a host {#add}

The number of hosts in {{ mmy-name }} clusters is limited by the CPU and RAM quotas allocated to database clusters in your cloud. To check the resources currently in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
  1. Specify the following host settings:

     
     * Availability zone.
     * Subnet (if the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md)).
     * Select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** to make the host accessible from outside {{ yandex-cloud }}, if required.


     * Host priority for promotion to master.
     * Host priority as a {{ MY }} replica for creating backups.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add a host to a cluster:
  1. To choose a subnet for your new host, get the list of all cluster subnets:

     ```bash
     yc vpc subnet list
     ```

     Result:

     ```text
     +----------------------+-----------+-----------------------+---------------+------------------+
     |          ID          |   NAME    |       NETWORK ID      |       ZONE    |      RANGE       |
     +----------------------+-----------+-----------------------+---------------+------------------+
     | b0cl69a2b4c6******** | default-d | enp6rq72rndgr******** | {{ region-id }}-d | [172.**.*.*/20]  |
     | e2lkj9qwe762******** | default-b | enp6rq72rndgr******** | {{ region-id }}-b | [10.**.*.*/16]   |
     | e9b0ph42bn96******** | a-2       | enp6rq72rndgr******** | {{ region-id }}-a | [172.**.**.*/20] |
     | e9b9v22r88io******** | default-a | enp6rq72rndgr******** | {{ region-id }}-a | [172.**.**.*/20] |
     +----------------------+-----------+-----------------------+---------------+------------------+
     ```

     
     If the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md).


  1. See the description of the CLI command for adding a host:

     ```bash
     {{ yc-mdb-my }} host add --help
     ```

  1. Run this command (our example does not use all available parameters):

     ```bash
     {{ yc-mdb-my }} host add \
       --cluster-name=<cluster_name> \
       --host zone-id=<availability_zone_ID>,`
         `subnet-id=<subnet_ID>,`
         `assign-public-ip=<allow_public_access_to_host>,`
         `replication-source=<source_host_name>,`
         `backup-priority=<host_backup_priority>,`
         `priority=<host_priority_for_promotion_to_master>
     ```

     Where:
     * `--cluster-name`: {{ mmy-name }} cluster name.
     * `--host`: Host settings:
       * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
       * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify it if the selected availability zone has two or more subnets.
       * `assign-public-ip`: Internet access to the host, `true` or `false.`.
       * `replication-source`: [Replication](../concepts/replication.md) source for the host.
       * `backup-priority`: Host's [backup](../concepts/backup.md#size) priority, between `0` and `100`.
       * `priority`: Host priority for promotion to master if the [primary master fails](../concepts/replication.md#master-failover), between `0` and `100`.

     You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     For information on how to create such a file, see [Creating a cluster](cluster-create.md).
  1. Add the `host` section to the {{ mmy-name }} cluster description:

     ```hcl
     resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
       ...
       host {
         zone             = "<availability_zone>"
         subnet_id        = <subnet_ID>
         assign_public_ip = <allow_public_access_to_host>
         priority         = <host_priority_for_promotion_to_master>
         ...
       }
     }
     ```

     Where:

     * `assign_public_ip`: Public access to the host, `true` or `false`.
     * `priority`: Host priority for promotion to master, between `0` and `100`.

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider article]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.addHosts](../api-ref/Cluster/addHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/hosts:batchCreate' \
          --data '{
                    "hostSpecs": [
                      {
                        "zoneId": "<availability_zone>",
                        "subnetId": "<subnet_ID>",
                        "assignPublicIp": <allow_public_access_to_host>,
                        "replicationSource": "<host_FQDN>",
                        "backupPriority": "<host_backup_priority>",
                        "priority": "<host_priority_for_promotion_to_master>"
                      }
                    ]
                  }'
      ```

      Where `hostSpecs` is the array of new hosts. Each array element contains the configuration for a single host and has the following structure:

      * `zoneId`: Availability zone.
      * `subnetId`: Subnet ID.
      * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.
      * `replicationSource`: Host’s replication source for [manual replication stream management](../concepts/replication.md#manual-source). Specify the [FQDN of the host](connect.md#fqdn) that will be used as the replication source.
      * `backupPriority`: Host’s [backup](../concepts/backup.md#size) priority, between `0` and `100`.
      * `priority`: Host priority for promotion to master if the [primary master fails](../concepts/replication.md#master-failover), between `0` and `100`.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService/AddHosts](../api-ref/grpc/Cluster/addHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "host_specs": [
                  {
                    "zone_id": "<availability_zone>",
                    "subnet_id": "<subnet_ID>",
                    "assign_public_ip": <allow_public_access_to_host>,
                    "replication_source": "<host_FQDN>",
                    "backup_priority": "<host_backup_priority>",
                    "priority": "<host_priority_for_promotion_to_master>"
                  }
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.AddHosts
      ```

      Where `host_specs` is the array of new hosts. Each array element contains the configuration for a single host and has the following structure:

      * `zone_id`: Availability zone.
      * `subnet_id`: Subnet ID.
      * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
      * `replication_source`: Host’s replication source for [manual replication stream management](../concepts/replication.md#manual-source). Specify the [FQDN of the host](connect.md#fqdn) that will be used as the replication source.
      * `backup_priority`: Host’s [backup](../concepts/backup.md#size) priority, between `0` and `100`.
      * `priority`: Host priority for promotion to master if the [primary master fails](../concepts/replication.md#master-failover), between `0` and `100`.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


{% note warning %}

If you cannot [connect](connect.md) to the host you added, check that the cluster [security group](../concepts/network.md#security-groups) is properly configured for the subnet containing your host.

{% endnote %}


## Updating a host {#update}

For each host in a {{ mmy-name }} cluster, you can:
* Set the [replication source](../concepts/replication.md#manual-source).
* Manage [public access](../concepts/network.md#public-access-to-host).
* Set the backup [priority](../concepts/backup.md#size).
* Set the priority for promotion to master if the [primary master fails](../concepts/replication.md#master-failover).

{% note info %}

You cannot restart a separate cluster host. To restart hosts, [stop and restart the cluster](cluster-stop.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To change the cluster host settings:
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host's row and select **{{ ui-key.yacloud.common.edit }}**.
  1. Specify new host settings:
     1. Select the host’s replication source for manual replication stream management.

     
     1. Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** to make the host accessible from outside {{ yandex-cloud }}, if required.


     1. Set the **{{ ui-key.yacloud.mysql.field_priority }}** field.
     1. Set the **{{ ui-key.yacloud.mysql.field_backup_priority }}** field.
  1. Click **{{ ui-key.yacloud.postgresql.hosts.dialog.button_choose }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update host settings, run the command below (our example does not use all available settings):

  ```bash
  {{ yc-mdb-my }} host update <host_name> \
    --cluster-name=<cluster_name> \
    --replication-source=<source_host_name> \
    --assign-public-ip=<allow_public_access_to_host> \
    --backup-priority=<host_backup_priority> \
    --priority=<host_priority_for_promotion_to_master>
  ```

  Where:
  * `--cluster-name`: {{ mmy-name }} cluster name.
  * `--replication-source`: [Replication](../concepts/replication.md) source for the host.
  * `--assign-public-ip`: Internet access to the host, `true` or `false`.
  * `--backup-priority`: Host’s [backup](../concepts/backup.md#size) priority, between `0` and `100`.
  * `--priority`: Host priority for promotion to master if the [primary master fails](../concepts/replication.md#master-failover), between `0` and `100`.

  You can get the host name with the [list of cluster hosts](#list), and the cluster name, with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  To change the cluster host settings:
  1. Open the current {{ TF }} configuration file describing your infrastructure.

     For information on how to create such a file, see [Creating a cluster](cluster-create.md).
  1. In the {{ mmy-name }} cluster description, change the attributes of the `host` section referring to the host you want to update.

     ```hcl
     resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
       ...
       host {
         replication_source_name = "<replication_source>"
         assign_public_ip        = <allow_public_access_to_host>
         priority                = <host_priority_for_promotion_to_master>
       }
     }
     ```

     Where:

     * `assign_public_ip`: Public access to the host, `true` or `false`.
     * `priority`: Host priority for promotion to master, between `0` and `100`.

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider article]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.updateHosts](../api-ref/Cluster/updateHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/hosts:batchUpdate' \
          --data '{
                    "updateHostSpecs": [
                      {
                        "updateMask": "assignPublicIp,replicationSource,backupPriority,priority",
                        "hostName": "<host_FQDN>",
                        "assignPublicIp": <allow_public_access_to_host>,
                        "replicationSource": "<host_FQDN>",
                        "backupPriority": "<host_backup_priority>",
                        "priority": "<host_priority_for_promotion_to_master>"
                      }
                    ]
                  }'
      ```

      Where `updateHostSpecs` is the array of hosts you are updating. Each array element contains the configuration for a single host and has the following structure:

      * `updateMask`: Comma-separated list of settings you want to update.
      * `hostName`: [FQDN of the host being updated](connect.md#fqdn).
      * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.
      * `replicationSource`: Host’s replication source for [manual replication stream management](../concepts/replication.md#manual-source). Specify the [FQDN of the host](connect.md#fqdn) that will be used as the replication source.
      * `backupPriority`: Host’s [backup](../concepts/backup.md#size) priority, between `0` and `100`.
      * `priority`: Host priority for promotion to master if the [primary master fails](../concepts/replication.md#master-failover), between `0` and `100`.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/updateHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService/UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "update_host_specs": [
                  {
                    "update_mask": {
                      "paths": [
                        "assign_public_ip", "replication_source", "backup_priority", "priority"
                      ]
                    },
                    "host_name": "<host_FQDN>",
                    "assign_public_ip": <allow_public_access_to_host>,
                    "replication_source": "<host_FQDN>",
                    "backup_priority": "<host_backup_priority>",
                    "priority": "<host_priority_for_promotion_to_master>"
                  }
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.UpdateHosts
      ```

      Where `update_host_specs` is the array of hosts you are updating. Each array element contains the configuration for a single host and has the following structure:

      * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).
      * `host_name`: [FQDN of the host being updated](connect.md#fqdn).
      * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
      * `replication_source`: Host’s replication source for [manual replication stream management](../concepts/replication.md#manual-source). Specify the [FQDN of the host](connect.md#fqdn) that will be used as the replication source.
      * `backup_priority`: Host’s [backup](../concepts/backup.md#size) priority, between `0` and `100`.
      * `priority`: Host priority for promotion to master if the [primary master fails](../concepts/replication.md#master-failover), between `0` and `100`.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


{% note warning %}

If you cannot [connect](connect.md) to the host after the update, check that the cluster [security group](../concepts/network.md#security-groups) is properly configured for the subnet containing your host.

{% endnote %}


## Deleting a host {#remove}

You can delete a host from a {{ MY }} cluster as long as it is not the only host in the cluster. To replace the only host, first create a new host and then delete the old one.

If you are deleting the master host, {{ mmy-name }} will automatically promote the highest priority replica to master.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host's row and select **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a host from the cluster, run this command:

  ```bash
  {{ yc-mdb-my }} host delete <host_name> \
     --cluster-name=<cluster_name>
  ```

  You can get the host name with the [list of cluster hosts](#list), and the cluster name, with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     For information on how to create such a file, see [Creating a cluster](cluster-create.md).
  1. Delete the `host` section from the {{ mmy-name }} cluster description.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Type `yes` and press **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider article]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.deleteHosts](../api-ref/Cluster/deleteHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/hosts:batchDelete' \
          --data '{
                    "hostNames": [
                      "<host_FQDN>"
                    ]
                  }'
      ```

      Where `hostNames` is the array containing the host you want to delete.

      You can provide only one host FQDN per request. If you need to delete multiple hosts, send a separate request for each one.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService/DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "host_names": [
                  "<host_FQDN>"
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.DeleteHosts
      ```

      Where `host_names` is the array containing the host you want to delete.

      You can only specify one host FQDN per request. If you need to delete multiple hosts, send a separate request for each one.

      You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}