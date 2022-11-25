---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/COUNTD_IF.md
---

# COUNTD_IF



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  COUNTD_IF( expression, condition )
  ```

- Расширенный

  ```
  COUNTD_IF( expression, condition
             [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
             [ BEFORE FILTER BY ... ]
           )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает количество уникальных значений в группе, которые удовлетворяют условию `condition`.

См. также [COUNTD_APPROX](COUNTD_APPROX.md).

**Типы аргументов:**
- `expression` — `Любой`
- `condition` — `Логический`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
COUNTD_IF([ClientID], [Profit] > 5)
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
