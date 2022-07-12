# {{ MG }} version update

You can upgrade a {{ mmg-name }} cluster within a single major version. Major version upgrades (such as 4 → 5) are not supported.

You can only upgrade to a version that immediately follows the current one, such as version 4.0 to 4.2. Upgrades to higher versions are performed in steps. To upgrade {{ MG }} from version 4.0 to version 4.4, for instance, follow the steps: 4.0 → 4.2 → 4.4.

{% if policy != "keep" %}

{% note info %}

In January 2022, clusters running {{ MG }} 4.0 will be [forcibly upgraded](../qa/general.md#dbms-deprecated) to version 4.2 due to the version 4.0 [End of Life](https://www.mongodb.com/support-policy). We recommend that you upgrade to the latest {{ MG }} versions in advance.

{% endnote %}

{% endif %}

## Before upgrading {#before-update}

Prior to upgrading a cluster, make sure this doesn't affect your applications:

1. View the changelog for {{ MG }} version [4.2](https://docs.mongodb.com/v4.2/release-notes/4.2/) or [4.4](https://docs.mongodb.com/v4.4/release-notes/4.4/) and check if any of the changes may affect your applications.
1. Try upgrading a test cluster (you can try [deploying](cluster-backups.md#restore) it from a backup of the main cluster).
1. [Back up](cluster-backups.md#create-backup) the main cluster prior to upgrading.

## Upgrading a cluster {#start-update}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Select the cluster from the list and click **Edit cluster**.
   1. In the **Version** field, choose `4.2` or `4.4`.
   1. Click **Save changes**.

   Once the update is launched, the cluster status changes to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- CLI

   1. Get a list of your {{ MG }} clusters using the command:

      ```bash
      yc managed-mongodb cluster list
      ```

   1. Get information about a cluster and check the {{ MG }} version in the `config.version` parameter:

      ```bash
      yc managed-mongodb cluster get <cluster ID>
      ```

   1. Start the {{ MG }} update:

      ```bash
      yc managed-mongodb cluster update <cluster ID> --mongodb-version=<new version ID>
      ```

      When the update starts, the cluster status switches to **UPDATING**. Wait for the operation to complete and then check the cluster version.

   1. After the update, all the MongoDB features that are not backward-compatible with the previous version are disabled. To remove this restriction, run the command:

      ```bash
      yc managed-mongodb cluster update <cluster ID> --feature-compatibility-version=<new version ID>
      ```

      Learn more about backward compatibility in the [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/).

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. To the {{ mmg-name }} cluster description, add the `version` field or change its value if it's already there:

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

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_mongodb_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

   You can update the {{ MG }} version for a cluster using the [update](../api-ref/Cluster/update.md) API method: pass the appropriate value in the `configSpec.version` property.

   After the update, all the MongoDB features that are not backward-compatible with the previous version are disabled. To remove this restriction, use the [update](../api-ref/Cluster/update.md) API method: pass the new version number in the request using the `configSpec.featureCompatibilityVersion` property.

   Learn more about backward compatibility in the [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/).

{% endlist %}


## Examples {#examples}

Let's say you need to upgrade your cluster from version 4.0 to version 4.2.

{% list tabs %}

- CLI

   1. To get a list of clusters and find out the cluster ID, run the command:

      ```
      yc managed-mongodb cluster list
      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih8iti42mh |   mongodb406  | 2019-04-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. To get information about the `c9qut3k64b2o9umqogr7` cluster, run the command:

      ```
      yc managed-mongodb cluster get c9qut3k64b2o9umqogr7
        id: c9qut3k64b2o9umqogr7
        folder_id: b1g0itj57rbjk9thrinv
        created_at: "2019-07-16T09:43:50.393231Z"
        name: mongodb406
        environment: PRODUCTION
        monitoring:
        - name: Console
          description: Console charts
          link: https://console.cloud.yandex.com/folders/b1g0itj57rbjk9thrinv/managed-mongodb/cluster/c9qut3k64b2o9umqogr7?section=monitoring
        config:
          version: "4.0"
          feature_compatibility_version: "4.0"
          ...
      ```

   1. To upgrade the cluster `c9qutgkd4b2o9umqog97` to version 4.2, run the command:

      ```bash
      yc managed-mongodb cluster update c9qutgkd4b2o9umqog97 --mongodb-version=4.2
      ```

   1. To enable all 4.2 features in the cluster `c9qutgkd4b2o9umqog97`, run the command:

      ```bash
      yc managed-mongodb cluster update c9qutgkd4b2o9umqog97 --feature-compatibility-version=4.2
      ```

{% endlist %}
