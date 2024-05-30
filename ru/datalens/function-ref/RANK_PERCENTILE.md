---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/RANK_PERCENTILE.md
---

# RANK_PERCENTILE (оконная)



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  RANK_PERCENTILE( value [ , direction ] )
  ```

- Расширенный

  ```
  RANK_PERCENTILE( value [ , direction ]
                   [ TOTAL | WITHIN ... | AMONG ... ]
                   [ BEFORE FILTER BY ... ]
                 )
  ```

  Подробнее:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Выполняет относительное ранжирование. Возвращает дробный ранг (от `0` до `1`). Расчитывается как `(RANK(...) - 1) / (количество строк)`.

Если `direction` равно `"desc"` или не указано, то ранжирование происходит от большего к меньшему, если `"asc"`, то от меньшего к большему. По умолчанию используется `"desc"`.

См. также [RANK](RANK.md), [RANK_DENSE](RANK_DENSE.md), [RANK_UNIQUE](RANK_UNIQUE.md).

**Типы аргументов:**
- `value` — `Логический | Дата | Дата и время | Дробное число | Целое число | Строка | UUID`
- `direction` — `Строка`


**Возвращаемый тип**: `Дробное число`

{% note info %}

Значения аргументов (`direction`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

{% cut "Пример с двумя аргументами" %}


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
- **RANK_PERCENTILE desc**: `RANK_PERCENTILE(SUM([Orders]), "desc")` ;
- **RANK_PERCENTILE asc**: `RANK_PERCENTILE(SUM([Orders]), "asc")` .


Результат

| **City**          | **Order Sum**   | **RANK_PERCENTILE desc**   | **RANK_PERCENTILE asc**   |
|:------------------|:----------------|:---------------------------|:--------------------------|
| `'Detroit'`       | `32`            | `0.00`                     | `1.00`                    |
| `'London'`        | `11`            | `0.67`                     | `0.33`                    |
| `'Moscow'`        | `6`             | `1.00`                     | `0.00`                    |
| `'San Francisco'` | `28`            | `0.33`                     | `0.67`                    |

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
- **RANK_PERCENTILE TOTAL**: `RANK_PERCENTILE(SUM([Orders]) TOTAL)` ;
- **RANK_PERCENTILE WITHIN**: `RANK_PERCENTILE(SUM([Orders]) WITHIN [City])` ;
- **RANK_PERCENTILE AMONG**: `RANK_PERCENTILE(SUM([Orders]) AMONG [City])` .


Результат

| **City**          | **Category**        | **Order Sum**   | **RANK_PERCENTILE TOTAL**   | **RANK_PERCENTILE WITHIN**   | **RANK_PERCENTILE AMONG**   |
|:------------------|:--------------------|:----------------|:----------------------------|:-----------------------------|:----------------------------|
| `'Detroit'`       | `'Furniture'`       | `7`             | `0.43`                      | `1.00`                       | `0.00`                      |
| `'Detroit'`       | `'Office Supplies'` | `25`            | `0.00`                      | `0.00`                       | `0.00`                      |
| `'London'`        | `'Furniture'`       | `1`             | `1.00`                      | `1.00`                       | `1.00`                      |
| `'London'`        | `'Office Supplies'` | `10`            | `0.29`                      | `0.00`                       | `0.67`                      |
| `'Moscow'`        | `'Furniture'`       | `2`             | `0.86`                      | `1.00`                       | `0.67`                      |
| `'Moscow'`        | `'Office Supplies'` | `4`             | `0.71`                      | `0.00`                       | `1.00`                      |
| `'San Francisco'` | `'Furniture'`       | `5`             | `0.57`                      | `1.00`                       | `0.33`                      |
| `'San Francisco'` | `'Office Supplies'` | `23`            | `0.14`                      | `0.00`                       | `0.33`                      |

{% endcut %}


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
