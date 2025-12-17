---
title: Migrating {{ VLK }} cluster hosts to a different availability zone
description: Follow this guide to migrate {{ VLK }} cluster hosts to a different availability zone.
---

# Migrating {{ VLK }} cluster hosts to a different availability zone


{% include [zone-d-restrictions](../../_includes/mdb/ru-central1-d-restrictions.md) %}


{{ mrd-name }} cluster hosts reside in {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md). To move hosts from one zone to another, add hosts residing in the target availability zone to the cluster and delete the hosts in the source availability zone:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the availability zone you want to move your hosts to.
1. If your cluster uses the `b2.medium` or `b3-c1-m4` [host class](../concepts/instance-types.md#available-flavors), [change it](update.md#change-resource-preset). Otherwise, you will not be able to add hosts to the cluster and perform migration.

   The cluster is unavailable for about five to seven minutes after changing the host class.

   You can restore the original class after migration.

1. Add a host to your cluster:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
      1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
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
      {{ yc-mdb-rd }} host add \
         --cluster-name <cluster_name> \
         --host zone-id=<availability_zone>,`
               `subnet-id=<new_subnet_ID>,`
               `assign-public-ip=<allow_public_access_to_host>
      ```

      You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

      In the `zone-id` argument, specify the target availability zone for your hosts.

   - {{ TF }} {#tf}

      1. Add a host manifest to the {{ TF }} configuration file describing your infrastructure:

         ```hcl
         resource "yandex_mdb_redis_cluster" "<cluster_name>" {
           ...
           host {
             zone             = "<availability_zone>"
             subnet_id        = "<new_subnet_ID>"
             assign_public_ip = <allow_public_access_to_host>
           }
         }
         ```

         In the `zone` attribute, specify the target availability zone for your hosts.

      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Confirm updating the resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   - REST API {#api}

       {% include [rest-add-hosts](../../_includes/mdb/mrd/api/rest-add-hosts.md) %}

   - gRPC API {#grpc-api}

       {% include [grpc-add-hosts](../../_includes/mdb/mrd/api/grpc-add-hosts.md) %}

   {% endlist %}

1. To connect to the database after migration, specify the new host’s FQDN in your backend or client, e.g., in your application code or graphical IDE. Delete the original host's FQDN in your source availability zone.

   To get the FQDN, request the list of hosts in the cluster:

   ```bash
   {{ yc-mdb-rd }} host list --cluster-name <cluster_name>
   ```

   You will see the FQDN in the command output under `NAME`.

1. Delete the hosts in the source availability zone:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
      1. Click the cluster name and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
      1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host row, select **{{ ui-key.yacloud.common.delete }}**, and confirm the deletion.

   - CLI {#cli}

      Run the following command for each host:

      ```bash
      {{ yc-mdb-rd }} host delete <host_FQDN> --cluster-name <cluster_name>
      ```

   - {{ TF }} {#tf}

      1. In your {{ TF }} infrastructure configuration file, delete the `host` resource sections with the source availability zone from your cluster description.
      1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Type `yes` and press **Enter**.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   - REST API {#api}

       {% include [rest-remove-hosts](../../_includes/mdb/mrd/api/rest-remove-hosts.md) %}

   - gRPC API {#grpc-api}

       {% include [grpc-remove-hosts](../../_includes/mdb/mrd/api/grpc-remove-hosts.md) %}

   {% endlist %}

1. Wait for the cluster state to change to **Alive**. In the management console, navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**. You can see the cluster state in the **{{ ui-key.yacloud.mdb.clusters.column_availability }}** column.
