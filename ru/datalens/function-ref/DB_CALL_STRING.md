---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/DB_CALL_STRING.md
---

# DB_CALL_STRING



#### Синтаксис {#syntax}


```
DB_CALL_STRING( db_function_name [ , arg_1 [ , arg_2 [ , ... ] ] ] )
```

#### Описание {#description}

{% note warning %}

Доступность и поведение нативных функций зависят от типа и версии вашей базы данных.

Нативные функции рекомендуется использовать только в том случае, если в {{ datalens-short-name }} нет функции (композиции функций), которая позволяет получить требуемый результат.

{% endnote %}

Вызывает нативную функцию базы данных по её имени. Нативная функция должна возвращать значение типа `Строка`. Функция выполняется для каждой строки в наборе данных (не агрегатная).

Первый аргумент `db_function_name` должен быть константной строкой с именем функции базы данных, которую нужно вызвать. Все последующие аргументы передаются в нативную функцию в том же порядке, в котором они записаны в формуле, и могут быть любого типа, включая типы, которые в настоящее время не поддерживаются в {{ datalens-short-name }}.

Имя функции должно содержать только буквы, цифры, нижние подчеркивания и двоеточия.

**Типы аргументов:**
- `db_function_name` — `Строка`
- `arg_1` — `Любой`
- `arg_2` — `Любой`


**Возвращаемый тип**: `Строка`

{% note info %}

Значения аргументов (`db_function_name`) должны быть константами.

{% endnote %}


#### Примеры {#examples}

```
DB_CALL_STRING("dictGetStringOrDefault", "categories", "category_name", [category_id], "other") -- ClickHouse: read from dictionary with default value
```

```
DB_CALL_STRING("JSONExtractString", [json_field], "category", "last_order_date") -- ClickHouse: extract nested JSON attribute
```

```
DB_CALL_STRING("hex", DB_CALL_STRING("SHA1", [salt_param] + [some_id])) -- ClickHouse: calculate hash with salt
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Trino`, `YDB`.
