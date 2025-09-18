# Analyzing links between metadata

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

You can analyze links between tables from all sources of the selected metadata catalog.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}**.
  1. Select the line with the **Dataset** type from the list and go to the **Links** tab. The tab will display a graph with links between the selected table and source DB objects as well as `table` → `{{ data-transfer-full-name }}` → `table` links.
  
     Each graph node represents a table and contains an expanding list of table columns.

  1. Configure the display of objects and their links on the graph:
      * Select the displayed object **{{ ui-key.yacloud.data-catalog.label_asset-lineage-depth }}**. By default, the depth value is two, i.e., objects no more than two links away from the selected table are displayed.
      * Select the **{{ ui-key.yacloud.data-catalog.label_asset-lineage-weak }}** option to display all object links on the graph.
      * To view a list of object columns, expand the **Columns** list.
      * To set a different central table for the graph, select it from the list. To display all links of the selected table, click it on the diagram and go to the **Links** section.
      * To view domains, tags, and terms associated with an object, click the object.

{% endlist %}
