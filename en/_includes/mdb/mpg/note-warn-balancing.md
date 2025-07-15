{% note warning %}

{{ mpg-name }} does not do any load balancing, so you need to implement it in your app's backend, e.g., using the `libpq` library. For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-CONNECT-TARGET-SESSION-ATTRS).

Alternatively, use [special FQDNs](../../../managed-postgresql/operations/connect.md#special-fqdns) pointing at the host master available for reads and writes and the most recent replica.

{% endnote %}
