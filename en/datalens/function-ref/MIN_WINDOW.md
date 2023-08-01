---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MIN_WINDOW.md
---

# MIN (оконная)

_Функция `MIN` также доступна в следующих категориях: [Агрегатные функции](MIN.md)._

#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  MIN( value
       TOTAL | WITHIN ... | AMONG ...
     )
  ```

  Подробнее:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)

- Расширенный

  ```
  MIN( value
       TOTAL | WITHIN ... | AMONG ...
       [ BEFORE FILTER BY ... ]
     )
  ```

  Подробнее:
  - [TOTAL, WITHIN, AMONG](window-functions.md#syntax-grouping)
  - [BEFORE FILTER BY](window-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает минимальное значение.

Если `value`:
- число — возвращает наименьшее число;
- дата — возвращает самую раннюю дату;
- строка — возвращает первое значение в алфавитном порядке.


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

Результат

| **[City]**        | **[Category]**      | **SUM([Orders])**   | **MIN(SUM([Orders]) TOTAL)**   | **MIN(SUM([Orders]) WITHIN [City])**   | **MIN(SUM([Orders]) AMONG [City])**   |
|:------------------|:--------------------|:--------------------|:-------------------------------|:---------------------------------------|:--------------------------------------|
| `'Detroit'`       | `'Furniture'`       | `7`                 | `1`                            | `7`                                    | `1`                                   |
| `'Detroit'`       | `'Office Supplies'` | `25`                | `1`                            | `7`                                    | `4`                                   |
| `'London'`        | `'Furniture'`       | `1`                 | `1`                            | `1`                                    | `1`                                   |
| `'London'`        | `'Office Supplies'` | `10`                | `1`                            | `1`                                    | `4`                                   |
| `'Moscow'`        | `'Furniture'`       | `2`                 | `1`                            | `2`                                    | `1`                                   |
| `'Moscow'`        | `'Office Supplies'` | `4`                 | `1`                            | `2`                                    | `4`                                   |
| `'San Francisco'` | `'Furniture'`       | `5`                 | `1`                            | `5`                                    | `1`                                   |
| `'San Francisco'` | `'Office Supplies'` | `23`                | `1`                            | `5`                                    | `4`                                   |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.6`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`.
