---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/builtins/_includes/basic/callable.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/builtins/_includes/basic/callable.md
---
## Callable {#callable}

Create a callable value with the specified signature from a lambda function. It's usually used to put callable values into containers.

Arguments:

1. Type.
2. Lambda function.

**Examples:**
``` yql
$lambda = ($x) -> {
    RETURN CAST($x as String)
};

$callables = AsTuple(
    Callable(Callable<(Int32)->String>, $lambda),
    Callable(Callable<(Bool)->String>, $lambda),
);

SELECT $callables.0(10), $callables.1(true);
```
