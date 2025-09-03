# Удаление термина


{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}


Перед удалением термина [удалите](delete-term-child.md) все его дочерние термины.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором вы хотите удалить термин.
  1. На панели слева выберите ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_terms-and-glossaries }}** и выберите глоссарий, который содержит нужный термин.
  1. В списке терминов нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужным термином и выберите **{{ ui-key.yacloud.common.delete }}**.

      {% include [search-tip](../../../_includes/metadata-hub/tip-search-term.md) %}

  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}
