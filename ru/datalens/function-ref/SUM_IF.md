---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/SUM_IF.md
---

# SUM_IF

_Функция `SUM_IF` также доступна в следующих категориях: [Оконные функции](SUM_IF_WINDOW.md)._

#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  SUM_IF( expression, condition )
  ```

- Расширенный

  ```
  SUM_IF( expression, condition
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает сумму всех значений выражения, которые удовлетворяют условию `condition`. Работает только с числовыми типами данных.

**Типы аргументов:**
- `expression` — `Дробное число | Целое число`
- `condition` — `Логический`


**Возвращаемый тип**: Совпадает с типом аргументов (`expression`)

#### Пример {#examples}




Исходные данные

| **City**          | **Category**        | **Orders**   | **Profit**   |
|:------------------|:--------------------|:-------------|:-------------|
| `'London'`        | `'Office Supplies'` | `8`          | `120.10`     |
| `'London'`        | `'Furniture'`       | `1`          | `750.00`     |
| `'Moscow'`        | `'Furniture'`       | `2`          | `1250.50`    |
| `'Moscow'`        | `'Office Supplies'` | `4`          | `85.34`      |
| `'San Francisco'` | `'Office Supplies'` | `23`         | `723.00`     |
| `'San Francisco'` | `'Technology'`      | `12`         | `1542.00`    |
| `'Detroit'`       | `'Furniture'`       | `5`          | `6205.87`    |
| `'Detroit'`       | `'Technology'`      | `9`          | `2901.00`    |

Группировка по `[City]`.

Сортировка по `[City]`.

Формулы:

- **City**: `[City]` ;
- **Sum Orders**: `SUM_IF([Orders], [Orders] >= 5)` ;
- **Sum Profit**: `SUM_IF([Profit], [Profit] >= 500)` .


Результат

| **City**          | **Sum Orders**   | **Sum Profit**   |
|:------------------|:-----------------|:-----------------|
| `'Detroit'`       | `14`             | `9106.87`        |
| `'London'`        | `8`              | `750.00`         |
| `'Moscow'`        | `NULL`           | `1250.50`        |
| `'San Francisco'` | `35`             | `2265.00`        |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
