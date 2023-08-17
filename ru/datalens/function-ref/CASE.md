---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/CASE.md
---

# CASE



#### Синтаксис {#syntax}

{% list tabs %}

- Как блок

  ```
  CASE expression
      WHEN value_1 THEN result_1
      [ WHEN value_2 THEN result_2
        ... ]
      ELSE default_result
  END
  ```

- Как функция

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

#### Описание {#description}
Сравнивает выражение `expression` с последовательностью значений `value_1`, `value_2`, ... и возвращает результат для первого совпадения.
Если совпадений не найдено, то возвращает `default_result`.

**Типы аргументов:**
- `expression` — `Любой`
- `value_1` — `Любой`
- `result_1` — `Любой`
- `value_2` — `Любой`
- `result_2` — `Любой`
- `default_result` — `Любой`


**Возвращаемый тип**: Совпадает с типом аргументов (`result_1`, `result_2`, `default_result`)

{% note info %}

Тип аргументов (`result_1`, `result_2`, `default_result`) должен совпадать.

{% endnote %}


#### Примеры {#examples}

```
CASE (
    [country],
    "AO", "Angola",
    "AU", "Australia",
    "BY", "Belarus",
    "CA", "Canada",
    "TT", "Trinidad and Tobago",
    "Other Country"
)
```

```
CASE [country]
    WHEN "AO" THEN "Angola"
    WHEN "AU" THEN "Australia"
    WHEN "BY" THEN "Belarus"
    WHEN "CA" THEN "Canada"
    WHEN "TT" THEN "Trinidad and Tobago"
    ELSE "Other Country"
END
```

{% cut "Пример с таблицей данных" %}


Формулы:

- **unit**: `[unit]` ;
- **case_function**: `CASE([unit], "s", 1, "m", 60, "h", 3600, 0)` ;
- **case_statement**: `CASE [unit] WHEN "s" THEN 1 WHEN "m" THEN 60 WHEN "h" THEN 3600 ELSE 0 END` .

| **unit**   | **case_function**   | **case_statement**   |
|:-----------|:--------------------|:---------------------|
| `'s'`      | `1`                 | `1`                  |
| `'m'`      | `60`                | `60`                 |
| `'h'`      | `3600`              | `3600`               |

{% endcut %}


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
