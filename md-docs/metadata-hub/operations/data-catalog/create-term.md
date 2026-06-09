# Создание термина


{% note info %}

Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором вы хотите создать термин.
  1. На панели слева выберите ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_terms-and-glossaries }}**.
  1. Выберите глоссарий, в котором вы хотите создать термин, или создайте новый глоссарий.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-term-action }}**.
  1. Задайте параметры термина:

      * В поле **{{ ui-key.yacloud.common.name }}** укажите уникальное имя термина.
      * (Опционально) Добавьте описание термина.
      * (Опционально) В поле **{{ ui-key.yacloud.data-catalog.label_term-synonyms }}** добавьте один или несколько синонимов термина. Чтобы удалить добавленный синоним, справа от него нажмите ![xmark](../../../_assets/console-icons/xmark.svg).
      
      * (Опционально) В поле **{{ ui-key.yacloud.data-catalog.label_connected-terms }}** нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_add }}**, в открывшемся окне выберите близкие по смыслу термины этого глоссария и нажмите кнопку **{{ ui-key.yacloud.common.save }}**. Чтобы удалить добавленный термин, справа от него нажмите ![xmark](../../../_assets/console-icons/xmark.svg).

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  {% note info %}
  
  Если включена AI-разметка метаданных, AI-ассистент создает глоссарии и термины автоматически, а также размечает с их помощью ваши метаданные. Предложенные ассистентом глоссарии и термины можно подтвердить, отредактировать или отклонить. Для этого наведите курсор на значок **{{ ui-key.yacloud.data-catalog.label_ai-label }}** рядом с предложением ассистента и выберите нужное действие.
  
  Включить AI-разметку можно при [изменении](update-catalog.md) каталога метаданных или на его странице **{{ ui-key.yacloud.common.overview }}**.
  
  
  {% endnote %}

{% endlist %}