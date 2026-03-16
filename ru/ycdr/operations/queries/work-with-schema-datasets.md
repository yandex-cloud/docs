---
title: Работа со схемой базы и датасетами в {{ ycdr-full-name }}
description: Следуя данной инструкции, вы научитесь работать со схемой базы данных и датасетами в {{ ycdr-name }}.
---

# Работа со схемой базы и датасетами

{% include [preview-by-request](../../../_includes/note-preview-by-request.md) %}

## Работа со схемой базы {#database-schema}

Вкладка **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.tab-schema_sChm1 }}** содержит иерархическую структуру всех доступных полей в базе данных.

### Просмотр полей {#view-fields}

Чтобы просмотреть поля:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте панель **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.title_xK9v2 }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.tab-schema_sChm1 }}**.
  1. Разверните нужные разделы, нажимая на стрелки.

  Для каждого поля отображается:
  * название;
  * тип данных.

{% endlist %}

### Поиск по полям {#search-fields}

Чтобы найти поле:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте вкладку **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.tab-schema_sChm1 }}**.
  1. Введите название в поле **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.schema-search-placeholder_sSrch }}**.
  1. Результаты отобразятся автоматически.

{% endlist %}

### Вставка поля в запрос {#insert-field}

Чтобы вставить поле в запрос:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Нажмите на нужное поле в схеме базы данных.
  1. Выберите **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.schema-insert-action_iNs1A }}**.

  Название поля будет добавлено в редактор запросов в позицию курсора.

{% endlist %}

## Работа с датасетами {#datasets}

Вкладка **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.tab-datasets_dSt4K }}** содержит список доступных датасетов и Lookup-таблиц.

### Просмотр датасетов {#view-datasets}

Чтобы просмотреть датасеты:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте панель данных.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.tab-datasets_dSt4K }}**.
  1. Выберите датасет из списка.

  Для каждого датасета отображается:
  * название;
  * описание;
  * список полей с типами данных.

{% endlist %}

### Lookup-таблицы {#lookup-tables}

**{{ ui-key.yacloud_org.security.ycdr.query-data-panel.datasets-type-lookup_dTpLk }}** — это справочные таблицы для обогащения данных. Они отображаются в отдельном разделе на вкладке датасетов.

Чтобы просмотреть {{ ui-key.yacloud_org.security.ycdr.query-data-panel.datasets-type-lookup_dTpLk }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте вкладку **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.tab-datasets_dSt4K }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.datasets-type-lookup_dTpLk }}**.
  1. Выберите таблицу из списка.

{% endlist %}

### Вставка датасета в запрос {#insert-dataset}

Чтобы вставить датасет в запрос:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Найдите нужный датасет.
  1. Нажмите на датасет.
  1. Выберите **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.schema-insert-action_iNs1A }}**.

  Название датасета будет добавлено в редактор запросов.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/investigations.md).
* [{#T}](../../concepts/queries.md).
* [{#T}](manage-queries.md).
* [{#T}](work-with-templates.md).