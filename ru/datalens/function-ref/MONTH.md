---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MONTH.md
---

# MONTH



#### Синтаксис {#syntax}


```
MONTH( datetime )
```

#### Описание {#description}
Возвращает номер месяца в году в указанной дате `datetime`.

**Типы аргументов:**
- `datetime` — `Дата | Дата и время`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
MONTH(#2019-01-23#) = 1
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
