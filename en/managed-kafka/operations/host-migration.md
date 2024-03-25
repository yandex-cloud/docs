# Migrating {{ KF }} cluster hosts to a different availability zone

{{ mkf-name }} cluster hosts reside in {{ yandex-cloud }} availability zones. You can move hosts from one availability zone to another. Migration process is different for single-host and multi-host clusters.

{% include [zone-d-restrictions](../../_includes/mdb/ru-central1-d-restrictions.md) %}

If a {{ mkf-name }} cluster is an endpoint in {{ data-transfer-full-name }}, restart the transfer to make it work correctly. For more information on which transfers to restart and how to do it, see [Specifics of migration in {{ data-transfer-full-name }}](#data-transfer).

## Migrating a single-host cluster {#one-host}

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the availability zone to which you are migrating the cluster.
1. If the cluster's security group is set up for a subnet in the availability zone from which you are migrating the cluster, [recongifure the group](../../vpc/operations/security-group-add-rule.md) for the new subnet.
1. [Create a {{ mkf-name }} cluster](cluster-create.md) whose configuration is different from the source cluster configuration only by subnet and security group.
1. Migrate data from the initial cluster to the new one using one of the following tools:

   * [MirrorMaker](../tutorials/kafka-connectors.md): You can use either the MirrorMaker connector embedded in {{ mkf-name }} or the MirrorMaker utility.
   * [{{ data-transfer-full-name }}](../../data-transfer/tutorials/mkf-to-mkf.md).

1. To successfully connect to topics after the migration is complete, specify the FQDN of the new cluster's broker in your backend or client (e.g., in the code or graphical IDE). Delete the FQDN of the original cluster's broker in the initial availability zone.

   To find out the FQDN, get a list of hosts in the cluster:

   ```bash
   {{ yc-mdb-kf }} cluster list-hosts <cluster_name_or_ID>
   ```

   The FQDN is specified in the command output under `NAME`.

1. [Delete the initial {{ mkf-name }} cluster](cluster-delete.md).

## Migrating a multi-host cluster {#multiple-hosts}

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the target availability zone to which you are migrating the cluster.
1. If the cluster's security group is set up for a subnet in the source availability zone, recongifure the group for the new subnet. To do so, replace the source subnet CIDR with the new subnet CIDR in the security group rules.
1. Change the availability zone of the cluster.

   {% note warning %}

   In case there are multiple subnets in the target availability zone, change the zone and specify the required subnet using {{ TF }} or the API. Use the management console and the CLI only if there is a single subnet in the target availability zone.

   {% endnote %}

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
      1. In the row with the appropriate cluster, click ![image](../../_assets/console-icons/ellipsis.svg) and then select ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, specify the new availability zones. Their number must not become smaller.
      1. Click **{{ ui-key.yacloud.common.save }}**.

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      To change the availability zones for a cluster, run this command:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
         --zone-ids <availability_zones>
      ```

      In the `--zone-ids` parameter, list availability zones separated by commas. Their number must not become smaller.

   - {{ TF }} {#tf}

      1. Open the current {{ TF }} configuration file with an infrastructure plan.

         For more information about creating this file, see [{#T}](cluster-create.md).

      1. In the {{ mkf-name }} cluster description, change the values of the `subnet_ids` and `zones` parameters:

         ```hcl
         resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
           ...
           subnet_ids = ["<subnets>"]
           config {
             ...
             zones = ["<availability_zone>"]
           }
         }
         ```

         In the `subnet_ids` parameter, specify new subnets. Make sure it contains subnets for the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d` availability zones. You must specify these zones even if the {{ KF }} hosts are placed in a smaller number of availability zones. You need all three availability zones for the {{ ZK }} hosts to be added automatically to the {{ KF }} multi-host cluster.

         The number of availability zones in the `zones` parameter must not become smaller.

      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm updating the resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

      {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

   - API {#api}

      To change the cluster availability zones, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

      * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
      * New list of availability zones in the `configSpec.zoneId` parameter. Their number must not become smaller.
      * New list of subnets in the `subnetIds` parameter.
      * List of settings to update, in the `updateMask` parameter.

      {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

   {% endlist %}

1. To successfully connect to topics after the migration is complete, specify the FQDN of the new cluster's broker in your backend or client (e.g., in the code or graphical IDE). Delete the FQDN of the original cluster's broker in the initial availability zone.

   To find out the FQDN, get a list of hosts in the cluster:

   ```bash
   {{ yc-mdb-kf }} cluster list-hosts <cluster_name_or_ID>
   ```

   The FQDN is specified in the command output under `NAME`.

{% include [migration-in-data-transfer](../../_includes/data-transfer/migration-in-data-transfer.md) %}
