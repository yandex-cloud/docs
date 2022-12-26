# Managing {{ OS }} plugins

When creating a cluster in {{ mos-short-name }}, you can specify a list of necessary plugins and they will be installed in the cluster automatically. For a full list of available plugins, see [{#T}](../concepts/plugins.md#opensearch).

## Retrieving a list of installed plugins {#list}

{% list tabs %}

- API

   Use the [get](../api-ref/Cluster/get.md) API method and pass the cluster ID in the `clusterId` request parameter.

   Enabled plugins will be shown in the `config.opensearch.plugins` list.

   You can get the cluster ID [with a list of clusters in a folder](cluster-list.md#list-clusters).

{% endlist %}

## Editing a list of installed plugins {#update}

{% list tabs %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The list of plugins in the `configSpec.opensearchSpec.plugins` parameter. Plugins that are not included in the list will be disabled.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
