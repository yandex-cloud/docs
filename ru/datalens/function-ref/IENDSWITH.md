---
editable: false
---

# IENDSWITH

_Строковые функции_

#### Синтаксис


```
IENDSWITH( string, substring )
```

#### Описание
Регистронезависимый вариант [ENDSWITH](ENDSWITH.md). Возвращает `TRUE`, если строка `string` оканчивается на подстроку `substring`.

**Типы аргументов:**
- `string` — `Строка`
- `substring` — `Строка`


**Возвращаемый тип**: `Логический`

#### Примеры

```
IENDSWITH("PETROV IVAN", "Ivan") = TRUE
```

```
IENDSWITH("Lorem ipsum", "SUM") = TRUE
```

```
IENDSWITH("Lorem ipsum", "abc") = FALSE
```


#### Поддержка источников данных

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
