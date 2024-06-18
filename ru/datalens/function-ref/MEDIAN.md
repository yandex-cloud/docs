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




Исходные данные

| **City**          | **Category**        | **Orders**   | **Profit**   |
|:------------------|:--------------------|:-------------|:-------------|
| `'London'`        | `'Office Supplies'` | `8`          | `120.10`     |
| `'London'`        | `'Furniture'`       | `1`          | `750.00`     |
| `'Moscow'`        | `'Furniture'`       | `2`          | `1250.50`    |
| `'Moscow'`        | `'Office Supplies'` | `4`          | `85.34`      |
| `'San Francisco'` | `'Office Supplies'` | `23`         | `723.00`     |
| `'San Francisco'` | `'Technology'`      | `12`         | `1542.00`    |
| `'Detroit'`       | `'Furniture'`       | `5`          | `6205.87`    |
| `'Detroit'`       | `'Technology'`      | `9`          | `2901.00`    |

Формулы:

- **Median Profit**: `MEDIAN([Profit])` .


Результат

| **Median Profit**   |
|:--------------------|
| `1250.50`           |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.4`, `YDB`.
