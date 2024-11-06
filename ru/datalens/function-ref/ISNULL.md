---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/ISNULL.md
---

# ISNULL



#### Синтаксис {#syntax}

Как функция
```
ISNULL( expression )
```
Как оператор
```
expression IS [ NOT ] NULL
```

#### Описание {#description}
Возвращает `TRUE`, если `expression` является `NULL`. В противном случае возвращает `FALSE`.

Вариант `expression IS NOT NULL` возвращает противоположное значение.

**Типы аргументов:**
- `expression` — `Любой`


**Возвращаемый тип**: `Логический`

#### Пример {#examples}



| **[sales]**   | **ISNULL([sales])**   | **[sales] IS NULL**   | **[sales] IS NOT NULL**   |
|:--------------|:----------------------|:----------------------|:--------------------------|
| `432.40`      | `False`               | `False`               | `True`                    |
| `77.00`       | `False`               | `False`               | `True`                    |
| `12000.00`    | `False`               | `False`               | `True`                    |
| `NULL`        | `True`                | `True`                | `False`                   |
| `34.25`       | `False`               | `False`               | `True`                    |
| `128.00`      | `False`               | `False`               | `True`                    |
| `0.00`        | `False`               | `False`               | `True`                    |
| `NULL`        | `True`                | `True`                | `False`                   |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
