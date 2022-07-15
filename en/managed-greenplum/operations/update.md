# Changing cluster settings

After creating a cluster, you can:

* [{#T}](#change-name-and-description).

* [{#T}](#change-additional-settings).

## Change the cluster name and description {#change-name-and-description}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. Select the cluster and click **Edit** at the top of the page.
   1. Under **Basic parameters**, enter a new name and description for the cluster.
   1. Click **Save**.

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * A new name in the `name` parameter.
   * A new description in the `description` parameter.
   * A list of cluster configuration fields to modify (`name`, `description` in this case) in the `updateMask` parameter.

      {% include [note-api-updatemask](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. Select the cluster and click **Edit** in the top panel.
   1. Change additional cluster settings:

      {% include [extra-settings](../../_includes/mdb/mgp/extra-settings.md) %}

   1. Click **Save**.

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Public access settings, in the `assignPublicIp` parameter.
   * Backup window settings, in the `config.backupWindowStart` parameter.
   * Settings of access from [{{ datalens-full-name }}](../../datalens/concepts/index.md), in the `config.access.dataLens` parameter.
   * {% include [Maintenance window](../../_includes/mdb/api/maintenance-window.md) %}
   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   * List of cluster configuration fields to be changed in the `updateMask` parameter.

      {% include [note-api-updatemask](../../_includes/mdb/note-api-updatemask.md) %}

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
