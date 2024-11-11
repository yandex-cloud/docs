---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/COUNT_IF.md
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

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
