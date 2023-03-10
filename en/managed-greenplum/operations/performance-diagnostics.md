# Performance diagnostics

For performance diagnostics, a {{ mgp-name }} cluster uses a dedicated `gpperfmon` database in which query statistics and system states are stored. The `gpperfmon` database can be accessed by:

* An admin user.
* A user with the `mdb_admin` role.
* A user with the `gpperfmon` database privileges.

The `gpperfmon` database contains the following information tables:

* `database_history`: {{ GP }} database workload.
* `diskspace_history`: Disk space usage.
* `dynamic_memory_info`: The totality of all segments and the amount of dynamic memory used for each host.
* `memory_info`: Information about memory for each host from the `system_history` and `segment_history` tables.
* `network_interface_history`: Networking for each active {{ GP }} database interface.
* `queries_history`: The status of high-level queries.
* `segment_history`: Memory allocation for a {{ GP }} database segment.
* `socket_history`: Use of {{ GP }} database sockets.
* `system_history`: System usage.

To view the table, [connect to the `gpperfmon` database](../operations/connect.md) and execute the query:

```sql
SELECT * FROM <table name>;
```

To learn more about information tables of the `gpperfmon` database, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/GUID-ref_guide-gpperfmon-dbref.html).

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
