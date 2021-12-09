---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/COS.md
---


# COS



#### Синтаксис {#syntax}


```
COS( number )
```

#### Описание {#description}
Возвращает косинус числа `number`, заданного в радианах.

**Типы аргументов:**
- `number` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Примеры {#examples}

```
COS(PI()/2) = 0.0
```

```
COS(0) = 1.0
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
