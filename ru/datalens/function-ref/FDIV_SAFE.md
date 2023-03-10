---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/FDIV_SAFE.md
---

# FDIV_SAFE



#### Синтаксис {#syntax}


```
FDIV_SAFE( numerator, denominator [ , fallback_value ] )
```

#### Описание {#description}
Возвращает результат деления `numerator` на `denominator`. В случае деления на ноль возвращает `fallback_value`. Если число `fallback_value` не указано, возвращает `NULL`.

**Типы аргументов:**
- `numerator` — `Дробное число | Целое число`
- `denominator` — `Дробное число | Целое число`
- `fallback_value` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Пример {#examples}



| **[numerator]**   | **[denominator]**   | **FDIV_SAFE([numerator], [denominator])**   | **FDIV_SAFE([numerator], [denominator], 42)**   |
|:------------------|:--------------------|:--------------------------------------------|:------------------------------------------------|
| `5.00`            | `2.00`              | `2.50`                                      | `2.50`                                          |
| `5.00`            | `0.00`              | `NULL`                                      | `42.00`                                         |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
