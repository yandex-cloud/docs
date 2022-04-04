---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/syntax/_includes/expressions/cast.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/syntax/_includes/expressions/cast.md
---
## CAST {#cast}

Tries to cast the value to the specified type. The attempt may fail and return `NULL`. When used with numbers, it may lose precision or most significant bits.

{% include notitle [Decimal types](../../../_includes/decimal_args.md) %}

**Examples**

{% include [cast_examples](../../../_includes/cast_examples.md) %}
