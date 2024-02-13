# Updating the {{ OS }} version

You can update a {{ mos-name }} cluster to a newer {{ OS }} version.

To learn more about updates within one version and host maintenance, see [{#T}](../concepts/maintenance.md).

## Viewing a list of available versions {#version-list}

{% list tabs group=instructions %}

- Management console {#console}

   In the [management console]({{ link-console-main }}), open the page where {{ mos-name }} clusters are [created](cluster-create.md) or [updated](update.md). You can view the list in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.

{% endlist %}

## Before updating the version {#before-version-update}

Make sure the update does not affect your applications:

1. See the {{ OS }} [changelog](https://opensearch.org/docs/latest/version-history/) to check how updates might affect your applications.
1. Try updating the version on a test cluster. You can deploy it from a backup of the main cluster.
1. [Create a backup](cluster-backups.md) of the main cluster before updating the version.

## Updating the version {#start-version-update}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Select a cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select the appropriate {{ OS }} version.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Get the name and ID of the cluster you need with the list of all {{ OS }} clusters:

      ```bash
      {{ yc-mdb-os }} cluster list
      ```

   1. Get information about the cluster you need and check the version in the `config.version` parameter:

      ```bash
      {{ yc-mdb-os }} cluster get <cluster_name_or_ID>
      ```

   1. Update the {{ OS }} version:

      ```bash
      {{ yc-mdb-os }} cluster update <cluster_name_or_ID> \
         --version <{{ OS }}_version>
      ```

- API {#api}

   Use the [update](../api-ref/Cluster/update.md) API method and include the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * New {{ OS }} version in the `configSpec.version` parameter.
   * List of cluster configuration fields to update in the `updateMask` parameter (in this case, `configSpec.version`).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
