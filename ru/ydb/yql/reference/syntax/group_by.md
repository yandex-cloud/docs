# GROUP BY

Сгруппировать таблицу по значениям указаных столбцов или выражений.

Если `GROUP BY` присутствует в запросе, то при выборке столбцов (между `SELECT ... FROM`) допустимы **только** следующие выражения:

1. Столбцы, по которым производится группировка (присутствующие в аргументе `GROUP BY`). Если группировка происходит по выражению, то в `GROUP BY` ему должно быть присвоено имя через `AS`, а при выборке должно использоваться имя (именно так, не наоборот, см. второй пример ниже). 
2. [Агрегатные функции](../builtins/aggregation.md). Столбцы, по которым **не** идёт группировка, можно включать только в качестве аргументов агрегатной функции.
3. Произвольные вычисления, включающие только столбцы, по которым производится группировка, и агрегатные функции.

Агрегатные функции автоматически пропускают `NULL` в своих аргументах, если явно не оговорено иное.

Также в YQL доступен механизм фабрик агрегатных функций, реализованный с помощью функций [AGGREGATION_FACTORY](../builtins/basic.md#aggregationfactory) и [AGGREGATE_BY](../builtins/aggregation.md#aggregateby).

**Примеры**

``` yql
SELECT key, COUNT(*) FROM my_table
GROUP BY key;
```

``` yql
SELECT double_key, COUNT(*) FROM my_table
GROUP BY key + key AS double_key;
```

## ROLLUP, CUBE и GROUPING SETS {#rollup-cube-group-sets}

Возможность посчитать статистику в `GROUP BY` по нескольким колонкам не только для каждой группы отдельно, но и промежуточные итоги по части колонок или по всей таблице:

* `ROLLUP` строит промежуточные итоги от самого детализированного до полного итога по всей таблице в том порядке, как колонке перечислены в аргументах;
* `CUBE` создает все возможные комбинации промежуточных итогов;
* `GROUPING SETS` позволяет явно перечислить, какие именно промежуточные итоги нужны.

`ROLLUP`, `CUBE` и `GROUPING SETS` можно комбинировать через запятую.

В результирующих строках с промежуточным итогом не участвующие в вычислении ключевые колонки заменяются на `NULL` (например, в финальном итоге по всей таблице это происходит для всех ключевых колонок). Чтобы отличить такие значения от `NULL` в исходных данных, предоставляется вспомогательная функция `GROUPING`, которая возвращает битовую маску с единицами в битах по номерам колонок, для которых на данной строке `NULL` означает промежуточный итог, а не пустое значение.

**Примеры**
.
``` yql
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

Применение агрегатных функций только к уникальным значениям столбца ([подробнее об агрегатных функциях](../builtins/aggregation.md)).

Применение `DISTINCT` к вычислимым значениям пока не реализовано. Однако это ограничение можно обойти с помощью [подзапроса](select.md#from).

**Примеры**

``` yql
SELECT
  key,
  COUNT(DISTINCT value) AS count -- топ-3 ключей по количеству уникальных значений
FROM my_table
GROUP BY key
ORDER BY count DESC
LIMIT 3;
```

Также ключевое слово `DISTINCT` может использоваться для выборки уникальных строк через [SELECT DISTINCT](select.md#distinct).

## HAVING {#having}

Фильтрация выхода `SELECT` по результатам вычисления [агрегатных функций](../builtins/aggregation.md). Синтаксис аналогичен конструкции [WHERE](select.md#where).

**Примеры**

``` yql
SELECT
    key
FROM my_table
GROUP BY key
HAVING COUNT(value) > 100;
```
