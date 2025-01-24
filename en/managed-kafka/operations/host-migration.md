---
title: Migrating {{ KF }} cluster hosts to a different availability zone
description: Follow this guide to move hosts in a {{ KF }} cluster to a different availability zone.
---

# Migrating {{ KF }} cluster hosts to a different availability zone


{{ mkf-name }} cluster hosts reside in {{ yandex-cloud }} availability zones. You can move {{ KF }} hosts from one availability zone to another. The migration process is different for single-host and multi-host clusters.

{% include [zone-d-restrictions](../../_includes/mdb/ru-central1-d-restrictions.md) %}

If a {{ mkf-name }} cluster is an endpoint in {{ data-transfer-full-name }}, restart the transfer to make it work correctly. For more information on which transfers to restart and how to do it, see [Specifics of migration in {{ data-transfer-full-name }}](#data-transfer).

## Migrating a single-host cluster {#one-host}

There are several ways to perform the migration:

* [Use the {{ yandex-cloud }} interfaces](#interfaces). In this case, the availability zone in the cluster's configuration will be updated. You do not need to create an additional cluster.

   This option is easier to implement; however, the cluster will remain idle during migration while its availability zone is updating. This may take several minutes.

* [Use auxiliary tools](#auxiliary-instruments) offered by MirrorMaker or {{ data-transfer-full-name }}. In this case, a new cluster will be created, and the data from the initial cluster will be transferred into it.

   This is a more difficult option, as you will need to create and configure the infrastructure. However, it allows you to avoid idle time. You can maintain two clusters with up-to-date data until you delete the original one.

### Migrating a single-host cluster using {{ yandex-cloud }} interfaces {#yandex-cloud-interfaces}

To move a {{ mkf-name }} host to a different availability zone in an {{ KF }} cluster:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the availability zone to which you are migrating the cluster.
1. If the cluster security group is set up for a subnet in the availability zone from which you are migrating the cluster, reconfigure the group for the new subnet. To do so, replace the source subnet CIDR with the new subnet CIDR in the security group rules.
1. Change the availability zone of the cluster and its {{ KF }} host:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
      1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg), then select ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, specify a new availability zone.
      1. Specify a subnet in the new availability zone if the zone has more than one subnet.
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

      If there is only one subnet in the new availability zone, you do not need to specify the `--subnet-ids` parameter.

   - {{ TF }} {#tf}

      1. Open the current {{ TF }} configuration file with an infrastructure plan.

         For more information about creating this file, see [{#T}](cluster-create.md).

      1. In the {{ mkf-name }} cluster description, specify the new subnet under `subnet_ids` and the new availability zone under `zones`:

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

         If there is only one subnet in the new availability zone, you do not need to specify the `subnet_ids` parameter.

      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm updating the resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

      {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

   - REST API {#api}

       1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

          {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

       1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

          * `updateMask`: List of parameters to update as a single string, separated by commas.

              Specify the relevant parameters:
              * `subnetIds`: To change the list of subnets.
              * `configSpec.zoneId`: To change an availability zone.
          * `subnetIds`: Array of strings. Each string is a subnet ID. If there is only one subnet in the new availability zone, you do not need to specify the `subnetIds` parameter.
          * `zoneId`: New cluster availability zone.

          You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

       1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

   - gRPC API {#grpc-api}

       1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

           {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

       1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

       1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

            * `update_mask`: List of parameters to update as an array of `paths[]` strings.

               Specify the relevant parameters:
               * `subnet_ids`: To change the list of subnets.
               * `config_spec.zone_id`: To change an availability zone.
            * `subnet_ids`: Array of strings. Each string is a subnet ID. If there is only one subnet in the new availability zone, you do not need to specify the `subnet_ids` parameter.
            * `zone_id`: New cluster availability zone.

            You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

       1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

   {% endlist %}

1. To successfully connect to topics after the migration is complete, specify the FQDN of the new broker in your backend or client (e.g., in the code or graphical IDE). Delete the FQDN of the original broker in the initial availability zone.

   To find out the FQDN, get a list of hosts in the cluster:

   {% include [list-hosts-quick](../../_includes/mdb/mkf/list-hosts-short.md) %}

### Migrating a single-host cluster with the help of auxiliary tools {#auxiliary-instruments}

To move a {{ mkf-name }} host to a different availability zone in an {{ KF }} cluster:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the availability zone to which you are migrating the cluster.
1. If the cluster security group is set up for a subnet in the availability zone from which you are migrating the cluster, reconfigure the group for the new subnet. To do so, replace the source subnet CIDR with the new subnet CIDR in the security group rules.
1. [Create a {{ mkf-name }} cluster](cluster-create.md) with a configuration different from the source cluster's configuration only by subnet and security group.
1. Migrate data from the initial cluster to the new one using one of the following tools:

   * [MirrorMaker](../tutorials/kafka-connectors.md): You can use either the MirrorMaker connector embedded in {{ mkf-name }} or the MirrorMaker utility.
   * [{{ data-transfer-name }}](../../data-transfer/tutorials/mkf-to-mkf.md).

1. To successfully connect to topics after the migration is complete, specify the FQDN of the new cluster's broker in your backend or client (e.g., in the code or graphical IDE). Delete the FQDN of the original cluster's broker in the initial availability zone.

   To find out the FQDN, get a list of hosts in the cluster:

   {% include [list-hosts-quick](../../_includes/mdb/mkf/list-hosts-short.md) %}

1. [Delete the initial {{ mkf-name }} cluster](cluster-delete.md).

## Migrating a multi-host cluster {#multiple-hosts}

{% note info %}

[Clusters running {{ KF }} version 3.6 or higher](../concepts/index.md#kraft) do not use {{ ZK }} hosts. Migration is only possible for configurations with three brokers in the same availability zone.

{% endnote %}

If you create an {{ KF }} cluster version 3.5 or lower out of more than one broker host, three dedicated {{ ZK }} hosts will be automatically added to the cluster. Each host is assigned a subnet from different availability zones. After you create a cluster, you cannot change its subnet in an availability zone.

The migration process of an {{ KF }} cluster version 3.5 or lower depends on which availability zones {{ KF }} and {{ ZK }} hosts initially reside in and the number of subnets in each availability zone. See these [examples](#examples) to better understand how migration works.

To move {{ KF }} hosts to a different availability zone in an {{ KF }} cluster version 3.5 or lower:

1. Find out in which availability zones {{ KF }} and {{ ZK }} hosts reside:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), go to the relevant folder.
      1. In the services list, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
      1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab. The **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_zone }}** column lists the availability zones for each host.

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      ```bash
      {{ yc-mdb-kf }} cluster list-hosts <cluster_name_or_ID>
      ```

      The availability zone is specified in the command output under `ZONE ID`.

   - REST API {#api}

       1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

           {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

       1. Use the [Cluster.listHosts](../api-ref/Cluster/listHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

           ```bash
           curl \
               --request GET \
               --header "Authorization: Bearer $IAM_TOKEN" \
               --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/hosts'
           ```

           You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

       1. View the [server response](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse) to make sure the request was successful. The availability zone is specified in the response under `hosts[].zoneId`.

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
               -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
               -rpc-header "Authorization: Bearer $IAM_TOKEN" \
               -d '{
                       "cluster_id": "<cluster_ID>"
                   }' \
               {{ api-host-mdb }}:443 \
               yandex.cloud.mdb.kafka.v1.ClusterService.ListHosts
           ```

           You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

       1. View the [server response](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse) to make sure the request was successful. The availability zone is specified in the response under `hosts[].zone_id`.

   {% endlist %}

1. If the target availability zone for {{ KF }} hosts is not on the list, [create a subnet](../../vpc/operations/subnet-create.md) in this zone.

   If the target availability zone is on the list, during migration, {{ KF }} hosts will be moved to a subnet where {{ KF }} or {{ ZK }} hosts already reside in this zone.

1. Check the cluster security group. If it is set up for a subnet in the source availability zone, reconfigure the group for the subnet in the target availability zone. To do so, replace the source subnet CIDR with the target subnet CIDR in the security group rules.
1. Change the availability zone of the cluster and its {{ KF }} host:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
      1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg), then select ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, specify a new set of availability zones. Their number must not decrease.

         {% note warning %}

         After adding a new availability zone, deselect one of the old zones. Otherwise, you will not be able to delete an old availability zone after you save the settings.

         {% endnote %}

      1. Specify a subnet in the new availability zone if:

         * {{ KF }} or {{ ZK }} hosts were not previously placed in the target availability zone.
         * The target availability zone has more than one subnet.

      1. Click **{{ ui-key.yacloud.common.save }}**.

   - CLI {#cli}

      To edit availability zones for a cluster and its {{ KF }} hosts, run this command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
         --zone-ids <availability_zones> \
         --subnet-ids <subnet_IDs>
      ```

      In the `--zone-ids` parameter, list the availability zones separated by commas. Their number must not decrease.

      {% note warning %}

      After adding a new availability zone, delete one of the old zones from the list. Otherwise, you will not be able to delete an old availability zone after you run the command.

      {% endnote %}

      In the `--subnet-ids` parameter, list the subnets in the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d` availability zones, separated by commas. You must specify subnets for these zones even if the {{ KF }} hosts are placed in a smaller number of availability zones. You need all three availability zones for {{ ZK }} hosts.

   - {{ TF }} {#tf}

      1. Open the current {{ TF }} configuration file with an infrastructure plan.

         For more information about creating this file, see [{#T}](cluster-create.md).

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

         After adding a new availability zone, delete one of the old zones from the list. Otherwise, you will not be able to delete an old availability zone after you save the settings.

         {% endnote %}

      1. Change the list of subnets under `subnet_ids` if these two conditions are met:

         * You are migrating {{ KF }} hosts to an availability zone where {{ ZK }} hosts were not previously placed.
         * The target availability zone has more than one subnet.

         If the cluster hosts are placed in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones and you change the availability zones to `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d`, specify a subnet only if there are multiple subnets in the `{{ region-id }}-d` zone. Otherwise, you do not need to specify a subnet.

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

      For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

      {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

   - REST API {#api}

       1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

          * `updateMask`: List of parameters to update as a single string, separated by commas.

            Specify the relevant parameters:
            * `subnetIds`: To change the list of subnets.
            * `configSpec.zoneId`: To change the list of availability zones.
          * `subnetIds`: Array of strings. Each string is a subnet ID. Change the list of subnets if these two conditions are met:

            * You are migrating {{ KF }} hosts to an availability zone where {{ ZK }} hosts were not previously placed.
            * The target availability zone has more than one subnet.

            If the cluster hosts are placed in the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-c` availability zones and you change the availability zones to `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d`, specify a subnet only if there are multiple subnets in the `{{ region-id }}-d` zone. Otherwise, you do not need to specify a subnet.
          * `zoneId`: New set of cluster availability zones. Their number must not decrease.

          You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

       1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

   - gRPC API {#grpc-api}

       1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

           * `update_mask`: List of parameters to update as an array of `paths[]` strings.

              Specify the relevant parameters:
              * `subnet_ids`: To change the list of subnets.
              * `config_spec.zone_id`: To change the list of availability zones.
           * `subnet_ids`: Array of strings. Each string is a subnet ID. Change the list of subnets if these two conditions are met:

             * You are migrating {{ KF }} hosts to an availability zone where {{ ZK }} hosts were not previously placed.
             * The target availability zone has more than one subnet.

             If the cluster hosts are placed in the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-c` availability zones and you change the availability zones to `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d`, specify a subnet only if there are multiple subnets in the `{{ region-id }}-d` zone. Otherwise, you do not need to specify a subnet.
           * `zone_id`: New set of cluster availability zones. Their number must not decrease.

           You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

       1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

   {% endlist %}

To move {{ KF }} hosts to a different availability zone in an {{ KF }} cluster version 3.6 or higher:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the target availability zone you are migrating {{ KF }} hosts to.
1. Check the cluster security group. If it is set up for a subnet in the source availability zone, reconfigure the group for the subnet in the target availability zone. To do so, replace the source subnet CIDR with the target subnet CIDR in the security group rules.
1. Change the availability zone of the cluster and its {{ KF }} host:

   {% list tabs group=instructions %}

   - CLI {#cli}

      To change the availability zone for a cluster and its {{ KF }} hosts, run this command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
         --zone-ids <availability_zone> \
         --subnet-ids <subnet_ID>
      ```

   - {{ TF }} {#tf}

      1. Open the current {{ TF }} configuration file with an infrastructure plan.

         For more information about creating this file, see [{#T}](cluster-create.md).

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

      1. In the `subnet_ids` parameter, specify the subnet in the target availability zone.

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

      For more information, see the [{{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster) provider documentation.

      {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

   - REST API {#api}

       1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

          * `updateMask`: List of parameters to update as a single string, separated by commas.

             In this case, specify the `subnetIds` and `configSpec.zoneId` parameters.

          * `subnetIds`: Array of strings. Each string is a subnet ID. Specify only the subnet in the target availability zone.
          * `zoneId`: New set of cluster availability zones. Specify only the target availability zone.

          You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

       1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

   - gRPC API {#grpc-api}

       1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

           * `update_mask`: List of parameters to update as an array of `paths[]` strings.

              In this case, the array consists of the `subnetIds` and `configSpec.zoneId` strings.

           * `subnetIds`: Array of strings. Each string is a subnet ID. Specify only the subnet in the target availability zone.
           * `zoneId`: New set of cluster availability zones. Specify only the target availability zone.

           You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

       1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

   {% endlist %}

To successfully connect to topics after the migration is complete, specify the FQDN of the new broker in your backend or client (e.g., in the code or graphical IDE). Delete the FQDN of the original broker in the initial availability zone.

To find out the FQDN, get a list of hosts in the cluster:

{% include [list-hosts-quick](../../_includes/mdb/mkf/list-hosts-short.md) %}

### Examples of migrating a multi-host cluster {#examples}

The examples below provide insight into situations where you need to specify a subnet to migrate a {{ mkf-name }} multi-host cluster version 3.5 or lower to a different availability zone.

#### A {{ ZK }} host already resides in the target availability zone {#already-located}

Let's assume your cluster comprises the hosts:

* {{ KF }} Host 1 in the `{{ region-id }}-a` availability zone
* {{ KF }} Host 2 in the `{{ region-id }}-c` availability zone
* {{ ZK }} Host 1 in the `{{ region-id }}-a` availability zone
* {{ ZK }} Host 2 in the `{{ region-id }}-b` availability zone
* {{ ZK }} Host 3 in the `{{ region-id }}-d` availability zone

You need to migrate {{ KF }} hosts to the `{{ region-id }}-a` and `{{ region-id }}-d` availability zones.

{{ ZK }} Host 3 already resides in the `{{ region-id }}-d` zone, which means it belongs to one of the subnets in this availability zone. This subnet will be used for migration, since you cannot change a cluster's subnets after you create it. As a result, you need not specify a subnet when performing the migration.

#### There are no hosts and there is one subnet in the target availability zone {#one-subnet}

Let's assume your cluster comprises the hosts:

* {{ KF }} Host 1 in the `{{ region-id }}-a` availability zone
* {{ KF }} Host 2 in the `{{ region-id }}-b` availability zone
* {{ KF }} Host 3 in the `{{ region-id }}-c` availability zone
* {{ ZK }} Host 1 in the `{{ region-id }}-a` availability zone
* {{ ZK }} Host 2 in the `{{ region-id }}-b` availability zone
* {{ ZK }} Host 3 in the `{{ region-id }}-c` availability zone

You need to migrate {{ KF }} hosts to the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d` availability zones.

No hosts initially reside in the `{{ region-id }}-d` zone. But there is only one subnet in it, so you need not specify a subnet when performing the migration.

#### There are no hosts and there are multiple subnets in the target availability zone {#several-subnets}

Let's assume your cluster comprises the hosts:

* {{ KF }} Host 1 in the `{{ region-id }}-a` availability zone
* {{ KF }} Host 2 in the `{{ region-id }}-b` availability zone
* {{ KF }} Host 3 in the `{{ region-id }}-c` availability zone
* {{ ZK }} Host 1 in the `{{ region-id }}-a` availability zone
* {{ ZK }} Host 2 in the `{{ region-id }}-b` availability zone
* {{ ZK }} Host 3 in the `{{ region-id }}-c` availability zone

You need to migrate {{ KF }} hosts to the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d` availability zones.

No hosts initially reside in the `{{ region-id }}-d` zone. However, there are multiple subnets, so you need to specify a subnet to perform the migration.

{% include [migration-in-data-transfer](../../_includes/data-transfer/migration-in-data-transfer.md) %}

For an example of data transfer using {{ data-transfer-name }}, see [this tutorial](../../data-transfer/tutorials/mkf-to-mkf.md).
