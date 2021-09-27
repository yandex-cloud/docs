---
editable: false
---

# COUNTD_IF



#### Синтаксис {#syntax}


```
COUNTD_IF( expression, condition )
```

#### Описание {#description}
Возвращает количество уникальных значений в группе, которые удовлетворяют условию `condition`.

См. также [COUNTD_APPROX](COUNTD_APPROX.md).

**Типы аргументов:**
- `expression` — `Любой`
- `condition` — `Логический`


**Возвращаемый тип**: `Целое число`

#### Примеры {#examples}

```
COUNTD_IF([ClientID], [Profit] > 5)
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
