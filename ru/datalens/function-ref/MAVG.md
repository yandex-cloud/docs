---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MAVG.md
---

# MAVG (оконная)



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  MAVG( value, rows_1 [ , rows_2 ] )
  ```

- Расширенный

  ```
  MAVG( value, rows_1 [ , rows_2 ]
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

Возвращает скользящее среднее значений по окну записей. Значение определяется порядком сортировки и аргументами:

| `rows_1`      | `rows_2`   | Окно                                                             |
|:--------------|:-----------|:-----------------------------------------------------------------|
| положительное | -          | Текущая запись и `rows_1` предшествующих.                        |
| отрицательное | -          | Текущая запись и -`rows_1` последующих.                          |
| любой знак    | любой знак | `rows_1` предшествующих записей, текущая и `rows_2` последующих. |



Аналогичное поведение у оконных функций [MSUM](MSUM.md), [MCOUNT](MCOUNT.md), [MMIN](MMIN.md), [MMAX](MMAX.md).

См. также [AVG](AVG.md), [RAVG](RAVG.md).

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

Формулы:

- **City**: `[City]` ;
- **Order Sum**: `SUM([Orders])` ;
- **MAVG 1**: `MAVG(SUM([Orders]), 1)` ;
- **MAVG 2**: `MAVG(SUM([Orders]), -2)` ;
- **MAVG 3**: `MAVG(SUM([Orders]) 1, 1)` .


Результат

| **City**          | **Order Sum**   | **MAVG 1**   | **MAVG 2**   | **MAVG 3**   |
|:------------------|:----------------|:-------------|:-------------|:-------------|
| `'Detroit'`       | `32`            | `32.00`      | `16.33`      | `21.50`      |
| `'London'`        | `11`            | `21.50`      | `15.00`      | `16.33`      |
| `'Moscow'`        | `6`             | `8.50`       | `17.00`      | `15.00`      |
| `'San Francisco'` | `28`            | `17.00`      | `28.00`      | `17.00`      |

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

Формулы:

- **City**: `[City]` ;
- **Order Sum**: `SUM([Orders])` ;
- **MAVG 1**: `MAVG(SUM([Orders]), 1 ORDER BY [City] DESC)` ;
- **MAVG 2**: `MAVG(SUM([Orders]), 1 ORDER BY [Order Sum])` .


Результат

| **City**          | **Order Sum**   | **MAVG 1**   | **MAVG 2**   |
|:------------------|:----------------|:-------------|:-------------|
| `'Detroit'`       | `32`            | `21.50`      | `30.00`      |
| `'London'`        | `11`            | `8.50`       | `8.50`       |
| `'Moscow'`        | `6`             | `17.00`      | `6.00`       |
| `'San Francisco'` | `28`            | `28.00`      | `19.50`      |

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

Формулы:

- **City**: `[City]` ;
- **Category**: `[Category]` ;
- **Order Sum**: `SUM([Orders])` ;
- **MAVG 1**: `MAVG(SUM([Orders]), 1 TOTAL ORDER BY [City], [Category])` ;
- **MAVG 2**: `MAVG(SUM([Orders]), 1 WITHIN [City] ORDER BY [Category])` ;
- **MAVG 3**: `MAVG(SUM([Orders]), 1 AMONG [City] ORDER BY [City])` .


Результат

| **City**          | **Category**        | **Order Sum**   | **MAVG 1**   | **MAVG 2**   | **MAVG 3**   |
|:------------------|:--------------------|:----------------|:-------------|:-------------|:-------------|
| `'Detroit'`       | `'Furniture'`       | `7`             | `7.00`       | `7.00`       | `7.00`       |
| `'Detroit'`       | `'Office Supplies'` | `25`            | `16.00`      | `16.00`      | `25.00`      |
| `'London'`        | `'Furniture'`       | `1`             | `13.00`      | `1.00`       | `4.00`       |
| `'London'`        | `'Office Supplies'` | `10`            | `5.50`       | `5.50`       | `17.50`      |
| `'Moscow'`        | `'Furniture'`       | `2`             | `6.00`       | `2.00`       | `1.50`       |
| `'Moscow'`        | `'Office Supplies'` | `4`             | `3.00`       | `3.00`       | `7.00`       |
| `'San Francisco'` | `'Furniture'`       | `5`             | `4.50`       | `5.00`       | `3.50`       |
| `'San Francisco'` | `'Office Supplies'` | `23`            | `14.00`      | `14.00`      | `13.50`      |

{% endcut %}


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`.
