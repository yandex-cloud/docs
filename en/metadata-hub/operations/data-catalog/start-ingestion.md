# Starting and stopping an ingestion

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

Ingestions start automatically as per the schedule you set up when [creating](create-ingestion.md) or [updating](update-ingestion.md) them. You can start or stop an ingestion if its schedule is set to **Manual start**.

## Starting an ingestion {#start-ingestion}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to start an ingestion in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. Select the metadata catalog you need to start an ingestion in and select ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **Ingestions** in the left-hand panel.
  1. In the list of ingestions, click ![image](../../../_assets/console-icons/ellipsis.svg) in the line with the ingestion and select **{{ ui-key.yacloud.common.start }}**.

{% endlist %}

## Stopping an ingestion {#stop-ingestion}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. Select the catalog you need to stop an ingestion in and select ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **Ingestions** in the left-hand panel.
  1. In the list of ingestions, click ![image](../../../_assets/console-icons/ellipsis.svg) in the line with an ingestion in the **Running** status and select **{{ ui-key.yacloud.common.stop }}**.

{% endlist %}
