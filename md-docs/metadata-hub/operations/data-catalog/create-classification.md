# Создание классификации


{% note info %}

Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором вы хотите создать классификацию.
  1. На панели слева выберите ![image](../../../_assets/console-icons/tag.svg) **{{ ui-key.yacloud.data-catalog.label_tags-and-classification }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-classification-action }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** задайте уникальное имя классификации.
  1. (Опционально) Добавьте описание классификации.
  1. (Опционально) Выберите опцию **{{ ui-key.yacloud.data-catalog.label_tag-mutual-exclusion }}**.

      Если опция включена, то на любой ресурс {{ data-catalog-name }} можно будет назначить не более одного тега классификации.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  {% note info %}
  
  Если включена AI-разметка метаданных, AI-ассистент создает классификации и теги автоматически, а также размечает с их помощью ваши метаданные. Предложенные ассистентом классификации и теги можно подтвердить, отредактировать или отклонить. Для этого наведите курсор на значок **{{ ui-key.yacloud.data-catalog.label_ai-label }}** рядом с предложением ассистента и выберите нужное действие.
  
  Включить AI-разметку можно при [изменении](update-catalog.md) каталога метаданных или на его странице **{{ ui-key.yacloud.common.overview }}**.
  
  
  {% endnote %}

{% endlist %}