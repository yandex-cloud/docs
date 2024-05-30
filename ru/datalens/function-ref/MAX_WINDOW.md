---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MAX_WINDOW.md
---

# MAX (оконная)

_Функция `MAX` также доступна в следующих категориях: [Агрегатные функции](MAX.md)._

#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  MAX( value
       TOTAL | WITHIN ... | AMONG ...
     )
  ```

  Подробнее:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)

- Расширенный

  ```
  MAX( value
       TOTAL | WITHIN ... | AMONG ...
       [ BEFORE FILTER BY ... ]
     )
  ```

  Подробнее:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает максимальное значение.

Если `value`:
- число — возвращает наибольшее число;
- дата — возвращает самую позднюю дату;
- строка — возвращает последнее значение в алфавитном порядке.


**Типы аргументов:**
- `value` — `Логический | Дата | Дата и время | Дробное число | Целое число | Строка | UUID`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

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

Формулы:

- **City**: `[City]` ;
- **Category**: `[Category]` ;
- **Order Sum**: `SUM([Orders])` ;
- **MAX TOTAL**: `MAX(SUM([Orders]) TOTAL)` ;
- **MAX WITHIN**: `MAX(SUM([Orders]) WITHIN [City])` ;
- **MAX AMONG**: `MAX(SUM([Orders]) AMONG [City])` .


Результат

| **City**          | **Category**        | **Order Sum**   | **MAX TOTAL**   | **MAX WITHIN**   | **MAX AMONG**   |
|:------------------|:--------------------|:----------------|:----------------|:-----------------|:----------------|
| `'Detroit'`       | `'Furniture'`       | `7`             | `25`            | `25`             | `7`             |
| `'Detroit'`       | `'Office Supplies'` | `25`            | `25`            | `25`             | `25`            |
| `'London'`        | `'Furniture'`       | `1`             | `25`            | `10`             | `7`             |
| `'London'`        | `'Office Supplies'` | `10`            | `25`            | `10`             | `25`            |
| `'Moscow'`        | `'Furniture'`       | `2`             | `25`            | `4`              | `7`             |
| `'Moscow'`        | `'Office Supplies'` | `4`             | `25`            | `4`              | `25`            |
| `'San Francisco'` | `'Furniture'`       | `5`             | `25`            | `23`             | `7`             |
| `'San Francisco'` | `'Office Supplies'` | `23`            | `25`            | `23`             | `25`            |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
