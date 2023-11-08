---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/WEEK.md
---

# WEEK



#### Синтаксис {#syntax}


```
WEEK( value )
```

#### Описание {#description}
Возвращает номер недели в соответствии с [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601). Первой считается неделя, которая содержит первый четверг года и 4.01.

**Типы аргументов:**
- `value` — `Дата | Дата и время`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
WEEK(#1971-01-14 01:02:03#) = 2
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
