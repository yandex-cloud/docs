---
title: Changing {{ OS }} cluster settings
description: After creating an {{ OS }} cluster, you can edit its service settings.
keywords:
  - OpenSearch settings
  - OpenSearch cluster settings
  - OpenSearch
---

# Updating {{ OS }} cluster settings

After creating a cluster, you can change:

* [Service account](#change-service-account)
* `admin` [password](#change-admin-password)
* [{{ OS }} settings](#change-opensearch-config)
* [Additional cluster settings](#change-additional-settings)
* [Security groups](#change-sg-set)

You can also:

* [Update the {{ OS }} version](cluster-version-update.md).
* [Change the host group configuration](host-groups.md#update-host-group).
* [Move host groups to a different availability zone](host-migration.md).


## Changing a service account {#change-service-account}

{% note warning %}

If the cluster already uses a service account to access objects from {{ objstorage-full-name }}, then changing it to a different service account may make these objects unavailable and interrupt the cluster operation. Before changing the service account settings, make sure that the cluster does not use the objects in question.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Select the cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
   1. In the **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** field, select the account you need from the list or [create a new one](../../iam/operations/sa/create.md). For more information about setting up service accounts, see [Configuring access to {{ objstorage-name }}](s3-access.md).
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change a service account linked to a {{ mos-name }} cluster, run the command:

   ```bash
   {{ yc-mdb-os }} cluster update <cluster_name_or_ID> \
      --service-account-name <service_account_name>
   ```

   You can request the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

   For more information about setting up service accounts, see [Configuring access to {{ objstorage-name }}](s3-access.md).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For a complete list of available {{ mos-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mos }}).

   1. In the `service_account_id` field, specify the service account ID:

      ```hcl
      resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
          ...
          service_account_id = "<service_account_ID>"
      }
      ```

      For more information about setting up service accounts, see [Configuring access to {{ objstorage-name }}](s3-access.md).

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   To change service account settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * ID of the service account used for cluster operations in the `serviceAccountId` parameter.

   For more information about setting up service accounts, see [Configuring access to {{ objstorage-name }}](s3-access.md).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}


## Changing the admin password {#change-admin-password}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Select the cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
   1. In the **{{ ui-key.yacloud.mdb.forms.database_field_admin-password }}** field, enter a new password.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the `admin` password for a cluster, enter a new password using one of these methods:

   * Entering a password as plain text (less secure method).

      ```bash
      {{ yc-mdb-os }} cluster update <cluster_name_or_ID> \
         --admin-password <new_password>
      ```

   * Generating a password automatically. The generated password will be output to the console.

      ```bash
      {{ yc-mdb-os }} cluster update <cluster_name_or_ID> \
         --generate-admin-password
      ```

   You can request the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For a complete list of available {{ mos-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mos }}).

   1. In the `config` section, change the `admin_password` field value:

      ```hcl
      resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
          ...
          config {
              admin_password = "<new_admin_password>"
          }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   To update the `admin` user's password, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * New `admin` user password in the `configSpec.adminPassword` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing {{ OS }} settings {#change-opensearch-config}

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Run the following command with a list of settings to change:

   ```bash
   {{ yc-mdb-os }} cluster update <cluster_name_or_ID> \
      --max-clause-count <number_of_boolean_expressions> \
      --fielddata-cache-size <JVM_heap_size> \
      --reindex-remote-whitelist <host_address>:<port>
   ```

   You can request the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

   Command settings:

   * `--max-clause-count`: Maximum allowed number of boolean expressions per query. See more in the [{{ OS }} documentation]({{ os.docs }}/query-dsl/compound/bool/).
   * `--fielddata-cache-size`: JVM heap size allocated for the fielddata data structure. You can specify either an absolute value or percentage, e.g., `512mb` or `50%`. For more details, see the [{{ OS }} documentation]({{ os.docs }}/install-and-configure/configuring-opensearch/index-settings/#cluster-level-index-settings).
   * `--reindex-remote-whitelist`: List of remote hosts whose indexes contain documents to copy for reindexing. Specify the parameter value as `<host_address>:<port>`. If you need to specify more than one host, list values separated by commas. For more details, see the [{{ OS }} documentation]({{ os.docs }}/im-plugin/reindex-data/#reindex-from-a-remote-cluster).

- API {#api}

   To change {{ OS }} settings, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * New maximum allowed number of boolean expressions in the `configSpec.opensearchSpec.opensearchConfig_2.maxClauseCount` parameter. See more in the [{{ OS }} documentation]({{ os.docs }}/query-dsl/compound/bool/).
   * New JVM heap size allocated for the fielddata data structure in the `configSpec.opensearchSpec.opensearchConfig_2.fielddataCacheSize` parameter. You can specify either an absolute value or percentage, e.g., `512mb` or `50%`. For more details, see the [{{ OS }} documentation]({{ os.docs }}/install-and-configure/configuring-opensearch/index-settings/#cluster-level-index-settings).
   * New list of remote hosts whose indexes contain documents to copy for reindexing in the `configSpec.opensearchSpec.opensearchConfig_2.reindexRemoteWhitelist` parameter. For more details, see the [{{ OS }} documentation]({{ os.docs }}/im-plugin/reindex-data/#reindex-from-a-remote-cluster).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Select the cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
   1. Change additional cluster settings:

      * **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance window](../concepts/maintenance.md) settings:

         {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}


      * {% include [Deletion protection](../../_includes/mdb/console/deletion-protection.md) %}

         {% include [Deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Run the following command with a list of settings to change:

   ```bash
   {{ yc-mdb-os }} cluster update <cluster_name_or_ID> \
      --maintenance schedule=<maintenance_type>,`
                   `weekday=<day_of_week>,`
                   `hour=<hour_of_day> \
      --delete-protection=<true_or_false> \
      --data-transfer-access=<true_or_false> \
      --serverless-access=<true_or_false>
   ```

   You can request the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

   Command settings:

   * `--maintenance`: [Maintenance](../concepts/maintenance.md) time settings (including for disabled clusters):

      * To allow maintenance at any time, specify `--maintenance schedule=anytime`.
      * To specify the preferred maintenance start time, specify `--maintenance schedule=weekly,weekday=<day_of_week>,hour=<hour_in_UTC>`. In this case, maintenance will take place every week on a specified day at a specified time.

         Possible values of the `weekday` parameter: `mon`, `tue`, `wed`, `thu`, `fry`, `sat`, and `sun`. In the `hour` parameter, specify the maintenance completion time. For example, if you set `14`, maintenance will take place from 13:00 until 14:00 UTC.

   * `--delete-protection`: Cluster protection against accidental deletion by a user, `true` or `false`.

      {% include [Deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}


   * `--serverless-access`: Access from [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml), `true` or `false`.

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For a complete list of available {{ mos-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mos }}).

   1. To change the [maintenance](../concepts/maintenance.md) time (including for disabled clusters), specify the following settings in the `maintenance_window` parameter:

      ```hcl
      resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
          ...
          maintenance_window {
              type = "<maintenance_frequency>"
              hour = <hour>
              day = "<day_of_week>"
          }
      }
      ```

      Specify the following in the parameters:

      * `type`: `ANYTIME` to allow maintenance at any time or `WEEKLY` to perform maintenance every week.
      * `hour`: Maintenance completion hour, UTC. For example, if you set `14`, maintenance will take place from 13:00 until 14:00 UTC.
      * `day`: Day of week for maintenance. Possible values: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, and `SUN`.

   1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

      ```hcl
      resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
          ...
          deletion_protection = <true_or_false>
      }
      ```

      Where `deletion_protection` is cluster deletion protection.

      {% include [Deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   To update the `admin` user's password, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * [Maintenance](../concepts/maintenance.md) window settings (including for disabled clusters) in the `maintenanceWindow` parameter.
   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [Deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   * Settings for access from [{{ data-transfer-full-name }}](../../data-transfer/index.yaml) in the `configSpec.access.dataTransfer` parameter.
   * Settings for access from [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml) in the `configSpec.access.serverless` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}


## Changing security groups {#change-sg-set}

After you assign other [security groups](../concepts/network.md#security-groups), you may need to [additionally set them up](connect.md#security-groups) to connect to the cluster.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Select the cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select security groups for cluster network traffic.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit the list of security groups for a cluster, specify the security groups you need in the command:

   ```bash
   {{ yc-mdb-os }} cluster update <cluster_name_or_ID> \
      --security-group-ids <list_of_security_group_IDs>
   ```

   If you need to specify more than one group, list them separated by commas.

   You can request the cluster name and ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For a complete list of available {{ mos-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mos }}).

   1. In the `security_group_ids` field, list the security group IDs separated by commas:

      ```hcl
      resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
          ...
          security_group_ids = [ "<security_groups>" ]
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   To edit the list of cluster security groups, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * List of security group IDs in the `securityGroupIds` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

