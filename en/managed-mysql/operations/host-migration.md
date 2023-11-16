# Migrating {{ MY }} cluster hosts to a different availability zone

{{ mmy-name }} cluster hosts reside in [availability zones](../../overview/concepts/geo-scope.md) {{ yandex-cloud }}. You can move hosts from one availability zone to another. To do this:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the availability zone you want to move your hosts to.
1. Add a host to your cluster:

   {% list tabs %}

   - Management console

      1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
      1. Click the cluster name and go to the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
      1. Click ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.button_add-host }}**.
      1. Specify the host parameters:

         * Availability zone to which you want to move the hosts.
         * New subnet.
         * Select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if the host must be accessible from outside {{ yandex-cloud }}.

      1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run the following command:

      ```bash
      {{ yc-mdb-my }} host add \
         --cluster-name <cluster_name> \
         --host zone-id=<availability_zone>,`
               `subnet-id=<new_subnet_ID>,`
               `assign-public-ip=<public_access_to_host:_true_or_false>
      ```

      You can retrieve the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters). In the `zone-id` parameter, specify the availability zone you want to move the hosts to.

   - {{ TF }}

      1. Add a host manifest to the {{ TF }} configuration file with the infrastructure plan:

         ```hcl
         resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
           ...
           host {
             zone             = "<availability_zone>"
             subnet_id        = "<new_subnet_ID>"
             assign_public_ip = <public_access_to_host:_true_or_false>
           }
         }
         ```

         In the `zone` parameter, specify the availability zone you want to move the hosts to.

      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm updating the resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   - API

      To add a host to a cluster, use the [addHosts](../api-ref/Cluster/addHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddHosts](../api-ref/grpc/cluster_service.md#AddHosts) gRPC API call and provide the following in the request:

      * Cluster ID in the `clusterId` parameter. You can get the ID with a [list of clusters in the folder](cluster-list.md#list-clusters).
      * New host settings in the `hostSpecs` parameters.

   {% endlist %}

1. To successfully connect to the database after the migration is complete, specify the new host's FQDN in your backend or client (for example, in the code or graphical IDE). Delete the original host's FQDN in the source availability zone.

   To find out the FQDN, get a list of hosts in the cluster:

   ```bash
   {{ yc-mdb-my }} host list --cluster-name <cluster_name>
   ```

   The FQDN is specified in the command output under `NAME`. You can also use a [special FQDN](connect.md#special-fqdns) for a connection.

1. Delete the hosts in the source availability zone:

   {% list tabs %}

   - Management console

      1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
      1. Click the cluster name and open the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
      1. Click ![image](../../_assets/horizontal-ellipsis.svg) in the required host row, select **{{ ui-key.yacloud.common.delete }}**, and confirm the deletion.

   - CLI

      Run the following command for each host:

      ```bash
      {{ yc-mdb-my }} host delete <host_FQDN> --cluster-name <cluster_name>
      ```

   - {{ TF }}

      1. In the {{ TF }} configuration file with the infrastructure plan, remove from the cluster description the `host` sections with the source availability zone.
      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Type `yes` and press **Enter**.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   - API

      To delete a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteHosts](../api-ref/grpc/cluster_service.md#DeleteHosts) gRPC API call and provide the following in the request:

      * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
      * FQDN or an array of names of the hosts you want to delete, in the `hostNames` parameter.

   {% endlist %}

1. Wait until the cluster status changes to **Alive**. In the management console, go to your folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**. You can see the cluster status in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.
