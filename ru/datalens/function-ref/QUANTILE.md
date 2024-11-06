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

| **Date**     | **Temperature**   |
|:-------------|:------------------|
| `2019-03-01` | `5.00`            |
| `2019-03-02` | `0.00`            |
| `2019-03-03` | `-3.00`           |
| `2019-03-04` | `1.00`            |
| `2019-03-05` | `4.00`            |
| `2019-03-06` | `5.00`            |
| `2019-03-07` | `1.00`            |
| `2019-03-08` | `-6.00`           |
| `2019-03-09` | `-6.00`           |
| `2019-03-10` | `-4.00`           |
| `2019-03-11` | `-2.00`           |
| `2019-03-12` | `0.00`            |

Формулы:

- **0.25 quantile**: `QUANTILE([Temperature], 0.25)` ;
- **0.5 quantile**: `QUANTILE([Temperature], 0.5)` ;
- **0.75 quantile**: `QUANTILE([Temperature], 0.75)` .


Результат

| **0.25 quantile**   | **0.5 quantile**   | **0.75 quantile**   |
|:--------------------|:-------------------|:--------------------|
| `-3.00`             | `0.00`             | `4.00`              |




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.4`, `Яндекс Документы`, `YDB`.
