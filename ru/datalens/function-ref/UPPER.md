---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/UPPER.md
---

# UPPER



#### Синтаксис {#syntax}


```
UPPER( string )
```

#### Описание {#description}
Возвращает строку `string` в верхнем регистре.

**Типы аргументов:**
- `string` — `Строка`


**Возвращаемый тип**: `Строка`

#### Примеры {#examples}

```
UPPER("Lorem ipsum") = "LOREM IPSUM"
```

```
UPPER("Карл у Клары") = "КАРЛ У КЛАРЫ"
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
