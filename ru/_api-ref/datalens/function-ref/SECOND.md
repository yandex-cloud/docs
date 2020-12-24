---
editable: false
---

# SECOND



#### Синтаксис {#syntax}


```
SECOND( datetime )
```

#### Описание {#description}
Возвращает номер секунды в минуте в указанной дате `datetime`. При указании даты без времени возвращает `0`.

**Типы аргументов:**
- `datetime` — `Дата | Дата и время`


**Возвращаемый тип**: `Целое число`

#### Примеры {#examples}

```
SECOND(#2019-01-23 15:07:47#) = 47
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
