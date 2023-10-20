# {{ RD }} version upgrade

You can upgrade a {{ mrd-name }} cluster to any supported version.

You can only upgrade to a version that immediately follows the current one, such as version 6.2 to 7.0. Upgrades to higher versions are performed in steps. For instance, to upgrade {{ RD }} from version 6.0 to version 7.0, you will first need to upgrade to 6.2, and then, to 7.0.

## Supported versions {#version-supported}

All {{ RD }} versions, which were supported in {{ mrd-name }}, will remain available as long as the vendor continues to support them. Normally, this is for 24 months after a version is released. For more information, see the [{{ RD }} documentation](https://docs.redis.com/latest/rs/release-notes/).


As of June 1, 2022, {{ RD }} versions 5.0 and 6.0 are discontinued. You cannot create a cluster with these versions. The version of existing clusters was automatically upgraded to 6.2.


### Viewing a list of available {{ RD }} versions {#version-list}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Select a cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. Open the list in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.

{% endlist %}

## Before updating the version {#before-update}

Make sure this does not affect your applications:

1. See the {{ RD }} [changelog](https://docs.redis.com/latest/rs/release-notes/) to check how updates might affect your applications.
1. Try updating the version on a test cluster. You can deploy it from a backup of the main cluster.
1. [Create a backup](cluster-backups.md) of the main cluster before updating the version.

## Upgrading a cluster {#start-update}

{% note alert %}

* After updating the DBMS, the cluster cannot be rolled back to the previous version.
* The success of a {{ RD }} version upgrade depends on multiple factors, including cluster settings and data stored in databases. We recommend that you first [upgrade a test cluster](#before-update) that uses the same data and settings.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder containing the cluster to upgrade.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
   1. Select the desired cluster from the list and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select the new version.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

   Once the update is launched, the cluster status will change to **Updating**. Wait for the operation to complete and then check the cluster version.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Get a list of your {{ RD }} clusters using this command:

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

      Once the update is launched, the cluster status will change to **Updating**. Wait for the operation to complete and then check the cluster version.

- API

   To update a cluster, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * {{ RD }} version number in the `configSpec.version` parameter.
   * List of cluster configuration fields to be changed in the `updateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Examples {#examples}

Let's assume you need to upgrade your cluster from version {{ versions.cli.previous }} to version {{ versions.cli.latest }}.

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
      | c9q8p8j2gaih8iti42mh |   redis406    | 2022-04-23 12:44:17 | ALIVE  | RUNNING |
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
        version: "{{ versions.cli.previous }}"
        ...
      ```

   1. To upgrade a cluster named `redis406` to version {{ versions.cli.latest }}, run the following command:

      ```bash
      {{ yc-mdb-rd }} cluster update redis406 --redis-version {{ versions.cli.latest }}
      ```

{% endlist %}
