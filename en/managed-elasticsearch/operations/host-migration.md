# Migrating {{ ES }} cluster hosts to a different availability zone

{{ mes-name }} cluster hosts reside in [availability zones](../../overview/concepts/geo-scope.md) {{ yandex-cloud }}. To move hosts from one availability zone to another:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the availability zone you want to move your hosts to.
1. Add a host to the cluster. You can only add or delete hosts with the [_Data node_](../concepts/index.md) role:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
      1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
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
      {{ yc-mdb-es }} host add \
         --cluster-name <cluster_name> \
         --host type=datanode,`
               `zone-id=<availability_zone>,`
               `subnet-id=<new_subnet_ID>,`
               `assign-public-ip=<host_public_access:_true_or_false>
      ```

      You can retrieve the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters). In the `zone-id` parameter, specify the availability zone you are moving the hosts to.

   - {{ TF }} {#tf}

      1. Add a host manifest to the {{ TF }} configuration file with the infrastructure plan:

         ```hcl
         resource "yandex_mdb_elasticsearch_cluster" "<cluster_name>" {
           ...
           host {
             type             = "DATA_NODE"
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

   - API {#api}

      To add a host to a cluster, use the [addHosts](../api-ref/Cluster/addHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddHosts](../api-ref/grpc/Cluster/addHosts.md) gRPC API call and provide the following in the request:

      * Cluster ID in the `clusterId` parameter. You can get the ID with a [list of clusters in the folder](cluster-list.md#list-clusters).
      * New host settings in the `hostSpecs` parameters.

   {% endlist %}

1. To successfully connect to the database after the migration is complete, specify the new host's FQDN in your backend or client (for example, in the code or graphical IDE). Delete the original host's FQDN in the source availability zone.

   To find out the FQDN, get a list of hosts in the cluster:

   ```bash
   {{ yc-mdb-es }} host list --cluster-name <cluster_name>
   ```

   The FQDN is specified in the command output under `NAME`. You can also use a [special FQDN](cluster-connect.md#automatic-host-selection) for a connection.

1. Delete the hosts in the source availability zone. You can add or delete hosts only with the [_Data node_](../concepts/index.md) role.

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
      1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
      1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host's row, select **{{ ui-key.yacloud.common.delete }}**, and confirm the deletion.

   - CLI {#cli}

      Run the following command for each host:

      ```bash
      {{ yc-mdb-es }} host delete <host_FQDN> --cluster-name <cluster_name>
      ```

   - {{ TF }} {#tf}

      1. In the {{ TF }} configuration file with the infrastructure plan, remove the `host` sections with the source availability zone from the cluster description.
      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm the deletion of resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   - API {#api}

      To delete a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) gRPC API call and provide the following in the request:

      * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
      * FQDN or an array of names of the hosts you want to delete, in the `hostNames` parameter.

   {% endlist %}

1. Wait until the cluster status changes to **Alive**. In the management console, go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**. You can see the cluster status in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

{% include [zone-d-disk-restrictions](../../_includes/mdb/ru-central1-d-local-ssd.md) %}

{% include [migration-in-data-transfer](../../_includes/data-transfer/migration-in-data-transfer.md) %}
