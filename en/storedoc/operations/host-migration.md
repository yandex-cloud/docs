---
title: Migrating {{ SD }} cluster hosts to a different availability zone
description: Follow this guide to relocate hosts in an {{ SD }} cluster to a different availability zone.
---

# Migrating {{ SD }} cluster hosts to a different availability zone

{{ mmg-name }} cluster hosts reside in {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md). To migrate hosts from one availability zone to another, do the following:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in your target availability zone.
1. Add a host to your cluster:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Go to the [folder]({{ link-console-main }}) page.
      1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
      1. Click the name of your {{ mmg-name }} cluster and open the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
      1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
      1. Specify the following host settings:

         * Availability zone to move your hosts to.
         * New subnet.
         * Select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** to make the host accessible from outside {{ yandex-cloud }}, if required.

      1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run this command:

      ```bash
      {{ yc-mdb-mg }} host add \
         --cluster-name <cluster_name> \
         --host type=<host_type>,`
               `zone-id=<availability_zone>,`
               `subnet-id=<new_subnet_ID>,`
               `assign-public-ip=<allow_public_access_to_host>
      ```

      Command specifics:

      * You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).
      * Possible `type` values: `mongod`, `mongos`, `mongocfg`, or `mongoinfra`. The host type depends on the [sharding type](../concepts/sharding.md#shard-management).
      * In the `zone-id` parameter, specify the target availability zone for your hosts.

   - {{ TF }} {#tf}

      1. Add a host manifest to the {{ TF }} configuration file describing your infrastructure:

         ```hcl
         resource "yandex_mdb_mongodb_cluster" "<cluster_name>" {
           ...
           host {
             type             = "<host_type>"
             zone_id          = "<availability_zone>"
             subnet_id        = "<new_subnet_ID>"
             assign_public_ip = <allow_public_access_to_host>
             ...
           }
         }
         ```

         Possible `type` values: `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`. The host type depends on the [sharding type](../concepts/sharding.md#shard-management).

         In the `zone` parameter, specify the target availability zone for your hosts.

      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm updating the resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   - REST API {#api}

      1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

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
                            "assignPublicIp": <allow_public_access_to_host>,
                            "type": "<host_type>",
                            "shardName": "<shard_name>",
                            "hidden": <hide_host>,
                            "secondaryDelaySecs": "<lag_in_seconds>",
                            "priority": "<host_priority_for_assignment_as_master>",
                            "tags": "<host_labels>"
                          }
                        ]
                      }'
            ```

            Where `hostSpecs` is the array of new hosts. One array element contains settings for a single host:

            * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
            * `subnetId`: [Subnet ID](../../vpc/concepts/network.md#subnet).
            * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.
            * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`. For a non-sharded cluster, use `MONGOD`.
            * `shardName`: Shard name in a sharded cluster.
            * `hidden`: The host will either be visible (`false`) or hidden (`true`).
            * `secondaryDelaySecs`: Host's lag behind the master.
            * `priority`: Host priority for assignment as a master if the [primary master fails](../concepts/replication.md#master-failover).
            * `tags`: Host labels.

            You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

      1. View the [server response](../api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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
               -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
               -rpc-header "Authorization: Bearer $IAM_TOKEN" \
               -d '{
                     "cluster_id": "<cluster_ID>",
                     "host_specs": [
                       {
                         "zone_id": "<availability_zone>",
                         "subnet_id": "<subnet_ID>",
                         "assign_public_ip": <allow_public_access_to_host>,
                         "type": "<host_type>",
                         "shard_name": "<shard_name>",
                         "hidden": <hide_host>,
                         "secondary_delay_secs": "<lag_in_seconds>",
                         "priority": "<host_priority_for_assignment_as_master>",
                         "tags": "<host_labels>"
                       }
                     ]
                  }' \
               {{ api-host-mdb }}:{{ port-https }} \
               yandex.cloud.mdb.mongodb.v1.ClusterService.AddHosts
            ```
            
            Where `host_specs` is the array of new hosts. One array element contains settings for a single host:

            * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
            * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet).
            * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
            * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`. For a non-sharded cluster, use `MONGOD`.
            * `shard_name`: Shard name in a sharded cluster.
            * `hidden`: The host will either be visible (`false`) or hidden (`true`).
            * `secondary_delay_secs`: Host's lag behind the master.
            * `priority`: Host priority for promotion to master if the [primary master fails](../concepts/replication.md#master-failover).
            * `tags`: Host labels.

            You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

      1. Check the [server response](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

   {% endlist %}

1. To connect to the database after migration, specify the new host’s FQDN in your backend or client, e.g., in your application code or graphical IDE. Delete the original host's FQDN in your source availability zone.

   To get the FQDN, request the list of hosts in the cluster:

   ```bash
   {{ yc-mdb-mg }} host list --cluster-name <cluster_name>
   ```

   You will see the FQDN under `NAME` in the command output.

   To learn how to get host FQDN in the [management console]({{ link-console-main }}), see [this guide](connect/index.md#get-fqdn).

1. Delete the hosts in the source availability zone:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Go to the [folder]({{ link-console-main }}) page.
      1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
      1. Click the name of the {{ mmg-name }} cluster you need and select the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
      1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host's row, select **{{ ui-key.yacloud.common.delete }}**, and confirm the deletion.

   - CLI {#cli}

      Run the following command for each host:

      ```bash
      {{ yc-mdb-mg }} host delete <host_FQDN> --cluster-name <cluster_name>
      ```

   - {{ TF }} {#tf}

      1. In your {{ TF }} infrastructure configuration file, delete the `host` sections with the source availability zone from your cluster description.
      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Type `yes` and press **Enter**.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   - REST API {#api}

      1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

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

            Where `hostNames` is an array with the names of hosts to delete. To find out the host name, [get a list of hosts in the cluster](hosts.md#list-hosts).

            You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

      1. View the [server response](../api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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

            Where `host_names` is an array with the names of hosts to delete. To find out the host name, [get a list of hosts in the cluster](hosts.md#list-hosts).

            You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

      1. View the [server response](../api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

   {% endlist %}

1. Wait for the cluster state to change to **Alive**. In the [management console]({{ link-console-main }}), navigate to the folder with the cluster. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**. You can see the cluster state in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

{% include [zone-d-restrictions](../../_includes/mdb/ru-central1-d-restrictions.md) %}

{% include [migration-in-data-transfer](../../_includes/data-transfer/migration-in-data-transfer.md) %}
