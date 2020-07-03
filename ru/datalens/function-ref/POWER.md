---
editable: false
---

# POWER

_Математические функции_

#### Синтаксис {#syntax}


```
POWER( base, power )
```

#### Описание {#description}
Возводит число `base` в степень `power`.

**Типы аргументов:**
- `base` — `Число`
- `power` — `Число`


**Возвращаемый тип**: `Дробное число`

#### Примеры {#examples}

```
POWER(2.3, 4.5) = 42.43998894277659
```

```
POWER(6, 2) = 36.0
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
