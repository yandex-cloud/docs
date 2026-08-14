---
title: Использование try_convert в {{ mgp-name }}
description: Как использовать расширение try_convert в {{ mgp-full-name }}.
---

# Использование try_convert в {{ mgp-name }}

`try_convert` — это расширение от {{ yandex-cloud }}, которое является аналогом функции [TRY_CONVERT](https://learn.microsoft.com/ru-ru/sql/t-sql/functions/try-convert-transact-sql?view=sql-server-ver17) для преобразования данных из одного типа в другой. Расширение позволяет выполнять преобразование типов при наличии ошибок во входных данных. Без использования расширения такие преобразования выполняются в pl/pgsql, что приводит к дополнительным затратам CPU.

Расширение работает только для стандартных типов данных {{ GP }}. Чтобы использовать другие типы данных, добавьте их с помощью функции `add_type_for_try_convert`.

> Например:
> 
> ```sql
> SELECT add_type_for_try_convert('hstore'::regtype);
> ```

Подробнее о расширении читайте в [документации try_convert](https://github.com/open-gpdb/gpdb/tree/OPENGPDB_STABLE/contrib/try_convert).

Для установки расширения обратитесь в [службу технической поддержки]({{ link-console-support }}).


## Примеры использования {#examples}

1. Преобразуйте текст, который можно привести к числу:

    ```sql
    SELECT TRY_CONVERT('42'::text, 0::int2);
    ```

    Будет возвращено значение `42`.

1. Преобразуйте текст, который невозможно привести к числу:

    ```sql
    SELECT TRY_CONVERT('42d'::text, 1234::int2);
    ```

    Будет возвращено значение `1234`.

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
