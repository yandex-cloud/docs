---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/SECOND.md
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

#### Пример {#examples}

```
SECOND(#2019-01-23 15:07:47#) = 47
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
