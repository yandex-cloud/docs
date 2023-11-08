---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/LAG.md
---

# LAG (оконная)



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  LAG( value [ , offset [ , default ] ] )
  ```

- Расширенный

  ```
  LAG( value [ , offset [ , default ] ]
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

Возвращает значение `value` из строки со смещением `offset` относительно текущей в рамках заданного окна:
- положительное значение `offset` делает смещение назад;
- отрицательное значение `offset` делает смещение вперед.

По умолчанию `offset` равно `1`.

Если значение отсутствует (`offset` ссылается на строку до первой или после последней), то возвращается значение `default` в качестве результата. Если `default` не задано, то используется `NULL`.

См. также [AGO](AGO.md) в качестве неоконной альтернативы.

**Типы аргументов:**
- `value` — `Любой`
- `offset` — `Целое число`
- `default` — `Любой`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

{% note info %}

Значения аргументов (`offset`, `default`) должны быть константами.

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

| **[City]**        | **[Category]**      | **SUM([Orders])**   | **LAG(SUM([Orders]) TOTAL)**   | **LAG(SUM([Orders]) WITHIN [City])**   | **LAG(SUM([Orders]) AMONG [City])**   |
|:------------------|:--------------------|:--------------------|:-------------------------------|:---------------------------------------|:--------------------------------------|
| `'Detroit'`       | `'Furniture'`       | `7`                 | `NULL`                         | `NULL`                                 | `NULL`                                |
| `'Detroit'`       | `'Office Supplies'` | `25`                | `7`                            | `7`                                    | `NULL`                                |
| `'London'`        | `'Furniture'`       | `1`                 | `25`                           | `NULL`                                 | `7`                                   |
| `'London'`        | `'Office Supplies'` | `10`                | `1`                            | `1`                                    | `25`                                  |
| `'Moscow'`        | `'Furniture'`       | `2`                 | `10`                           | `NULL`                                 | `1`                                   |
| `'Moscow'`        | `'Office Supplies'` | `4`                 | `2`                            | `2`                                    | `10`                                  |
| `'San Francisco'` | `'Furniture'`       | `5`                 | `4`                            | `NULL`                                 | `2`                                   |
| `'San Francisco'` | `'Office Supplies'` | `23`                | `5`                            | `5`                                    | `4`                                   |

{% endcut %}

{% cut "Пример опциональным аргументом" %}


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

| **[City]**        | **SUM([Orders])**   | **LAG(SUM([Orders]), 1)**   | **LAG(SUM([Orders]), -2)**   |
|:------------------|:--------------------|:----------------------------|:-----------------------------|
| `'Detroit'`       | `32`                | `NULL`                      | `6`                          |
| `'London'`        | `11`                | `32`                        | `28`                         |
| `'Moscow'`        | `6`                 | `11`                        | `NULL`                       |
| `'San Francisco'` | `28`                | `6`                         | `NULL`                       |

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

| **[City]**        | **SUM([Orders])**   | **LAG(SUM([Orders]) ORDER BY [City] DESC)**   | **LAG(SUM([Orders]) ORDER BY [Order Sum])**   |
|:------------------|:--------------------|:----------------------------------------------|:----------------------------------------------|
| `'Detroit'`       | `32`                | `11`                                          | `28`                                          |
| `'London'`        | `11`                | `6`                                           | `6`                                           |
| `'Moscow'`        | `6`                 | `28`                                          | `NULL`                                        |
| `'San Francisco'` | `28`                | `NULL`                                        | `11`                                          |

{% endcut %}


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
