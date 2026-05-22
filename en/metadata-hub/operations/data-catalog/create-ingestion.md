# Creating a data ingestion


{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

{% endnote %}


If the metadata origin's {{ yandex-cloud }} subnet security group has traffic restriction rules in place, add a new rule to allow incoming traffic:

  * Based on CIDR IP address range 198.19.0.0/16, for {{ data-catalog-name }}.
  * Based on port used for connection to the data source for the purpose of creating the ingestion, e.g., for {{ mpg-name }}, it is port 6432.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. [Go](../../../console/operations/select-service#select-service.md) to **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog where you want to create an ingestion.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud.data-catalog.label_ingestions }}**.
  1. Click **{{ ui-key.yacloud.data-catalog.label_create-ingestion-action }}**.
  1. Specify the ingestion settings:

      * In the **{{ ui-key.yacloud.common.name }}** field, enter a unique name for the ingestion.
      * Optionally, describe the ingestion.
      * Select a data source or create one.
      * Specify the ingestion configuration for the data source:

         * Select an ingestion schedule:

            {% include [schedule](../../../_includes/metadata-hub/schedule-ingestion.md) %}

         * Optionally, under **{{ ui-key.data-catalog.console.form.ingestion.PostgresConfigForm.data_filters.title }}**, use regular expressions to specify which backends and database objects to include in or exclude from the ingestion.

         {% include [metadata-profiling](../../../_includes/metadata-hub/metadata-profiling.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
