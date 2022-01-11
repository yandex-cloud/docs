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
## Изменение групп колонок {#column-family}

```ADD FAMILY``` — создаёт новую группу колонок в таблице. Приведенный ниже код создаст в таблице ```series_with_families``` группу колонок ```family_small```.

```sql
ALTER TABLE series_with_families ADD FAMILY family_small (
    DATA = "ssd",
    COMPRESSION = "off"
);
```

При помощи команды ```ALTER COLUMN``` можно изменить группу колонок для указанной колонки. Приведенный ниже код для колонки ```release_date``` в таблице ```series_with_families``` сменит группу колонок на ```family_small```.

```sql
ALTER TABLE series_with_families ALTER COLUMN release_date SET FAMILY family_small;
```

Две предыдущие команды из листингов 8 и 9 можно объединить в один вызов ```ALTER TABLE```. Приведенный ниже код создаст в таблице ```series_with_families``` группу колонок ```family_small``` и установит её для колонки ```release_date```.

```sql
ALTER TABLE series_with_families
	ADD FAMILY family_small (
    	DATA = "ssd",
    	COMPRESSION = "off"
	),
	ALTER COLUMN release_date SET FAMILY family_small;
```

При помощи команды ```ALTER FAMILY``` можно изменить параметры группы колонок. Приведенный ниже код для группы колонок ```default``` в таблице ```series_with_families``` сменит тип хранилища на ```hdd```:

```sql
ALTER TABLE series_with_families ALTER FAMILY default SET DATA "hdd";
```

Могут быть указаны все параметры группы колонок, описанные в команде [`CREATE TABLE`](create_table#column-family)


## Изменение дополнительных параметров таблицы {#additional-alter}

Большинство параметров таблицы в YDB, приведенных на странице [описания таблицы](../../../../concepts/datamodel#table), можно изменить командой ```ALTER```.

В общем случае команда для изменения любого параметра таблицы выглядит следующим образом:

```sql
ALTER TABLE table_name SET (key = value);
```

```key``` — имя параметра, ```value``` — его новое значение.

Например, такая команда выключит автоматическое партиционирование таблицы:

```sql
ALTER TABLE series SET (AUTO_PARTITIONING_BY_SIZE = DISABLED);
```

## Сброс дополнительных параметров таблицы {#additional-reset}

Некоторые параметры таблицы в YDB, приведенные на странице [описания таблицы](../../../../concepts/datamodel#table), можно сбросить командой ```ALTER```.

Команда для сброса параметра таблицы выглядит следующим образом:

```sql
ALTER TABLE table_name RESET (key);
```

```key``` — имя параметра.

Например, такая команда сбросит (удалит) настройки TTL для таблицы:

```sql
ALTER TABLE series RESET (TTL);
```