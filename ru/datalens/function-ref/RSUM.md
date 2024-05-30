---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/RSUM.md
---

# RSUM (оконная)



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  RSUM( value [ , direction ] )
  ```

- Расширенный

  ```
  RSUM( value [ , direction ]
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

Возвращает сумму значений в рамках окна записей, определяемого порядком сортировки и значением аргумента `direction`:

| `direction`   | Окно                            |
|:--------------|:--------------------------------|
| `"asc"`       | От первой записи до текущей.    |
| `"desc"`      | От текущей записи до последней. |

По умолчанию используется значение `"asc"`.


Аналогичное поведение у оконных функций [RCOUNT](RCOUNT.md), [RMIN](RMIN.md), [RMAX](RMAX.md), [RAVG](RAVG.md).

См. также [SUM](SUM.md), [MSUM](MSUM.md).

**Типы аргументов:**
- `value` — `Дробное число | Целое число`
- `direction` — `Строка`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

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
- **RSUM TOTAL**: `RSUM(SUM([Orders]) TOTAL)` ;
- **RSUM WITHIN**: `RSUM(SUM([Orders]) WITHIN [City])` ;
- **RSUM AMONG**: `RSUM(SUM([Orders]) AMONG [City])` .


Результат

| **City**          | **Category**        | **Order Sum**   | **RSUM TOTAL**   | **RSUM WITHIN**   | **RSUM AMONG**   |
|:------------------|:--------------------|:----------------|:-----------------|:------------------|:-----------------|
| `'Detroit'`       | `'Furniture'`       | `7`             | `7`              | `7`               | `7`              |
| `'Detroit'`       | `'Office Supplies'` | `25`            | `32`             | `32`              | `25`             |
| `'London'`        | `'Furniture'`       | `1`             | `33`             | `1`               | `8`              |
| `'London'`        | `'Office Supplies'` | `10`            | `43`             | `11`              | `35`             |
| `'Moscow'`        | `'Furniture'`       | `2`             | `45`             | `2`               | `10`             |
| `'Moscow'`        | `'Office Supplies'` | `4`             | `49`             | `6`               | `39`             |
| `'San Francisco'` | `'Furniture'`       | `5`             | `54`             | `5`               | `15`             |
| `'San Francisco'` | `'Office Supplies'` | `23`            | `77`             | `28`              | `62`             |

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
- **RSUM 1**: `RSUM(SUM([Orders]), "desc")` ;
- **RSUM 2**: `RSUM(SUM([Orders]), "asc" ORDER BY [City] DESC)` ;
- **RSUM 3**: `RSUM(SUM([Orders]) ORDER BY [Order Sum])` .


Результат

| **City**          | **Order Sum**   | **RSUM 1**   | **RSUM 2**   | **RSUM 3**   |
|:------------------|:----------------|:-------------|:-------------|:-------------|
| `'Detroit'`       | `32`            | `77`         | `77`         | `77`         |
| `'London'`        | `11`            | `45`         | `45`         | `17`         |
| `'Moscow'`        | `6`             | `34`         | `34`         | `6`          |
| `'San Francisco'` | `28`            | `28`         | `28`         | `45`         |

{% endcut %}


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
