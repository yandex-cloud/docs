---
editable: false
---

# COUNT_IF

_Функция `COUNT_IF` также доступна в следующих категориях: [Оконные функции](COUNT_IF_WINDOW.md)._

#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  COUNT_IF( condition )
  ```

- Расширенный

  ```
  COUNT_IF( condition
            [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
            [ BEFORE FILTER BY ... ]
          )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает количество элементов в группе, которые удовлетворяют условию `condition`.

**Типы аргументов:**
- `condition` — `Логический`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
COUNT_IF([Profit] > 5)
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
