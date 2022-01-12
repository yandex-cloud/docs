---
sourcePath: core/yql/reference/yql-docs-core-2/syntax/_includes/discard.md
sourcePath: yql/reference/yql-docs-core-2/syntax/_includes/discard.md
---

# DISCARD

Вычисляет [`SELECT`](../select.md), но не возвращает результат ни в клиент, ни в таблицу. 

Полезно использовать в сочетании с [`Ensure`](../../builtins/basic.md#ensure) для проверки выполнения пользовательских условий на финальный результат вычислений.

**Примеры**

``` yql
DISCARD SELECT 1;
```

``` yql
INSERT INTO result_table WITH TRUNCATE
SELECT * FROM
my_table
WHERE value % 2 == 0;

COMMIT;

DISCARD SELECT Ensure(
    0, -- will discard result anyway
    COUNT(*) > 1000,
    "Too small result table, got only " || CAST(COUNT(*) AS String) || " rows"
) FROM result_table;

```