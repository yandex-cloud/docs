[Документация Yandex Cloud](../../../index.md) > [Yandex MPP Analytics for PostgreSQL](../../index.md) > [Пошаговые инструкции](../index.md) > Расширения > try_convert

# Использование try_convert в Yandex MPP Analytics for PostgreSQL

{% note warning %}

Это расширение не поддерживается в Apache Cloudberry™.

{% endnote %}

`try_convert` — это расширение от Yandex Cloud, которое является аналогом функции [TRY_CONVERT](https://learn.microsoft.com/ru-ru/sql/t-sql/functions/try-convert-transact-sql?view=sql-server-ver17) для преобразования данных из одного типа в другой. Расширение позволяет выполнять преобразование типов при наличии ошибок во входных данных. Без использования расширения такие преобразования выполняются в pl/pgsql, что приводит к дополнительным затратам CPU.

Расширение работает только для стандартных типов данных Greenplum®. Чтобы использовать другие типы данных, добавьте их с помощью функции `add_type_for_try_convert`.

> Например:
> 
> ```sql
> SELECT add_type_for_try_convert('hstore'::regtype);
> ```

Подробнее о расширении читайте в [документации try_convert](https://github.com/open-gpdb/gpdb/tree/OPENGPDB_STABLE/contrib/try_convert).

## Установить расширение try_convert в кластер Yandex MPP Analytics for PostgreSQL {#extension-install}

1. [Подключитесь](../connect/index.md) к базе данных от имени владельца или пользователя, имеющего в базе данных разрешение `CREATE`, и выполните команду:

    ```sql
    CREATE EXTENSION try_convert;
    ```

1. Проверьте, что расширение было установлено:

    ```sql
    SELECT extname FROM pg_extension;
    ```

    Будет выведен список расширений, установленных в БД.

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

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_Apache® и Apache Cloudberry™ являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._