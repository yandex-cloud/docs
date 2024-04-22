---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MEDIAN.md
---

# MEDIAN



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  MEDIAN( value )
  ```

- Расширенный

  ```
  MEDIAN( value
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает [медианное](https://ru.wikipedia.org/wiki/Медиана_(статистика)) значение. При четном количестве элементов возвращает наибольший из соседних элементов в центральной позиции.

**Типы аргументов:**
- `value` — `Дата | Дата и время | Дробное число | Целое число`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Пример {#examples}

```
MEDIAN([Profit])
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.4`, `YDB`.
