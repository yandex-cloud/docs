# Using pgcrypto in {{ mgp-name }}

The [pgcrypto]({{ pg-docs }}/static/pgcrypto.html) extension provides cryptographic functions that allow database administrators to encrypt specific table columns.

## Installing the pgcrypto extension in a {{ GP }} cluster {#pgcrypto-install}

1. [Connect](../connect/index.md) to the database as the owner or a user with the `CREATE` permission in the database and run this command:

    ```sql
    CREATE EXTENSION pgcrypto;
    ```

1. Make sure the extension has been installed:

    ```sql
    SELECT extname FROM pg_extension;
    ```

To learn more about the `pgcrypto` extension, see its [official guide]({{ pg-docs }}/static/pgcrypto.html).

{% include [example-pgcrypto](../../../_includes/mdb/mgp-mpg-example-pgcrypto.md) %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
