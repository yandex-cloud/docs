# Using pgcrypto in {{ mgp-name }}

The [pgcrypto]({{ pg-docs }}/static/pgcrypto.html) extension provides cryptographic functions that allow database administrators to store certain columns of data in encrypted form.

## Installing the pgcrypto extension in a {{ GP }} cluster {#pgcrypto-install}

1. [Connect](../connect.md) to a database as owner or user with the `CREATE` permission to the database and run the query below:

   ```sql
   CREATE EXTENSION pgcrypto;
   ```

1. Make sure that the extension is installed:

   ```sql
   SELECT extname FROM pg_extension;
   ```

For more information about the `pgcrypto` extension, see the [official documentation]({{ pg-docs }}/static/pgcrypto.html).

{% include [example-pgcrypto](../../../_includes/mdb/mgp-mpg-example-pgcrypto.md) %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
