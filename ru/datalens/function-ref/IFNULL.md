---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/IFNULL.md
---

# IFNULL



#### Синтаксис {#syntax}


```
IFNULL( check_value, alt_value )
```

#### Описание {#description}
Возвращает `check_value`, если оно не `NULL`. В противном случае возвращает `alt_value`.

**Типы аргументов:**
- `check_value` — `Любой`
- `alt_value` — `Любой`


**Возвращаемый тип**: Совпадает с типом аргументов (`check_value`, `alt_value`)

{% note info %}

Тип аргументов (`check_value`, `alt_value`) должен совпадать.

{% endnote %}


#### Пример {#examples}



| **[sales]**   | **IFNULL([sales], -100.0)**   |
|:--------------|:------------------------------|
| `432.40`      | `432.40`                      |
| `77.00`       | `77.00`                       |
| `12000.00`    | `12000.00`                    |
| `NULL`        | `-100.00`                     |
| `34.25`       | `34.25`                       |
| `128.00`      | `128.00`                      |
| `0.00`        | `0.00`                        |
| `NULL`        | `-100.00`                     |




#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
