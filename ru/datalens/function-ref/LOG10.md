---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/LOG10.md
---

# LOG10



#### Синтаксис {#syntax}


```
LOG10( number )
```

#### Описание {#description}
Возвращает логарифм числа `number` по основанию 10. Возвращает `NULL`, если число меньше или равно 0.

**Типы аргументов:**
- `number` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Примеры {#examples}

```
LOG10(1) = 0.0
```

```
LOG10(1000) = 3.0
```

```
LOG10(100) = 2.0
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
