---
editable: false
---

# ISTARTSWITH

_Строковые функции_

#### Синтаксис


```
ISTARTSWITH( string, substring )
```

#### Описание
Регистронезависимый вариант [STARTSWITH](STARTSWITH.md). Возвращает `TRUE`, если строка `string` начинается на подстроку `substring`.

**Типы аргументов:**
- `string` — `Строка`
- `substring` — `Строка`


**Возвращаемый тип**: `Логический`

#### Примеры

```
ISTARTSWITH("petrov ivan", "Petrov") = TRUE
```

```
ISTARTSWITH("Lorem ipsum", "LORE") = TRUE
```

```
ISTARTSWITH("Lorem ipsum", "abc") = FALSE
```


#### Поддержка источников данных

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
