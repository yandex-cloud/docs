---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/DIV_SAFE.md
---

# DIV_SAFE



#### Синтаксис {#syntax}


```
DIV_SAFE( numerator, denominator [ , fallback_value ] )
```

#### Описание {#description}
Возвращает результат деления `numerator` на `denominator`. В случае деления на ноль возвращает `fallback_value`. Если число `fallback_value` не указано, возвращает `NULL`.
Результат будет округлен до целого числа.

**Типы аргументов:**
- `numerator` — `Дробное число | Целое число`
- `denominator` — `Дробное число | Целое число`
- `fallback_value` — `Целое число`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}



| **[numerator]**   | **[denominator]**   | **DIV_SAFE([numerator], [denominator])**   | **DIV_SAFE([numerator], [denominator], 42)**   |
|:------------------|:--------------------|:-------------------------------------------|:-----------------------------------------------|
| `5.00`            | `2.00`              | `2`                                        | `2`                                            |
| `5.00`            | `0.00`              | `NULL`                                     | `42`                                           |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
