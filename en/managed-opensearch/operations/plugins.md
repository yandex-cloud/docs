# Managing {{ OS }} plugins

When creating a cluster in {{ mos-short-name }}, you can specify a list of necessary plugins and they will be installed in the cluster automatically. For a full list of available plugins, see [{#T}](../concepts/plugins.md#opensearch).

## Retrieving a list of installed plugins {#list}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mos-name }}**.
   1. Click on the name of the desired cluster.

- API

   Use the [get](../api-ref/Cluster/get.md) API method and pass the cluster ID in the `clusterId` request parameter.

   Enabled plugins will be shown in the `config.opensearch.plugins` list.

   You can get the cluster ID [with a list of clusters in a folder](cluster-list.md#list-clusters).

{% endlist %}

## Editing a list of installed plugins {#update}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mos-name }}**.
   1. Select a cluster and click ![pencil](../../_assets/pencil.svg) **Edit cluster** on the top panel.
   1. Under **General parameters**, enter the plugins to set up.
   1. Click **Save**.

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * Cluster ID in the `clusterID` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * List of plugins in the `configSpec.opensearchSpec.plugins` parameter. The plugins that are not included in the list will be disabled.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
