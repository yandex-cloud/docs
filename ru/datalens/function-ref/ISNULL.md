---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/ISNULL.md
---


# ISNULL



#### Синтаксис {#syntax}

Вариант 1:
```
ISNULL( expression )
```
Вариант 2:
```
expression IS [ NOT ] NULL
```

#### Описание {#description}
Возвращает `TRUE`, если `expression` является `NULL`. В противном случае возвращает `FALSE`.

Вариант `expression IS NOT NULL` возвращает противоположное значение.

**Типы аргументов:**
- `expression` — `Любой`


**Возвращаемый тип**: `Логический`

#### Примеры {#examples}

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


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
