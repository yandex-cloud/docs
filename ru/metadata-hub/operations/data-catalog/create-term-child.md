# Создание дочернего термина

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором вы хотите создать термин.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/book.svg) **Термины и глоссарии**.
  1. Выберите глоссарий с термином, для которого вы хотите создать дочерний термин.
  1. В списке терминов нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужным термином и выберите **Создать термин**.

      {% include [search-tip](../../../_includes/metadata-hub/tip-search-term.md) %}

  1. Задайте параметры термина:

      {% include [term-properties](../../../_includes/metadata-hub/term-properties.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
