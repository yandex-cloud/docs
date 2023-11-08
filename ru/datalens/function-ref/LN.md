---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/LN.md
---

# LN



#### Синтаксис {#syntax}


```
LN( number )
```

#### Описание {#description}
Возвращает натуральный логарифм числа `number`. Возвращает `NULL`, если число меньше или равно 0.

**Типы аргументов:**
- `number` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Примеры {#examples}

```
LN(1) = 0.0
```

```
LN(EXP(2)) = 2.0
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
