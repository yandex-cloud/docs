# Managing {{ OS }} plugins

When creating a cluster in {{ mos-short-name }}, you can specify a list of necessary plugins and they will be installed in the cluster automatically. For a full list of available plugins, see [{#T}](../concepts/plugins.md#opensearch).

## Retrieving a list of installed plugins {#list}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Click the cluster name.

- API

   To get a list of installed plugins, use the [get](../api-ref/Cluster/get.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   Enabled plugins will be shown in the `config.opensearch.plugins` list.

   {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}

## Editing a list of installed plugins {#update}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Select a cluster and click ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** on the top panel.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, specify the plugins you want to install.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- API

   To update the list of installed plugins, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter.

      {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

   * List of plugins in the `configSpec.opensearchSpec.plugins` parameter. The plugins that are not included in the list will be disabled.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
