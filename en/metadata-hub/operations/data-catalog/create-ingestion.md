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
  1. Navigate to the ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.data-catalog.label_ingestions }}** tab.
  1. Click **{{ ui-key.yacloud.data-catalog.label_create-ingestion-action }}**.
  1. Specify the ingestion settings:

      * In the **{{ ui-key.yacloud.common.name }}** field, enter a unique name for the ingestion.
      * Optionally, describe the ingestion.
      * Select a data source or create one.
      * Under **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.title }}**:

         * Select an ingestion schedule:

            {% include [schedule](../../../_includes/metadata-hub/schedule-ingestion.md) %}

         * Optionally, under **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.data_filters.title }}**, use regular expressions to specify which databases and database objects to include or exclude from the ingestion.

         {% include [metadata-profiling](../../../_includes/metadata-hub/metadata-profiling.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
