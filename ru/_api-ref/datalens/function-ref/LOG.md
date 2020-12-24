---
editable: false
---

# LOG



#### Синтаксис {#syntax}


```
LOG( value, base )
```

#### Описание {#description}
Возвращает логарифм числа `value` по основанию числа `base`. Возвращает `NULL`, если число `value` меньше или равно 0.

**Типы аргументов:**
- `value` — `Число`
- `base` — `Число`


**Возвращаемый тип**: `Дробное число`

#### Примеры {#examples}

```
LOG(1, 2.6) = 0.0
```

```
LOG(1024, 2) = 10.0
```

```
LOG(100, 10) = 2.0
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
