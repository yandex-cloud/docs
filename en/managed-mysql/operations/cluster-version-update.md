# {{ MY }} version upgrade

You can upgrade a {{ mmy-name }} cluster to any supported minor or major version.

In single-host clusters, the only master host is brought out of its running state for upgrades. Unlike multi-host clusters, these clusters are not available for reads and writes during an upgrade.

In multi-host clusters, upgrades follow the procedure below:

1. The replicas are withdrawn from service one by one for an upgrade. The replicas are queued randomly. Following an upgrade, the replicas are put back online.
1. A master host is closed for writes. A [new master host is selected](../concepts/replication.md#master-failover) from among the replicas and opened for writes. As a result, the cluster is updated with minimal downtime.
1. The original master host is shut down, upgraded, and resumes its operation as a replica. It does not take back its role as a master.

To learn more about updates within a single version and host maintenance, see [Maintenance](../concepts/maintenance.md).

{% note alert %}

* Once your DBMS is upgraded, you cannot roll a cluster back to the previous version.
* The success of a {{ MY }} version upgrade depends on multiple factors, including cluster settings and data stored in databases. We recommend that you begin by [upgrading a test cluster](#before-update) that has the same data and settings.
* Upgrade your cluster when it is less loaded.

{% endnote %}

## Before a version upgrade {#before-update}

Make sure the update does not affect your applications:

1. See the {{ MY }} [changelog](https://docs.percona.com/percona-server/8.0/release-notes/release-notes_index.html) to check how updates might affect your applications.
1. Try upgrading the version on a test cluster. You can deploy it from a backup of the main cluster. Use the `PRESTABLE` environment for the test cluster.
1. [Create a backup](cluster-backups.md) of the main cluster directly before the version upgrade.
1. Since a cluster of three or more hosts is fault-tolerant, make sure the primary and test clusters have at least two replica hosts and a single master host. [Add hosts](hosts.md#add) as needed.

## Updating the {{ MY }} version {#start-update}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Select the cluster you need from the list and click ![image](../../_assets/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select a new version number.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

   As soon as you run the upgrade, the cluster status will change to **Updating**. Wait for the operation to complete and then check the cluster version.

   The upgrade time depends on multiple factors, e.g., the amount of data or the number of databases in the cluster. The upgrade usually takes several minutes, and 10 minutes or more for large databases.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update the {{ MY }} version:

   1. Get a list of your {{ MY }} clusters using this command:

      ```bash
      {{ yc-mdb-my }} cluster list
      ```

   1. Get information about the cluster you need and check the {{ MY }} version in the `config.version` parameter:

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

      For more information about creating this file, see [Creating clusters](cluster-create.md).

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

- REST API {#api}

   1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. Use the [Cluster.update](../api-ref/Cluster/update.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --header "Content-Type: application/json" \
         --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<cluster_ID>' \
         --data '{
                   "updateMask": "configSpec.version",
                   "configSpec": {
                     "version": "<{{ MY }}_version>"
                   }
                 }'
      ```

      Where:

      * `updateMask`: List of parameters to update as a single string, separated by commas.

         In this case, only one parameter is provided.

      * `configSpec.version`: New {{ MY }} version.

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

   1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

   1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
   1. Use the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
         -format json \
         -import-path ~/cloudapi/ \
         -import-path ~/cloudapi/third_party/googleapis/ \
         -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
               "cluster_id": "<cluster_ID>",
               "update_mask": {
                 "paths": [
                   "config_spec.version"
                 ]
               },
               "config_spec": {
                 "version": "<{{ MY }}_version>"
               }
             }' \
         {{ api-host-mdb }}:{{ port-https }} \
         yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Where:

      * `update_mask`: List of parameters to update as an array of `paths[]` strings.

         In this case, only one parameter is provided.

      * `config_spec.version`: New {{ MY }} version.

      You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

   1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

The upgrade time depends on multiple factors, e.g., the amount of data or the number of databases in the cluster. The upgrade usually takes several minutes, and 10 minutes or more for large databases.

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

   1. To get information about a cluster named `mysql406`, run the following command:

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
   1. In the `version` field, specify the `8.0` value in the `yandex_mdb_mysql_cluster` resource:

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
