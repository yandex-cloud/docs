---
editable: false
---

# MCOUNT (оконная)



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  MCOUNT( value, rows_1 [ , rows_2 ] )
  ```

- Расширенный

  ```
  MCOUNT( value, rows_1 [ , rows_2 ]
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

Возвращает количество значений (не равных `NULL`) по окну записей, которое определяется порядком сортировки и аргументами:

| `rows_1`      | `rows_2`   | Окно                                                             |
|:--------------|:-----------|:-----------------------------------------------------------------|
| положительное | -          | Текущая запись и `rows_1` предшествующих.                        |
| отрицательное | -          | Текущая запись и -`rows_1` последующих.                          |
| любой знак    | любой знак | `rows_1` предшествующих записей, текущая и `rows_2` последующих. |



Аналогичное поведение у оконных функций [MSUM](MSUM.md), [MMIN](MMIN.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

См. также [COUNT](COUNT.md), [RCOUNT](RCOUNT.md).

**Типы аргументов:**
- `value` — `Любой`
- `rows_1` — `Целое число`
- `rows_2` — `Целое число`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

{% note info %}

Значения аргументов (`rows_1`, `rows_2`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

{% cut "Пример с двумя и тремя аргументами" %}


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

| **[City]**        | **SUM([Orders])**   | **MCOUNT(SUM([Orders]), 1)**   | **MCOUNT(SUM([Orders]), -2)**   | **MCOUNT(SUM([Orders]) 1, 1)**   |
|:------------------|:--------------------|:-------------------------------|:--------------------------------|:---------------------------------|
| `'Detroit'`       | `32`                | `1`                            | `3`                             | `2`                              |
| `'London'`        | `11`                | `2`                            | `3`                             | `3`                              |
| `'Moscow'`        | `6`                 | `2`                            | `2`                             | `3`                              |
| `'San Francisco'` | `28`                | `2`                            | `1`                             | `2`                              |

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

| **[City]**        | **SUM([Orders])**   | **MCOUNT(SUM([Orders]), 1 ORDER BY [City] DESC)**   | **MCOUNT(SUM([Orders]), 1 ORDER BY [Order Sum])**   |
|:------------------|:--------------------|:----------------------------------------------------|:----------------------------------------------------|
| `'Detroit'`       | `32`                | `2`                                                 | `2`                                                 |
| `'London'`        | `11`                | `2`                                                 | `2`                                                 |
| `'Moscow'`        | `6`                 | `2`                                                 | `1`                                                 |
| `'San Francisco'` | `28`                | `1`                                                 | `2`                                                 |

{% endcut %}

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

| **[City]**        | **[Category]**      | **SUM([Orders])**   | **MCOUNT(SUM([Orders]), 1 TOTAL)**   | **MCOUNT(SUM([Orders]), 1 WITHIN [City])**   | **MCOUNT(SUM([Orders]), 1 AMONG [City])**   |
|:------------------|:--------------------|:--------------------|:-------------------------------------|:---------------------------------------------|:--------------------------------------------|
| `'Detroit'`       | `'Furniture'`       | `7`                 | `1`                                  | `1`                                          | `1`                                         |
| `'Detroit'`       | `'Office Supplies'` | `25`                | `2`                                  | `2`                                          | `2`                                         |
| `'London'`        | `'Furniture'`       | `1`                 | `2`                                  | `1`                                          | `2`                                         |
| `'London'`        | `'Office Supplies'` | `10`                | `2`                                  | `2`                                          | `2`                                         |
| `'Moscow'`        | `'Furniture'`       | `2`                 | `2`                                  | `1`                                          | `2`                                         |
| `'Moscow'`        | `'Office Supplies'` | `4`                 | `2`                                  | `2`                                          | `2`                                         |
| `'San Francisco'` | `'Furniture'`       | `5`                 | `2`                                  | `1`                                          | `2`                                         |
| `'San Francisco'` | `'Office Supplies'` | `23`                | `2`                                  | `2`                                          | `1`                                         |

{% endcut %}


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
