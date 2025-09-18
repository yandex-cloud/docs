# Starting and stopping an ingestion


{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}


Ingestions start automatically as per the schedule you set up when [creating](create-ingestion.md) or [updating](update-ingestion.md) them. You can start or stop an ingestion if its schedule is set to **{{ ui-key.data-catalog.console.form.cron.Cron.none.title }}**.

## Starting an ingestion {#start-ingestion}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to start an ingestion in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. Select the metadata catalog you need to start an ingestion in and select ![image](../../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud.data-catalog.label_ingestions }}** in the left-hand panel.
  1. In the list of ingestions, click ![image](../../../_assets/console-icons/ellipsis.svg) in the line with the ingestion and select **{{ ui-key.yacloud.common.start }}**.
  
  Once successfully completed, the ingestion will get the **{{ ui-key.yacloud.data-catalog.label_ingestion-status-Success }}** status, and the ingested data will be [available for viewing](#see-ingested-data).

{% endlist %}

## Stopping an ingestion {#stop-ingestion}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. Select the catalog where you need to stop an ingestion and select ![image](../../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud.data-catalog.label_ingestions }}** in the left-hand panel.
  1. In the list of ingestions, click ![image](../../../_assets/console-icons/ellipsis.svg) in the row with a **{{ ui-key.yacloud.data-catalog.label_ingestion-status-Running }}** ingestion and select **{{ ui-key.yacloud.common.stop }}**.

{% endlist %}

## Viewing ingested data {#see-ingested-data}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the ingestion in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. Select the metadata catalog you created the ingestion in, then select ![image](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}** in the left-hand panel.

  The page displays info about the ingested data: [data sources](../../concepts/data-catalog.md#metadata-upload) (clusters and custom installations), databases, and tables. Here you can [find the metadata you need](search-metadata.md) and [mark it up](markup-metadata.md), as well as [analyze its structure and links between its parts](analysis-metadata.md).

{% endlist %}
