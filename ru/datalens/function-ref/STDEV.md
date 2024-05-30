---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/STDEV.md
---

# STDEV



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  STDEV( value )
  ```

- Расширенный

  ```
  STDEV( value
         [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
         [ BEFORE FILTER BY ... ]
       )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает статистическое [стандартное отклонение](https://ru.wikipedia.org/wiki/Среднеквадратическое_отклонение) всех значений в выражении на основе выборки из совокупности.

**Типы аргументов:**
- `value` — `Дробное число | Целое число`


**Возвращаемый тип**: `Дробное число`

#### Пример {#examples}




Исходные данные

| **Month**     | **Temperature**   |
|:--------------|:------------------|
| `'January'`   | `-8.00`           |
| `'February'`  | `-4.00`           |
| `'March'`     | `-1.00`           |
| `'April'`     | `7.00`            |
| `'May'`       | `14.00`           |
| `'June'`      | `18.00`           |
| `'July'`      | `22.00`           |
| `'August'`    | `19.00`           |
| `'September'` | `13.00`           |
| `'October'`   | `5.00`            |
| `'November'`  | `1.00`            |
| `'December'`  | `-4.00`           |

Формулы:

- **Temperature SD**: `STDEV([Temperature])` .


Результат

| **Temperature SD**   |
|:---------------------|
| `10.21`              |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `YDB`.
