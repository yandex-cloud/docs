# Migrating {{ MY }} cluster hosts to a different availability zone


{{ mmy-name }} cluster hosts reside in [availability zones](../../overview/concepts/geo-scope.md) {{ yandex-cloud }}. To move hosts from one availability zone to another:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the availability zone you want to move your hosts to.
1. Add a host to your cluster:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
      1. Click the cluster name and go to the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
      1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
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
      {{ yc-mdb-my }} host add \
         --cluster-name <cluster_name> \
         --host zone-id=<availability_zone>,`
               `subnet-id=<new_subnet_ID>,`
               `assign-public-ip=<host_public_access:_true_or_false>
      ```

      You can retrieve the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters). In the `zone-id` parameter, specify the availability zone you are moving the hosts to.

   - {{ TF }} {#tf}

      1. Add a host manifest to the {{ TF }} configuration file with the infrastructure plan:

         ```hcl
         resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
           ...
           host {
             zone             = "<availability_zone>"
             subnet_id        = "<new_subnet_ID>"
             assign_public_ip = <host_public_access:_true_or_false>
           }
         }
         ```

         In the `zone` parameter, specify the availability zone you are moving the hosts to.

      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm updating the resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   - REST API {#api}

      1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

         {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

      1. Use the [Cluster.addHosts](../api-ref/Cluster/addHosts.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

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
                          "assignPublicIp": <host_public_access:_true_or_false>
                        }
                      ]
                    }'
         ```

         You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

      1. View the [server response](../api-ref/Cluster/addHosts.md#responses) to make sure the request was successful.

   - gRPC API {#grpc-api}

      1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

         {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

      1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
      1. Use the [ClusterService/AddHosts](../api-ref/grpc/Cluster/addHosts.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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
                      "assign_public_ip": <host_public_access:_true_or_false>
                    }
                  ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mysql.v1.ClusterService.AddHosts
         ```

         You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

      1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

   {% endlist %}

1. To successfully connect to the database after the migration is complete, specify the new host's FQDN in your backend or client (for example, in the code or graphical IDE). Delete the original host's FQDN in the source availability zone.

   To find out the FQDN, get a list of hosts in the cluster:

   ```bash
   {{ yc-mdb-my }} host list --cluster-name <cluster_name>
   ```

   The FQDN is specified in the command output under `NAME`. You can also use a [special FQDN](connect.md#special-fqdns) for a connection.

1. Delete the hosts in the source availability zone:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
      1. Click the cluster name and open the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
      1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host's row, select **{{ ui-key.yacloud.common.delete }}**, and confirm the deletion.

   - CLI {#cli}

      Run the following command for each host:

      ```bash
      {{ yc-mdb-my }} host delete <host_FQDN> --cluster-name <cluster_name>
      ```

   - {{ TF }} {#tf}

      1. In the {{ TF }} configuration file with the infrastructure plan, remove the `host` sections with the source availability zone from the cluster description.
      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Type `yes` and press **Enter**.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   - REST API {#api}

      1. Use the [Cluster.deleteHosts](../api-ref/Cluster/deleteHosts.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

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

         Where `hostNames` is an array with the host to delete.

         Only one host FQDN can be provided in a single request. If you need to delete multiple hosts, run the request for each of them.

      1. View the [server response](../api-ref/Cluster/deleteHosts.md#responses) to make sure the request was successful.

   - gRPC API {#grpc-api}

      1. Use the [ClusterService/DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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

         Where `host_names` is an array with the host to delete.

         Only one host FQDN can be provided in a single request. If you need to delete multiple hosts, run the request for each of them.

      1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

   {% endlist %}

1. Wait until the cluster status changes to **Alive**. In the management console, go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**. You can see the cluster status in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

{% include [zone-d-restrictions](../../_includes/mdb/ru-central1-d-restrictions.md) %}

{% include [migration-in-data-transfer](../../_includes/data-transfer/migration-in-data-transfer.md) %}

{% include [migration-in-data-transfer-mysql-note](../../_includes/data-transfer/notes/mysql-migration.md) %}
