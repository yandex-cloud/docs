---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/DEGREES.md
---


# DEGREES



#### Синтаксис {#syntax}


```
DEGREES( radians )
```

#### Описание {#description}
Преобразует радианы в градусы.

**Типы аргументов:**
- `radians` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Примеры {#examples}

```
DEGREES(0) = 0.0
```

```
DEGREES(PI()) = 180.0
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
