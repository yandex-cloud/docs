# Создание глоссария


{% note info %}

Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором вы хотите создать глоссарий.
  1. На панели слева выберите ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_terms-and-glossaries }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-glossary-action }}**.
  1. Задайте параметры глоссария:

      * В поле **{{ ui-key.yacloud.common.name }}** задайте уникальное имя глоссария.
      * (Опционально) Добавьте описание глоссария.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  {% note info %}
  
  Если включена AI-разметка метаданных, AI-ассистент создает глоссарии и термины автоматически, а также размечает с их помощью ваши метаданные. Предложенные ассистентом глоссарии и термины можно подтвердить, отредактировать или отклонить. Для этого наведите курсор на значок **{{ ui-key.yacloud.data-catalog.label_ai-label }}** рядом с предложением ассистента и выберите нужное действие.
  
  Включить AI-разметку можно при [изменении](update-catalog.md) каталога метаданных или на его странице **{{ ui-key.yacloud.common.overview }}**.
  
  
  {% endnote %}

{% endlist %}