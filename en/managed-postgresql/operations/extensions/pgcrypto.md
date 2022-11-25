# Using pgcrypto in {{ mpg-name }}

The [pgcrypto]({{ pg-docs }}/static/pgcrypto.html) extension exposes cryptographic functions that enable database administrators to store certain data columns in an encrypted format.

## Installing the pgcrypto extension in a {{ PG }} cluster {#pgcrypto-install}

[Add](./cluster-extensions.md#update-extensions) `pgcrypto` to the database.

{% note warning %}

Installing the `pgcrypto` extension will cause {{ PG }} to restart sequentially on all cluster hosts.

{% endnote %}

For more detail on the `pgcrypto` extension, please see the [official documentation]({{ pg-docs }}/static/pgcrypto.html).

{% include [example-pgcrypto](../../../_includes/mdb/mgp-mpg-example-pgcrypto.md) %}
