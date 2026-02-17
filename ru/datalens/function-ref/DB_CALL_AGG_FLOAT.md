---
editable: false
---

# DB_CALL_AGG_FLOAT



#### Синтаксис {#syntax}

{% list tabs %}

- Стандартный

  ```
  DB_CALL_AGG_FLOAT( db_agg_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ] )
  ```

- Расширенный

  ```
  DB_CALL_AGG_FLOAT( db_agg_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ]
                     [ FIXED ... | INCLUDE ... | EXCLUDE ... ]
                     [ BEFORE FILTER BY ... ]
                   )
  ```

  Подробнее:
  - [FIXED, INCLUDE, EXCLUDE](native-functions.md#syntax-lod)
  - [BEFORE FILTER BY](native-functions.md#syntax-before-filter-by)

{% endlist %}

#### Описание {#description}

{% note warning %}

Доступность и поведение нативных функций зависят от типа и версии вашей базы данных.

Нативные функции рекомендуется использовать только в том случае, если в {{ datalens-short-name }} нет функции (композиции функций), которая позволяет получить требуемый результат.

{% endnote %}

Вызывает нативную агрегатную функцию (агрегацию) базы данных по её имени. Нативная функция должна возвращать значение типа `Дробное число`. Функция выполняется как агрегация по сгруппированным строкам.

Первый аргумент `db_agg_function_name` должен быть константной строкой с именем функции базы данных, которую нужно вызвать. Все последующие аргументы передаются в нативную функцию в том же порядке, в котором они записаны в формуле, и могут быть любого типа, включая типы, которые в настоящее время не поддерживаются в {{ datalens-short-name }}.

Имя функции должно содержать только буквы, цифры, нижние подчеркивания и двоеточия.

**Типы аргументов:**
- `db_agg_function_name` — `Строка`
- `arg_1` — `Любой`
- `arg_2` — `Любой`


**Возвращаемый тип**: `Дробное число`

{% note info %}

Значения аргументов (`db_agg_function_name`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

```
DB_CALL_AGG_FLOAT("avgWeighted", [amount], [weight_field]) -- ClickHouse: calculate weighted average of amount by weight
```

```
DB_CALL_AGG_FLOAT("corr", [x], [y]) -- ClickHouse: calculate correlation coefficient between x and y
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Trino`, `YDB`.
