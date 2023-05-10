---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/ALL_CONCAT.md
---

# ALL_CONCAT



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  ALL_CONCAT( expression [ , separator ] )
  ```

- Расширенный

  ```
  ALL_CONCAT( expression [ , separator ]
              [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
              [ BEFORE FILTER BY ... ]
            )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](aggregation-functions.md#syntax-lod)
  - [BEFORE FILTER BY](aggregation-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}
Возвращает строку, которая содержит все уникальные значения `expression`, разделенные `separator` (по умолчанию разделитель — запятая).

**Типы аргументов:**
- `expression` — `Массив дробных чисел | Массив целых числел | Массив строк | Логический | Дата | Дата и время | Дробное число | Геоточка | Геополигон | Целое число | Строка | UUID`
- `separator` — `Строка`


**Возвращаемый тип**: `Строка`

{% note info %}

Значения аргументов (`separator`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

```
ALL_CONCAT([Profit])
```

```
ALL_CONCAT([Profit], '; ')
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `PostgreSQL 9.3`, `YDB`.
