---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/QUARTER.md
---

# QUARTER



#### Синтаксис {#syntax}


```
QUARTER( datetime )
```

#### Описание {#description}
Возвращает номер квартала года (от `1` до `4`) в указанной дате `datetime`.

**Типы аргументов:**
- `datetime` — `Дата | Дата и время`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
QUARTER(#2019-01-23#) = 1
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
