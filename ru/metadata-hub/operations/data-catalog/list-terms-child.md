# Получение списка дочерних терминов

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором созданы термины.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/book.svg) **Термины и глоссарии** и выберите глоссарий, в котором созданы термины.
  1. В списке терминов выберите термин, для которого вы хотите получить список дочерних терминов.

     {% include [search-tip](../../../_includes/metadata-hub/tip-search-term.md) %}

  1. На странице термина перейдите на вкладку **Термины**.

{% endlist %}

## Настройка списка дочерних терминов {#setting-list-terms}

{% include [list-search](../../../_includes/metadata-hub/search-sort-list-terms.md) %}

{% include [list-display](../../../_includes/metadata-hub/display-columns.md) %}
