---
title: Using pgcrypto in {{ mpg-name }}
description: In this tutorial, you will learn how to use pgcrypto in {{ mpg-name }}.
---

# Using pgcrypto in {{ mpg-name }}

The [pgcrypto]({{ pg-docs }}/static/pgcrypto.html) extension provides cryptographic functions that allow database administrators to encrypt specific table columns.

## Installing pgcrypto in a {{ PG }} cluster {#pgcrypto-install}

[Enable](./cluster-extensions.md#update-extensions) the `pgcrypto` extension in your database.

{% note warning %}

Installing `pgcrypto` will trigger a rolling restart of {{ PG }} on all cluster hosts.

{% endnote %}

To learn more about the `pgcrypto` extension, see its [official documentation]({{ pg-docs }}/static/pgcrypto.html).

{% include [example-pgcrypto](../../../_includes/mdb/mgp-mpg-example-pgcrypto.md) %}
