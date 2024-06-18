---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/COUNT_IF_WINDOW.md
---

# COUNT_IF (оконная)

_Функция `COUNT_IF` также доступна в следующих категориях: [Агрегатные функции](COUNT_IF.md)._

#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  COUNT_IF( expression, condition
            TOTAL | WITHIN ... | AMONG ...
          )
  ```

  Подробнее:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)

- Расширенный

  ```
  COUNT_IF( expression, condition
            TOTAL | WITHIN ... | AMONG ...
            [ BEFORE FILTER BY ... ]
          )
  ```

  Подробнее:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает количество элементов в заданном окне, которые удовлетворяют условию `expression`.

**Типы аргументов:**
- `expression` — `Дробное число | Целое число`
- `condition` — `Логический`


**Возвращаемый тип**: Совпадает с типом аргументов (`expression`)

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

Группировка по `[Date]`, `[Category]`.

Сортировка по `[Date]`, `[Category]`.

Формулы:

- **Date**: `[Date]` ;
- **Category**: `[Category]` ;
- **Profit**: `SUM([Profit])` ;
- **COUNT_IF TOTAL**: `COUNT_IF(SUM([Profit]), [Category] = 'Furniture' TOTAL)` ;
- **COUNT_IF WITHIN**: `COUNT_IF(SUM([Profit]), [Category] = 'Furniture' WITHIN [Date])` ;
- **COUNT_IF AMONG**: `COUNT_IF(SUM([Profit]), [Category] = 'Furniture' AMONG [Date])` .


Результат

| **Date**       | **Category**        | **Profit**   | **COUNT_IF TOTAL**   | **COUNT_IF WITHIN**   | **COUNT_IF AMONG**   |
|:---------------|:--------------------|:-------------|:---------------------|:----------------------|:---------------------|
| `'2019-03-01'` | `'Furniture'`       | `1000.00`    | `5.00`               | `1.00`                | `5.00`               |
| `'2019-03-01'` | `'Office Supplies'` | `843.80`     | `5.00`               | `1.00`                | `0.00`               |
| `'2019-03-02'` | `'Furniture'`       | `4950.50`    | `5.00`               | `1.00`                | `5.00`               |
| `'2019-03-03'` | `'Furniture'`       | `4000.00`    | `5.00`               | `1.00`                | `5.00`               |
| `'2019-03-03'` | `'Office Supplies'` | `85.00`      | `5.00`               | `1.00`                | `0.00`               |
| `'2019-03-04'` | `'Furniture'`       | `3500.00`    | `5.00`               | `1.00`                | `5.00`               |
| `'2019-03-04'` | `'Office Supplies'` | `1300.00`    | `5.00`               | `1.00`                | `0.00`               |
| `'2019-03-05'` | `'Furniture'`       | `750.00`     | `5.00`               | `1.00`                | `5.00`               |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
