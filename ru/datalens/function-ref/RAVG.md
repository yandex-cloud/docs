---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/RAVG.md
---

# RAVG (оконная)



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  RAVG( value [ , direction ] )
  ```

- Расширенный

  ```
  RAVG( value [ , direction ]
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

Возвращает среднее арифметическое значений в рамках окна записей, определяемого аргументом `direction`:

| `direction`   | Окно                            |
|:--------------|:--------------------------------|
| `"asc"`       | От первой записи до текущей.    |
| `"desc"`      | От текущей записи до последней. |

По умолчанию используется значение `"asc"`.


Аналогичное поведение у оконных функций [RSUM](RSUM.md), [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RMAX](RMAX.md).

См. также [AVG](AVG.md), [MAVG](MAVG.md).

**Типы аргументов:**
- `value` — `Дробное число | Целое число`
- `direction` — `Строка`


**Возвращаемый тип**: `Целое число`

{% note info %}

Значения аргументов (`direction`) должны быть константами.

{% endnote %}


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

| **[City]**        | **[Category]**      | **SUM([Orders])**   | **RAVG(SUM([Orders]) TOTAL)**   | **RAVG(SUM([Orders]) WITHIN [City])**   | **RAVG(SUM([Orders]) AMONG [City])**   |
|:------------------|:--------------------|:--------------------|:--------------------------------|:----------------------------------------|:---------------------------------------|
| `'Detroit'`       | `'Furniture'`       | `7`                 | `7.00`                          | `7.00`                                  | `7.00`                                 |
| `'Detroit'`       | `'Office Supplies'` | `25`                | `16.00`                         | `16.00`                                 | `24.00`                                |
| `'London'`        | `'Furniture'`       | `1`                 | `11.00`                         | `1.00`                                  | `4.00`                                 |
| `'London'`        | `'Office Supplies'` | `10`                | `10.75`                         | `5.50`                                  | `15.50`                                |
| `'Moscow'`        | `'Furniture'`       | `2`                 | `9.00`                          | `2.00`                                  | `3.33`                                 |
| `'Moscow'`        | `'Office Supplies'` | `4`                 | `8.17`                          | `3.00`                                  | `17.33`                                |
| `'San Francisco'` | `'Furniture'`       | `5`                 | `7.71`                          | `5.00`                                  | `3.75`                                 |
| `'San Francisco'` | `'Office Supplies'` | `23`                | `9.62`                          | `14.00`                                 | `23.00`                                |

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

| **[City]**        | **SUM([Orders])**   | **RAVG(SUM([Orders]), "desc")**   | **RAVG(SUM([Orders]), "asc" ORDER BY [City] DESC)**   | **RAVG(SUM([Orders]) ORDER BY [Order Sum])**   |
|:------------------|:--------------------|:----------------------------------|:------------------------------------------------------|:-----------------------------------------------|
| `'Detroit'`       | `32`                | `19.25`                           | `19.25`                                               | `19.25`                                        |
| `'London'`        | `11`                | `15.00`                           | `15.00`                                               | `8.50`                                         |
| `'Moscow'`        | `6`                 | `17.00`                           | `17.00`                                               | `6.00`                                         |
| `'San Francisco'` | `28`                | `28.00`                           | `28.00`                                               | `15.00`                                        |

{% endcut %}


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
