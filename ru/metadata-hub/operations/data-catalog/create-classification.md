# Создание классификации

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором вы хотите создать классификацию.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/tag.svg) **Теги и классификации**.
  1. Нажмите кнопку **Создать классификацию**.
  1. В поле **{{ ui-key.yacloud.common.name }}** задайте уникальное имя классификации.
  1. (Опционально) Добавьте описание классификации.
  1. (Опционально) Выберите опцию **Взаимоисключение**.

      Если опция включена, то на любой ресурс {{ data-catalog-name }} можно будет назначить не более одного тега классификации.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
