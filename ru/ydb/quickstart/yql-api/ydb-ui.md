---
sourcePath: overlay/quickstart/yql-api/ydb-ui.md
---
# Работа с данными через консоль управления

После [создания базы данных](../create-db.md) выполните базовые YQL-запросы используя консоль управления Yandex.Cloud.

{% note tip %}

Подробнее о синтаксисе YQL читайте в [Справочнике YQL](../../yql/reference/index.md).

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


## Измените данные {#update-data}

Измените существующие данные в таблице, используя инструкцию [UPDATE](../../yql/reference/syntax/update.md):

{% list tabs %}

- Консоль управления

  {% include [update-data-via-console](../../_includes/update-data-via-console.md) %}

{% endlist %}


## Удалите данные {#delete-data}

Удалите данные из таблицы с помощью инструкции [DELETE](../../yql/reference/syntax/delete.md):

{% list tabs %}

- Консоль управления

  {% include [delete-data-via-console](../../_includes/delete-data-via-console.md) %}

{% endlist %}


## Запросите данные {#select-data}

Запросите данные из таблицы с помощью инструкции [SELECT](../../yql/reference/syntax/select.md):

{% list tabs %}

- Консоль управления

  {% include [select-data-via-console](../../_includes/select-data-via-console.md) %}

{% endlist %}


## Удалите таблицу {#drop-table}

Удалите таблицу с помощью инструкции [DROP TABLE](../../yql/reference/syntax/drop_table.md):

{% list tabs %}

- Консоль управления

  {% include [drop-table-via-console](../../_includes/drop-table-via-console.md) %}

{% endlist %}
