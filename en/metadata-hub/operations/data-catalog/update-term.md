# Updating a term

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog with the glossary containing the term you want to update.
  1. Go to the ![image](../../../_assets/console-icons/book.svg) **Terms and glossaries** tab and click the row with your glossary.  
  1. In the term list, click ![image](../../../_assets/console-icons/ellipsis.svg) next to the term and select **{{ ui-key.yacloud.common.edit }}**.

      {% include [search-tip](../../../_includes/metadata-hub/tip-search-term.md) %}

  1. Edit the term properties:

     * In the **{{ ui-key.yacloud.common.name }}** field, specify a new unique name for the term.
     * Optionally, edit the term description.
     * Optionally, in the **Synonyms** field, add or delete one or more synonyms for the term:
        * Click **Add**, type a new synonym, and press **Enter**.
        * Next to the synonym you want to delete, click ![image](../../../_assets/console-icons/xmark.svg).
     * Optionally, in the **Related terms** field, add or delete closely related terms in this glossary:
        * Click **Add**, select the terms you need in the window that opens, and click **Add terms**.
        * To remove a related term, click ![image](../../../_assets/console-icons/xmark.svg) to the right of the term or select multiple terms and click **{{ ui-key.yacloud.common.delete }}** at the bottom.

  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}
