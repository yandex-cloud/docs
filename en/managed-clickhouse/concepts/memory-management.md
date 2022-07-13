# Memory management in {{ mch-name }}

The amount of RAM available for using {{ CH }} is specified in the [Max server memory usage]({{ ch.docs }}/operations/server-configuration-parameters/settings/#max_server_memory_usage) setting.

It also affects the maximum value of the [Max memory usage](./settings-list.md#setting-max-memory-usage) setting.

Unlike other [DBMS settings](./settings-list.md), you can't change the **Max server memory usage** setting value directly. {{ mch-name }} sets its value automatically depending on the amount of RAM available to {{ CH }} hosts:

* < 10 GB: To a value that is 1 GB less than the host's RAM.
* ≥ 10 GB: To 90% of a host's RAM.

The remaining RAM is committed to the OS and auxiliary services such as monitoring or backups.

You can only change the **Max server memory usage** setting value along with the [host class](./instance-types.md).
