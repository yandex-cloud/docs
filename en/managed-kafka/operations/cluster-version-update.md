# {{ KF }} version upgrade

You can upgrade a {{ mkf-name }} cluster to any supported version.

We recommend upgrading to a version that immediately follows the current one, such as version 2.8 to 3.0. Upgrades to higher versions should be performed in steps. To upgrade {{ KF }} from 2.8 to 3.1, for instance, follow the steps: 2.8 → 3.0→ 3.1.

To learn more about updates within one version and host maintenance, see [{#T}](../concepts/maintenance.md).

## Before updating the version {#before-update}

Prior to upgrading a cluster, make sure this does not affect your applications. See the {{ KF }} [changelog](https://kafka.apache.org/downloads) to check which updates might affect your apps.

## Upgrading a cluster {#start-update}

{% note alert %}

Once upgraded, you cannot roll a {{ KF }} cluster back to the previous version.

{% endnote %}

During an upgrade, topics may be unavailable if their [replication factor](../concepts/settings-list.md#settings-topic-replication-factor) is 1.

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mkf-name }}**.
   1. Select the desired cluster from the list and click **Edit**.
   1. In the **Version** field, select a new version number.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Get a list of your {{ mkf-short-name }} clusters:

      ```bash
      {{ yc-mdb-kf }} cluster list
      ```

   1. Get information about a cluster and check the version in the `config.version` parameter:

      ```bash
      {{ yc-mdb-kf }} cluster get <cluster ID or name>
      ```

   1. Start the {{ KF }} upgrade:

      ```bash
      {{ yc-mdb-kf }} cluster update <cluster ID or name> \
         --version=<new version number>
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Add a `version` field to the `config` section of the desired {{ mkf-name }} cluster or edit the field value if the field already exists:

      ```hcl
      resource "yandex_mdb_kafka_cluster" "<cluster name>" {
        ...
        config {
          version = "<{{ KF }} version>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mkf }}).

   {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API

   To update a cluster, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. You can retrieve it with a [list of clusters in the folder](./cluster-list.md#list-clusters).
   * {{ KF }} version number in the `configSpec.version` parameter.
   * List of cluster configuration fields to update in the `UpdateMask` parameter.

      {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Examples {#examples}

Let's assume you need to upgrade your cluster from version 2.8 to version 3.0.

{% list tabs %}

- CLI

   1. To get a list of clusters and find out their IDs and names, run the command:

      ```bash
      {{ yc-mdb-kf }} cluster list
      ```

      ```text
      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih8iti42mh |    kafka35    | 2021-10-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. To get information about the cluster `kafka35`, run the following command:

      ```bash
      {{ yc-mdb-kf }} cluster get kafka35
      ```

      ```text
        id: c9q8p8j2gaih8iti42mh
        ...
        config:
          version: "2.8"
          ...
      ```

   1. To upgrade the `kafka35` cluster to version 3.0, run the following command:

      ```bash
      {{ yc-mdb-kf }} cluster update kafka35 --version=3.0
      ```

{% endlist %}
