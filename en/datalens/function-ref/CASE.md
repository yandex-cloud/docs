---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/CASE.md
---

# CASE



#### Syntax {#syntax}

{% list tabs %}

- As a block

  ```
  CASE expression
      WHEN value_1 THEN result_1
      [ WHEN value_2 THEN result_2
        ... ]
      ELSE default_result
  END
  ```

- As a function

  ```
  CASE(
      expression,
      value_1, result_1,
    [ value_2, result_2,
      ... ]
      default_result
  )
  ```

{% endlist %}

#### Description {#description}
Compares `expression` to `value_1`, `value_2`, ... consecutively and returns the corresponding result for the first match. If no match is found, it returns `default_result`.

**Argument types:**
- `expression` — `Any`
- `value_1` — `Any`
- `result_1` — `Any`
- `value_2` — `Any`
- `result_2` — `Any`
- `default_result` — `Any`


**Return type**: Same type as (`result_1`, `result_2`, `default_result`)

{% note info %}

Arguments (`result_1`, `result_2`, `default_result`) must be of the same type.

{% endnote %}


#### Examples {#examples}

```
CASE (
    [country],
    "BY", "Белоруссия",
    "KZ", "Казахстан",
    "RU", "Россия",
    "TR", "Турция",
    "UZ", "Узбекистан",
    "Другая страна"
)
```

```
CASE [country]
    WHEN "BY" THEN "Белоруссия"
    WHEN "KZ" THEN "Казахстан"
    WHEN "RU" THEN "Россия"
    WHEN "TR" THEN "Турция"
    WHEN "UZ" THEN "Узбекистан"
    ELSE "Другая страна"
END
```

{% cut "Example with data table" %}


Formulas:

- **unit**: `[unit]` ;
- **case_function**: `CASE([unit], "s", 1, "m", 60, "h", 3600, 0)` ;
- **case_statement**: `CASE [unit] WHEN "s" THEN 1 WHEN "m" THEN 60 WHEN "h" THEN 3600 ELSE 0 END` .

| **unit**   | **case_function**   | **case_statement**   |
|:-----------|:--------------------|:---------------------|
| `'s'`      | `1`                 | `1`                  |
| `'m'`      | `60`                | `60`                 |
| `'h'`      | `3600`              | `3600`               |

{% endcut %}


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
