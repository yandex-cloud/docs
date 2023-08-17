---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/ZN.md
---

# ZN



#### Синтаксис {#syntax}


```
ZN( expression )
```

#### Описание {#description}
Возвращает значение выражения `expression`, если оно не `NULL`. В противном случае возвращает 0.

**Типы аргументов:**
- `expression` — `Дробное число | Целое число`


**Возвращаемый тип**: Совпадает с типом аргументов (`expression`)

#### Пример {#examples}



| **[sales]**   | **ZN([sales])**   |
|:--------------|:------------------|
| `432.40`      | `432.40`          |
| `77.00`       | `77.00`           |
| `12000.00`    | `12000.00`        |
| `NULL`        | `0.00`            |
| `34.25`       | `34.25`           |
| `128.00`      | `128.00`          |
| `0.00`        | `0.00`            |
| `NULL`        | `0.00`            |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
