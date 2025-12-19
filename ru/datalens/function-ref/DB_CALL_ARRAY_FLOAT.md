---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/DB_CALL_ARRAY_FLOAT.md
---

# DB_CALL_ARRAY_FLOAT



#### Синтаксис {#syntax}


```
DB_CALL_ARRAY_FLOAT( db_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ] )
```

#### Описание {#description}

{% note warning %}

Доступность и поведение нативных функций зависят от типа и версии вашей базы данных.

Нативные функции рекомендуется использовать только в том случае, если в {{ datalens-short-name }} нет функции (композиции функций), которая позволяет получить требуемый результат.

{% endnote %}

Вызывает нативную функцию базы данных по её имени. Нативная функция должна возвращать значение типа `Массив дробных чисел`. Функция выполняется для каждой строки в наборе данных (не агрегатная).

Первый аргумент `db_function_name` должен быть константной строкой с именем функции базы данных, которую нужно вызвать. Все последующие аргументы передаются в нативную функцию в том же порядке, в котором они записаны в формуле, и могут быть любого типа, включая типы, которые в настоящее время не поддерживаются в {{ datalens-short-name }}.

Имя функции должно содержать только буквы, цифры, нижние подчеркивания и двоеточия.

**Типы аргументов:**
- `db_function_name` — `Строка`
- `arg_1` — `Любой`
- `arg_2` — `Любой`


**Возвращаемый тип**: `Массив дробных чисел`

{% note info %}

Значения аргументов (`db_function_name`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

```
DB_CALL_ARRAY_FLOAT("arrayConcat", ARRAY(1.0, 2.0), ARRAY(3.0)) = ARRAY(1.0, 2.0, 3.0) -- ClickHouse: concatenate arrays of floats
```

```
DB_CALL_ARRAY_FLOAT("arrayCompact", [float_arr_field]) -- ClickHouse: remove duplicate consecutive values from array of floats
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Trino`, `YDB`.
