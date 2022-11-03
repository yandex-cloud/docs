# {{ RD }} version upgrade

You can upgrade a {{ mrd-name }} cluster to any supported version.

You can only upgrade to a version that immediately follows the current one, such as version 5.0 to 6.0. Upgrades to higher versions are performed in steps. To upgrade {{ RD }} from version 5.0 to version 6.2, for instance, follow the steps 5.0 → 6.0 → 6.2.

## Supported versions {#version-supported}

All {{ RD }} versions, which were supported in {{ mrd-name }}, will remain available as long as the vendor continues to support them. Normally, this is for 24 months after a version is released. For more information, see the [{{ RD }} documentation](https://docs.redis.com/latest/rs/release-notes/).

As of June 1, 2022, {{ RD }} versions 5.0 and 6.0 will no longer be supported. You will not be able to create a cluster with these versions. We recommend that you manually update your cluster to a newer {{ RD }} version. If you have any problems updating, contact [technical support]({{ link-console-support }}).

When version 7.0 is released, {{ mrd-name }} cluster users with versions 5.0 and 6.0 will receive a notification suggesting that they upgrade to version 6.2 (the lowest supported version). One month after this date, {{ RD }} clusters with versions 5.0 and 6.0 will be automatically upgraded to version 6.2.

### Viewing a list of available {{ RD }} versions {#version-list}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mrd-name }}**.
   1. Select a cluster and click **Edit**.
   1. Open the list in the **Version** field.

{% endlist %}

## Before upgrading {#before-update}

Prior to upgrading a cluster, make sure this doesn't affect your applications:

1. Review the [change log](https://docs.redis.com/latest/rs/release-notes/) for the {{ RD }} versions that you are upgrading your cluster to, and make sure that changes do not affect your application.
1. Try upgrading a test cluster (you can try [deploying](cluster-backups.md#restore) it from a backup of the main cluster).
1. [Back up](cluster-backups.md#create-backup) the main cluster prior to upgrading.

## Upgrading a cluster {#start-update}

{% note alert %}

* After updating the DBMS, the cluster can't be rolled back to the previous version.
* The success of {{ RD }} version upgrade depends on multiple factors, including cluster settings and data stored in databases. We recommend that you first [upgrade a test cluster](#before-update) that uses the same data and settings.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder containing the cluster to upgrade.
   1. Select **{{ mrd-name }}**.
   1. Select the cluster from the list and click **Edit cluster**.
   1. In the **Version** field, select the new version.
   1. Click **Save changes**.

   Once the upgrade is launched, the cluster status changes to **UPDATING**. Wait for the operation to complete and then check the cluster version.

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

   1. Start the {{ RD }} upgrade:

      ```bash
      {{ yc-mdb-rd }} cluster update <cluster ID or name> \
        --redis-version <new version number>
      ```

      Once the upgrade is launched, the cluster status changes to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. You can retrieve it with a [list of clusters in the folder](./cluster-list.md#list-clusters).
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

      Result:

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

      Result:

      ```text
      id: c9q8p8j2gaih8iti42mh
      ...
      config:
        version: "5.0"
        ...
      ```

   1. To upgrade a cluster named `redis406` to version 6.0, run the following command:

      ```bash
      {{ yc-mdb-rd }} cluster update redis406 --redis-version 6.0
      ```

{% endlist %}
