---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MSUM.md
---

# MSUM (оконная)



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  MSUM( value, rows_1 [ , rows_2 ] )
  ```

- Расширенный

  ```
  MSUM( value, rows_1 [ , rows_2 ]
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

Возвращает скользящую сумму значений по окну записей, которое определяется порядком сортировки и аргументами:

| `rows_1`      | `rows_2`   | Окно                                                             |
|:--------------|:-----------|:-----------------------------------------------------------------|
| положительное | -          | Текущая запись и `rows_1` предшествующих.                        |
| отрицательное | -          | Текущая запись и -`rows_1` последующих.                          |
| любой знак    | любой знак | `rows_1` предшествующих записей, текущая и `rows_2` последующих. |



Аналогичное поведение у оконных функций [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MMAX](MMAX.md), [MAVG](MAVG.md).

См. также [SUM](SUM.md), [RSUM](RSUM.md).

**Типы аргументов:**
- `value` — `Дробное число | Целое число`
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

| **[City]**        | **SUM([Orders])**   | **MSUM(SUM([Orders]), 1)**   | **MSUM(SUM([Orders]), -2)**   | **MSUM(SUM([Orders]) 1, 1)**   |
|:------------------|:--------------------|:-----------------------------|:------------------------------|:-------------------------------|
| `'Detroit'`       | `32`                | `32`                         | `49`                          | `43`                           |
| `'London'`        | `11`                | `43`                         | `45`                          | `49`                           |
| `'Moscow'`        | `6`                 | `17`                         | `34`                          | `45`                           |
| `'San Francisco'` | `28`                | `34`                         | `28`                          | `34`                           |

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

| **[City]**        | **SUM([Orders])**   | **MSUM(SUM([Orders]), 1 ORDER BY [City] DESC)**   | **MSUM(SUM([Orders]), 1 ORDER BY [Order Sum])**   |
|:------------------|:--------------------|:--------------------------------------------------|:--------------------------------------------------|
| `'Detroit'`       | `32`                | `43`                                              | `60`                                              |
| `'London'`        | `11`                | `17`                                              | `17`                                              |
| `'Moscow'`        | `6`                 | `34`                                              | `6`                                               |
| `'San Francisco'` | `28`                | `28`                                              | `39`                                              |

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

| **[City]**        | **[Category]**      | **SUM([Orders])**   | **MSUM(SUM([Orders]), 1 TOTAL)**   | **MSUM(SUM([Orders]), 1 WITHIN [City])**   | **MSUM(SUM([Orders]), 1 AMONG [City])**   |
|:------------------|:--------------------|:--------------------|:-----------------------------------|:-------------------------------------------|:------------------------------------------|
| `'Detroit'`       | `'Furniture'`       | `7`                 | `7`                                | `7`                                        | `7`                                       |
| `'Detroit'`       | `'Office Supplies'` | `25`                | `32`                               | `32`                                       | `48`                                      |
| `'London'`        | `'Furniture'`       | `1`                 | `26`                               | `1`                                        | `8`                                       |
| `'London'`        | `'Office Supplies'` | `10`                | `11`                               | `11`                                       | `14`                                      |
| `'Moscow'`        | `'Furniture'`       | `2`                 | `12`                               | `2`                                        | `3`                                       |
| `'Moscow'`        | `'Office Supplies'` | `4`                 | `6`                                | `6`                                        | `29`                                      |
| `'San Francisco'` | `'Furniture'`       | `5`                 | `9`                                | `5`                                        | `7`                                       |
| `'San Francisco'` | `'Office Supplies'` | `23`                | `28`                               | `28`                                       | `23`                                      |

{% endcut %}


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
