---
title: "Selecting data from all columns in {{ yq-full-name }}"
description: "Follow this guide to select data from all columns."
---

# Selecting data from all columns

To select data from all columns, use the SELECT statement:

```sql
SELECT  -- Data selection operator.
    *   -- Select all columns.
FROM
    `tutorial-analytics`
```

Take a look at the example on the right and click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
Query results are available in the **{{ ui-key.yql.yq-query-results.result.tab-text }}** tab as a table or schema.
