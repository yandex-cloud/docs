---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/YEAR.md
---

# YEAR



#### Синтаксис {#syntax}


```
YEAR( datetime )
```

#### Описание {#description}
Возвращает номер года в указанной дате `datetime`.

**Типы аргументов:**
- `datetime` — `Дата | Дата и время`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
YEAR(#2019-01-23#) = 2019
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
