---
editable: false
---

# ENDSWITH

_Строковые функции_

#### Синтаксис


```
ENDSWITH( string, substring )
```

#### Описание
Возвращает `TRUE`, если строка `string` оканчивается на подстроку `substring`.Для регистронезависимой проверки см. [IENDSWITH](IENDSWITH.md).

**Типы аргументов:**
- `string` — `Строка`
- `substring` — `Строка`


**Возвращаемый тип**: `Логический`

#### Примеры

```
ENDSWITH("Petrov Ivan", "Ivan") = TRUE
```

```
ENDSWITH("Lorem ipsum", "sum") = TRUE
```

```
ENDSWITH("Lorem ipsum", "abc") = FALSE
```


#### Поддержка источников данных

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
