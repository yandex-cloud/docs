---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/COUNTD.md
---

# COUNTD



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  COUNTD( value )
  ```

- Расширенный

  ```
  COUNTD( value
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает количество уникальных значений в группе.

См. также [COUNTD_APPROX](COUNTD_APPROX.md).

**Типы аргументов:**
- `value` — `Любой`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
COUNTD([ClientID])
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
