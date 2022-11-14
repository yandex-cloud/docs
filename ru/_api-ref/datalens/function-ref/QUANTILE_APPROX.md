---
editable: false
---

# QUANTILE_APPROX



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  QUANTILE_APPROX( value, quant )
  ```

- Расширенный

  ```
  QUANTILE_APPROX( value, quant
                   [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
                   [ BEFORE FILTER BY ... ]
                 )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает примерный квантиль уровня `quant` (значение от 0 до 1).

**Типы аргументов:**
- `value` — `Дата | Дата и время | Дробное число | Целое число`
- `quant` — `Дробное число | Целое число`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`.
