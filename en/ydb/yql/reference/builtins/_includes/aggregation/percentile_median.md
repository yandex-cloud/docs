---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/builtins/_includes/aggregation/percentile_median.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/builtins/_includes/aggregation/percentile_median.md
---
## PERCENTILE and MEDIAN {#percentile-median}

Calculating percentiles using the amortized version of the [TDigest](https://github.com/tdunning/t-digest) algorithm. `MEDIAN`: An alias for `PERCENTILE(N, 0.5)`.

{% note info %}

The first argument (N) must be a table column name. If you need to bypass this restriction, use a subquery. The restriction is introduced to simplify calculations, since the implementation merges the calls with the same first argument (N) into a single pass.

{% endnote %}

```yql
SELECT
    MEDIAN(numeric_column),
    PERCENTILE(numeric_column, 0.99)
FROM my_table;
```

