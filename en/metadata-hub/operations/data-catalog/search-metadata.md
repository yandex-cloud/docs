# Metadata search

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog.
  1. Navigate to the ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}** tab.

  1. Optionally, customize the columns:
  
     1. Click ![image](../../../_assets/console-icons/gear.svg) in the column header row. This will open the list of all columns.
     1. Do one of the following in the list of columns:
  
        * Uncheck the columns you do not need.
        * Check the hidden columns you want displayed.
        * To reorder columns, click ![image](../../../_assets/console-icons/grip.svg) to the left of the column name and drag the column up or down to a new position in the list.
  
     1. Click **Apply**.

  1. Perform this search:

      * In the search bar above the metadata list, enter the entity's name or name description (fully or partially).

        To search only for particular data types, select them from the list next to the search bar. The search will return only the selected entity types.

      * Click **{{ ui-key.yacloud.data-catalog.label_search-button-add-filter }}** above the metadata list and select a filter:
         * **Glossary**: Select one or more glossaries and click **{{ ui-key.yacloud.common.save }}**. The search will return metadata marked up with terms from the selected glossaries.
         * **Domain**: Select one or more domains and click **{{ ui-key.yacloud.common.save }}**. The search will return metadata marked up with the selected domains.
         * **Classification**: Select one or more classifications and click **{{ ui-key.yacloud.common.save }}**. The search will return metadata marked up with tags of the selected classifications.
         * **Tag**: Select one or more tags and click **{{ ui-key.yacloud.common.save }}**. The search will return metadata marked up with the selected tags.
         * **Term**: Select one or more terms and click **{{ ui-key.yacloud.common.save }}**. The search will return metadata marked up with the selected terms.

         You can specify multiple search criteria by clicking **{{ ui-key.yacloud.data-catalog.label_search-button-add-filter }}** again.

         To remove all filters, click **{{ ui-key.yacloud.common.clear }}**.

         You can share your filter with other users by clicking **{{ ui-key.yacloud.data-catalog.label_search-action-share }}**.

{% endlist %}
