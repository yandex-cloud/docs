---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/TRIM.md
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

#### Пример {#examples}

```
TRIM(" Computer ") = "Computer"
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
