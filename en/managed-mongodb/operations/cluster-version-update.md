# {{ MG }} version upgrade

You can upgrade a {{ mmg-name }} cluster within a single major version. Major version upgrades (such as 4 → 5) are not supported.

You can only upgrade to a version that immediately follows the current one, such as, from 4.0 to 4.2. Upgrades to higher versions are performed in steps. For example, to upgrade {{ MG }} from 4.0 to 4.4, you will first need to upgrade to 4.2, and then, to 4.4.


{% note alert %}

* After upgrading, you cannot roll a cluster back to the previous version.
* Perform setup steps prior to the upgrade.

{% endnote %}

## Before updating the version {#before-update}

Prior to upgrading a cluster, make sure this does not affect your applications:

1. See the {{ MG }} [changelog](https://docs.mongodb.com/manual/release-notes/) to check how updates might affect your applications.
1. Try updating the version on a test cluster. You can deploy it from a backup of the main cluster.
1. [Make a backup](cluster-backups.md) of the main cluster before updating the version.

## Upgrading a cluster {#start-update}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Select the cluster from the list and click **Edit cluster**.
   1. In the **Version** field, select a new version number.
   1. Click **Save changes**.

   Once the upgrade is launched, the cluster status will change to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- CLI

   1. Get a list of your {{ MG }} clusters using this command:

      ```bash
      {{ yc-mdb-mg }} cluster list
      ```

   1. Get information about a cluster and check the {{ MG }} version in the `config.version` parameter:

      ```bash
      {{ yc-mdb-mg }} cluster get <cluster ID or name>
      ```

   1. Start the {{ MG }} upgrade:

      ```bash
      {{ yc-mdb-mg }} cluster update <cluster name or ID> \
         --mongodb-version=<new version number>
      ```

      When the update starts, the cluster status will switch to **UPDATING**. Wait for the operation to complete and then check the cluster version.

   1. After the upgrade, all MongoDB features that are not backward-compatible with the previous version will be disabled. To remove this restriction, run this command:

      ```bash
      {{ yc-mdb-mg }} cluster update <cluster ID or name> \
         --feature-compatibility-version=<new version number>
      ```

      Learn more about backward compatibility in the [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. To the {{ mmg-name }} cluster description, add the `version` field or change its value if it is already there:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<cluster name>" {
        ...
        cluster_config {
          version = "<MongoDB version>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_mongodb_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

   To update the {{ MG }} version, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * {{ MG }} version which you are upgrading to, in the `configSpec.version` parameter.
   * List of settings to update (in our case, `configSpec.version`) in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

   After the upgrade, all MongoDB features that are not backward-compatible with the previous version will be disabled. To remove this restriction, use the [update](../api-ref/Cluster/update.md) API method and provide the new version number in the call using the `configSpec.featureCompatibilityVersion` property.

   Learn more about backward compatibility in the [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/).

{% endlist %}

## Examples {#examples}

Let's assume you need to upgrade your cluster from version 4.0 to 4.2.

{% list tabs %}

- CLI

   1. To find out the cluster ID, get a list of all clusters in the folder:

      ```bash
      {{ yc-mdb-mg }} cluster list

      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih8iti42mh |   mongodb406  | 2019-04-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. To get information about the `c9qut3k64b2o9umqogr7` cluster, run this command:

      ```bash
      {{ yc-mdb-mg }} cluster get c9qut3k64b2o9umqogr7
        id: c9qut3k64b2o9umqogr7
        folder_id: b1g0itj57rbjk9thrinv
        created_at: "2019-07-16T09:43:50.393231Z"
        name: mongodb406
        environment: PRODUCTION
        monitoring:
        - name: Console
          description: Console charts
          link: {{ link-console-main }}/folders/b1g0itj57rbjk9thrinv/managed-mongodb/cluster/c9qut3k64b2o9umqogr7?section=monitoring
        config:
          version: "4.0"
          feature_compatibility_version: "4.0"
          ...
      ```

   1. To upgrade the cluster `c9qutgkd4b2o9umqog97` to version 4.2, run this command:

      ```bash
      {{ yc-mdb-mg }} cluster update c9qutgkd4b2o9umqog97 \
          --mongodb-version=4.2
      ```

   1. To enable all 4.2 features in the cluster `c9qutgkd4b2o9umqog97`, run this command:

      ```bash
      {{ yc-mdb-mg }} cluster update c9qutgkd4b2o9umqog97 \
          --feature-compatibility-version=4.2
      ```

{% endlist %}
