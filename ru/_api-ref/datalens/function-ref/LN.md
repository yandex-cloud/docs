---
editable: false
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

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
