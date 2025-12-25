{% note warning %}

As {{ mpg-name }} does not provide load balancing, you need to configure it in your application backend, for example, by using the `libpq` library. For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-CONNECT-TARGET-SESSION-ATTRS).

Alternatively, you can use [special FQDNs](../../../managed-postgresql/operations/connect.md#special-fqdns) pointing to the read-write master host and the most up-to-date replica.

{% endnote %}
