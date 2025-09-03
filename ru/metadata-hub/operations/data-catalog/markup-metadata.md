# Разметка метаданных

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

Для разметки метаданных вы можете:

* [назначить домены](#assign-domains);
* [изменить термины](#change-terms);
* [изменить теги](#change-tags);
* [изменить описание метаданных](#change-metadata-description).

## Назначение доменов {#assign-domains}

Вы можете назначить [домены](../../concepts/data-catalog.md#domains-and-subdomains) всем метаданным.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных.
  1. На панели слева выберите ![image](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}**.
  1. Чтобы назначить домен одному объекту:
     1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужным объектом и выберите **{{ ui-key.yacloud.data-catalog.action_set-domain }}**. Если домен уже назначен и его нужно изменить, нажмите **{{ ui-key.yacloud.data-catalog.action_edit-domain }}**.
     1. Выберите нужный домен из списка во всплывающем окне и нажмите **{{ ui-key.yacloud.common.save }}**.
  1. Чтобы назначить или изменить домен для нескольких объектов
     1. Выберите в колонке слева нужные объекты.
     1. На панели внизу нажмите **{{ ui-key.yacloud.data-catalog.action_set-domain }}**.
     1. Выберите нужный домен из списка во всплывающем окне и нажмите **{{ ui-key.yacloud.common.save }}**.

  {% include [search-tip](../../../_includes/metadata-hub/tip-search.md) %}

{% endlist %}

## Изменение терминов {#change-terms}

Вы можете изменить [термины](../../concepts/data-catalog.md#glossaries-and-terms) для всех метаданных.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных.
  1. На панели слева выберите ![image](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}**.
  1. Чтобы добавить или изменить термины для одного объекта:
     1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужным объектом и выберите **{{ ui-key.yacloud.data-catalog.label_add-terms }}**.
     1. Выберите нужные термины из списка во всплывающем окне и нажмите **{{ ui-key.yacloud.common.save }}**.
  1. Чтобы добавить или изменить термины для нескольких объектов:
     1. Выберите в колонке слева нужные объекты.
     1. На панели внизу нажмите **{{ ui-key.yacloud.data-catalog.label_add-terms }}**.
     1. Выберите нужные термины из списка во всплывающем окне и нажмите **{{ ui-key.yacloud.common.save }}**.

  {% include [search-tip](../../../_includes/metadata-hub/tip-search.md) %}

{% endlist %}

## Изменение тегов {#change-tags}

Вы можете изменить [теги](../../concepts/data-catalog.md#classifications-and-tags) для метаданных, а также доменов, глоссариев и терминов.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных.
  1. На панели слева выберите ![image](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}**.
  1. Чтобы добавить или изменить теги для одного объекта:
     1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужным объектом и выберите **{{ ui-key.yacloud.data-catalog.label_add-tags }}**.
     1. Выберите нужные теги из списка во всплывающем окне и нажмите **{{ ui-key.yacloud.common.save }}**.
  1. Чтобы добавить или изменить теги для нескольких объектов:
     1. Выберите в колонке слева нужные объекты.
     1. На панели внизу нажмите **{{ ui-key.yacloud.data-catalog.label_add-tags }}**.
     1. Выберите нужные термины из списка во всплывающем окне и нажмите **{{ ui-key.yacloud.common.save }}**.

  {% include [search-tip](../../../_includes/metadata-hub/tip-search.md) %}

{% endlist %}

## Изменение описания метаданных {#change-metadata-description}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных.
  1. На панели слева выберите ![image](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}**.
  1. Нажмите на нужный объект в списке.
  1. Чтобы изменить описание объекта с типом, предназначенным для разметки метаданных (тег, термин, классификация, глоссарий, домен), нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.

     Чтобы изменить описание объекта с другим типом, нажмите на верхней панели **{{ ui-key.yacloud.common.edit }}**.

     Чтобы изменить описание колонки таблицы (тип объекта **Набор данных**), перейдите на вкладку **Схема**, нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с именем нужной колонки и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Введите описание и нажмите **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}
