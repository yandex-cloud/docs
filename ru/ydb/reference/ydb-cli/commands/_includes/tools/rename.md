---
sourcePath: ru/ydb/ydb-docs-core/ru/core/reference/ydb-cli/commands/_includes/tools/rename.md
---
# Переименование таблицы

С помощью подкоманды `tools rename` вы можете переименовать одну или несколько таблиц одновременно, перенести таблицу в другую директорию в пределах той же БД, заменить одну таблицу другой в рамках одной транзакции.

Общий вид команды:

```bash
ydb [global options...] tools rename [options...]
```

* `global options` — [глобальные параметры](../../../commands/global-options.md).
* `options` — [параметры подкоманды](#options).

Посмотрите описание команды для переименования таблицы:

```bash
ydb tools rename --help
```

## Параметры подкоманды {#options}

Имя параметра | Описание параметра
---|---
`--timeout <значение>` | Таймаут операции, мс.
`--item <свойство>=<значение>,...` | Параметры операции. Возможные значения:<br/><ul><li>`destination`, `dst`, `d` —  обязательный параметр, путь до таблицы назначения. Если путь назначения содержит директории, они должны быть созданы заранее.</li> <li>`source`, `src`, `s` — обязательный параметр, путь таблицы источника.</li><li>`replace`, `force` — необязательный параметр. Если значение `True`, то таблица назначения должна существовать и будет перезаписана. `False` — таблица назначения не должна существовать. Значение по умолчанию: `False`.</li></ul>

## Примеры {#examples}

### Переименовать таблицу {#rename}

База данных содержит директорию `new-project` с таблицами `main_table`, `second_table`, `third_table`.

Переименуйте таблицы:

```bash
{{ ydb-cli }} tools rename \
  --item source=new-project/main_table,destination=new-project/episodes \
  --item source=new-project/second_table,destination=new-project/seasons \
  --item source=new-project/third_table,destination=new-project/series
```

Получите листинг объектов:

```bash
ydb scheme ls new-project
```

Результат:

```text
episodes  seasons  series
```

### Переместить таблицы {#move}

База данных содержит директорию `new-project` с таблицами `main_table`, `second_table`, `third_table`.

Создайте директорию:

```bash
{{ ydb-cli }} scheme mkdir cinema
```

Переименуйте таблицы и переместите их в созданную директорию:

```bash
{{ ydb-cli }} tools rename \
  --item source=new-project/main_table,destination=cinema/episodes \
  --item source=new-project/second_table,destination=cinema/seasons \
  --item source=new-project/third_table,destination=cinema/series
```

Получите листинг объектов созданной директории:

```bash
ydb scheme ls cinema
```

Результат:

```text
episodes  seasons  series
```

### Заменить таблицу {#replace}

База данных содержит директорию `prod-project` с таблицами `main_table`, `other_table` и директорию `pre-prod-project` с таблицами `main_table`, `other_table`.

Замените таблицу `main_table` директории `prod-project` одноименной таблицей директории `pre-prod-project`:

```bash
{{ ydb-cli }} tools rename \
  --item replace=True,source=pre-prod-project/main_table,destination=prod-project/main_table
```

Получите листинг объектов директории `prod-project`:

```bash
ydb scheme ls prod-project
```

Результат:

```text
main_table  other_table
```

Получите листинг объектов директории `pre-prod-project`:

```bash
ydb scheme ls pre-prod-project
```

Результат:

```text
other_table
```

Директория `pre-prod-project` больше не содержит таблицу `main_table`.

### Заменить таблицу без удаления {#switch}

База данных содержит директорию `prod-project` с таблицами `main_table`, `other_table` и директорию `pre-prod-project` с таблицами `main_table`, `other_table`.

Переместите таблицу `prod-project/main_table` в таблицу `prod-project/main_table.backup`, а таблицу `pre-prod-project/main_table` в таблицу  `prod-project/main_table`:

```bash

{{ ydb-cli }} tools rename \
  --item source=prod-project/main_table,destination=prod-project/main_table.backup \
  --item source=pre-prod-project/main_table,destination=prod-project/main_table
```

Получите листинг объектов директории `prod-project`:

```bash
ydb scheme ls prod-project
```

Результат:

```text
main_table  other_table main_table.backup
```

Получите листинг объектов директории `pre-prod-project`:

```bash
ydb scheme ls pre-prod-project
```

Результат:

```text
other_table
```

Директория `pre-prod-project` больше не содержит таблицу `main_table`.
