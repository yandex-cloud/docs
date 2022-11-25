---
editable: false
---

# DB_CAST



#### Синтаксис {#syntax}


```
DB_CAST( expression, native_type [ , param_1 [ , param_2 ] ] )
```

#### Описание {#description}
Переводит выражение `expression` в указанный нативный тип данных `native_type`.

Поддерживаются следующие типы:

| Источник данных   | Тип данных             | Нативный тип          | Параметры нативного типа     | Комментарий                   |
|:------------------|:-----------------------|:----------------------|:-----------------------------|:------------------------------|
| `ClickHouse`      | `Дробное число`        | `Float32`             |                              |                               |
| `ClickHouse`      | `Дробное число`        | `Float64`             |                              |                               |
| `ClickHouse`      | `Дробное число`        | `Decimal`             | `Целое число`, `Целое число` |                               |
| `ClickHouse`      | `Целое число`          | `Int8`                |                              |                               |
| `ClickHouse`      | `Целое число`          | `Int16`               |                              |                               |
| `ClickHouse`      | `Целое число`          | `Int32`               |                              |                               |
| `ClickHouse`      | `Целое число`          | `Int64`               |                              |                               |
| `ClickHouse`      | `Целое число`          | `UInt8`               |                              |                               |
| `ClickHouse`      | `Целое число`          | `UInt16`              |                              |                               |
| `ClickHouse`      | `Целое число`          | `UInt32`              |                              |                               |
| `ClickHouse`      | `Целое число`          | `UInt64`              |                              |                               |
| `ClickHouse`      | `Строка`               | `String`              |                              |                               |
| `PostgreSQL`      | `Массив дробных чисел` | `double precision[]`  |                              |                               |
| `PostgreSQL`      | `Массив дробных чисел` | `real[]`              |                              |                               |
| `PostgreSQL`      | `Массив дробных чисел` | `numeric[]`           | `Целое число`, `Целое число` |                               |
| `PostgreSQL`      | `Массив целых числел`  | `smallint[]`          |                              |                               |
| `PostgreSQL`      | `Массив целых числел`  | `integer[]`           |                              |                               |
| `PostgreSQL`      | `Массив целых числел`  | `bigint[]`            |                              |                               |
| `PostgreSQL`      | `Массив строк`         | `text[]`              |                              |                               |
| `PostgreSQL`      | `Массив строк`         | `character varying[]` |                              |                               |
| `PostgreSQL`      | `Массив строк`         | `varchar[]`           |                              |                               |
| `PostgreSQL`      | `Дробное число`        | `double precision`    |                              |                               |
| `PostgreSQL`      | `Дробное число`        | `real`                |                              |                               |
| `PostgreSQL`      | `Дробное число`        | `numeric`             | `Целое число`, `Целое число` |                               |
| `PostgreSQL`      | `Целое число`          | `smallint`            |                              |                               |
| `PostgreSQL`      | `Целое число`          | `integer`             |                              |                               |
| `PostgreSQL`      | `Целое число`          | `bigint`              |                              |                               |
| `PostgreSQL`      | `Строка`               | `text`                |                              |                               |
| `PostgreSQL`      | `Строка`               | `character`           | `Целое число`                | Алиас: `char`                 |
| `PostgreSQL`      | `Строка`               | `character varying`   | `Целое число`                | Алиас: `varchar`              |
| `PostgreSQL`      | `Строка`               | `char`                | `Целое число`                | Алиас для `character`         |
| `PostgreSQL`      | `Строка`               | `varchar`             | `Целое число`                | Алиас для `character varying` |


**Типы аргументов:**
- `expression` — `Массив дробных чисел | Массив целых числел | Массив строк | Дробное число | Целое число | Строка`
- `native_type` — `Строка`
- `param_1` — `Любой`
- `param_2` — `Любой`


**Возвращаемый тип**: Совпадает с типом аргументов (`expression`)

{% note info %}

Значения аргументов (`native_type`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

```
DB_CAST([float_value], "Decimal", 10, 5)
```

```
DB_CAST([float_value], "double precision")
```

```
DB_CAST([float_value], "numeric", 10, 5)
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 19.13`, `PostgreSQL 9.3`.
