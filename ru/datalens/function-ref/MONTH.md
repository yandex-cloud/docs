---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MONTH.md
---

# MONTH



#### Синтаксис {#syntax}


```
MONTH( datetime )
```

#### Описание {#description}
Возвращает номер месяца в году в указанной дате `datetime`.

**Типы аргументов:**
- `datetime` — `Дата | Дата и время`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}




Формулы:

- **Date**: `[Date]` ;
- **Month**: `MONTH([Date])` ;
- **Month name**: `CASE(MONTH([Date]), 1, "January", 2, "February", 3, "March", 4, "April", 5, "May", 6, "June", 7, "July", 8, "August", 9, "September", 10, "October", 11, "November", 12, "December", "Undefined")` .

| **Date**     | **Month**   | **Month name**   |
|:-------------|:------------|:-----------------|
| `2014-10-06` | `10`        | `'October'`      |
| `2014-10-07` | `10`        | `'October'`      |
| `2017-03-08` | `3`         | `'March'`        |
| `2024-02-12` | `2`         | `'February'`     |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
