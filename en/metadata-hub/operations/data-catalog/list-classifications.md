# Getting a list of classifications

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog your classifications were created in.
  1. Navigate to the ![image](../../../_assets/console-icons/tag.svg) **{{ ui-key.yacloud.data-catalog.label_tags-and-classification }}** tab.

{% endlist %}

## Configuring a list of classifications {#setting-list-classifications}

You can use the management console to find classifications by ID or name, sort classifications by name, and customize the columns in the list.

To find a classification, enter its ID or name in the search bar above the list of classifications.

To sort classifications by name, click the **{{ ui-key.yacloud.common.name }}** column header. This will sort the classifications in alphabetical order. Clicking the same header a second time reverses the sorting order. Clicking a third time clears the applied sorting.

{% include [display-columns](../../../_includes/metadata-hub/display-columns.md) %}
