---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/ABS.md
---

# ABS



#### Синтаксис {#syntax}


```
ABS( number )
```

#### Описание {#description}
Возвращает абсолютное значение заданного числа `number`.

**Типы аргументов:**
- `number` — `Дробное число | Целое число`


**Возвращаемый тип**: Совпадает с типом аргументов (`number`)

#### Пример {#examples}



| **[value]**   | **ABS([value])**   |
|:--------------|:-------------------|
| `1.00`        | `1.00`             |
| `0.10`        | `0.10`             |
| `-2.00`       | `2.00`             |
| `50.50`       | `50.50`            |
| `0.00`        | `0.00`             |
| `-3.50`       | `3.50`             |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
