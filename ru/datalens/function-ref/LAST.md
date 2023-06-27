---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/LAST.md
---

# LAST (оконная)



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  LAST( value )
  ```

- Расширенный

  ```
  LAST( value
        [ TOTAL | WITHIN ... | AMONG ... ]
        [ ORDER BY ... ]
        [ BEFORE FILTER BY ... ]
      )
  ```

  Подробнее:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [ORDER BY](window-functions.md#syntax-order-by)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}

{% note warning %}

Сортировка осуществляется на основе полей, перечисленных в области сортировки в чарте и в ORDER BY. При этом сначала берутся поля из `ORDER BY`.

{% endnote %}

Возвращает значение `value` из последней строки заданного окна. См. также [FIRST](FIRST.md).

**Типы аргументов:**
- `value` — `Любой`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Примеры {#examples}

{% cut "Пример с группировкой" %}


Исходные данные

| **Date**       | **City**          | **Category**        | **Orders**   | **Profit**   |
|:---------------|:------------------|:--------------------|:-------------|:-------------|
| `'2019-03-01'` | `'London'`        | `'Office Supplies'` | `8`          | `120.80`     |
| `'2019-03-04'` | `'London'`        | `'Office Supplies'` | `2`          | `100.00`     |
| `'2019-03-05'` | `'London'`        | `'Furniture'`       | `1`          | `750.00`     |
| `'2019-03-02'` | `'Moscow'`        | `'Furniture'`       | `2`          | `1250.50`    |
| `'2019-03-03'` | `'Moscow'`        | `'Office Supplies'` | `4`          | `85.00`      |
| `'2019-03-01'` | `'San Francisco'` | `'Office Supplies'` | `23`         | `723.00`     |
| `'2019-03-01'` | `'San Francisco'` | `'Furniture'`       | `1`          | `1000.00`    |
| `'2019-03-03'` | `'San Francisco'` | `'Furniture'`       | `4`          | `4000.00`    |
| `'2019-03-02'` | `'Detroit'`       | `'Furniture'`       | `5`          | `3700.00`    |
| `'2019-03-04'` | `'Detroit'`       | `'Office Supplies'` | `25`         | `1200.00`    |
| `'2019-03-04'` | `'Detroit'`       | `'Furniture'`       | `2`          | `3500.00`    |

Группировка по `[City]`, `[Category]`.

Сортировка по `[City]`, `[Category]`.

Результат

| **[City]**        | **[Category]**      | **SUM([Orders])**   | **LAST(SUM([Orders]) TOTAL)**   | **LAST(SUM([Orders]) WITHIN [City])**   | **LAST(SUM([Orders]) AMONG [City])**   |
|:------------------|:--------------------|:--------------------|:--------------------------------|:----------------------------------------|:---------------------------------------|
| `'Detroit'`       | `'Furniture'`       | `7`                 | `23`                            | `25`                                    | `5`                                    |
| `'Detroit'`       | `'Office Supplies'` | `25`                | `23`                            | `25`                                    | `10`                                   |
| `'London'`        | `'Furniture'`       | `1`                 | `23`                            | `10`                                    | `5`                                    |
| `'London'`        | `'Office Supplies'` | `10`                | `23`                            | `10`                                    | `10`                                   |
| `'Moscow'`        | `'Furniture'`       | `2`                 | `23`                            | `4`                                     | `5`                                    |
| `'Moscow'`        | `'Office Supplies'` | `4`                 | `23`                            | `4`                                     | `10`                                   |
| `'San Francisco'` | `'Furniture'`       | `5`                 | `23`                            | `23`                                    | `5`                                    |
| `'San Francisco'` | `'Office Supplies'` | `23`                | `23`                            | `23`                                    | `10`                                   |

{% endcut %}

{% cut "Пример с ORDER BY" %}


Исходные данные

| **Date**       | **City**          | **Category**        | **Orders**   | **Profit**   |
|:---------------|:------------------|:--------------------|:-------------|:-------------|
| `'2019-03-01'` | `'London'`        | `'Office Supplies'` | `8`          | `120.80`     |
| `'2019-03-04'` | `'London'`        | `'Office Supplies'` | `2`          | `100.00`     |
| `'2019-03-05'` | `'London'`        | `'Furniture'`       | `1`          | `750.00`     |
| `'2019-03-02'` | `'Moscow'`        | `'Furniture'`       | `2`          | `1250.50`    |
| `'2019-03-03'` | `'Moscow'`        | `'Office Supplies'` | `4`          | `85.00`      |
| `'2019-03-01'` | `'San Francisco'` | `'Office Supplies'` | `23`         | `723.00`     |
| `'2019-03-01'` | `'San Francisco'` | `'Furniture'`       | `1`          | `1000.00`    |
| `'2019-03-03'` | `'San Francisco'` | `'Furniture'`       | `4`          | `4000.00`    |
| `'2019-03-02'` | `'Detroit'`       | `'Furniture'`       | `5`          | `3700.00`    |
| `'2019-03-04'` | `'Detroit'`       | `'Office Supplies'` | `25`         | `1200.00`    |
| `'2019-03-04'` | `'Detroit'`       | `'Furniture'`       | `2`          | `3500.00`    |

Группировка по `[City]`.

Сортировка по `[City]`.

Результат

| **[City]**        | **SUM([Orders])**   | **LAST(SUM([Orders]) ORDER BY [City] DESC)**   | **LAST(SUM([Orders]) ORDER BY [Order Sum])**   |
|:------------------|:--------------------|:-----------------------------------------------|:-----------------------------------------------|
| `'Detroit'`       | `32`                | `32`                                           | `32`                                           |
| `'London'`        | `11`                | `32`                                           | `32`                                           |
| `'Moscow'`        | `6`                 | `32`                                           | `32`                                           |
| `'San Francisco'` | `28`                | `32`                                           | `32`                                           |

{% endcut %}


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
