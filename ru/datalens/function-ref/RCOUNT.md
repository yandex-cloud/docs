---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/RCOUNT.md
---

# RCOUNT (оконная)



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  RCOUNT( value [ , direction ] )
  ```

- Расширенный

  ```
  RCOUNT( value [ , direction ]
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

Возвращает количество значений в рамках окна записей, определяемого порядком сортировки и значением аргумента `direction`:

| `direction`   | Окно                            |
|:--------------|:--------------------------------|
| `"asc"`       | От первой записи до текущей.    |
| `"desc"`      | От текущей записи до последней. |

По умолчанию используется значение `"asc"`.


Аналогичное поведение у оконных функций [RSUM](RSUM.md), [RMIN](RMIN.md), [RMAX](RMAX.md), [RAVG](RAVG.md).

См. также [COUNT](COUNT.md), [MCOUNT](MCOUNT.md).

**Типы аргументов:**
- `value` — `Любой`
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

Формулы:

- **City**: `[City]` ;
- **Category**: `[Category]` ;
- **Order Sum**: `SUM([Orders])` ;
- **RCOUNT TOTAL**: `RCOUNT(SUM([Orders]) TOTAL)` ;
- **RCOUNT WITHIN**: `RCOUNT(SUM([Orders]) WITHIN [City])` ;
- **RCOUNT AMONG**: `RCOUNT(SUM([Orders]) AMONG [City])` .


Результат

| **City**          | **Category**        | **Order Sum**   | **RCOUNT TOTAL**   | **RCOUNT WITHIN**   | **RCOUNT AMONG**   |
|:------------------|:--------------------|:----------------|:-------------------|:--------------------|:-------------------|
| `'Detroit'`       | `'Furniture'`       | `7`             | `1`                | `1`                 | `1`                |
| `'Detroit'`       | `'Office Supplies'` | `25`            | `2`                | `2`                 | `1`                |
| `'London'`        | `'Furniture'`       | `1`             | `3`                | `1`                 | `2`                |
| `'London'`        | `'Office Supplies'` | `10`            | `4`                | `2`                 | `2`                |
| `'Moscow'`        | `'Furniture'`       | `2`             | `5`                | `1`                 | `3`                |
| `'Moscow'`        | `'Office Supplies'` | `4`             | `6`                | `2`                 | `3`                |
| `'San Francisco'` | `'Furniture'`       | `5`             | `7`                | `1`                 | `4`                |
| `'San Francisco'` | `'Office Supplies'` | `23`            | `8`                | `2`                 | `4`                |

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
- **RCOUNT 1**: `RCOUNT(SUM([Orders]), "desc")` ;
- **RCOUNT 2**: `RCOUNT(SUM([Orders]), "asc" ORDER BY [City] DESC)` ;
- **RCOUNT 3**: `RCOUNT(SUM([Orders]) ORDER BY [Order Sum])` .


Результат

| **City**          | **Order Sum**   | **RCOUNT 1**   | **RCOUNT 2**   | **RCOUNT 3**   |
|:------------------|:----------------|:---------------|:---------------|:---------------|
| `'Detroit'`       | `32`            | `4`            | `4`            | `4`            |
| `'London'`        | `11`            | `3`            | `3`            | `2`            |
| `'Moscow'`        | `6`             | `2`            | `2`            | `1`            |
| `'San Francisco'` | `28`            | `1`            | `1`            | `3`            |

{% endcut %}


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
