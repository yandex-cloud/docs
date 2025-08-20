---
title: Migrating {{ MG }} cluster hosts to a different availability zone
description: Follow this guide to relocate hosts in a {{ MG }} cluster to a different availability zone.
---

# Migrating {{ MG }} cluster hosts to a different availability zone

{{ mmg-name }} cluster hosts reside in [availability zones](../../overview/concepts/geo-scope.md) {{ yandex-cloud }}. To move hosts from one availability zone to another:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the availability zone you want to move your hosts to.
1. Add a host to your cluster:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
      1. Click the name of the {{ mmg-name }} cluster you need and go to the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
      1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
      1. Specify the host parameters:

         * Availability zone to which you want to move the hosts.
         * New subnet.
         * Select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if the host must be accessible from outside {{ yandex-cloud }}.

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
      * In the `zone-id` parameter, specify the availability zone you are moving the hosts to.

   - {{ TF }} {#tf}

      1. Add a host manifest to the {{ TF }} configuration file with the infrastructure plan:

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

         In the `zone` parameter, specify the availability zone you are moving the hosts to.

      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm updating the resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

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

            Where `hostSpecs` is an array of new hosts. One array element contains settings for a single host:

            * `zoneId`: [Availability zone](../../overview/concepts/geo-scope.md).
            * `subnetId`: [Subnet ID](../../vpc/concepts/network.md#subnet).
            * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.
            * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`. For a non-sharded cluster, use `MONGOD`.
            * `shardName`: Shard name in a sharded cluster.
            * `hidden`: The host will either be visible (`false`) or hidden (`true`).
            * `secondaryDelaySecs`: Host's lag behind the master.
            * `priority`: Host priority for assignment as a master if the [primary master fails](../concepts/replication.md#master-failover).
            * `tags`: Host labels.

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
            
            Where `host_specs` is an array of new hosts. One array element contains settings for a single host:

            * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
            * `subnet_id`: [Subnet ID](../../vpc/concepts/network.md#subnet).
            * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
            * `type`: Host type in a sharded cluster, `MONGOD`, `MONGOINFRA`, `MONGOS`, or `MONGOCFG`. For a non-sharded cluster, use `MONGOD`.
            * `shard_name`: Shard name in a sharded cluster.
            * `hidden`: The host will either be visible (`false`) or hidden (`true`).
            * `secondary_delay_secs`: Host's lag behind the master.
            * `priority`: Host priority for assignment as a master if the [primary master fails](../concepts/replication.md#master-failover).
            * `tags`: Host labels.

            You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

      1. View the [server response](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

   {% endlist %}

1. To successfully connect to the database after the migration is complete, specify the new host's FQDN in your backend or client (for example, in the code or graphical IDE). Delete the original host's FQDN in the source availability zone.

   To find out the FQDN, get a list of hosts in the cluster:

   ```bash
   {{ yc-mdb-mg }} host list --cluster-name <cluster_name>
   ```

   The FQDN is specified in the command output under `NAME`.

   To learn how to get host FQDN in the [management console]({{ link-console-main }}), see [this guide](connect/index.md#get-fqdn).

1. Delete the hosts in the source availability zone:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
      1. Click the name of the {{ mmg-name }} cluster you need and select the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** tab.
      1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the required host row, select **{{ ui-key.yacloud.common.delete }}**, and confirm the deletion.

   - CLI {#cli}

      Run the following command for each host:

      ```bash
      {{ yc-mdb-mg }} host delete <host_FQDN> --cluster-name <cluster_name>
      ```

   - {{ TF }} {#tf}

      1. In the {{ TF }} configuration file with the infrastructure plan, remove the `host` sections with the source availability zone from the cluster description.
      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Type `yes` and press **Enter**.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

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

            Where `hostNames` is an array with the names of hosts to delete. To find out the host name, [get a list of hosts in the cluster](hosts.md#list-hosts).

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

            Where `host_names` is an array with the names of hosts to delete. To find out the host name, [get a list of hosts in the cluster](hosts.md#list-hosts).

            You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

      1. View the [server response](../api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure the request was successful.

   {% endlist %}

1. Wait until the cluster status changes to **Alive**. In the management console, go to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**. You can see the cluster status in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

{% include [zone-d-restrictions](../../_includes/mdb/ru-central1-d-restrictions.md) %}

{% include [migration-in-data-transfer](../../_includes/data-transfer/migration-in-data-transfer.md) %}
