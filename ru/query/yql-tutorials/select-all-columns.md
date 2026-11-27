---
title: Выбрать данные из всех колонок в {{ yq-full-name }}
description: Следуя данному руководству, вы сможете выбрать данные из всех колонок.
alternate:
  - href: ru/query/yql-tutorials/select-all-columns.md
    type: text/markdown
    title: Markdown version
---

# Выбрать данные из всех колонок

Чтобы выбрать данные из всех колонок, используйте оператор SELECT:

```sql
SELECT  -- Оператор выбора данных.
    *   -- Выбор всех колонок.
FROM
    `tutorial-analytics`
```

Рассмотрите пример в блоке справа и нажмите кнопку ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
Результат выполнения запроса отобразится на вкладке **{{ ui-key.yql.yq-query-results.result.tab-text }}** в виде таблицы или схемы.
