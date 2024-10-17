# Upgrading {{ MY }} version

You can upgrade a {{ mmy-name }} cluster to any supported minor or major version.

In single-host clusters, the only master host is brought out of its running state for upgrades. Unlike multi-host clusters, these clusters are not available for reads and writes during an upgrade.

In multi-host clusters, upgrades follow the procedure below:

1. The replicas are withdrawn from service one by one for an upgrade. The replicas are queued randomly. Following an upgrade, the replicas are put back online.
1. A master host is closed for writes. A [new master host is selected](../concepts/replication.md#master-failover) from among the replicas and opened for writes. As a result, the cluster is updated with minimal downtime.
1. The original master host is shut down, upgraded, and resumes its operation as a replica. It does not take back its role as a master.

To learn more about updates within a single version and host maintenance, see [Maintenance](../concepts/maintenance.md).

{% note alert %}

* Once your DBMS is upgraded, you cannot roll a cluster back to the previous version.
* The success of a {{ MY }} version upgrade depends on multiple factors, including cluster settings and data stored in databases. We recommend that you first [upgrade a test cluster](#before-update) that uses the same data and settings.
* Upgrade your cluster when it is less loaded.

{% endnote %}

## Before updating the version {#before-update}

Make sure the update does not affect your applications:

1. See the {{ MY }} [changelog](https://docs.percona.com/percona-server/8.0/release-notes/release-notes_index.html) to check how updates might affect your applications.
1. Try updating the version on a test cluster. You can deploy it from a backup of the main cluster. Use the `PRESTABLE` environment for the test cluster.
1. [Create a backup](cluster-backups.md) of the main cluster before updating the version.
1. Since a cluster of three or more hosts is fault-tolerant, make sure the primary and test clusters have at least two replica hosts and a single master host. [Add hosts](hosts.md#add) as needed.

## Upgrading a cluster {#start-update}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Select the cluster from the list and click ![image](../../_assets/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select a new version number.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

   Once the update is launched, the cluster status will change to **Updating**. Wait for the operation to complete and then check the cluster version.

   The upgrade time depends on multiple factors, e.g., the amount of data or the number of databases in the cluster. The upgrade usually takes several minutes, and 10 minutes or more for large databases.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update the {{ MY }} version:

   1. Get a list of your {{ MY }} clusters using this command:

      ```bash
      {{ yc-mdb-my }} cluster list
      ```

   1. Get information about a cluster and check the {{ MY }} version in the `config.version` parameter:

      ```bash
      {{ yc-mdb-my }} cluster get <cluster_name_or_ID>
      ```

   1. Run the {{ MY }} upgrade:

      ```bash
      {{ yc-mdb-my }} cluster update <cluster_name_or_ID> \
         --mysql-version <new_version_number>
      ```

   The upgrade time depends on multiple factors, e.g., the amount of data or the number of databases in the cluster. The upgrade usually takes several minutes, and 10 minutes or more for large databases.

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. Add the `version` field to the `yandex_mdb_mysql_cluster` resource or change the field value if it already exists:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
         ...
         version = "<{{ MY }}_version>"
         ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API {#api}

   To upgrade a cluster to a specific {{ MY }} version, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * {{ MY }} version number in the `configSpec.version` parameter.
   * List of cluster configuration fields to update in the `UpdateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

   The upgrade time depends on multiple factors, e.g., the amount of data or the number of databases in the cluster. The upgrade usually takes several minutes, and 10 minutes or more for large databases.

{% endlist %}

## Examples {#examples}

Let's assume you need to upgrade your cluster from version 5.7 to 8.0.

{% list tabs group=instructions %}

- CLI {#cli}

   1. To get a list of clusters and find out their IDs and names, run this command:

      ```bash
      {{ yc-mdb-my }} cluster list
      ```

      Result example:

      ```text
      +----------------------+------------+---------------------+--------+---------+
      |          ID          |    NAME    |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+------------+---------------------+--------+---------+
      | c9q8p8j2gaih******** |  mysql406  | 2021-10-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+------------+---------------------+--------+---------+
      ```

   1. To get information about a cluster named `mysql406`, run the this command:

      ```bash
      {{ yc-mdb-my }} cluster get mysql406
      ```

      Result example:

      ```text
        id: c9q8p8j2gaih********
        ...
        config:
          version: "5.7"
          ...
      ```

   1. To upgrade the `mysql406` cluster to version 8.0, run this command:

      ```bash
      {{ yc-mdb-my }} cluster update mysql406 --mysql-version 8.0
      ```

- {{ TF }} {#tf}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.
   1. Set the `version` field value to `8.0` in the `yandex_mdb_mysql_cluster` resource.

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<cluster_name>" {
         ...
         version = "8.0"
         ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}
