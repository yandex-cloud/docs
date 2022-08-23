---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/MEDIAN.md
---

# MEDIAN



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  MEDIAN( value )
  ```

- Расширенный

  ```
  MEDIAN( value
          [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
          [ BEFORE FILTER BY ... ]
        )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Вовзращает медианное значение.

**Типы аргументов:**
- `value` — `Дата | Дата и время | Дата и время (устаревший) | Дробное число | Целое число`


**Возвращаемый тип**: Совпадает с типом аргументов (`value`)

#### Пример {#examples}

```
MEDIAN([Profit])
```


#### Поддержка источников данных {#data-source-support}

`Материализованный датасет`, `ClickHouse 19.13`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.4`, `YDB`.
