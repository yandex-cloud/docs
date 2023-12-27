# Memory management in {{ mch-name }}

The amount of RAM available for using {{ CH }} is specified in the [Max server memory usage]({{ ch.docs }}/operations/server-configuration-parameters/settings/#max_server_memory_usage) setting.

It also affects the maximum value of the [Max memory usage](./settings-list.md#setting-max-memory-usage) setting.

As opposed to other [DBMS settings](./settings-list.md), you cannot change the **Max server memory usage** setting value directly. {{ mch-name }} sets its value automatically depending on the amount of RAM available to {{ CH }} hosts:

* RAM less than 10 GB: Setting value is 1 GB less than the host's RAM.
* RAM more or equal to 10 GB and less than 40 GB: Setting value is 90% of the host's RAM.
* RAM more or equal to 40 GB: Setting value is 4 GB less than the host's RAM.

The remaining RAM is committed to the OS and auxiliary services such as monitoring or backups.

You can only change the **Max server memory usage** setting value along with the [host class](./instance-types.md).

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
