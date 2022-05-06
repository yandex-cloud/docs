# {{ RD }} version update

You can upgrade {{ mrd-name }} clusters to versions 6.0 or 6.2.

You can only upgrade to the version that immediately follows the current one, namely:

* From version 5.0 to version 6.0.
* From version 6.0 to version 6.2.

You need multiple steps to upgrade between versions that are farther apart. To upgrade a cluster from version 5.0 to version 6.2, you have to do it in steps as follows: 5.0 → 6.0 → 6.2.

## Before upgrading {#before-update}

Prior to upgrading a cluster, make sure this doesn't affect your applications:

1. View the revision history for {{ RD }} versions [6.0](https://raw.githubusercontent.com/redis/redis/6.0/00-RELEASENOTES) or [6.2](https://raw.githubusercontent.com/redis/redis/6.2/00-RELEASENOTES)  to check if there are any changes that may affect applications at runtime.
1. Try upgrading a test cluster (you can try [deploying](cluster-backups.md#restore) it from a backup of the main cluster).
1. [Back up](cluster-backups.md#create-backup) the main cluster prior to upgrading.

## Upgrading a cluster {#start-update}

{% note alert %}

* After updating the DBMS, the cluster can't be rolled back to the previous version.
* The success of {{ RD }} version upgrade depends on multiple factors, including cluster settings and data stored in databases. We recommend that you first [upgrade a test cluster](#before-update) that uses the same data and settings.

{% endnote %}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mrd-name }}**.
  1. Select the cluster from the list and click **Edit cluster**.
  1. In the **Version** field, select the new version.
  1. Click **Save changes**.

  Once the update is launched, the cluster status changes to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Get a list of your {{ RD }} clusters using the command:

     ```bash
     {{ yc-mdb-rd }} cluster list
     ```

  1. Get information about a cluster and check the {{ RD }} version in the `config.version` parameter:

     ```bash
     {{ yc-mdb-rd }} cluster get <cluster ID or name>
     ```

  1. Start the {{ RD }} update:

     ```bash
     {{ yc-mdb-rd }} cluster update <cluster name or ID> \
         --redis-version <new version number>
     ```

     Once the update is launched, the cluster status changes to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

  * The cluster ID in the `clusterId` parameter. You can get it with a [list of clusters in the folder](./cluster-list.md#list-clusters).

  * The {{ RD }} version number in the `configSpec.version` parameter.

  * List of cluster configuration fields to be changed in the `updateMask` parameter.

      {% include [updateMask note](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}

## Examples {#examples}

Let's assume that you need to upgrade your cluster from version 5.0 to version 6.0.

{% list tabs %}

- CLI

   1. To retrieve a list of clusters and find out their IDs and names, run the command below:

      ```bash
      {{ yc-mdb-rd }} cluster list
      ```

      ```text
      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih8iti42mh |   redis406    | 2021-11-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. To get information about a cluster named `redis406`, run the following command:

      ```bash
      {{ yc-mdb-rd }} cluster get redis406
      ```

      ```text
      id: c9q8p8j2gaih8iti42mh
      ...
      config:
        version: "5.0"
        ...
      ```

   1. To update a cluster named `redis406` to version 6.0, run the following command:

      ```bash
      {{ yc-mdb-rd }} cluster update redis406 --redis-version 6.0
      ```

{% endlist %}
