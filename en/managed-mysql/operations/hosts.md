---
title: Managing {{ MY }} cluster hosts
description: In this tutorial, you will learn how to manage {{ MY }} cluster hosts and their settings.
---

# Managing {{ MY }} cluster hosts

You can add and remove cluster hosts and manage their settings. For information about moving cluster hosts to a different [availability zone](../../overview/concepts/geo-scope.md), see [this guide](host-migration.md).

## Getting the list of cluster hosts {#list}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster hosts, run the command:

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

  You can request the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.listHosts](../api-ref/Cluster/listHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>/hosts'
      ```

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.mysql.v1.ListClusterHostsResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/ListHosts](../api-ref/grpc/Cluster/listHosts.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.mysql.v1.ListClusterHostsResponse) to make sure the request was successful.

{% endlist %}

## Adding a host {#add}

The number of hosts in {{ mmy-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources currently in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
  1. Specify the host parameters:

     
     * Availability zone.
     * Subnet (if the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md)).
     * Select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if the host must be accessible from outside {{ yandex-cloud }}.


     * Host priority for assignment as a master.
     * Host priority as a {{ MY }} replica for creating backups.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add a host to a cluster:
  1. Request a list of cluster subnets to select one for the new host:

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

     
     If the required subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).


  1. View a description of the CLI command for adding a host:

     ```bash
     {{ yc-mdb-my }} host add --help
     ```

  1. Run the add host command (the example does not show all the available parameters):

     ```bash
     {{ yc-mdb-my }} host add \
       --cluster-name=<cluster_name> \
       --host zone-id=<availability_zone_ID>,`
         `subnet-id=<subnet_ID>,`
         `assign-public-ip=<allow_public_access_to_host>,`
         `replication-source=<source_host_name>,`
         `backup-priority=<host_backup_priority>,`
         `priority=<host_priority_for_assignment_as_master>
     ```

     Where:
     * `--cluster-name`: {{ mmy-name }} cluster name.
     * `--host`: Host parameters:
       * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
       * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). Specify if two or more subnets are created in the selected availability zone.
       * `assign-public-ip`: Internet access to the host, `true` or `false.`.
       * `replication-source`: [Replication](../concepts/replication.md) source for the host.
       * `backup-priority`: Host's [backup](../concepts/backup.md#size) priority, between `0` and `100`.
       * `priority`: Priority for assigning the host as master if the [primary master fails](../concepts/replication.md#master-failover), between `0` and `100`.

     You can request the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

     For more information about creating this file, see [Creating clusters](cluster-create.md).
  1. Add a `host` block to the {{ mmy-name }} cluster description:

     ```hcl
     resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
       ...
       host {
         zone             = "<availability_zone>"
         subnet_id        = <subnet_ID>
         assign_public_ip = <allow_public_access_to_host>
         priority         = <host_priority_for_assignment_as_master>
         ...
       }
     }
     ```

     Where:

     * `assign_public_ip`: Public access to the host, `true` or `false`.
     * `priority`: Priority of assigning the host as master, between `0` and `100`.

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.addHosts](../api-ref/Cluster/addHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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
                        "priority": "<host_priority_for_assignment_as_master>"
                      }
                    ]
                  }'
      ```

      Where `hostSpecs` is an array of new hosts. One array element contains settings for a single host and has the following structure:

      * `zoneId`: Availability zone.
      * `subnetId`: Subnet ID.
      * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.
      * `replicationSource`: Replication source for the host to [manually manage replication threads](../concepts/replication.md#manual-source). In the parameter, specify the [FQDN of the host](connect.md#fqdn) to be used as a replication source.
      * `backupPriority`: Host's [backup](../concepts/backup.md#size) priority, between `0` and `100`.
      * `priority`: Priority for assigning the host as master if the [primary master fails](../concepts/replication.md#master-failover), between `0` and `100`.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/AddHosts](../api-ref/grpc/Cluster/addHosts.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
                    "priority": "<host_priority_for_assignment_as_master>"
                  }
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.AddHosts
      ```

      Where `host_specs` is an array of new hosts. One array element contains settings for a single host and has the following structure:

      * `zone_id`: Availability zone.
      * `subnet_id`: Subnet ID.
      * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
      * `replication_source`: Replication source for the host to [manually manage replication threads](../concepts/replication.md#manual-source). In the parameter, specify the [FQDN of the host](connect.md#fqdn) to be used as a replication source.
      * `backup_priority`: Host's [backup](../concepts/backup.md#size) priority, between `0` and `100`.
      * `priority`: Priority for assigning the host as master if the [primary master fails](../concepts/replication.md#master-failover), between `0` and `100`.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}


{% note warning %}

If you cannot [connect](connect.md) to the host you added, check that the cluster [security group](../concepts/network.md#security-groups) is configured correctly for the host's subnet.

{% endnote %}


## Changing a host {#update}

For each host in a {{ mmy-name }} cluster, you can:
* Setting the [replication source](../concepts/replication.md#manual-source).
* Managing [public access](../concepts/network.md#public-access-to-host).
* Setting backup [priority](../concepts/backup.md#size).
* Set a priority for assigning the host as a master if the [primary master fails](../concepts/replication.md#master-failover).

{% note info %}

You cannot restart a separate cluster host. To restart hosts, [stop and restart the cluster](cluster-stop.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To change the parameters of the cluster host:
  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host's row and select **{{ ui-key.yacloud.common.edit }}**.
  1. Set new settings for the host:
     1. Select a replication source for the host to control replication threads manually.

     
     1. Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if the host must be accessible from outside {{ yandex-cloud }}.


     1. Set the value of the **{{ ui-key.yacloud.mysql.field_priority }}** field.
     1. Set the value of the **{{ ui-key.yacloud.mysql.field_backup_priority }}** field.
  1. Click **{{ ui-key.yacloud.postgresql.hosts.dialog.button_choose }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To modify host parameters, execute the command below (the parameter list in the example is not exhaustive):

  ```bash
  {{ yc-mdb-my }} host update <host_name> \
    --cluster-name=<cluster_name> \
    --replication-source=<source_host_name> \
    --assign-public-ip=<allow_public_access_to_host> \
    --backup-priority=<host_backup_priority> \
    --priority=<host_priority_for_assignment_as_master>
  ```

  Where:
  * `--cluster-name`: {{ mmy-name }} cluster name.
  * `--replication-source`: [Replication](../concepts/replication.md) source for the host.
  * `--assign-public-ip`: Internet access to the host, `true` or `false`.
  * `--backup-priority`: Host's [backup](../concepts/backup.md#size) priority, between `0` and `100`.
  * `--priority`: Priority for assigning the host as master if the [primary master fails](../concepts/replication.md#master-failover), between `0` and `100`.

  You can request the host name with the [list of cluster hosts](#list), and the cluster name, with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  To change the parameters of the cluster host:
  1. Open the current {{ TF }} configuration file that defines your infrastructure.

     For more information about creating this file, see [Creating clusters](cluster-create.md).
  1. In the {{ mmy-name }} cluster description, change the attributes of the `host` block corresponding to the host you are updating.

     ```hcl
     resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
       ...
       host {
         replication_source_name = "<replication_source>"
         assign_public_ip        = <allow_public_access_to_host>
         priority                = <host_priority_for_assignment_as_master>
       }
     }
     ```

     Where:

     * `assign_public_ip`: Public access to the host, `true` or `false`.
     * `priority`: Priority of assigning the host as master, between `0` and `100`.

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.updateHosts](../api-ref/Cluster/updateHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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
                        "priority": "<host_priority_for_assignment_as_master>"
                      }
                    ]
                  }'
      ```

      Where `updateHostSpecs` is an array of hosts being changed. One array element contains settings for a single host and has the following structure:

      * `updateMask`: List of parameters to update as a single string, separated by commas.
      * `hostName`: [FQDN of a host being changed](connect.md#fqdn).
      * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.
      * `replicationSource`: Replication source for the host to [manually manage replication threads](../concepts/replication.md#manual-source). In the parameter, specify the [FQDN of the host](connect.md#fqdn) to be used as a replication source.
      * `backupPriority`: Host's [backup](../concepts/backup.md#size) priority, between `0` and `100`.
      * `priority`: Priority for assigning the host as master if the [primary master fails](../concepts/replication.md#master-failover), between `0` and `100`.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/updateHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
                    "priority": "<host_priority_for_assignment_as_master>"
                  }
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.UpdateHosts
      ```

      Where `update_host_specs` is an array of hosts being changed. One array element contains settings for a single host and has the following structure:

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.
      * `host_name`: [FQDN of the host being changed](connect.md#fqdn).
      * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
      * `replication_source`: Replication source for the host to [manually manage replication threads](../concepts/replication.md#manual-source). In the parameter, specify the [FQDN of the host](connect.md#fqdn) to be used as a replication source.
      * `backup_priority`: Host's [backup](../concepts/backup.md#size) priority, between `0` and `100`.
      * `priority`: Priority for assigning the host as master if the [primary master fails](../concepts/replication.md#master-failover), between `0` and `100`.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}


{% note warning %}

If you cannot [connect](connect.md) to the host after you changed it, check that the cluster [security group](../concepts/network.md#security-groups) is configured correctly for the host's subnet.

{% endnote %}


## Removing a host {#remove}

You can remove a host from a {{ MY }} cluster if it is not the only host in it. To replace a single host, first create a new host and then remove the old one.

If the host is the master at the time of deletion, {{ mmy-name }} will automatically assign the next highest priority replica as the master.

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host's row and select **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a host from the cluster, run:

  ```bash
  {{ yc-mdb-my }} host delete <host_name> \
     --cluster-name=<cluster_name>
  ```

  You can request the host name with the [list of cluster hosts](#list), and the cluster name, with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

     For more information about creating this file, see [Creating clusters](cluster-create.md).
  1. Delete the `host` block from the {{ mmy-name }} cluster description.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Type `yes` and press **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.deleteHosts](../api-ref/Cluster/deleteHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

      Where `hostNames` is the array with the host to delete.

      You can provide only one host FQDN per request. If you need to delete multiple hosts, make a separate request for each of them.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

      Where `host_names` is the array with the host to delete.

      You can provide only one host FQDN per request. If you need to delete multiple hosts, make a separate request for each of them.

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}