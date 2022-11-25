---
editable: false
---

# COUNT

_Функция `COUNT` также доступна в следующих категориях: [Оконные функции](COUNT_WINDOW.md)._

#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  COUNT(  [ value ] )
  ```

- Расширенный

  ```
  COUNT(  [ value ]
         [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
         [ BEFORE FILTER BY ... ]
       )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает количество элементов в группе.

**Типы аргументов:**
- `value` — `Любой`


**Возвращаемый тип**: `Целое число`

#### Примеры {#examples}

```
COUNT()
```

```
COUNT([OrderID])
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
