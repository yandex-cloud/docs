# Разметка хранилища данных

{% note info %}

Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

Для разметки хранилища данных вы можете выполнить следующие действия:

* [назначить домен](#assign-domain);
* [изменить термины](#change-terms);
* [изменить теги](#change-tags);
* [изменить описание](#change-description).

## Назначить домен {#assign-domain}

Чтобы назначить или изменить домен для одного или нескольких хранилищ данных:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, содержащий нужные хранилища данных.
  1. На панели слева выберите ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_data-store }}**.
  1. Чтобы назначить домен для одного хранилища данных:
      1. Нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужным хранилищем и выберите **{{ ui-key.yacloud.data-catalog.action_set-domain }}**. Если домен уже назначен и его нужно изменить, выберите **{{ ui-key.yacloud.data-catalog.action_edit-domain }}**.
      1. Выберите нужный домен из списка и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  1. Чтобы назначить или изменить домен для нескольких хранилищ данных:
      1. Выберите одно или несколько хранилищ и на панели снизу нажмите **{{ ui-key.yacloud.data-catalog.action_set-domain }}**.
      1. Выберите нужный домен из списка и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

  {% note info %}
  
  Если включена AI-разметка метаданных, AI-ассистент создает домены автоматически, а также размечает с их помощью ваши метаданные. Предложенные ассистентом домены можно подтвердить, отредактировать или отклонить. Для этого наведите курсор на значок **{{ ui-key.yacloud.data-catalog.label_ai-label }}** рядом с предложением ассистента и выберите нужное действие.
  
  Включить AI-разметку можно при [изменении](update-catalog.md) каталога метаданных или на его странице **{{ ui-key.yacloud.common.overview }}**.
  
  
  {% endnote %}

{% endlist %}

## Изменить термины {#change-terms}

Чтобы назначить или изменить термины для одного или нескольких хранилищ данных:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, содержащий нужные хранилища данных.
  1. На панели слева выберите ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_data-store }}**.
  1. Выберите одно или несколько хранилищ данных и на панели снизу нажмите **{{ ui-key.yacloud.data-catalog.label_add-terms }}**.
  1. Выберите нужные термины из списка и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

  {% note info %}
  
  Если включена AI-разметка метаданных, AI-ассистент создает глоссарии и термины автоматически, а также размечает с их помощью ваши метаданные. Предложенные ассистентом глоссарии и термины можно подтвердить, отредактировать или отклонить. Для этого наведите курсор на значок **{{ ui-key.yacloud.data-catalog.label_ai-label }}** рядом с предложением ассистента и выберите нужное действие.
  
  Включить AI-разметку можно при [изменении](update-catalog.md) каталога метаданных или на его странице **{{ ui-key.yacloud.common.overview }}**.
  
  
  {% endnote %}
  
{% endlist %}

## Изменить теги {#change-tags}

Чтобы назначить или изменить теги для одного или нескольких хранилищ данных:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, содержащий нужные хранилища данных.
  1. На панели слева выберите ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_data-store }}**.
  1. Выберите одно или несколько хранилищ данных и на панели снизу нажмите **{{ ui-key.yacloud.data-catalog.label_add-tags }}**.
  1. Выберите нужные теги из списка и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

  {% note info %}
  
  Если включена AI-разметка метаданных, AI-ассистент создает классификации и теги автоматически, а также размечает с их помощью ваши метаданные. Предложенные ассистентом классификации и теги можно подтвердить, отредактировать или отклонить. Для этого наведите курсор на значок **{{ ui-key.yacloud.data-catalog.label_ai-label }}** рядом с предложением ассистента и выберите нужное действие.
  
  Включить AI-разметку можно при [изменении](update-catalog.md) каталога метаданных или на его странице **{{ ui-key.yacloud.common.overview }}**.
  
  
  {% endnote %}
  
{% endlist %}

## Изменить описание {#change-description}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, содержащий нужное хранилище данных.
  1. На панели слева выберите ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_data-store }}**.
  1. Нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке нужного хранилища и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените поле **Описание** и нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}