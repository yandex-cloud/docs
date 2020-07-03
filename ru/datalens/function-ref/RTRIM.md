---
editable: false
---

# RTRIM

_Строковые функции_

#### Синтаксис {#syntax}


```
RTRIM( string )
```

#### Описание {#description}
Возвращает строку `string` без знаков пробела в конце строки.

**Типы аргументов:**
- `string` — `Строка`


**Возвращаемый тип**: `Строка`

#### Примеры {#examples}

```
RTRIM("Computer ") = "Computer"
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
