# Upgrading {{ PG }} version

You can upgrade a {{ mpg-name }} cluster to any version up to and including version 17.

{% note info %}

Upgrade from a standard cluster version to an _1C:Enterprise_ version (e.g., 14 to 14-1c) is not supported.

{% endnote %}

{% note warning %}

To upgrade the version, the cluster storage must have at least 10% free space, with a minimum of 10 GB.

{% endnote %}

You can only upgrade to the next sequential version, e.g., from 14 to 15. Upgrading to later versions is performed in stages. For example, to upgrade {{ PG }} from version 13 to 15, follow this sequence: 13 → 14 → 15.

In single-host clusters, only the master host is taken offline for upgrades. Such clusters are unavailable for reading and writing during upgrades.

In multi-host clusters, upgrades follow the procedure below:

1. The master host is taken offline for an upgrade. During this time, replicas operate in read-only mode. No [failover](../concepts/replication.md#replication-auto) occurs. After the upgrade, the master host stays offline, even for reads, until all replicas are upgraded.
1. Replicas are taken offline for an upgrade, one by one. Replicas are queued in a random order. Once upgraded, replicas resume operation in read-only mode.

    A two-host cluster will be unavailable during the upgrade of its replica. In a cluster of three or more hosts, at least one replica will be always available for reading.

1. The master host resumes its operation.

For information on minor version upgrades and host maintenance, see [Maintenance](../concepts/maintenance.md).

## Pre-upgrade steps {#before-update}

Make sure the upgrade will not disrupt your applications:

1. Check the [{{ PG }} changelog](https://www.postgresql.org/docs/release/) to see how upgrades might affect your applications or installed [extensions](./extensions/cluster-extensions.md).
1. Try upgrading a test cluster. You can [deploy](cluster-backups.md#restore) it from the main cluster’s backup.
1. [Back up](cluster-backups.md) the main cluster immediately before upgrading.

## Upgrading a cluster {#start-update}

{% note alert %}

* After the DBMS upgrade, you cannot revert a cluster to the previous version.
* Whether a {{ PG }} version upgrade succeeds depends on multiple factors, including your cluster’s configuration and the nature of the stored data. We recommend you first [upgrade a test cluster](#before-update) with the same data and configuration.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Select your cluster from the list and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select the new version number.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To upgrade a cluster to {{ PG }} version 15 or lower:

  1. Get a list of your {{ PG }} clusters using this command:

     ```bash
     {{ yc-mdb-pg }} cluster list
     ```

  1. Get the target cluster details and check its {{ PG }} version in the `config.version` setting:

     ```bash
     {{ yc-mdb-pg }} cluster get <cluster_name_or_ID>
     ```

  1. Run the {{ PG }} upgrade:

     ```bash
     {{ yc-mdb-pg }} cluster update <cluster_name_or_ID> \
        --postgresql-version <new_version_number>
     ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

       To learn how to create this file, see [Creating clusters](cluster-create.md).

       For a complete list of configurable {{ mpg-name }} cluster fields, refer to the [{{ TF }} provider guides]({{ tf-provider-mpg }}).

    1. Add the `version` field to the `cluster_config` section of the target {{ mpg-name }} cluster, or update its value if it already exists:

       ```hcl
       resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
         ...
         cluster_config {
           version = "<{{ PG }}_version>"
         }
       }
       ```

    1. Validate your configuration.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

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

     * `updateMask`: Comma-separated list of settings you want to update.

       Here, we provide only one setting.

     * `configSpec.version`: New {{ PG }} version.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

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

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

       Here, we provide only one setting.

     * `config_spec.version`: New {{ PG }} version.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

Once you run the upgrade, the cluster status will change to **UPDATING**. Wait for the upgrade to complete and then check the cluster version.

Cluster upgrade time depends on the database size.

{% note tip %}

If you encounter issues while upgrading to version 17, contact [technical support]({{ link-console-support }}).

{% endnote %}

## Examples {#examples}

Suppose you need to upgrade a cluster from version 14 to 15.

{% list tabs group=instructions %}

- CLI {#cli}

   1. To get a list of clusters with their IDs and names, run this command:

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
          version: "14"
          ...
      ```

   1. To upgrade the `postgre406` cluster to version 15, run this command:

      ```bash
      {{ yc-mdb-pg }} cluster update postgre406 --postgresql-version 15
      ```

{% endlist %}

