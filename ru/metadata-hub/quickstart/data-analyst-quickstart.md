---
title: Начало работы с {{ data-catalog-full-name }} для аналитика метаданных
description: Следуя данному руководству, вы начнете работу с {{ data-catalog-name }} в роли аналитика метаданных.
---

# Начало работы для аналитика метаданных



{% include notitle [preview](../../_includes/note-preview.md) %}



Работая с {{ data-catalog-full-name }} в роли аналитика метаданных, вы можете анализировать и визуализировать метаданные об объектах {{ yandex-cloud }} и связях между ними.

Чтобы начать работу с сервисом:

1. [Просмотрите каталог метаданных](#open-data-catalog).
1. [Просмотрите информацию о метаданных](#view-metadata).
1. [Найдите метаданные](#search-data) при помощи поиска.
1. [Настройте фильтры для метаданных](#create-filters).
1. [Просмотрите размеченные ресурсы](#view-markup-data).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Получите у администратора вашего рабочего облака или организации доступ к каталогу ресурсов, в котором ведется работа с метаданными.

1. Убедитесь, что у вашего аккаунта есть роль `data-catalog.dataConsumer` на рабочий каталог для просмотра и обновления ресурсов {{ data-catalog-name }}.

    Если нужной роли нет, обратитесь к администратору каталога метаданных, вашего облака или организации.

1. Уточните у администратора вашего облака или организации, в каком каталоге метаданных вам нужно работать.

## Просмотрите каталог метаданных {#open-data-catalog}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите ваш рабочий каталог ресурсов.
  1. [Перейдите]({{ link-console-main }}/link/metadata-hub) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. В блоке **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}** выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. Выберите нужный [каталог метаданных](*каталог).
  1. Чтобы просмотреть доступные в каталоге метаданные, перейдите на вкладку **{{ ui-key.yacloud.data-catalog.layout.label.search-new-layout_Y7pK2 }}**.

{% endlist %}

## Просмотрите информацию о метаданных {#view-metadata}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите ваш рабочий каталог метаданных.
  1. Перейдите на вкладку **{{ ui-key.yacloud.data-catalog.layout.label.search-new-layout_Y7pK2 }}** и выберите нужный набор данных.
  1. Чтобы просмотреть общую информацию о наборе данных, перейдите на вкладку **{{ ui-key.yacloud.common.overview }}** и разверните список с нужными параметрами.
  1. Чтобы просмотреть схему объекта, перейдите на вкладку **Схема** и выберите в выпадающем списке нужную версию схемы.
  1. Чтобы просмотреть связи с другими объектами, перейдите на вкладку **Связи**.

     Вы можете выбрать глубину отображения связей, а также включить или отключить опцию **{{ ui-key.yacloud.data-catalog.label_asset-lineage-weak }}**.

     {{ data-catalog-name }} отображает связи не только между объектами, но и между отдельными колонками внутри объектов. Чтобы просмотреть связи между колонками, разверните список колонок в нужном объекте.

  1. Чтобы просмотреть запросы к данным, перейдите на вкладку **{{ ui-key.yacloud.data-catalog.label_source-queries-tab }}**.

{% endlist %}

## Найдите метаданные при помощи поиска {#search-data}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите ваш рабочий каталог метаданных.
  1. Перейдите на вкладку **{{ ui-key.yacloud.data-catalog.layout.label.search-new-layout_Y7pK2 }}**.
  1. По умолчанию поиск ведется по всем типам данных. Если вам нужны только определенные типы данных, в выпадающем списке слева от поисковой строки выберите нужные типы данных.
  1. В поле **{{ ui-key.yacloud.data-catalog.label_search-placeholder }}** введите поисковый запрос.
  1. Чтобы повысить релевантность поисковой выдачи, уточните поисковый запрос и [настройте фильтры метаданных](#create-filters).

     Количество доступных фильтров зависит от выбранных типов данных. Если вы работаете с несколькими типами данных одновременно, будут доступны только фильтры, которые применимы ко всем выбранным типам данных.

     Более точный выбор типов может увеличить количество доступных фильтров.

  {% include [ai-search-on](../../_includes/metadata-hub/data-catalog-ai-search.md) %}

{% endlist %}

## Настройте фильтры для метаданных {#create-filters}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите ваш рабочий каталог метаданных.
  1. Перейдите на вкладку **{{ ui-key.yacloud.data-catalog.layout.label.search-new-layout_Y7pK2 }}**.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.data-catalog.label_search-button-add-filter }}**.
  1. Отфильтруйте метаданные по одному или нескольким созданным в каталоге [тегам](*тег).

     Вы также можете добавлять другие фильтры. Количество доступных фильтров зависит от типа данных, выбранных в списке слева от поисковой строки. Если вы работаете с несколькими типами данных одновременно, будут доступны только фильтры, которые применимы ко всем выбранным типам данных.

     Более точный выбор типов может увеличить количество доступных фильтров.

{% endlist %}

## Просмотрите размеченные ресурсы {#view-markup-data}

### Домены {#domain-markup}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите ваш рабочий каталог метаданных.
  1. Перейдите на вкладку **{{ ui-key.yacloud.data-catalog.label_domains }}**.
  1. Выберите в списке нужный [домен](*домен) или [поддомен](*поддомен).
  1. Перейдите на вкладку **{{ ui-key.yacloud.data-catalog.layout.label.search-new-layout_Y7pK2 }}**. На ней отобразится список наборов данных, которые размечены текущим доменом или содержат поля, размеченные текущим доменом.
  1. Чтобы найти в списке конкретные данные, введите запрос в поисковой строке над списком данных.
  1. Чтобы перейти в набор данных, нажмите на его имя в списке.

{% endlist %}

### Термины {#term-markup}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите ваш рабочий каталог метаданных.
  1. Перейдите на вкладку **{{ ui-key.yacloud.data-catalog.label_terms-and-glossaries }}**.
  1. Выберите в списке [глоссарий](*глоссарий), которому принадлежит нужный.
  1. Выберите в списке нужный [термин](*термин).
  1. Перейдите на вкладку **{{ ui-key.yacloud.data-catalog.layout.label.search-new-layout_Y7pK2 }}**. На ней отобразится список наборов данных, которые размечены текущим термином или содержат поля, размеченные текущим термином.
  1. Чтобы найти в списке конкретные данные, введите запрос в поисковой строке над списком данных.
  1. Чтобы перейти в набор данных, нажмите на его имя в списке.

{% endlist %}

### Теги {#tags-markup}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите ваш рабочий каталог метаданных.
  1. Перейдите на вкладку **{{ ui-key.yacloud.data-catalog.label_tags-and-classification }}**.
  1. Выберите в списке [классификацию](*классификация), которой принадлежит нужный тег.
  1. Выберите в списке нужный [тег](*тег). На странице тега отобразится список наборов данных, которые размечены текущим тегом или содержат поля, размеченные текущим тегом.
  1. Чтобы найти в списке конкретные данные, введите запрос в поисковой строке над списком данных.
  1. Чтобы перейти в набор данных, нажмите на его имя в списке.

{% endlist %}

## Что дальше {#what-is-next}

* [Создайте термин](../operations/data-catalog/create-term.md) в глоссарии.
* [Создайте дочерний термин](../operations/data-catalog/create-term-child.md).
* [Измените глоссарий](../operations/data-catalog/update-glossary.md).
* [Измените термин в глоссарии](../operations/data-catalog/update-term.md).
* [Создайте тег](../operations/data-catalog/create-tag.md) в классификации.
* [Измените классификацию](../operations/data-catalog/update-classification.md).
* [Измените тег](../operations/data-catalog/update-tag.md) в классификации.

#### Полезные ссылки {#see-also}

[{#T}](./data-steward-quickstart.md)

[*глоссарий]: {% include notitle [glossary](../../_popups/metadata-hub/data-catalog.md#glossary) %}

[*домен]: {% include notitle [domain](../../_popups/metadata-hub/data-catalog.md#domain) %}

[*загрузка]: {% include notitle [ingestion](../../_popups/metadata-hub/data-catalog.md#ingestion) %}

[*каталог]: {% include notitle [catalog](../../_popups/metadata-hub/data-catalog.md#catalog) %}

[*классификация]: {% include notitle [classification](../../_popups/metadata-hub/data-catalog.md#classification) %}

[*поддомен]: {% include notitle [subdomain](../../_popups/metadata-hub/data-catalog.md#subdomain) %}

[*тег]: {% include notitle [tag](../../_popups/metadata-hub/data-catalog.md#tag) %}

[*термин]: {% include notitle [term](../../_popups/metadata-hub/data-catalog.md#term) %}

[*хранилище]: {% include notitle [data-store](../../_popups/metadata-hub/data-catalog.md#data-store) %}
