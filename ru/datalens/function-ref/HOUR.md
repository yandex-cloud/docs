---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/HOUR.md
---

# HOUR



#### Синтаксис {#syntax}


```
HOUR( datetime )
```

#### Описание {#description}
Возвращает номер часа в дне в указанной дате и времени `datetime`. При указании даты без времени возвращает `0`.

**Типы аргументов:**
- `datetime` — `Дата | Дата и время`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
HOUR(#2019-01-23 15:07:47#) = 15
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
