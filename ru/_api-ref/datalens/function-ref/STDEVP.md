---
editable: false
---

# STDEVP



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  STDEVP( value )
  ```

- Расширенный

  ```
  STDEVP( value
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает статистическое стандартное отклонение всех значений в выражении на основе смещенной совокупности.

**Типы аргументов:**
- `value` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Пример {#examples}

```
STDEVP([Profit])
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
