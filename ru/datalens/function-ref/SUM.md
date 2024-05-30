---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/SUM.md
---

# SUM

_Функция `SUM` также доступна в следующих категориях: [Оконные функции](SUM_WINDOW.md)._

#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  SUM( value )
  ```

- Расширенный

  ```
  SUM( value
       [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
       [ BEFORE FILTER BY ... ]
     )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает сумму всех значений выражения. Работает только с числовыми типами данных.

**Типы аргументов:**
- `value` — `Дробное число | Целое число`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Пример {#examples}




Исходные данные

| **City**          | **Category**        | **Orders**   | **Profit**   |
|:------------------|:--------------------|:-------------|:-------------|
| `'London'`        | `'Office Supplies'` | `8`          | `120.10`     |
| `'London'`        | `'Furniture'`       | `1`          | `750.00`     |
| `'Moscow'`        | `'Furniture'`       | `2`          | `1250.50`    |
| `'Moscow'`        | `'Office Supplies'` | `4`          | `85.34`      |
| `'San Francisco'` | `'Office Supplies'` | `23`         | `723.00`     |
| `'Detroit'`       | `'Furniture'`       | `5`          | `6205.87`    |

Группировка по `[City]`.

Сортировка по `[City]`.

Формулы:

- **City**: `[City]` ;
- **Sum Orders**: `SUM([Orders])` ;
- **Sum Profit**: `SUM([Profit])` .


Результат

| **City**          | **Sum Orders**   | **Sum Profit**   |
|:------------------|:-----------------|:-----------------|
| `'Detroit'`       | `5`              | `6205.87`        |
| `'London'`        | `9`              | `870.10`         |
| `'Moscow'`        | `6`              | `1335.84`        |
| `'San Francisco'` | `23`             | `723.00`         |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
