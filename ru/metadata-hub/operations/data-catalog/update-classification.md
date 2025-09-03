# Изменение классификации


{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором вы хотите изменить классификацию.
  1. На панели слева выберите ![image](../../../_assets/console-icons/tag.svg) **{{ ui-key.yacloud.data-catalog.label_tags-and-classification }}**.
  1. В списке классификаций нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужной классификацией и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** задайте новое уникальное имя классификации.
  1. (Опционально) Измените описание классификации.
  1. (Опционально) Включите или выключите опцию **{{ ui-key.yacloud.data-catalog.label_tag-mutual-exclusion }}**.

      Если опция включена, то на любой ресурс {{ data-catalog-name }} можно будет назначить не более одного тега классификации.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}
