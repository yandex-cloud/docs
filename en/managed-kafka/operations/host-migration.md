---
title: Migrating {{ KF }} cluster hosts to a different availability zone
description: Follow this guide to migrate {{ KF }} cluster hosts to a different availability zone.
---

# Migrating {{ KF }} cluster hosts to a different availability zone


{{ mkf-name }} cluster hosts reside in {{ yandex-cloud }} availability zones. You can move {{ KF }} hosts from one availability zone to another. The migration process is different for single-host and multi-host clusters.

{% include [zone-d-restrictions](../../_includes/mdb/ru-central1-d-restrictions.md) %}

If a {{ mkf-name }} cluster is an endpoint in {{ data-transfer-full-name }}, restart the transfer to make it work correctly. To find out which transfers to restart and how to do it, see [Specifics of migration in {{ data-transfer-full-name }}](#data-transfer).

## Migrating a single-host cluster {#one-host}

You can migrate your cluster in the following ways:

* [Use the {{ yandex-cloud }} interfaces](#yandex-cloud-interfaces). In this case, the availability zone in the cluster configuration will change. You do not need to create an additional cluster.

   This option is easier to implement; however, the cluster will remain idle during migration while changing its availability zone. This may take a few minutes.

* [Use auxiliary tools](#auxiliary-instruments) offered by MirrorMaker or {{ data-transfer-full-name }}. In this case, you need to create a new cluster and transfer data from the source cluster into it.

   This option is more challenging to implement since it requires building and configuring the infrastructure. However, it allows you to avoid downtime: you can maintain two clusters with up-to-date data until you delete the source one.

### Migrating a single-host cluster using {{ yandex-cloud }} interfaces {#yandex-cloud-interfaces}

To move an {{ KF }} host to a different availability zone in a {{ mkf-name }} cluster:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the target availability zone.
1. If the cluster security group is set up for a subnet in the availability zone you are moving your cluster from, reconfigure the group for the new subnet. To do so, replace the source subnet CIDR with the new subnet CIDR in the security group rules.
1. Change the availability zone of your cluster and its {{ KF }} host:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
      1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}** service.
      1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, specify the new availability zone.
      1. If the new availability zone has multiple subnets, specify the one you need.
      1. Click **{{ ui-key.yacloud.common.save }}**.

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      To change the availability zone for a cluster and its {{ KF }} host, run this command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
         --zone-ids <availability_zone> \
         --subnet-ids <subnet_ID>
      ```

      If there is only one subnet in the new availability zone, you do not need to specify `--subnet-ids`.

   - {{ TF }} {#tf}

      1. Open the current {{ TF }} configuration file describing your infrastructure.

         Learn how to create this file in [{#T}](cluster-create.md).

      1. In the {{ mkf-name }} cluster description, specify the new subnet in `subnet_ids` and the new availability zone in `zones`:

         ```hcl
         resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
           ...
           subnet_ids = ["<subnet>"]
           config {
             ...
             zones = ["<availability_zone>"]
           }
           ...
         }
         ```

         If there is only one subnet in the new availability zone, you do not need to specify `subnet_ids`.

      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm updating the resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

      {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

   - REST API {#api}

       1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

          {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

       1. Call the [Cluster.update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

          {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

          ```bash
          curl \
              --request PATCH \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>' \
              --data '{
                        "updateMask": "configSpec.zoneId,subnetIds",
                        "subnetIds": [
                          "<subnet>"
                        ]
                        "configSpec": {
                          "zoneId": [
                            "<availability_zone>"
                          ]
                        }
                      }'
          ```

          Where:

          * `updateMask`: Comma-separated string of settings you want to update.

              Specify the relevant parameters:
              * `subnetIds`: To change the list of subnets.
              * `configSpec.zoneId`: To change the availability zone.
          * `subnetIds`: Array of strings. Each string is a subnet ID. If there is only one subnet in the new availability zone, you do not need to specify `subnetIds`.
          * `zoneId`: New availability zone for the cluster.

          You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

       1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

   - gRPC API {#grpc-api}

       1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

           {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

       1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

       1. Call the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

            {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<cluster_ID>",
                      "update_mask": {
                        "paths": [
                          "subnet_ids",
                          "config_spec.zone_id"
                        ]
                      },
                      "subnet_ids": [
                        "<subnet>"
                      ]
                      "config_spec": {
                        "zone_id": [
                          "<availability_zone>"
                        ]
                      }
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.kafka.v1.ClusterService.Update
            ```

            Where:

            * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

               Specify the relevant parameters:
               * `subnet_ids`: To change the list of subnets.
               * `config_spec.zone_id`: To change the availability zone.
            * `subnet_ids`: Array of strings. Each string is a subnet ID. If there is only one subnet in the new availability zone, you do not need to specify `subnet_ids`.
            * `zone_id`: New availability zone for the cluster.

            You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

       1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

   {% endlist %}

1. To successfully connect to topics after migration, specify the new broker’s FQDN in your backend or client, e.g., in your application code or graphical IDE. Delete the FQDN of the original broker in your source availability zone.

   To find out the FQDN, get the list of hosts in the cluster:

   {% include [list-hosts-quick](../../_includes/mdb/mkf/list-hosts-short.md) %}

### Migrating a single-host cluster using auxiliary tools {#auxiliary-instruments}

To move an {{ KF }} host to a different availability zone in a {{ mkf-name }} cluster:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the target availability zone.
1. If the cluster security group is set up for a subnet in the availability zone you are moving your cluster from, reconfigure the group for the new subnet. To do so, replace the source subnet CIDR with the new subnet CIDR in the security group rules.
1. [Create](cluster-create.md) a {{ mkf-name }} cluster with the same configuration as the source cluster, except for a different subnet and security group.
1. Migrate data from your source cluster to the new one using one of the following tools:

   * [MirrorMaker](../tutorials/kafka-connectors.md): You can use either the MirrorMaker connector embedded in {{ mkf-name }} or the MirrorMaker utility.
   * [{{ data-transfer-name }}](../../data-transfer/tutorials/mkf-to-mkf.md).

1. To successfully connect to topics after migration, specify the new cluster’s broker FQDN in your backend or client, e.g., in your application code or graphical IDE. Delete the FQDN of your source cluster's broker in the source availability zone.

   To find out the FQDN, get the list of hosts in the cluster:

   {% include [list-hosts-quick](../../_includes/mdb/mkf/list-hosts-short.md) %}

1. [Delete the source {{ mkf-name }} cluster](cluster-delete.md).

## Migrating a multi-host cluster {#multiple-hosts}

{% note info %}

[Clusters running {{ KF }} 3.6 or higher](../concepts/index.md#kraft) do not use {{ ZK }} hosts. Migration is only possible for configurations with three brokers in the same availability zone.

{% endnote %}

If you create an {{ KF }} 3.5 cluster out of more than one broker host, three dedicated {{ ZK }} hosts will be automatically added to the cluster. Each host is assigned a subnet from different availability zones. After you create a cluster, you cannot change its subnet in the availability zone.

The migration process of an {{ KF }} 3.5 cluster depends on which availability zones {{ KF }} and {{ ZK }} hosts reside in prior to migration and how many subnets each zone contains. See [these examples](#examples) to better understand how migration works.

To move {{ KF }} hosts to a different availability zone in an {{ KF }} 3.5 cluster:

1. Find out in which availability zones {{ KF }} and {{ ZK }} hosts reside:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
      1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}** service.
      1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab. The **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_zone }}** column lists the availability zones for each host.

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      ```bash
      {{ yc-mdb-kf }} cluster list-hosts <cluster_name_or_ID>
      ```

      The availability zone is specified in the command output under `ZONE ID`.

   - REST API {#api}

       1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

           {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

       1. Call the [Cluster.listHosts](../api-ref/Cluster/listHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

           ```bash
           curl \
               --request GET \
               --header "Authorization: Bearer $IAM_TOKEN" \
               --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/hosts'
           ```

           You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

       1. Check the [server response](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse) to make sure your request was successful. You will find the availability zone in the `hosts[].zoneId` field of the response.

   - gRPC API {#grpc-api}

       1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

           {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

       1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

       1. Call the [ClusterService/ListHosts](../api-ref/grpc/Cluster/listHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

           ```bash
           grpcurl \
               -format json \
               -import-path ~/cloudapi/ \
               -import-path ~/cloudapi/third_party/googleapis/ \
               -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
               -rpc-header "Authorization: Bearer $IAM_TOKEN" \
               -d '{
                       "cluster_id": "<cluster_ID>"
                   }' \
               {{ api-host-mdb }}:443 \
               yandex.cloud.mdb.kafka.v1.ClusterService.ListHosts
           ```

           You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

       1. Check the [server response](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse) to make sure your request was successful. You will find the availability zone in the `hosts[].zone_id` field of the response.

   {% endlist %}

1. If the target availability zone for {{ KF }} hosts is not on the list, [create a subnet](../../vpc/operations/subnet-create.md) in this zone.

   If the target availability zone is on the list, {{ KF }} hosts will migrate to the subnet that already contains {{ KF }} or {{ ZK }} hosts in that zone.

1. Check the cluster security group. If it is set up for a subnet in the source availability zone, reconfigure the group for the subnet in the target availability zone. To do so, replace the source subnet CIDR with the target subnet CIDR in the security group rules.
1. Change the availability zone of your cluster and its {{ KF }} hosts:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
      1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}** service.
      1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, set the new availability zones. Their total number must not decrease.

         {% note warning %}

         After adding a new availability zone, deselect one of the old zones. Otherwise, you will not be able to delete an old availability zone after you save the settings.

         {% endnote %}

      1. Specify a subnet in the new availability zone if:

         * {{ KF }} or {{ ZK }} hosts were not previously placed in the target availability zone.
         * The target availability zone has more than one subnet.

      1. Click **{{ ui-key.yacloud.common.save }}**.

   - CLI {#cli}

      To update availability zones for a cluster and its {{ KF }} hosts, run this command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
         --zone-ids <availability_zones> \
         --subnet-ids <subnet_IDs>
      ```

      In `--zone-ids`, list the availability zones separated by commas. Their total number must not decrease.

      {% note warning %}

      After adding a new availability zone, remove one of the old zones from the list. Otherwise, you will not be able to delete an old availability zone after you run the command.

      {% endnote %}

      In `--subnet-ids`, list the subnets for the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d` availability zones, separated by commas. You must specify subnets for these zones even if the {{ KF }} hosts are deployed in fewer zones. You need all three availability zones for {{ ZK }} hosts.

   - {{ TF }} {#tf}

      1. Open the current {{ TF }} configuration file describing your infrastructure.

         Learn how to create this file in [{#T}](cluster-create.md).

      1. In the {{ mkf-name }} cluster description, change the list of availability zones under `zones`:

         ```hcl
         resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
           ...
           config {
             ...
             zones = ["<availability_zones>"]
           }
           ...
         }
         ```

         The number of availability zones must not decrease.

         {% note warning %}

         After adding a new availability zone, remove one of the old zones from the list. Otherwise, you will not be able to delete an old availability zone after you save the settings.

         {% endnote %}

      1. Change the list of subnets under `subnet_ids` if these two conditions are met:

         * You are migrating {{ KF }} hosts to an availability zone where {{ ZK }} hosts were not previously placed.
         * The target availability zone has more than one subnet.

         If the cluster hosts are placed in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones, and you change the availability zones to `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d`, specify a subnet only if the `{{ region-id }}-d` zone has multiple subnets. Otherwise, you do not need to specify it.

         ```hcl
         resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
           ...
           subnet_ids = ["<subnets>"]
           ...
         }
         ```

      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm updating the resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

      {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

   - REST API {#api}

       1. Call the [Cluster.update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

          {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

          ```bash
          curl \
              --request PATCH \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>' \
              --data '{
                        "updateMask": "configSpec.zoneId,subnetIds",
                        "subnetIds": [
                          <subnet_list>
                        ],
                        "configSpec": {
                          "zoneId": [
                            <list_of_availability_zones>
                          ]
                        }
                      }'
          ```

          Where:

          * `updateMask`: Comma-separated string of settings you want to update.

            Specify the relevant parameters:
            * `subnetIds`: To change the list of subnets.
            * `configSpec.zoneId`: To change the list of availability zones.
          * `subnetIds`: Array of strings. Each string is a subnet ID. Change the list of subnets if these two conditions are met:

            * You are migrating {{ KF }} hosts to an availability zone where {{ ZK }} hosts were not previously placed.
            * The target availability zone has more than one subnet.

            If the cluster hosts are placed in the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-c` availability zones, and you change the availability zones to `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d`, specify a subnet only if the `{{ region-id }}-d` zone has multiple subnets. Otherwise, you do not need to specify it.
          * `zoneId`: New availability zones for the cluster. Their total number must not decrease.

          You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

       1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

   - gRPC API {#grpc-api}

       1. Call the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

           {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

           ```bash
           grpcurl \
               -format json \
               -import-path ~/cloudapi/ \
               -import-path ~/cloudapi/third_party/googleapis/ \
               -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
               -rpc-header "Authorization: Bearer $IAM_TOKEN" \
               -d '{
                     "cluster_id": "<cluster_ID>",
                     "update_mask": {
                       "paths": [
                         "subnet_ids",
                         "config_spec.zone_id"
                       ]
                     },
                     "subnet_ids": [
                       <subnet_list>
                     ],
                     "config_spec": {
                       "zone_id": [
                         <list_of_availability_zones>
                       ]
                     }
                   }' \
               {{ api-host-mdb }}:{{ port-https }} \
               yandex.cloud.mdb.kafka.v1.ClusterService.Update
           ```

           Where:

           * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

              Specify the relevant parameters:
              * `subnet_ids`: To change the list of subnets.
              * `config_spec.zone_id`: To change the list of availability zones.
           * `subnet_ids`: Array of strings. Each string is a subnet ID. Change the list of subnets if these two conditions are met:

             * You are migrating {{ KF }} hosts to an availability zone where {{ ZK }} hosts were not previously placed.
             * The target availability zone has more than one subnet.

             If the cluster hosts are placed in the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-c` availability zones, and you change the availability zones to `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d`, specify a subnet only if the `{{ region-id }}-d` zone has multiple subnets. Otherwise, you do not need to specify it.
           * `zone_id`: New availability zones for the cluster. Their total number must not decrease.

           You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

       1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

   {% endlist %}

To move {{ KF }} hosts to a different availability zone in an {{ KF }} cluster version 3.6 or higher:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the target availability zone you are migrating {{ KF }} hosts to.
1. Check the cluster security group. If it is set up for a subnet in the source availability zone, reconfigure the group for the subnet in the target availability zone. To do so, replace the source subnet CIDR with the target subnet CIDR in the security group rules.
1. Change the availability zone of your cluster and its {{ KF }} hosts:

   {% list tabs group=instructions %}

   - CLI {#cli}

      To change the availability zone for a cluster and its {{ KF }} hosts, run this command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
         --zone-ids <availability_zone> \
         --subnet-ids <subnet_ID>
      ```

   - {{ TF }} {#tf}

      1. Open the current {{ TF }} configuration file describing your infrastructure.

         Learn how to create this file in [{#T}](cluster-create.md).

      1. In the {{ mkf-name }} cluster description, change the availability zone in the `zones` parameter:

         ```hcl
         resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
           ...
           config {
             ...
             zones = ["<availability_zone>"]
           }
           ...
         }
         ```

      1. In the `subnet_ids` parameter, specify a subnet in the target availability zone.

         ```hcl
         resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
           ...
           subnet_ids = ["<subnet>"]
           ...
         }
         ```

      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm updating the resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

      {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

   - REST API {#api}

       1. Call the [Cluster.update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

          {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

          ```bash
          curl \
              --request PATCH \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>' \
              --data '{
                        "updateMask": "configSpec.zoneId,subnetIds",
                        "subnetIds": [
                          <subnet_in_target_availability_zone>
                        ],
                        "configSpec": {
                          "zoneId": [
                            <target_availability_zone>
                          ]
                        }
                      }'
          ```

          Where:

          * `updateMask`: Comma-separated string of settings you want to update.

             In this case, specify `subnetIds` and `configSpec.zoneId`.

          * `subnetIds`: Array of strings. Each string is a subnet ID. Specify only the subnet in the target availability zone.
          * `zoneId`: New availability zones for the cluster. Specify only the target availability zone.

          You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

       1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

   - gRPC API {#grpc-api}

       1. Call the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

           {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

           ```bash
           grpcurl \
               -format json \
               -import-path ~/cloudapi/ \
               -import-path ~/cloudapi/third_party/googleapis/ \
               -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
               -rpc-header "Authorization: Bearer $IAM_TOKEN" \
               -d '{
                     "cluster_id": "<cluster_ID>",
                     "update_mask": {
                       "paths": [
                         "subnet_ids",
                         "config_spec.zone_id"
                       ]
                     },
                     "subnet_ids": [
                       <subnet_in_target_availability_zone>
                     ],
                     "config_spec": {
                       "zone_id": [
                         <target_availability_zone>
                       ]
                     }
                   }' \
               {{ api-host-mdb }}:{{ port-https }} \
               yandex.cloud.mdb.kafka.v1.ClusterService.Update
           ```

           Where:

           * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

              In this case, the array consists of the `subnetIds` and `configSpec.zoneId` strings.

           * `subnetIds`: Array of strings. Each string is a subnet ID. Specify only the subnet in the target availability zone.
           * `zoneId`: New availability zones for the cluster. Specify only the target availability zone.

           You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

       1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

   {% endlist %}

To successfully connect to topics after migration, specify the new broker’s FQDN in your backend or client, e.g., in your application code or graphical IDE. Delete the FQDN of the original broker in your source availability zone.

To find out the FQDN, get the list of hosts in the cluster:

{% include [list-hosts-quick](../../_includes/mdb/mkf/list-hosts-short.md) %}

### Examples of migrating a multi-host cluster {#examples}

The examples below provide insight into situations where you need to specify a subnet to migrate a {{ mkf-name }} 3.5 multi-host cluster to a different availability zone.

#### A {{ ZK }} host already resides in the target availability zone {#already-located}

Let’s assume your cluster comprises the following hosts:

* {{ KF }} host 1 in the `{{ region-id }}-a` availability zone
* {{ KF }} host 2 in the `{{ region-id }}-c` availability zone
* {{ ZK }} host 1 in the `{{ region-id }}-a` availability zone
* {{ ZK }} host 2 in the `{{ region-id }}-b` availability zone
* {{ ZK }} host 3 in the `{{ region-id }}-d` availability zone

You need to migrate {{ KF }} hosts to the `{{ region-id }}-a` and `{{ region-id }}-d` availability zones.

{{ ZK }} host 3 already resides in the `{{ region-id }}-d` zone, which means it belongs to one of the subnets in this availability zone. This subnet will be used for migration, since you cannot change subnets after you create the cluster. As a result, you do not need to specify a subnet during migration.

#### The target availability zone contains no hosts and has one subnet {#one-subnet}

Let’s assume your cluster comprises the following hosts:

* {{ KF }} host 1 in the `{{ region-id }}-a` availability zone
* {{ KF }} host 2 in the `{{ region-id }}-b` availability zone
* {{ KF }} host 3 in the `{{ region-id }}-c` availability zone
* {{ ZK }} host 1 in the `{{ region-id }}-a` availability zone
* {{ ZK }} host 2 in the `{{ region-id }}-b` availability zone
* {{ ZK }} host 3 in the `{{ region-id }}-c` availability zone

You need to migrate {{ KF }} hosts to the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d` availability zones.

No hosts initially reside in the `{{ region-id }}-d` zone. But there is only one subnet in it, so you need not specify a subnet when performing the migration.

#### The target availability zone contains no hosts and has multiple subnets {#several-subnets}

Let’s assume your cluster comprises the following hosts:

* {{ KF }} host 1 in the `{{ region-id }}-a` availability zone
* {{ KF }} host 2 in the `{{ region-id }}-b` availability zone
* {{ KF }} host 3 in the `{{ region-id }}-c` availability zone
* {{ ZK }} host 1 in the `{{ region-id }}-a` availability zone
* {{ ZK }} host 2 in the `{{ region-id }}-b` availability zone
* {{ ZK }} host 3 in the `{{ region-id }}-c` availability zone

You need to migrate {{ KF }} hosts to the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d` availability zones.

No hosts initially reside in the `{{ region-id }}-d` zone. However, there are multiple subnets, so you need to specify a subnet to perform the migration.

{% include [migration-in-data-transfer](../../_includes/data-transfer/migration-in-data-transfer.md) %}

For an example of transferring data using {{ data-transfer-name }}, see [this tutorial](../../data-transfer/tutorials/mkf-to-mkf.md).
