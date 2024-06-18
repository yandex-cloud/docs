---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/QUANTILE.md
---

# QUANTILE



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  QUANTILE( value, quant )
  ```

- Расширенный

  ```
  QUANTILE( value, quant
            [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
            [ BEFORE FILTER BY ... ]
          )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает точный квантиль уровня `quant` (значение от 0 до 1).

**Типы аргументов:**
- `value` — `Дата | Дата и время | Дробное число | Целое число`
- `quant` — `Дробное число | Целое число`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

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

- **0.25 quantile**: `QUANTILE([Temperature], 0.25)` ;
- **0.5 quantile**: `QUANTILE([Temperature], 0.5)` ;
- **0.75 quantile**: `QUANTILE([Temperature], 0.75)` .


Результат

| **0.25 quantile**   | **0.5 quantile**   | **0.75 quantile**   |
|:--------------------|:-------------------|:--------------------|
| `-1.00`             | `7.00`             | `18.00`             |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.4`, `YDB`.
