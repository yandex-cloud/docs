---
editable: false
---

# LOWER



#### Синтаксис {#syntax}


```
LOWER( string )
```

#### Описание {#description}
Возвращает строку `string` в нижнем регистре.

**Типы аргументов:**
- `string` — `Строка`


**Возвращаемый тип**: `Строка`

#### Примеры {#examples}

```
LOWER("Lorem ipsum") = "lorem ipsum"
```

```
LOWER("Карл у Клары") = "карл у клары"
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
