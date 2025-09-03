# Изменение термина


{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных с глоссарием, в котором вы хотите изменить термин.
  1. На панели слева выберите ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_terms-and-glossaries }}** и нажмите на строку с нужным глоссарием.  
  1. В списке терминов нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужным термином и выберите **{{ ui-key.yacloud.common.edit }}**.

      {% include [search-tip](../../../_includes/metadata-hub/tip-search-term.md) %}

  1. Измените параметры термина:

     * В поле **{{ ui-key.yacloud.common.name }}** задайте новое уникальное имя термина.
     * (Опционально) Измените описание термина.
     * (Опционально) В поле **{{ ui-key.yacloud.data-catalog.label_term-synonyms }}** добавьте или удалите один или несколько синонимов термина:
        * Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_term-synonyms-add }}**, введите новый синоним и нажмите **Enter**.
        * Справа от синонима, который вы хотите удалить, нажмите ![image](../../../_assets/console-icons/xmark.svg) .
     * (Опционально) В поле **{{ ui-key.yacloud.data-catalog.label_connected-terms }}** добавьте или удалите близкие по смыслу термины этого глоссария:
        * Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_add }}**, в открывшемся окне выберите нужные термины и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
        * Нажмите ![image](../../../_assets/console-icons/xmark.svg) справа от термина, связь с которым вы хотите удалить, или выделите сразу несколько терминов и нажмите внизу кнопку **{{ ui-key.yacloud.common.delete }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}
