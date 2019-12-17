---
editable: false
---

# STARTSWITH

_Строковые функции_

#### Синтаксис


```
STARTSWITH( string, substring )
```

#### Описание
Возвращает `TRUE`, если строка `string` начинается на подстроку `substring`. Для регистронезависимой проверки см. [ISTARTSWITH](../ISTARTSWITH/overview.md).

**Типы аргументов:**
- `string` — `Строка`
- `substring` — `Строка`


**Возвращаемый тип**: `Логический`

#### Примеры

```
STARTSWITH("Petrov Ivan", "Petrov") = TRUE
```

```
STARTSWITH("Lorem ipsum", "Lore") = TRUE
```

```
STARTSWITH("Lorem ipsum", "abc") = FALSE
```


#### Поддержка источников данных

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
