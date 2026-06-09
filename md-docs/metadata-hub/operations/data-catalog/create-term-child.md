# Создание дочернего термина


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
  1. Выберите глоссарий с термином, для которого вы хотите создать дочерний термин.
  1. В списке терминов нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужным термином и выберите **{{ ui-key.yacloud.data-catalog.label_create-term-action }}**.

      {% note tip %}
      
      Чтобы найти термин, введите его идентификатор или имя в поисковой строке над списком терминов.
      
      {% endnote %}

  1. Задайте параметры термина:

      * В поле **{{ ui-key.yacloud.common.name }}** укажите уникальное имя термина.
      * (Опционально) Добавьте описание термина.
      * (Опционально) В поле **{{ ui-key.yacloud.data-catalog.label_term-synonyms }}** добавьте один или несколько синонимов термина. Чтобы удалить добавленный синоним, справа от него нажмите ![xmark](../../../_assets/console-icons/xmark.svg).
      
      * (Опционально) В поле **{{ ui-key.yacloud.data-catalog.label_connected-terms }}** нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_add }}**, в открывшемся окне выберите близкие по смыслу термины этого глоссария и нажмите кнопку **{{ ui-key.yacloud.common.save }}**. Чтобы удалить добавленный термин, справа от него нажмите ![xmark](../../../_assets/console-icons/xmark.svg).

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}