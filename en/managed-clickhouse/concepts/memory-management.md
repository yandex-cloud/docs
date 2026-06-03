# Memory management in {{ mch-name }}

The [Max server memory usage]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#max_server_memory_usage) setting determines the amount of RAM {{ CH }} can use.

It also affects the maximum value of the [Max memory usage](./settings-list.md#setting-max-memory-usage) setting.

Unlike other [DBMS settings](./settings-list.md), you cannot directly change the **Max server memory usage** value. {{ mch-name }} sets this value automatically depending on the amount of RAM available to {{ CH }} hosts:

* RAM RAM less than 10 GB: Value is 1 GB less than the host RAM.
* RAM greater than or equal to 10 GB and less than 40 GB: Value is 90% of the host RAM.
* RAM greater than or equal to 40 GB: Value is 4 GB less than the host RAM.

The remaining RAM is reserved for the OS and auxiliary services, such as monitoring, backups, etc.

You can only change the **Max server memory usage** setting value along with the [host class](./instance-types.md).

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
