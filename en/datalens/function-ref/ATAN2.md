---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/ATAN2.md
---

# ATAN2



#### Синтаксис {#syntax}


```
ATAN2( x, y )
```

#### Описание {#description}
Возвращает выраженный в радианах арктангенс для заданных координат `x` и `y`.

**Типы аргументов:**
- `x` — `Дробное число | Целое число`
- `y` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Пример {#examples}

```
ATAN2(5, 7) = 0.62024
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
