# SELECT

Возвращает набор данных из {{ ydb-short-name }}.

**Примеры**

```sql
SELECT "Hello, world!";
```

```sql
SELECT 2 + 2;
```

## FROM {#from}

Источник данных для `SELECT`. В качестве аргумента может принимать имя таблицы, результат другого `SELECT` или [именованное выражение](expressions.md#named-nodes). Между `SELECT` и `FROM` через запятую указываются имена столбцов из источника или `*` для выбора всех столбцов.

**Примеры**

```sql
SELECT key FROM my_table;
```

```sql
SELECT * FROM
  (SELECT value FROM my_table);
```

```sql
$table_name = "my_table";
SELECT * FROM $table_name;
```

## WHERE {#where}

Фильтрация строк в результате `SELECT` по условию.

**Пример**

```sql
SELECT key FROM my_table
WHERE value > 0;
```

## ORDER BY {#order-by}

Сортировка результата `SELECT`:
- `ASC` — по возрастанию. Применяется по умолчанию.
- `DESC` — по убыванию.

Несколько критериев сортировки будут применены слева направо.

{% note info %}

Без `ORDER BY` запрос `SELECT FROM` возвращает несортированные данные и не сохраняет порядок из исходной таблицы. В [подзапросах](#from) использование `ORDER BY` допускается только вместе с [`LIMIT`](#limit-offset).

{% endnote %}

**Пример**

```sql
SELECT key, string_column
FROM my_table
ORDER BY key DESC, LENGTH(string_column) ASC;
```

Также `ORDER BY` может использоваться для сортировки в механизме [оконных функций](../builtins/window.md).

## LIMIT и OFFSET {#limit-offset}

`LIMIT` ограничивает вывод указанным количеством строк. По умолчанию вывод не ограничен.

`OFFSET` указывает отступ от начала (в строках). По умолчанию — ноль.

**Примеры**

```sql
SELECT key FROM my_table
LIMIT 7;
```

```sql
SELECT key FROM my_table
LIMIT 7 OFFSET 3;
```

```sql
SELECT key FROM my_table
LIMIT 3, 7; -- эквивалентно предыдущему примеру
```

## DISTINCT {#distinct}

Выбор уникальных строк.

{% note info %}

Применение `DISTINCT` к вычислимым значениям на данный момент не реализовано. С этой целью можно использовать подзапрос или выражение [`GROUP BY ... AS ...`](group_by.md).

{% endnote %}

**Пример**

```sql
SELECT DISTINCT value -- только уникальные значения из таблицы
FROM my_table;
```

Также `DISTINCT` может использоваться для применения [агрегатных функций](../builtins/aggregation.md) только к уникальным значениям. Подробнее читайте в разделе [{#T}](group_by.md).

## UNION ALL {#union-all}

Конкатенация результатов нескольких `SELECT`.

**Пример**

```sql
SELECT 1 AS x
UNION ALL
SELECT 2 AS y
UNION ALL
SELECT 3 AS z;
```

## WITHOUT {#without-select}

Исключение столбцов из результата `SELECT *`.

**Примеры**

```sql
SELECT * WITHOUT foo, bar FROM my_table;
```

```sql
PRAGMA simplecolumns;
SELECT * WITHOUT t.foo FROM my_table AS t
CROSS JOIN (SELECT 1 AS foo) AS v;
```

## FROM ... SELECT ... {#from-select}

Перевернутая форма записи, в которой сначала указывается источник данных, а затем — операция.

**Примеры**

```sql
FROM my_table SELECT key, value;
```

```sql
FROM a_table AS a
JOIN b_table AS b
USING (key)
SELECT *;
```


## SELECT по вторичному индексу {#si-select}

{% include [select_by_secondary_index](../../../oss/public/_includes/select-by-secondary-index.md) %}


## FROM AS_TABLE {#as-table}

Обращение к именованным выражениям как к таблицам с помощью функции `AS_TABLE`.

`AS_TABLE($variable)` позволяет использовать значение `$variable` в качестве источника данных для запроса. При этом переменная `$variable` должна иметь тип `List<Struct<...>>`.

**Пример**

```sql
$data = AsList(
    AsStruct(1u AS Key, "v1" AS Value),
    AsStruct(2u AS Key, "v2" AS Value),
    AsStruct(3u AS Key, "v3" AS Value));

SELECT Key, Value FROM AS_TABLE($data);
```
