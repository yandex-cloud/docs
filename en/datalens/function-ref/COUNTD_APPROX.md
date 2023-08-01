---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/COUNTD_APPROX.md
---

# COUNTD_APPROX



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  COUNTD_APPROX( value )
  ```

- Расширенный

  ```
  COUNTD_APPROX( value
                 [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
                 [ BEFORE FILTER BY ... ]
               )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает приблизительное количество уникальных значений в группе. Работает быстрее функции [COUNTD](COUNTD.md), но не гарантирует точность.

**Типы аргументов:**
- `value` — `Любой`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
COUNTD_APPROX([ClienID])
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Oracle Database 12c (12.1)`, `YDB`.
