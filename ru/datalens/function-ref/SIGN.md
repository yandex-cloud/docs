---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/SIGN.md
---

# SIGN



#### Синтаксис {#syntax}


```
SIGN( number )
```

#### Описание {#description}
Возвращает знак числа `number`:
- `-1` если число отрицательное;
- `0` если число равно нулю;
- `1` если число положительное.

**Типы аргументов:**
- `number` — `Дробное число | Целое число`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}



| **[value]**   | **SIGN([value])**   |
|:--------------|:--------------------|
| `1.00`        | `1`                 |
| `0.10`        | `1`                 |
| `-2.00`       | `-1`                |
| `50.50`       | `1`                 |
| `0.00`        | `0`                 |
| `-3.50`       | `-1`                |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
