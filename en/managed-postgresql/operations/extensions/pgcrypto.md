# Using pgcrypto in {{ mpg-name }}

The [pgcrypto]({{ pg-docs }}/static/pgcrypto.html) extension provides cryptographic functions that allow database administrators to store certain columns of data in encrypted form.

## Installing the pgcrypto extension in a {{ PG }} cluster {#pgcrypto-install}

[Add](./cluster-extensions.md#update-extensions) `pgcrypto` to the database.

{% note warning %}

Installing the `pgcrypto` extension will cause {{ PG }} to restart sequentially on all cluster hosts.

{% endnote %}

For more information about the `pgcrypto` extension, see the [official documentation]({{ pg-docs }}/static/pgcrypto.html).

{% include [example-pgcrypto](../../../_includes/mdb/mgp-mpg-example-pgcrypto.md) %}
