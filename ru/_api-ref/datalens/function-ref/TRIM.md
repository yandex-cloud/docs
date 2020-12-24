---
editable: false
---

# TRIM



#### Синтаксис {#syntax}


```
TRIM( string )
```

#### Описание {#description}
Возвращает строку `string` без знаков пробела в начале и конце строки.

**Типы аргументов:**
- `string` — `Строка`


**Возвращаемый тип**: `Строка`

#### Примеры {#examples}

```
TRIM(" Computer ") = "Computer"
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
