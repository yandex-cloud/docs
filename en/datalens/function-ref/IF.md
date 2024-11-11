---
editable: false
sourcePath: en/_api-ref/datalens/function-ref/IF.md
---

# IF



#### Syntax {#syntax}

{% list tabs %}

- As a block

  ```
  IF condition_1
      THEN result_1
  [ ELSEIF condition_2
      THEN result_2
    ... ]
  ELSE
      default_result
  END
  ```

- As a function

  ```
  IF(
      condition_1, result_1,
    [ condition_2, result_2,
      ... ]
      default_result
  )
  ```

{% endlist %}

#### Description {#description}
Checks conditional expressions `condition_1`, `result_1`, ... and returns the matching result for the first condition found to be `TRUE`. IF all conditional expressions are `FALSE`, it returns `default_result`. The expressions to be checked are set using logical operators.

**Argument types:**
- `condition_1` — `Any`
- `result_1` — `Any`
- `condition_2` — `Any`
- `result_2` — `Any`
- `default_result` — `Any`


**Return type**: Depends on argument types

{% note info %}

Arguments `result_1`, `result_2`, `default_result` must be of the same type.

{% endnote %}


#### Examples {#examples}

```
IF
    [Profit] > 100
        THEN "High"
    ELSEIF [Profit] > 25
        THEN "Medium"
    ELSE "Low"
END
```

{% cut "Example with data table" %}


Formulas:

- **sales**: `[sales]` ;
- **if_function**: `IF(ZN([sales]) < 100, "Less than 100", [sales] < 1000, "100 - 1000", "1000 and greater")` ;
- **if_statement**: `IF ZN([sales]) < 100 THEN "Less than 100" ELSEIF [sales] < 1000 THEN "100 - 1000" ELSE "1000 and greater" END` .

| **sales**   | **if_function**      | **if_statement**     |
|:------------|:---------------------|:---------------------|
| `432.40`    | `'100 - 1000'`       | `'100 - 1000'`       |
| `77.00`     | `'Less than 100'`    | `'Less than 100'`    |
| `12000.00`  | `'1000 and greater'` | `'1000 and greater'` |
| `NULL`      | `'Less than 100'`    | `'Less than 100'`    |
| `34.25`     | `'Less than 100'`    | `'Less than 100'`    |
| `128.00`    | `'100 - 1000'`       | `'100 - 1000'`       |
| `0.00`      | `'Less than 100'`    | `'Less than 100'`    |
| `NULL`      | `'Less than 100'`    | `'Less than 100'`    |

{% endcut %}


#### Data source support {#data-source-support}

`ClickHouse 21.8`, `Files`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Yandex Documents`, `YDB`.
