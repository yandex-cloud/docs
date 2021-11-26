# ALTER TABLE

Модифицирует схему созданной таблицы или добавляет/удаляет вторичные индексы:

## Добавление/удаление столбцов в таблицу {#alter-columns}

```sql
ALTER TABLE episodes ADD COLUMN viewers Uint64;

ALTER TABLE episodes DROP COLUMN viewers;
```

Для ключевых и неключевых столбцов допускаются только [примитивные](../types/primitive.md) типы данных.


## Добавление/удаление вторичных индексов {#alter-index}

```sql
ALTER TABLE `series` ADD INDEX `title_index` GLOBAL [SYNC|ASYNC] ON (`title`);
```

При необходимости можно продублировать данные в индекс, использовав ключевое слово COVER:

```sql
ALTER TABLE `series` ADD INDEX `title_index` GLOBAL [SYNC|ASYNC] ON (`title`) COVER(`release_date`);
```

Удавление вторичного индекса.

```sql
ALTER TABLE `series` DROP INDEX `title_index`;
```

{% note warning %}

Отменить построение вторичного индекса средствами YQL невозможно, при необходимости используйте {{ ydb-short-name }} CLI.

{% endnote %}

{% note info %}

Если не указать тип индекса, то по умолчанию будет создан синхронный индекс.

{% endnote %}



Про вторичные индексы Вы можете прочитать больше [тут](../../../oss/public/develop/concepts/secondary_indexes.md)

а также [тут](../../../oss/public/develop/best_practices/secondary_indexes.md)