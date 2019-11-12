---
editable: false
---

# ISNULL

_Логические функции_

#### Синтаксис

Вариант 1:
```
ISNULL( expression )
```
Вариант 2:
```
expression IS [ NOT ] NULL
```

#### Описание
Возвращает `TRUE`, если `expression` не `NULL`. В противном случае возвращает `FALSE`.

Вариант `expression IS NOT NULL` возвращает противоположное значение.

**Типы аргументов:**
- `expression` — `Любой`


**Возвращаемый тип**: `Логический`

#### Примеры

```
ISNULL([Profit])
```

```
ISNULL("qwerty") = FALSE
```

```
"qwerty" IS NULL = FALSE
```

```
NULL IS NULL = TRUE
```

```
"qwerty" IS NOT NULL = TRUE
```

```
NULL IS NOT NULL = FALSE
```


#### Поддержка источников данных

`Материализованный датасет`, `ClickHouse 1.1`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `PostgreSQL 9.3`
