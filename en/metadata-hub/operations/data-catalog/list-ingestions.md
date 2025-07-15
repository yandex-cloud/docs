# Getting a list of ingestions

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog your ingestions were created in.
  1. Go to the ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **Ingestions** tab.

{% endlist %}

## Configuring a list of ingestions {#setting-list-ingestions}

From the management console, you can:

* Search for ingestions by ID, name, or status.
* Sort ingestions by name.
* List all ingestions or the current user's ingestions.
* Customize the columns in the list.

To find an ingestion, enter its ID or name in the search bar above the list of ingestions. To find all ingestions with a particular status, select the status from the list above the list of ingestions.

To sort ingestions by name, click the **{{ ui-key.yacloud.common.name }}** column header. This will sort the ingestions in alphabetical order. A second click on the same header reverses the sorting order. A third click cancels the sorting.

To filter the current user's ingestions, click **My** above the list of ingestions.

To customize the columns:

1. Click ![image](../../../_assets/console-icons/gear.svg) in the column header row. This will open the list of all columns.
1. Do one of the following in the list of columns:

    * Uncheck the columns you do not need.
    * Check the hidden columns you want displayed.
    * To reorder columns, click ![image](../../../_assets/console-icons/grip.svg) to the left of the column name and drag the column up or down to a new position in the list.

1. Click **Apply**.
