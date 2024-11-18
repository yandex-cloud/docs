# {{ PG }} version upgrade

You can upgrade a {{ mpg-name }} cluster to any supported version.

{% note info %}

You cannot upgrade a regular cluster version to versions optimized for _1C:Enterprise_ (e.g., from version 14 to version 14-1c).

{% endnote %}

You can only upgrade to a version that immediately follows the current one, e.g., from version 11 to 12. Upgrades to higher versions are performed in steps. For example, for {{ PG }}, the upgrade sequence from version 11 to 15 is: 11 → 12 → 13 → 14 → 15.

You can upgrade to version 16 only using {{ data-transfer-full-name }}. To do so, [create a version 16 cluster](cluster-create.md#create-cluster) and [transfer data to it](../tutorials/data-migration.md#data-transfer) from the cluster you want to upgrade.

In single-host clusters, the only master host is brought out of its running state for upgrades. During an upgrade, these clusters will be unavailable for reading and writing.

In multi-host clusters, upgrades follow the procedure below:

1. The master is unavailable during upgrades. During this time, the replicas continue running in read-only mode. No [failover](../concepts/replication.md#replication-auto) occurs. After an upgrade, the master is not returned to a running state until all the replicated hosts are upgraded. It is temporarily unavailable even for reading.
1. The replicas are sequentially made unavailable and upgraded. The replicas are queued randomly. Following an upgrade, the replicas are returned to a running state in read-only mode.

    A two-host cluster is unavailable while its replica is upgrading. In a cluster of three or more hosts, at least one replica will be available for reading.

1. The master returns to a running state.

To learn more about updates within a single version and host maintenance, see [Maintenance](../concepts/maintenance.md).

## Before a version upgrade {#before-update}

Make sure this does not affect your applications:

1. See the {{ PG }} [changelog](https://www.postgresql.org/docs/release/) to see how upgrades may affect your applications or installed [extensions](./extensions/cluster-extensions.md).
1. Try upgrading the version on a test cluster. You can deploy it from a backup of the main cluster.
1. [Create a backup](cluster-backups.md) of the main cluster directly before the version upgrade.

## Upgrading a cluster {#start-update}

{% note alert %}

* Once your DBMS is upgraded, you cannot roll a cluster back to the previous version.
* The success of a {{ PG }} version upgrade depends on multiple factors, including cluster settings and data stored in databases. We recommend that you begin by [upgrading a test cluster](#before-update) that has the same data and settings.

{% endnote %}

### Upgrading a cluster to {{ PG }} 16 {#update-to-v16}

  1. [Create a cluster](cluster-create.md#create-cluster) with {{ PG }} 16.
  1. Use {{ data-transfer-name }} to [transfer data to it](../tutorials/data-migration.md#data-transfer) from the cluster you want to upgrade.

### Upgrading a cluster to {{ PG }} 15 or lower {#update-to-v15-or-lower}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Select the cluster you need from the list and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select a new version number.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To upgrade a cluster to {{ PG }} 15 or lower:

  1. Get a list of your {{ PG }} clusters using this command:

     ```bash
     {{ yc-mdb-pg }} cluster list
     ```

  1. Get information about the cluster you need and check the {{ PG }} version in the `config.version` parameter:

     ```bash
     {{ yc-mdb-pg }} cluster get <cluster_name_or_ID>
     ```

  1. Run the {{ PG }} upgrade:

     ```bash
     {{ yc-mdb-pg }} cluster update <cluster_name_or_ID> \
        --postgresql-version <new_version_number>
     ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

       For more information about creating this file, see [Creating clusters](cluster-create.md).

      For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

    1. In the `cluster_config` section of the required {{ mpg-name }} cluster, add the `version` field or edit the existing one:

       ```hcl
       resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
         ...
         cluster_config {
           version = "<{{ PG }}_version>"
         }
       }
       ```

    1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

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
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>' \
       --data '{
                 "updateMask": "configSpec.version",
                 "configSpec": {
                   "version": "<{{ PG }}_version>"
                 }
               }'
     ```

     Where:

     * `updateMask`: List of parameters to update as a single string, separated by commas.

       In this case, only one parameter is provided.

     * `configSpec.version`: New {{ PG }} version.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/update.md#responses) to make sure the request was successful.

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "update_mask": {
               "paths": [
                 "config_spec.version"
               ]
             },
             "config_spec": {
               "version": "<{{ PG }}_version>"
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Where:

     * `update_mask`: List of parameters to update as an array of `paths[]` strings.

       In this case, only one parameter is provided.

     * `config_spec.version`: New {{ PG }} version.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster) to make sure the request was successful.

{% endlist %}

As soon as you run the upgrade, the cluster enters the **UPDATING** status. Wait for the operation to complete and then check the cluster version.

Cluster upgrade time depends on the database size.

## Examples {#examples}

Let's assume that you need to upgrade your cluster from version 11 to version 12.

{% list tabs group=instructions %}

- CLI {#cli}

   1. To get a list of clusters and find out their IDs and names, run this command:

      ```bash
      {{ yc-mdb-pg }} cluster list
      ```

      ```text
      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih******** |   postgre406  | 2021-10-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. To get information about a cluster named `postgre406`, run the following command:

      ```bash
      {{ yc-mdb-pg }} cluster get postgre406
      ```

      ```text
        id: c9q8p8j2gaih********
        ...
        config:
          version: "11"
          ...
      ```

   1. To upgrade the `postgre406` cluster to version 12, run this command:

      ```bash
      {{ yc-mdb-pg }} cluster update postgre406 --postgresql-version 12
      ```

{% endlist %}
