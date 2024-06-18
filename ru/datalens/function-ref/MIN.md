---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MIN.md
---

# MIN

_Функция `MIN` также доступна в следующих категориях: [Оконные функции](MIN_WINDOW.md)._

#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  MIN( value )
  ```

- Расширенный

  ```
  MIN( value
       [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
       [ BEFORE FILTER BY ... ]
     )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

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
- **Min Orders**: `MIN([Orders])` ;
- **Min Profit**: `MIN([Profit])` .


Результат

| **City**          | **Min Orders**   | **Min Profit**   |
|:------------------|:-----------------|:-----------------|
| `'Detroit'`       | `5`              | `2901.00`        |
| `'London'`        | `1`              | `120.10`         |
| `'Moscow'`        | `2`              | `85.34`          |
| `'San Francisco'` | `12`             | `723.00`         |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
