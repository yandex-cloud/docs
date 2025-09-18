# Creating a child term


{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog you want to create a term in.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_terms-and-glossaries }}**.
  1. Select the glossary containing the term you want to create a child term for.
  1. In the term list, click ![image](../../../_assets/console-icons/ellipsis.svg) next to the term and select **{{ ui-key.yacloud.data-catalog.label_create-term-action }}**.

      {% include [search-tip](../../../_includes/metadata-hub/tip-search-term.md) %}

  1. Set up the term:

      {% include [term-properties](../../../_includes/metadata-hub/term-properties.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
