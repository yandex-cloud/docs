---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/RTRIM.md
---

# RTRIM



#### Синтаксис {#syntax}


```
RTRIM( string )
```

#### Описание {#description}
Возвращает строку `string` без знаков пробела в конце строки.

**Типы аргументов:**
- `string` — `Строка`


**Возвращаемый тип**: `Строка`

#### Пример {#examples}

```
RTRIM("Computer ") = "Computer"
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
