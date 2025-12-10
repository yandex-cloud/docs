---
title: Migrating {{ MY }} cluster hosts to a different availability zone
description: Follow this guide to migrate {{ MY }} cluster hosts to a different availability zone.
---

# Migrating {{ MY }} cluster hosts to a different availability zone


{{ mmy-name }} cluster hosts reside in {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md). To migrate hosts from one availability zone to another, do the following:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in your target availability zone.
1. Add a host to your cluster:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
      1. Click the name of your cluster and open the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
      1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
      1. Specify the following host settings:

         * Target availability zone for your hosts.
         * New subnet.
         * Select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** to make the host accessible from outside {{ yandex-cloud }}, if required.

      1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run this command:

      ```bash
      {{ yc-mdb-my }} host add \
         --cluster-name <cluster_name> \
         --host zone-id=<availability_zone>,`
               `subnet-id=<new_subnet_ID>,`
               `assign-public-ip=<allow_public_access_to_host>
      ```

      You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters). In the `zone-id` parameter, specify the target availability zone for your hosts.

   - {{ TF }} {#tf}

      1. Add a host resource to the {{ TF }} configuration file describing your infrastructure:

         ```hcl
         resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
           ...
           host {
             zone             = "<availability_zone>"
             subnet_id        = "<new_subnet_ID>"
             assign_public_ip = <allow_public_access_to_host>
           }
         }
         ```

         In the `zone` parameter, specify the target availability zone for your hosts.

      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm updating the resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

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
                          "subnetId": "<new_subnet_ID>",
                          "assignPublicIp": <allow_public_access_to_host>
                        }
                      ]
                    }'
         ```

         You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

      1. Check the [server response](../api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

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
                      "subnet_id": "<new_subnet_ID>",
                      "assign_public_ip": <allow_public_access_to_host>
                    }
                  ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mysql.v1.ClusterService.AddHosts
         ```

         You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

      1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

   {% endlist %}

1. To connect to the database after migration, specify the new host’s FQDN in your backend or client, e.g., in your application code or graphical IDE. Delete the original host’s FQDN in your source availability zone.

   To get the FQDN, request the list of hosts in the cluster:

   ```bash
   {{ yc-mdb-my }} host list --cluster-name <cluster_name>
   ```

   You will see the FQDN in the command output under `NAME`. Alternatively, you can connect using a [special FQDN](connect.md#fqdn-master).

1. Delete the hosts in the source availability zone:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
      1. Click the name of your cluster and open the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
      1. Find the host you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in its row, select **{{ ui-key.yacloud.common.delete }}**, and confirm the deletion.

   - CLI {#cli}

      Run the following command for each host:

      ```bash
      {{ yc-mdb-my }} host delete <host_FQDN> --cluster-name <cluster_name>
      ```

   - {{ TF }} {#tf}

      1. In your {{ TF }} infrastructure configuration file, delete the `host` resource sections with the source availability zone from your cluster’s description.
      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Type `yes` and press **Enter**.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   - REST API {#api}

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

         You can provide only one host FQDN per request. If you need to delete multiple hosts, send a separate request for each of them.

      1. Check the [server response](../api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

   - gRPC API {#grpc-api}

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

         You can provide only one host FQDN per request. If you need to delete multiple hosts, send a separate request for each of them.

      1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

   {% endlist %}

1. Wait for the cluster status to change to **Alive**. In the management console, navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**. You can see the cluster status in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

{% include [zone-d-restrictions](../../_includes/mdb/ru-central1-d-restrictions.md) %}

{% include [migration-in-data-transfer](../../_includes/data-transfer/migration-in-data-transfer.md) %}

{% include [migration-in-data-transfer-mysql-note](../../_includes/data-transfer/notes/mysql-migration.md) %}
