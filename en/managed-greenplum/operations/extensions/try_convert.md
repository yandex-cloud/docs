---
title: Using try_convert in {{ mgp-name }}
description: How to use try_convert in {{ mgp-full-name }}.
---

# Using try_convert in {{ mgp-name }}

`try_convert` is a {{ yandex-cloud }} extension which works in the same way as the [TRY_CONVERT](https://learn.microsoft.com/ru-ru/sql/t-sql/functions/try-convert-transact-sql?view=sql-server-ver17) function and converts data from one type to another. This extension enables type conversions when there are errors in the input data. Without `try_convert`, such conversions are performed in pl/pgsql, resulting in increased CPU consumption.

The extension only supports the standard {{ GP }} data types. To use other data types, add them using the `add_type_for_try_convert` function.

> Here is an example:
> 
> ```sql
> SELECT add_type_for_try_convert('hstore'::regtype);
> ```

For more information about the extension, see [this try_convert guide](https://github.com/open-gpdb/gpdb/tree/OPENGPDB_STABLE/contrib/try_convert).

## Installing try_convert in a {{ GP }} cluster {#extension-install}

1. [Connect](../connect/index.md) to the database as the owner or a user with the `CREATE` permission in the database and run this command:

    ```sql
    CREATE EXTENSION try_convert;
    ```

1. Make sure the extension has been installed:

    ```sql
    SELECT extname FROM pg_extension;
    ```

    This will bring up the list of extensions installed in the database.

## Use cases {#examples}

1. Convert text that is convertible to a number:

    ```sql
    SELECT TRY_CONVERT('42'::text, 0::int2);
    ```

    The returned result is `42`.

1. Convert text that is not convertible to a number:

    ```sql
    SELECT TRY_CONVERT('42d'::text, 1234::int2);
    ```

    The returned result is `1234`.