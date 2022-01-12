---
sourcePath: core/yql/reference/yql-docs-core-2/syntax/_includes/select/execution.md
sourcePath: yql/reference/yql-docs-core-2/syntax/_includes/select/execution.md
---

## Процедура выполнения SELECT {#selectexec}

Результат запроса `SELECT` вычисляется следующим образом:

* определяется набор входных таблиц – вычисляются выражения после [FROM](#from);
* к входным таблицам применяется [SAMPLE](#sample) / [TABLESAMPLE](#sample)
* выполняется [FLATTEN COLUMNS](../../flatten.md#flatten-columns) или [FLATTEN BY](../../flatten.md); алиасы, заданные во `FLATTEN BY`, становятся видны после этой точки;
* выполняются все [JOIN](../../join.md);
* к полученным данным добавляются (или заменяются) колонки, заданные в [GROUP BY ... AS ...](../../group_by.md);
* выполняется [WHERE](#where) &mdash; все данные не удовлетворяющие предикату отфильтровываются;
* выполняется [GROUP BY](../../group_by.md), вычисляются значения агрегатных функций;
* выполняется фильтрация [HAVING](../../group_by.md#having);
* ввычисляются значения [оконных функций](../../window.md)
* вычисляются выражения в `SELECT`
* выражениям в `SELECT` назначаются имена заданные алиасами;
* к полученным таким образом колонкам применяется top-level [DISTINCT](#distinct);
* таким же образом вычисляются все подзапросы в [UNION ALL](#unionall), выполняется их объединение (см. [PRAGMA AnsiOrderByLimitInUnionAll](../../pragma.md#pragmas));
* выполняется сортировка согласно [ORDER BY](#order-by);
* к полученному результату применяются [OFFSET и LIMIT](#limit-offset).