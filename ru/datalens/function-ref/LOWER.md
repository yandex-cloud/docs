---
editable: false
---

# LOWER

_Строковые функции_

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

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
