# Базовый синтаксис SELECT

## SELECT {#select}

Возвращает результат вычисления выражений, указанных после SELECT.

Может использоваться в сочетании с другими операциями для получения иного эффекта.

**Примеры**

```sql
SELECT "Hello, world!";
```

```sql
SELECT 2 + 2;
```

## FROM {#from}

Используется для указания источника данных для SELECT. Как правило, в качестве аргумента FROM выступает имя таблицы, однако в подзапросах может использоваться результат другого SELECT. Также таблицу можно указать через [именованное выражение](expressions.md#named-nodes), содержащее строку.

В выражениях между SELECT и FROM через запятую можно указывать имена столбцов из источника. Специальный символ `*` в этой позиции обозначает «все столбцы». Также есть нестандартное расширение синтакса [WITHOUT](#without), позволяющее выразить «все столбцы, кроме...».

**Примеры**

```sql
SELECT key FROM my_table;
```

```sql
SELECT * FROM
  (SELECT value FROM my_table);
```

```sql
$table_name = "my_" || "table";
SELECT * FROM $table_name;
```

## WHERE {#where}

Фильтрация строк в результате SELECT по условию.

**Примеры**

```sql
SELECT key FROM my_table
WHERE value > 0;
```

## ORDER BY {#order-by}

Сортировка результата SELECT по значению в указанном столбце или по результату вычисления указанного выражения от этого значения.

Порядок сортировки можно контролировать с помощью ключевых слов ASC (по возрастанию) и DESC (по убыванию). По умолчанию применяется сортировка по возрастанию (ASC).

Несколько критериев сортировки будут применены слева направо.

{% note alert %}

Без указания ORDER BY в SELECT __не гарантируется__ какой-либо порядок сортировки, равно как и сохранение порядка из исходной таблицы или подзапроса. Этот факт делает бессмысленным использование в [подзапросах](#from) ORDER BY без [LIMIT](#limit).

{% endnote %}

**Примеры**

```sql
SELECT key, string_column
FROM my_table
ORDER BY key DESC, LENGTH(string_column) ASC;
```

Также ключевое слово ORDER BY может использоваться в механизме [оконных функций](../builtins/window.md).

## LIMIT и OFFSET {#limit-offset}

LIMIT ограничивает вывод указанным количеством строк. По умолчанию вывод не ограничен.

OFFSET указывает отступ от начала (в строках). По умолчанию — ноль.

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

SELECT DISTINCT выбирает уникальные строки.

На данный момент не разрешено применять DISTINCT к вычислимым значениям. Это ограничение можно обойти с помощью подзапроса или выражения [GROUP BY ... AS ...](group_by.md).

**Примеры**

```sql
SELECT DISTINCT value -- только уникальные значения из таблицы
FROM my_table;
```

Также ключевое слово DISTINCT может использоваться для применения [агрегатных функций](../builtins/aggregation.md) только к уникальным значениям. Подробнее читайте в документации по [GROUP BY](group_by.md).

## UNION ALL {#union-all}

Конкатенация результатов нескольких SELECT.

**Примеры**

```sql
SELECT 1 AS x
UNION ALL
SELECT 2 AS y
UNION ALL
SELECT 3 AS z;
```

## Исключение части колонок из SELECT * {#without-select}

WITHOUT позволяет убрать часть столбцов из результата [SELECT *](#from).

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

Во многом ради удобства автодополнения имен колонок в таблицах и в некоторых случаях для читабельности, в YQL для SELECT поддерживается «перевернутая» форма записи, в которой сначала указывается, откуда брать данные, а затем — что с ними делать.

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

{% include [select_by_secondary_index](../../../../_includes/ydb/select-by-secondary-index.md) %}


## Обращение к именованным выражениям как к таблицам {#as-table}

Иногда возникает задача сделать SELECT из именованного выражения, которое не является результатом подзапроса из таблицы. Для этого в SELECT после FROM можно использовать функцию AS_TABLE.

AS_TABLE($variable) позволяет использовать значение `$variable` в качестве источника данных для запроса. При этом переменная `$variable` должна иметь тип `List<Struct<...>>`.

**Примеры**

```sql
$data = AsList(
    AsStruct(1u AS Key, "v1" AS Value),
    AsStruct(2u AS Key, "v2" AS Value),
    AsStruct(3u AS Key, "v3" AS Value));

SELECT Key, Value FROM AS_TABLE($data);
```


