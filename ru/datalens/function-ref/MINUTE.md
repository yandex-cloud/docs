---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MINUTE.md
---

# MINUTE



#### Синтаксис {#syntax}


```
MINUTE( datetime )
```

#### Описание {#description}
Возвращает номер минуты в часе в указанной дате `datetime`. При указании даты без времени возвращает 0.

**Типы аргументов:**
- `datetime` — `Дата | Дата и время | Дата и время (устаревший)`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
MINUTE(#2019-01-23 15:07:47#) = 7
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
