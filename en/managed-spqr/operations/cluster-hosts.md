---
title: Managing {{ SPQR }} cluster hosts
description: In this tutorial, you will learn how to manage {{ SPQR }} cluster hosts. You can add and remove cluster hosts, as well as manage their settings via the management console, CLI, and API.
---

# Managing {{ SPQR }} cluster hosts

You can manage the {{ mspqr-name }} cluster hosts, including the following operations:

* [Get a list of hosts](#list).
* [Create a host](#add).
* [Update host settings](#update).
* [Delete a host](#remove).

## Getting a list of cluster hosts {#list}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster hosts, run this command:

  ```bash
  yc managed-sharded-postgresql hosts list \
    --cluster-name <cluster_name>
  ```

  Result:

  
  ```text
  +----------------------------+----------------------+---------+--------+--------------------+-----------+
  |            NAME            |      CLUSTER ID      |  ROLE   | HEALTH |      ZONE ID       | PUBLIC IP |
  +----------------------------+----------------------+---------+--------+--------------------+-----------+
  | rc1b***{{ dns-zone }} | c9qp71dk1dfg******** | PRIMARY | ALIVE  | {{ region-id }}-b      | true      |
  | rc1a***{{ dns-zone }} | c9qp71dk1dfg******** | PRIMARY | ALIVE  | {{ region-id }}-a      | false     |
  +----------------------------+----------------------+---------+--------+--------------------+-----------+
  ```


- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.ListHosts](../api-ref/Cluster/listHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/hosts'
     ```

  1. View the [server response](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.spqr.v1.ListClusterHostsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.ListHosts](../api-ref/grpc/Cluster/listHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.ListHosts
     ```

  1. Check the [server response](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.spqr.v1.ListClusterHostsResponse) to make sure your request was successful.

{% endlist %}

## Creating a host {#add}

The number of `INFRA`, `ROUTER`, and `COORDINATOR` hosts in the {{ mspqr-short-name }} clusters is limited by the CPU and RAM quotas available to database clusters in your cloud. To review your resource usage, open the [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) page and find the **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}** section.

{% list tabs group=instructions %}

- Management console {#console}

  To create a host:
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}** service.
  1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.

  
  1. Specify the following host settings:
     * Availability zone.
     * Subnet (if the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md)).
     * [Host type](../concepts/index.md#router): `INFRA` (for a cluster with standard sharding), `ROUTER`, or `COORDINATOR` (for a cluster with advanced sharding).
     * To make the host accessible from outside {{ yandex-cloud }}, select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.


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
     +----------------------+-----------+----------------------+---------------+-------------------+
     |          ID          |   NAME    |      NETWORK ID      |      ZONE     |      RANGE        |
     +----------------------+-----------+----------------------+---------------+-------------------+
     | b0cl69q1w2e3******** | default-d | enp6rq71w2e3******** | {{ region-id }}-d | [172.16.**.**/20] |
     | e2lkj9q1w2e3******** | default-b | enp6rq71w2e3******** | {{ region-id }}-b | [10.10.**.**/16]  |
     | e9b9v2q1w2e3******** | default-a | enp6rq71w2e3******** | {{ region-id }}-a | [172.16.**.**/20] |
     +----------------------+-----------+----------------------+---------------+-------------------+
     ```

     If the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md).


  1. See the description of the CLI command for adding new hosts:

     ```bash
     yc managed-sharded-postgresql hosts add --help
     ```

  1. Run this command to add a host:

     
     ```bash
     yc managed-sharded-postgresql hosts add \
       --cluster-name <cluster_name> \
       --host zone-id=<availability_zone>,subnet-id=<subnet_ID>,type=<host_type>
     ```


     
     If your availability zone contains more than one subnet, make sure to specify the subnet ID; otherwise, {{ mspqr-short-name }} will automatically select a single subnet.


     Possible [host type](../concepts/index.md#router) values: `infra` (for a cluster with standard sharding), `router`, or `coordinator` (for a cluster with advanced sharding).

     You can also set the additional `assign-public-ip` option in `--host` to manage public access to the host:
       * `true`: Public access enabled.
       * `false`: Public access disabled.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.AddHosts](../api-ref/Cluster/addHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/hosts:batchCreate' \
       --data '{
                 "hostSpecs": [
                   {
                     "zoneId": "<availability_zone>",
                     "subnetId": "<subnet_ID>",
                     "assignPublicIp": <allow_public_access_to_host>,
                     "type": "<host_type>"
                   },
                   { <similar_settings_for_new_host_2> },
                   { ... },
                   { <similar_settings_for_new_host_N> }
                 ]
               }'
     ```

     Where `hostSpecs` is the array of new hosts. Each array element contains the configuration for a single host and has the following structure:

     * `zoneId`: Availability zone.
     * `subnetId`: Subnet ID.
     * `assignPublicIp`: Host accessibility from the internet via a public IP address, `true` or `false`.
     * `type`: [Host type](../concepts/index.md#router), `infra` (for a cluster with standard sharding), `router`, or `coordinator` (for a cluster with advanced sharding).

  1. Check the [server response](../api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.AddHosts](../api-ref/grpc/Cluster/addHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "host_specs": [
               {
                 "zone_id": "<availability_zone>",
                 "subnet_id": "<subnet_ID>",
                 "assign_public_ip": <allow_public_access_to_host>,
                 "type": "<host_type>"
               },
               { <similar_settings_for_new_host_2> },
               { ... },
               { <similar_settings_for_new_host_N> }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.AddHosts
     ```

     Where `host_specs` is an array of new hosts, Each array element contains the configuration for a single host and has the following structure:

     * `zone_id`: Availability zone.
     * `subnet_id`: Subnet ID.
     * `assign_public_ip`: Host accessibility from the internet via a public IP address, `true` or `false`.
     * `type`: [Host type](../concepts/index.md#router), `infra` (for a cluster with standard sharding), `router`, or `coordinator` (for a cluster with advanced sharding).

  1. Check the [server response](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


## Updating a host {#update}

You can change public access settings for any host in a {{ mspqr-short-name }} cluster.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update the cluster host’s settings, run the following command:

  ```bash
  yc managed-sharded-postgresql hosts update <host_name> \
    --cluster-name <cluster_name> \
    --assign-public-ip=<public_access_to_host>
  ```

  Where:

  * `cluster-name`: Cluster name.
  * `assign-public-ip`: Public access to the host, `true` or `false`.

  You can get the host name with the [list of hosts in the cluster](#list).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.UpdateHosts](../api-ref/Cluster/updateHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/hosts:batchUpdate' \
       --data '{
                 "updateHostSpecs": [
                   {
                     "updateMask": "assignPublicIp",
                     "hostName": "<host_name>",
                     "assignPublicIp": <allow_public_access_to_host>
                   },
                   { <similar_settings_for_host_2_being_changed> },
                   { ... },
                   { <similar_settings_for_host_N_being_changed> }
                 ]
               }'
     ```

     Where `updateHostSpecs` is the array of hosts you are updating. Each array element contains the configuration for a single host and has the following structure:

     * `updateMask`: Comma-separated string of settings to update.
     * `hostName`: Target host name.
     * `assignPublicIp`: Host accessibility from the internet via a public IP address, `true` or `false`.

     You can get the host name with the [list of hosts in the cluster](#list).

  1. Check the [server response](../api-ref/Cluster/updateHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "update_host_specs": [
               {
                 "update_mask": {
                     "paths": [
                       "assign_public_ip"
                     ]
                 },
                 "host_name": "<host_name>",
                 "assign_public_ip": <allow_public_access_to_host>
               },
               { <similar_settings_for_host_2_being_changed> },
               { ... },
               { <similar_settings_for_host_N_being_changed> }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.UpdateHosts
     ```

     Where `update_host_specs` is an array of hosts you want to update. Each array element contains the configuration for a single host and has the following structure:

     * `update_mask`: List of settings to update as an array of strings (`paths[]`).
     * `host_name`: Target host name.
     * `assign_public_ip`: Host accessibility from the internet via a public IP address, `true` or `false`.

     You can get the host name with the [list of hosts in the cluster](#list).

  1. Check the [server response](../api-ref/grpc/Cluster/updateHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


## Deleting a host {#remove}

You can remove an `INFRA`, `ROUTER`, or `COORDINATOR` type host from a {{ SPQR }} cluster if it is not the cluster’s only host of that type. To replace the only host, first create a new host and then delete the old one.

{% list tabs group=instructions %}

- Management console {#console}

  To delete a host from a cluster:
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}** service.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the host you want to delete, select **{{ ui-key.yacloud.common.delete }}**, and confirm deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a host from a cluster, run this command:

  ```bash
  yc managed-sharded-postgresql hosts delete <host_name> \
    --cluster-name <cluster_name>
  ```

  You can get the host name with the [list of hosts in the cluster](#list).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.DeleteHosts](../api-ref/Cluster/deleteHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-spqr/v1/clusters/<cluster_ID>/hosts:batchDelete' \
       --data '{
                 "hostNames": [
                   "<host_name>"
                 ]
               }'
     ```

     Where `hostNames` is an array of strings consisting of a single element with the host name. You can get the host name with the [list of hosts in the cluster](#list).

  1. Check the [server response](../api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/spqr/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "host_names": [
               "<host_name>"
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.spqr.v1.ClusterService.DeleteHosts
     ```

     Where `host_names` is an array of strings consisting of a single element with the host name. You can get the host name with the [list of hosts in the cluster](#list).

  1. Check the [server response](../api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
