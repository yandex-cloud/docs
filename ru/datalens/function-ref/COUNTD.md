---
editable: false
---

# COUNTD



#### Синтаксис {#syntax}


```
COUNTD( value )
```

#### Описание {#description}
Возвращает количество уникальных значений в группе.

См. также [COUNTD_APPROX](COUNTD_APPROX.md).

**Типы аргументов:**
- `value` — `Любой`


**Возвращаемый тип**: `Целое число`

#### Примеры {#examples}

```
COUNTD([ClientID])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
