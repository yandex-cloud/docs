---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/POWER.md
---

# POWER



#### Синтаксис {#syntax}


```
POWER( base, power )
```

#### Описание {#description}
Возводит число `base` в степень `power`.

**Типы аргументов:**
- `base` — `Дробное число | Целое число`
- `power` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Примеры {#examples}

```
POWER(2.3, 4.5) = 42.43998894277659
```

```
POWER(6, 2) = 36.0
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
