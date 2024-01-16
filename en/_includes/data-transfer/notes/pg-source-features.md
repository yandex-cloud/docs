
When transferring data of the `TIMESTAMP WITHOUT TIME ZONE` type, the time zone set in the `timezone` parameter of the {{ PG }} source database applies.

{% cut "Example" %}

The column with the `TIMESTAMP WITHOUT TIME ZONE` data type contains the `1970-01-01 00:00:00` value. The way the value will be transferred depends on the `timezone` parameter in the database:

* If the parameter is set to `Etc/UTC`, the time will be transferred as `1970-01-01 00:00:00+00`.
* If the parameter is set to `Europe/Moscow`, the time will be transferred as `1970-01-01 00:00:00+03`.

{% endcut %}

{% include [matview limits](../pg-gp-matview.md) %}

If the definition of the `VIEW` to be transferred contains an invocation of the `VOLATILE` [function]({{ pg.docs.org }}/current/xfunc-volatility.html), the transfer reads data from this `VIEW` with the `READ UNCOMMITTED` isolation level. No consistency between the `VIEW` data and the data of other objects being transferred is guaranteed. Reading data from a `MATERIALIZED VIEW` in the `VIEW` definition are equivalent to invoking the `VOLATILE` function.
