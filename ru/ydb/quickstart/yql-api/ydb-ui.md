# Работа с данными через консоль управления

После [создания базы данных](../create-db.md) выполните базовые YQL-запросы используя консоль управления {{ yandex-cloud }}.

{% note tip %}

Подробнее о синтаксисе YQL читайте в [Справочнике YQL](../../yql/reference/overview.md).

{% endnote %}

## Создайте таблицу {#create-table}

Создайте таблицу в БД с помощью инструкции [CREATE TABLE](../../yql/reference/syntax/create_table.md):

{% list tabs %}

- Консоль управления

  {% include [create-schema-via-console](../../_includes/create-new-table-via-console.md) %}

{% endlist %}

## Добавьте данные {#replace-data}

Добавьте данные в таблицу, используя инструкцию [REPLACE INTO](../../yql/reference/syntax/replace_into.md):

{% list tabs %}

- Консоль управления

  {% include [replace-data-via-console](../../_includes/replace-data-via-console.md) %}

{% endlist %}

{% if audience == "internal" %}

![Table preview](../../../_assets/ydb/db_ui_table_preview.png)

{% endif %}

## Измените данные {#update-data}

Измените существующие данные в таблице, используя инструкцию [UPDATE](../../yql/reference/syntax/update.md):

{% list tabs %}

- Консоль управления

  {% include [update-data-via-console](../../_includes/update-data-via-console.md) %}

{% endlist %}

{% if audience == "internal" %}

![Update preview](../../../_assets/ydb/db_ui_run_update.png)

{% endif %}

## Удалите данные {#delete-data}

Удалите данные из таблицы с помощью инструкции [DELETE](../../yql/reference/syntax/delete.md):

{% list tabs %}

- Консоль управления

  {% include [delete-data-via-console](../../_includes/delete-data-via-console.md) %}

{% endlist %}

{% if audience == "internal" %}

![Delete preview](../../../_assets/ydb/db_ui_run_delete.png)

{% endif %}

## Запросите данные {#select-data}

Запросите данные из таблицы с помощью инструкции [SELECT](../../yql/reference/syntax/select.md):

{% list tabs %}

- Консоль управления

  {% include [select-data-via-console](../../_includes/select-data-via-console.md) %}

{% endlist %}

{% if audience == "internal" %}

![Select from table](../../../_assets/ydb/db_ui_run_select.png)

{% endif %}

## Удалите таблицу {#drop-table}

Удалите таблицу с помощью инструкции [DROP TABLE](../../yql/reference/syntax/drop_table.md):

{% list tabs %}

- Консоль управления

  {% include [drop-table-via-console](../../_includes/drop-table-via-console.md) %}

{% endlist %}
