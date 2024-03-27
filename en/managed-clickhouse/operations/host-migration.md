# Migrating {{ CH }} cluster hosts to a different availability zone

{{ CH }} and {{ ZK }} hosts of the {{ mch-name }} cluster are located in the {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md). You can move hosts from one availability zone to another.

{% include [zone-d-restrictions](../../_includes/mdb/ru-central1-d-restrictions.md) %}

## Migrating {{ CH }} hosts {#clickhouse-hosts}

1. Make sure the migration will only include [replicated tables](../concepts/replication.md#replicated-tables) powered by the `ReplicatedMergeTree` family engine.

   Non-replicated tables will be lost during migration.

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the availability zone you want to move cluster hosts to.
1. Add a host to your cluster:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
      1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
      1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.button_add-host }}**.
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
      {{ yc-mdb-ch }} host add \
         --cluster-name <cluster_name> \
         --host type=clickhouse,`
               `zone-id=<availability_zone>,`
               `subnet-id=<new_subnet_ID>,`
               `assign-public-ip=<public_access_to_host:_true_or_false>
      ```

      You can retrieve the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters). In the `zone-id` parameter, specify the availability zone you want to move the hosts to.

   - {{ TF }} {#tf}

      1. Add a host manifest to the {{ TF }} configuration file with the infrastructure plan:

         ```hcl
         resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
           ...
           host {
             type             = "CLICKHOUSE"
             zone             = "<availability_zone>"
             subnet_id        = "<new_subnet_ID>"
             assign_public_ip = <public_access_to_host:_true_or_false>
           }
         }
         ```

         In the `zone` parameter, specify the availability zone you are moving the hosts to.

      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm updating the resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   - API {#api}

      To add a host to a cluster, use the [addHosts](../api-ref/Cluster/addHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddHosts](../api-ref/grpc/cluster_service.md#AddHosts) gRPC API call and provide the following in the request:

      * Cluster ID in the `clusterId` parameter. You can get the ID with a [list of clusters in the folder](cluster-list.md#list-clusters).
      * New host settings in the `hostSpecs` parameters.

   {% endlist %}

1. To successfully connect to the database after the migration is complete, specify the new host's FQDN in your backend or client (for example, in the code or graphical IDE). Delete the original host's FQDN in the source availability zone.

   To find out the FQDN, get a list of hosts in the cluster:

   ```bash
   {{ yc-mdb-ch }} host list --cluster-name <cluster_name>
   ```

   The FQDN is specified in the command output under `NAME`. You can also use a [special FQDN](connect.md#fqdn) for a connection.

1. Delete the hosts in the source availability zone:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
      1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
      1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the required host row, select **{{ ui-key.yacloud.common.delete }}**, and confirm the deletion.

   - CLI {#cli}

      Run the following command for each host:

      ```bash
      {{ yc-mdb-ch }} host delete <host_FQDN> --cluster-name <cluster_name>
      ```

   - {{ TF }} {#tf}

      1. In the {{ TF }} configuration file with the infrastructure plan, remove from the cluster description the `host` sections with the source availability zone.
      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Type `yes` and press **Enter**.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   - API {#api}

      To delete a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteHosts](../api-ref/grpc/cluster_service.md#DeleteHosts) gRPC API call and provide the following in the request:

      * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
      * FQDN or an array of names of the hosts you want to delete, in the `hostNames` parameter. You can get FQDN names in the [management console]({{ link-console-main }}), on the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab of the cluster page.

   {% endlist %}

1. Wait until the cluster status changes to **Alive**. In the management console, go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**. You can see the cluster status in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

## Migrating {{ ZK }} hosts {#zookeeper-hosts}

1. Make sure the migration will only include [replicated tables](../concepts/replication.md#replicated-tables) powered by the `ReplicatedMergeTree` family engine.

   Non-replicated tables will be lost during migration.

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the availability zone you want to move cluster hosts to.
1. Add a host to your cluster:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
      1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
      1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.button_add-zookeeper }}**.
      1. Specify the new subnet and the availability zone to move the hosts to.
      1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run this command:

      ```bash
      {{ yc-mdb-ch }} host add \
         --cluster-name <cluster_name> \
         --host type=zookeeper,`
               `zone-id=<availability_zone>,`
               `subnet-id=<new_subnet_ID>,`
               `assign-public-ip=<public_access_to_host:_true_or_false>
      ```

      You can retrieve the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters). In the `zone-id` parameter, specify the availability zone you want to move the hosts to.

   - {{ TF }} {#tf}

      1. Add a host manifest to the {{ TF }} configuration file with the infrastructure plan:

         ```hcl
         resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
           ...
           host {
             type             = "ZOOKEEPER"
             zone             = "<availability_zone>"
             subnet_id        = "<new_subnet_ID>"
             assign_public_ip = <public_access_to_host:_true_or_false>
           }
         }
         ```

         In the `zone` parameter, specify the availability zone you are moving the hosts to.

      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm updating the resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   - API {#api}

      To add a host to a cluster, use the [addZookeeper](../api-ref/Cluster/addZookeeper.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddZookeeper](../api-ref/grpc/cluster_service.md#AddZookeeper) gRPC API call and provide the following in the request:

      * Cluster ID in the `clusterId` parameter. You can get the ID with a [list of clusters in the folder](cluster-list.md#list-clusters).
      * New host settings in the `resources` and `hostSpecs` parameters.

   {% endlist %}

1. Delete the hosts in the source availability zone:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
      1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
      1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the required host row, select **{{ ui-key.yacloud.common.delete }}**, and confirm the deletion.

   - CLI {#cli}

      Run the following command for each host:

      ```bash
      {{ yc-mdb-ch }} host delete <host_FQDN> --cluster-name <cluster_name>
      ```

   - {{ TF }} {#tf}

      1. In the {{ TF }} configuration file with the infrastructure plan, remove the `host` sections with the source availability zone from the cluster description.
      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Type `yes` and press **Enter**.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   - API {#api}

      To delete a host, use the [deleteHosts](../api-ref/Cluster/deleteHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteHosts](../api-ref/grpc/cluster_service.md#DeleteHosts) gRPC API call and provide the following in the request:

      * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
      * FQDN or an array of names of the hosts you want to delete, in the `hostNames` parameter. You can get FQDN names in the [management console]({{ link-console-main }}), on the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab of the cluster page.

   {% endlist %}

1. Wait until the cluster status changes to **Alive**. In the management console, go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**. You can see the cluster status in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.

{% include [migration-in-data-transfer](../../_includes/data-transfer/migration-in-data-transfer.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
