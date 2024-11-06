---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/FIRST.md
---

# FIRST (оконная)



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  FIRST( value )
  ```

- Расширенный

  ```
  FIRST( value
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

Возвращает значение `value` из первой строки заданного окна. См. также [LAST](LAST.md).

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

Формулы:

- **City**: `[City]` ;
- **Category**: `[Category]` ;
- **Order Sum**: `SUM([Orders])` ;
- **FIRST TOTAL**: `FIRST(SUM([Orders]) TOTAL)` ;
- **FIRST WITHIN**: `FIRST(SUM([Orders]) WITHIN [City])` ;
- **FIRST AMONG**: `FIRST(SUM([Orders]) AMONG [City])` .


Результат

| **City**          | **Category**        | **Order Sum**   | **FIRST TOTAL**   | **FIRST WITHIN**   | **FIRST AMONG**   |
|:------------------|:--------------------|:----------------|:------------------|:-------------------|:------------------|
| `'Detroit'`       | `'Furniture'`       | `7`             | `7`               | `7`                | `7`               |
| `'Detroit'`       | `'Office Supplies'` | `25`            | `7`               | `7`                | `25`              |
| `'London'`        | `'Furniture'`       | `1`             | `7`               | `1`                | `7`               |
| `'London'`        | `'Office Supplies'` | `10`            | `7`               | `1`                | `25`              |
| `'Moscow'`        | `'Furniture'`       | `2`             | `7`               | `2`                | `7`               |
| `'Moscow'`        | `'Office Supplies'` | `4`             | `7`               | `2`                | `25`              |
| `'San Francisco'` | `'Furniture'`       | `5`             | `7`               | `5`                | `7`               |
| `'San Francisco'` | `'Office Supplies'` | `23`            | `7`               | `5`                | `25`              |

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
- **FIRST ORDER BY City**: `FIRST(SUM([Orders]) ORDER BY [City] DESC)` ;
- **FIRST ORDER BY Order Sum**: `FIRST(SUM([Orders]) ORDER BY [Order Sum])` .


Результат

| **City**          | **Order Sum**   | **FIRST ORDER BY City**   | **FIRST ORDER BY Order Sum**   |
|:------------------|:----------------|:--------------------------|:-------------------------------|
| `'Detroit'`       | `32`            | `28`                      | `6`                            |
| `'London'`        | `11`            | `28`                      | `6`                            |
| `'Moscow'`        | `6`             | `28`                      | `6`                            |
| `'San Francisco'` | `28`            | `28`                      | `6`                            |

{% endcut %}


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`.
