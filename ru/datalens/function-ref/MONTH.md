---
editable: false
---

# MONTH

_Функции даты и времени_

#### Синтаксис {#syntax}


```
MONTH( datetime )
```

#### Описание {#description}
Возвращает номер месяца в году в указанной дате `datetime`.

**Типы аргументов:**
- `datetime` — `Дата | Дата и время`


**Возвращаемый тип**: `Целое число`

#### Примеры {#examples}

```
MONTH(#2019-01-23#) = 1
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
