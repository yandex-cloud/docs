---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/IF.md
---

# IF



#### Синтаксис {#syntax}

{% list tabs %}

- Как блок

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

- Как функция

  ```
  IF(
      condition_1, result_1,
    [ condition_2, result_2,
      ... ]
      default_result
  )
  ```

{% endlist %}

#### Описание {#description}
Проверяет последовательно логические выражения `condition_1`, `condition_2`, ... и возвращает соответствующий результат для первого выполнения.
Если все `condition_1`, `condition_2`, ... возвращают `FALSE`, то блок возвращает `default_result`. Проверяемые выражения задаются с помощью логических операторов.

**Типы аргументов:**
- `condition_1` — `Любой`
- `result_1` — `Любой`
- `condition_2` — `Любой`
- `result_2` — `Любой`
- `default_result` — `Любой`


**Возвращаемый тип**: Зависит от типов аргументов

#### Примеры {#examples}

```
IF
    [Profit] > 100
        THEN "High"
    ELSEIF [Profit] > 25
        THEN "Medium"
    ELSE "Low"
END
```

{% cut "Пример с таблицей данных" %}


Формулы:

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


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
