---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/COUNT.md
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

Функцию можно использовать с константами, например, `COUNT(1)` или `COUNT()`. Если в чарте не используются другие показатели и измерения, результатом такого выражения всегда будет значение `1`. Это происходит из-за того, что в функции не указано ни одного поля, поэтому {{ datalens-short-name }} в запросе не обращается ни к одной таблице источника.

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

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
