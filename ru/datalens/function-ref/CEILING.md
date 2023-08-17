---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/CEILING.md
---

# CEILING



#### Синтаксис {#syntax}


```
CEILING( number )
```

#### Описание {#description}
Округляет значение до ближайшего целого числа в большую сторону.

**Типы аргументов:**
- `number` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Пример {#examples}



| **[value]**   | **CEILING([value])**   |
|:--------------|:-----------------------|
| `1.00`        | `1.00`                 |
| `0.10`        | `1.00`                 |
| `-2.00`       | `-2.00`                |
| `50.50`       | `51.00`                |
| `0.00`        | `0.00`                 |
| `-3.50`       | `-3.00`                |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
