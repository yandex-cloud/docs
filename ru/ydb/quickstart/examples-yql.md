# Примеры YQL-запросов

После [создания базы](create-db.md) выполните базовые YQL-запросы.

Подробнее о синтаксисе YQL читайте в [Справочнике YQL](../yql/reference/overview.md).

## Создайте таблицу {#create-table}

Чтобы начать работать с базой, создайте новую таблицу с помощью конструкции [CREATE TABLE](../yql/reference/syntax/create_table.md):

{% include [create-schema-via-console](../_includes/create-schema-via-console.md) %}

## Добавьте строки {#replace-data}

Добавьте новые данные в таблицу с помощью конструкции [REPLACE INTO](../yql/reference/syntax/replace_into.md):

{% include [replace-data-via-console](../_includes/replace-data-via-console.md) %}


## Замените строки {#update-data}

Замените существующие данные в таблице с помощью оператора [UPDATE](../yql/reference/syntax/update.md):

{% include [update-data-via-console](../_includes/update-data-via-console.md) %}


## Удалите строки {#delete-data}

Удалите данные из таблицы с помощью оператора [DELETE](../yql/reference/syntax/delete.md):

{% include [delete-data-via-console](../_includes/delete-data-via-console.md) %}


## Выберите строки {#select-data}

Выберите данные из таблицы с помощью оператора [SELECT](../yql/reference/syntax/select.md):

{% include [select-data-via-console](../_includes/select-data-via-console.md) %}


## Удалите таблицу {#drop-table}

Удалите таблицу с помощью конструкции [DROP TABLE](../yql/reference/syntax/drop_table.md):

{% include [drop-table-via-console](../_includes/drop-table-via-console.md) %}