---
editable: false
---

# DEGREES

_Математические функции_

#### Синтаксис {#syntax}


```
DEGREES( radians )
```

#### Описание {#description}
Преобразует радианы в градусы.

**Типы аргументов:**
- `radians` — `Число`


**Возвращаемый тип**: `Дробное число`

#### Примеры {#examples}

```
DEGREES(0) = 0.0
```

```
DEGREES(PI()) = 180.0
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
