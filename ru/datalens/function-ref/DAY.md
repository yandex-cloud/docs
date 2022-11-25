---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/DAY.md
---

# DAY



#### Синтаксис {#syntax}


```
DAY( datetime )
```

#### Описание {#description}
Возвращает номер дня в месяце в указанной дате `datetime`.

**Типы аргументов:**
- `datetime` — `Дата | Дата и время`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
DAY(#2019-01-23#) = 23
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
