---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MAX.md
---

# MAX

_Функция `MAX` также доступна в следующих категориях: [Оконные функции](MAX_WINDOW.md)._

#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  MAX( value )
  ```

- Расширенный

  ```
  MAX( value
       [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
       [ BEFORE FILTER BY ... ]
     )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

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
- **Max Orders**: `MAX([Orders])` ;
- **Max Profit**: `MAX([Profit])` .


Результат

| **City**          | **Max Orders**   | **Max Profit**   |
|:------------------|:-----------------|:-----------------|
| `'Detroit'`       | `9`              | `6205.87`        |
| `'London'`        | `8`              | `750.00`         |
| `'Moscow'`        | `4`              | `1250.50`        |
| `'San Francisco'` | `23`             | `1542.00`        |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
