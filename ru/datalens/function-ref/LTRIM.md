---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/LTRIM.md
---

# LTRIM



#### Синтаксис {#syntax}


```
LTRIM( string )
```

#### Описание {#description}
Возвращает строку `string` без знаков пробела в начале строки.

**Типы аргументов:**
- `string` — `Строка`


**Возвращаемый тип**: `Строка`

#### Пример {#examples}

```
LTRIM(" Computer") = "Computer"
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
