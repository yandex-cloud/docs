# {{ PG }} version update

You can update {{ mpg-name }} clusters to versions 11, 12, and 13.

{% note info %}

* You can't update the versions of {{ mpg-name }} clusters optimized for <q>1C:Enterprise</q> (10-1c, 11-1c, or 12-1c).
* You can't update a regular cluster version to a version optimized for <q>1C:Enterprise</q> (such as from version 10 to version 10-1c).

{% endnote %}

You can only upgrade to the version that immediately follows the current one, namely:

* From version 10 to version 11.
* From version 11 to version 12.
* From version 12 to version 13.

You need multiple steps to upgrade between versions that are farther apart. For example, to upgrade a cluster from 11 to 13, you need two steps: 11 → 12 → 13.

## Before upgrading {#before-update}

Prior to upgrading a cluster, make sure this doesn't affect your applications:

1. View the revision history for versions [11](https://www.postgresql.org/docs/release/11.0/), [12](https://www.postgresql.org/docs/release/12.0/), or [13](https://www.postgresql.org/docs/release/13.0/) {{ PG }} and check if any of the revisions affect your applications or the {{ PG }} [extensions](cluster-extensions.md) installed.
1. Try upgrading a test cluster (you can try [deploying](cluster-backups.md#restore) it from a backup of the main cluster).
1. [Back up ](cluster-backups.md#create-backup) the main cluster prior to upgrading.

## Upgrading a cluster {#start-update}

{% note alert %}

* After updating the DBMS, the cluster can't be rolled back to the previous version.
* The success of {{ PG }} version upgrade depends on multiple factors, including cluster settings and data stored in databases. We recommend that you first [upgrade a test cluster](#before-update) that uses the same data and settings.

{% endnote %}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Select the cluster from the list and click **Edit cluster**.
  1. In the **Version** field, select a new version number.
  1. Click **Save changes**.

  Once the update is launched, the cluster status changes to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Get a list of your {{ PG }} clusters using the command:

     ```bash
     {{ yc-mdb-pg }} cluster list
     ```

  1. Get information about a cluster and check the {{ PG }} version in the `config.version` parameter:

     ```bash
     {{ yc-mdb-pg }} cluster get <cluster ID or name>
     ```

  1. Start the {{ PG }} update:

     ```bash
     {{ yc-mdb-pg }} cluster update <cluster name or ID> \
        --postgresql-version <new version>
     ```

     Once the update is launched, the cluster status changes to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

       For information about how to create this file, see [{#T}](cluster-create.md).

    1. Under `cluster_config` of the desired {{ mpg-name }} cluster, add the `version` field or edit it if it already exists:

       ```hcl
       resource "yandex_mdb_postgresql_cluster" "<cluster name>" {
         ...
         cluster_config {
           version = "<PostgreSQL version>"
         }
       }
       ```

    1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).

- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

    * The cluster ID in the `clusterId` parameter. You can get it with a [list of clusters in the folder](./cluster-list.md#list-clusters).
    * The {{ PG }} version number in the `configSpec.version` parameter.
    * List of cluster configuration fields to be changed in the `updateMask` parameter.

        {% include [updateMask note](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}

## Examples {#examples}

Let's say you need to upgrade your cluster from version 11 to version 12.

{% list tabs %}

- CLI

   1. To get a list of clusters and find out their IDs and names, run the command:

      ```bash
      {{ yc-mdb-pg }} cluster list
      ```

      ```text
      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih8iti42mh |   postgre406  | 2021-10-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. To get information about a cluster named `postgre406`, run the command:

      ```bash
      {{ yc-mdb-pg }} cluster get postgre406
      ```

      ```text
        id: c9q8p8j2gaih8iti42mh
        ...
        config:
          version: "11"
          ...
      ```

   1. To upgrade the `postgre406` cluster to version 12, run the command:

      ```bash
      {{ yc-mdb-pg }} cluster update postgre406 --postgresql-version 12
      ```

{% endlist %}
