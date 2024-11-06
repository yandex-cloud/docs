---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/RANK_UNIQUE.md
---

# RANK_UNIQUE (оконная)



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  RANK_UNIQUE( value [ , direction ] )
  ```

- Расширенный

  ```
  RANK_UNIQUE( value [ , direction ]
               [ TOTAL | WITHIN ... | AMONG ... ]
               [ BEFORE FILTER BY ... ]
             )
  ```

  Подробнее:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Выполняет уникальное ранжирование. Возвращает порядковый номер строки при сортировке по `value`. Строки, которые соответствуют одному и тому же значению `value`, имеют разные значения ранга. Ни для каких двух строк значения не совпадают. Принимает все значения от `1` до значения, которое равно количеству строк.

Если `direction` равно `"desc"` или не указано, то ранжирование происходит от большего к меньшему, если `"asc"`, то от меньшего к большему. По умолчанию используется `"desc"`.

См. также [RANK](RANK.md), [RANK_DENSE](RANK_DENSE.md), [RANK_PERCENTILE](RANK_PERCENTILE.md).

**Типы аргументов:**
- `value` — `Логический | Дата | Дата и время | Дробное число | Целое число | Строка | UUID`
- `direction` — `Строка`


**Возвращаемый тип**: `Целое число`

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
- **RANK_UNIQUE desc**: `RANK_UNIQUE(SUM([Orders]), "desc")` ;
- **RANK_UNIQUE asc**: `RANK_UNIQUE(SUM([Orders]), "asc")` .


Результат

| **City**          | **Order Sum**   | **RANK_UNIQUE desc**   | **RANK_UNIQUE asc**   |
|:------------------|:----------------|:-----------------------|:----------------------|
| `'Detroit'`       | `32`            | `1`                    | `4`                   |
| `'London'`        | `11`            | `3`                    | `2`                   |
| `'Moscow'`        | `6`             | `4`                    | `1`                   |
| `'San Francisco'` | `28`            | `2`                    | `3`                   |

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
- **RANK_UNIQUE TOTAL**: `RANK_UNIQUE(SUM([Orders]) TOTAL)` ;
- **RANK_UNIQUE WITHIN**: `RANK_UNIQUE(SUM([Orders]) WITHIN [City])` ;
- **RANK_UNIQUE AMONG**: `RANK_UNIQUE(SUM([Orders]) AMONG [City])` .


Результат

| **City**          | **Category**        | **Order Sum**   | **RANK_UNIQUE TOTAL**   | **RANK_UNIQUE WITHIN**   | **RANK_UNIQUE AMONG**   |
|:------------------|:--------------------|:----------------|:------------------------|:-------------------------|:------------------------|
| `'Detroit'`       | `'Furniture'`       | `7`             | `4`                     | `2`                      | `1`                     |
| `'Detroit'`       | `'Office Supplies'` | `25`            | `1`                     | `1`                      | `1`                     |
| `'London'`        | `'Furniture'`       | `1`             | `8`                     | `2`                      | `4`                     |
| `'London'`        | `'Office Supplies'` | `10`            | `3`                     | `1`                      | `3`                     |
| `'Moscow'`        | `'Furniture'`       | `2`             | `7`                     | `2`                      | `3`                     |
| `'Moscow'`        | `'Office Supplies'` | `4`             | `6`                     | `1`                      | `4`                     |
| `'San Francisco'` | `'Furniture'`       | `5`             | `5`                     | `2`                      | `2`                     |
| `'San Francisco'` | `'Office Supplies'` | `23`            | `2`                     | `1`                      | `2`                     |

{% endcut %}


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`.
