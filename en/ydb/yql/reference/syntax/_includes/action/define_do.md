---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/syntax/_includes/action/define_do.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/syntax/_includes/action/define_do.md
---

## DEFINE ACTION {#define-action}

Specifies a named action that is a parameterizable block of multiple top-level expressions.

**Syntax**

1. `DEFINE ACTION`: Action definition.
1. [Action name](../../expressions.md#named-nodes) that will be used to access the defined action further in the query.
1. The values of parameter names are listed in parentheses.
1. `AS` keyword.
1. List of top-level expressions.
1. `END DEFINE`: The marker of the last expression inside the action.

One or more of the last parameters can be marked with a question mark `?` as optional. If they are omitted during the call, they will be assigned the `NULL` value.

## DO {#do}

Executes an `ACTION` with the specified parameters.

**Syntax**

1. `DO`: Executing an action.
1. The named expression for which the action is defined.
1. The values to be used as parameters are listed in parentheses.

`EMPTY_ACTION`: An action that does nothing.


**Example**

```yql
DEFINE ACTION $hello_world($name, $suffix?) AS
    $name = $name ?? ($suffix ?? "world");
    SELECT "Hello, " || $name || "!";
END DEFINE;

DO EMPTY_ACTION();
DO $hello_world(NULL);
DO $hello_world("John");
DO $hello_world(NULL, "Earth");
```