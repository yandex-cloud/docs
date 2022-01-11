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

```
IFNULL([Profit], 0)
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
