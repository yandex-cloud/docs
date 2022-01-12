---
sourcePath: core/yql/reference/yql-docs-core-2/syntax/_includes/alter_table.md
sourcePath: yql/reference/yql-docs-core-2/syntax/_includes/alter_table.md
---

# ALTER TABLE

При помощи команды ```ALTER TABLE``` можно изменить состав колонок и дополнительные параметры таблицы. В одной команде можно указать несколько действий. В общем случае команда ```ALTER TABLE``` выглядит так:

```sql
ALTER TABLE table_name action1, action2, ..., actionN;
```

```action``` — это любое действие по изменению таблицы, из описанных ниже.

## Изменение состава колонок {#columns}

YDB поддерживает возможность добавлять столбцы в таблицу, а также удалять неключевые колонки из таблицы.

```ADD COLUMN``` — добавляет столбец с указанными именем и типом. Приведенный ниже код добавит к таблице ```episodes``` столбец ```is_deleted``` с типом данных ```Bool```.

```sql
ALTER TABLE episodes ADD COLUMN is_deleted Bool;
```

```DROP COLUMN``` — удаляет столбец с указанным именем. Приведенный ниже код удалит столбец ```is_deleted``` из таблицы ```episodes```.

```sql
ALTER TABLE episodes DROP column is_deleted;
```

## Добавление или удаление вторичного индекса {#secondary-index}

```ADD INDEX``` — добавляет индекс с указанным именем и типом для заданного набора колонок. Приведенный ниже код добавит глобальный индекс с именем ```title_index``` для колонки ```title```.

```sql
ALTER TABLE `series` ADD INDEX `title_index` GLOBAL ON (`title`);
```

Могут быть указаны все параметры индекса, описанные в команде [`CREATE TABLE`](../create_table#secondary_index)

Удаление индекса:

```DROP INDEX``` — удаляет индекс с указанным именем. Приведенный ниже код удалит индекс с именем ```title_index```.

```sql
ALTER TABLE `series` DROP INDEX `title_index`;
```
