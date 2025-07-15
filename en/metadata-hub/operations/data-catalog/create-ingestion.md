# Creating a data ingestion

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog where you want to create an ingestion.
  1. Go to the ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **Ingestions** tab.
  1. Click **Create ingestion**.
  1. Specify the ingestion settings:

      * In the **{{ ui-key.yacloud.common.name }}** field, enter a unique name for the ingestion.
      * Optionally, describe the ingestion.
      * Select a data source or create one.
      * Under **Ingestion configuration**, do the following:

         * Select an ingestion schedule:

            {% include [schedule](../../../_includes/metadata-hub/schedule-ingestion.md) %}

         * Optionally, under **Data filters**, specify use regular expressions to specify which databases and database objects to include to exclude from the ingestion.

         {% include [metadata-profiling](../../../_includes/metadata-hub/metadata-profiling.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
