# ACTION

An action that is a parameterizable block of multiple top-level expressions.

[`DEFINE ACTION`](#define-action) defines an action that can then be accessed repeatedly using [`DO`](#do).

`You can use DO ACTION` in the body of the [`EVALUATE IF`](#evaluate-if) condition or [`EVALUATE FOR`](#evaluate-for) cycle.

## DEFINE ACTION {#define-action}

Defines an `ACTION` consisting of the specified expressions.

**Syntax**

1. `DEFINE ACTION`: action definition.
1. [A named expression](expressions.md#named-nodes) that will be used to access the defined action further in the query.
1. The round brackets contain a list of named expressions you can use to access parameters inside the action.
1. `AS` keyword.
1. List of top-level expressions.
1. `END DEFINE`: The marker of the last expression inside the action.

## DO {#do}

Executes an `ACTION` with the specified parameters.

**Syntax**

1. `DO`: Executing an action.
1. The named expression for which the action is defined.
1. The values to be used as parameters are listed in parentheses.

`EMPTY_ACTION`: An action that does nothing.

{% note info %}

In large queries, you can use separate files for action definition and include them to the main query using `EXPORT + IMPORT`. To define actions on tables by using a separate library, make sure to include `USE my_cluster;` in it: action compilation depends on the cluster type.

{% endnote %}

**Example**

```sql
DEFINE ACTION $hello_world($name) AS
    $name = $name ?? "world";
    SELECT "Hello, " || $name || "!";
END DEFINE;

DO EMPTY_ACTION();
DO $hello_world(NULL);
DO $hello_world("John");
```

