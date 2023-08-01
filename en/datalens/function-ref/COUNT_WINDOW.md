---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/COUNT_WINDOW.md
---

# COUNT (оконная)

_Функция `COUNT` также доступна в следующих категориях: [Агрегатные функции](COUNT.md)._

#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  COUNT(  [ value ]
         TOTAL | WITHIN ... | AMONG ...
       )
  ```

  Подробнее:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)

- Расширенный

  ```
  COUNT(  [ value ]
         TOTAL | WITHIN ... | AMONG ...
         [ BEFORE FILTER BY ... ]
       )
  ```

  Подробнее:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает количество элементов в заданном окне.

**Типы аргументов:**
- `value` — `Любой`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}




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

| **[City]**        | **[Category]**      | **SUM([Orders])**   | **COUNT(SUM([Orders]) TOTAL)**   | **COUNT(SUM([Orders]) WITHIN [City])**   | **COUNT(SUM([Orders]) AMONG [City])**   |
|:------------------|:--------------------|:--------------------|:---------------------------------|:-----------------------------------------|:----------------------------------------|
| `'Detroit'`       | `'Furniture'`       | `7`                 | `8`                              | `2`                                      | `4`                                     |
| `'Detroit'`       | `'Office Supplies'` | `25`                | `8`                              | `2`                                      | `4`                                     |
| `'London'`        | `'Furniture'`       | `1`                 | `8`                              | `2`                                      | `4`                                     |
| `'London'`        | `'Office Supplies'` | `10`                | `8`                              | `2`                                      | `4`                                     |
| `'Moscow'`        | `'Furniture'`       | `2`                 | `8`                              | `2`                                      | `4`                                     |
| `'Moscow'`        | `'Office Supplies'` | `4`                 | `8`                              | `2`                                      | `4`                                     |
| `'San Francisco'` | `'Furniture'`       | `5`                 | `8`                              | `2`                                      | `4`                                     |
| `'San Francisco'` | `'Office Supplies'` | `23`                | `8`                              | `2`                                      | `4`                                     |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
