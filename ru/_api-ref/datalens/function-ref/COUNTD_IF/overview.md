# COUNTD_IF

_Агрегатные функции_

#### Синтаксис


```
COUNTD_IF( expression, condition )
```

#### Описание
Возвращает количество уникальных значений в группе, которые удовлетворяют условию `condition`.

 См. также [COUNTD_APPROX](../COUNTD_APPROX/overview.md).

**Типы аргументов:**
- `expression` — `Любой`
- `condition` — `Логический`


**Возвращаемый тип**: `Целое число`

#### Примеры

```
COUNTD([ClientID], [Profit] > 5)
```


#### Поддержка источников данных

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
