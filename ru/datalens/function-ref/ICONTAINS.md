---
editable: false
---

# ICONTAINS

_Строковые функции_

#### Синтаксис


```
ICONTAINS( string, substring )
```

#### Описание
Регистронезависимый вариант [CONTAINS](CONTAINS.md). Возвращает `TRUE`, если строка `string` содержит в себе подстроку `substring`.

**Типы аргументов:**
- `string` — `Строка`
- `substring` — `Строка`


**Возвращаемый тип**: `Логический`

#### Примеры

```
ICONTAINS("RU0891923", "ru") = TRUE
```

```
ICONTAINS("Lorem ipsum", "abc") = FALSE
```


#### Поддержка источников данных

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`.
