---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# GROUP BY

Группирует результаты `SELECT` по значениям указанных столбцов или выражений. Вместе с `GROUP BY` часто применяются [агрегатные функции](../builtins/aggregation.md) (`COUNT`, `MAX`, `MIN`, `SUM`, `AVG`) для выполнения вычислений в каждой группе.

**Синтаксис**
```sql
SELECT                               -- столбцы, которые не входят в AGGREGATE_FUNCTION
    column1, column2, ... column_n   -- и должны быть включены в GROUP BY

AGGREGATE_FUNCTION                   -- функция COUNT, SUM, MAX, MIN, SUM или AVG        
    (aggregate_column)               -- аргумент агрегатной функции

FROM table

GROUP by                             -- при группировке по выражению ему задается имя
    column1, column2, ... column_n   -- через AS в GROUP BY,
                                     -- а в SELECT используется заданное имя
```
{% note info %}

По умолчанию агрегатные функции не учитывают `NULL` в своих аргументах.

{% endnote %}

Также в YQL доступен механизм фабрик агрегатных функций, реализованный с помощью функций [`AGGREGATION_FACTORY`](../builtins/basic.md#aggregationfactory) и [`AGGREGATE_BY`](../builtins/aggregation.md#aggregateby).

**Примеры**

```sql
SELECT key, COUNT(*) FROM my_table
GROUP BY key;
```

```sql
SELECT double_key, COUNT(*) FROM my_table
GROUP BY key + key AS double_key;
```

## ROLLUP, CUBE и GROUPING SETS {#rollup-cube-group-sets}

Результаты вычисления агрегатной функции в виде промежуточных итогов для групп и общих итогов для отдельных столбцов или всей таблицы.

**Синтаксис**

```sql
SELECT 
    c1, c2,                          -- столбцы, по которым производится группировка

AGGREGATE_FUNCTION(c3) AS outcome_c  -- агрегатная функция (SUM, AVG, MIN, MAX, COUNT)

FROM table_name

GROUP BY
    GROUP_BY_EXTENSION(c1, c2)       -- расширение GROUP BY: ROLLUP, CUBE или GROUPING SETS
```


* `ROLLUP` — группирует значения столбцов в порядке их перечисления в аргументах (строго слева направо), формирует промежуточные итоги для каждой группы и общий итог.
* `CUBE` — группирует значения для всех возможных комбинаций столбцов, формирует промежуточные итоги для каждой группы и общий итог.
* `GROUPING SETS` — задает группы для промежуточных итогов.

`ROLLUP`, `CUBE` и `GROUPING SETS` можно комбинировать через запятую.

### GROUPING {#grouping}

В промежуточном итоге значения столбцов, которые не участвуют в вычислениях, заменяются на `NULL`. В общем итоге на `NULL` заменяются значения всех столбцов. `GROUPING` — функция, которая позволяет отличить исходные значения `NULL` от `NULL`, которые были добавлены при формировании общих и промежуточных итогов.

`GROUPING` возвращает битовую маску:
* `0` — `NULL` для исходного пустого значения.
* `1` — `NULL`, добавленный для промежуточного или общего итога.

**Пример**

```sql
SELECT
    column1,
    column2,
    column3,

    CASE GROUPING(
        column1,
        column2,
        column3,
    )
        WHEN 1  THEN "Subtotal: column1 and column2"
        WHEN 3  THEN "Subtotal: column1"
        WHEN 4  THEN "Subtotal: column2 and column3"
        WHEN 6  THEN "Subtotal: column3"
        WHEN 7  THEN "Grand total"
        ELSE         "Individual group"
    END AS subtotal,

    COUNT(*) AS rows_count

FROM my_table

GROUP BY
    ROLLUP(
        column1,
        column2,
        column3
    ),
    GROUPING SETS(
        (column2, column3),
        (column3)
        -- если добавить cюда ещё (column2), то в сумме
        -- эти ROLLUP и GROUPING SETS дали бы результат,
        -- аналогичный CUBE
    )
;
```

## DISTINCT {#distinct}

Применение [агрегатных функций](../builtins/aggregation.md) только к уникальным значениям столбца.

{% note info %}

Применение `DISTINCT` к вычислимым значениям на данный момент не реализовано. С этой целью можно использовать [подзапрос](select.md#from) или выражение `GROUP BY ... AS ...`.

{% endnote %}

**Пример**

```sql
SELECT
  key,
  COUNT(DISTINCT value) AS count -- топ-3 ключей по количеству уникальных значений
FROM my_table
GROUP BY key
ORDER BY count DESC
LIMIT 3;
```

Также ключевое слово `DISTINCT` может использоваться для выборки уникальных строк через [`SELECT DISTINCT`](select.md#distinct).

## HAVING {#having}

Фильтрация выборки `SELECT` по результатам вычисления [агрегатных функций](../builtins/aggregation.md). Синтаксис аналогичен конструкции [`WHERE`](select.md#where).

**Пример**

```sql
SELECT
    key
FROM my_table
GROUP BY key
HAVING COUNT(value) > 100;
```