---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# DISCARD

Calculates [`SELECT`](select.md), `PROCESS`, or `REDUCE`, but doesn't return the result to either the client or table.

It's good to combine it with [`Ensure`](../builtins/basic.md#ensure) to check the final calculation result against the user's criteria.

**Examples**

```sql
DISCARD SELECT 1;
```

```sql
INSERT INTO result_table WITH TRUNCATE
SELECT * FROM
my_table
WHERE value % 2 == 0;

COMMIT:

DISCARD SELECT Ensure(
    0, -- will discard result anyway
    COUNT(*) > 1000,
    "Too small result table, got only " || CAST(COUNT(*) AS String) || " rows"
) FROM result_table;
```

