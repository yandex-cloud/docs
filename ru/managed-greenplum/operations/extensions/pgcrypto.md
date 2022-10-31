# Использование pgcrypto в {{ mgp-name }}

Расширение [pgcrypto]({{ pg-docs }}/static/pgcrypto.html) предоставляет криптографические функции, которые позволяют администраторам баз данных хранить определенные столбцы данных в зашифрованном виде.

## Установить расширение pgcrypto в кластер {{ GP }} {#pgcrypto-install}

1. [Подключитесь](../connect.md) к базе данных от имени владельца или пользователя, имеющего в базе данных разрешение `CREATE`, и выполните команду:

    ```sql
    CREATE EXTENSION pgcrypto;
    ```

1. Проверьте, что расширение было установлено:

    ```sql
    SELECT extname FROM pg_extension;
    ```

Подробнее о расширении `pgcrypto` см. в [официальной документации]({{ pg-docs }}/static/pgcrypto.html).

{% include [example-pgcrypto](../../../_includes/mdb/mgp-mpg-example-pgcrypto.md) %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
