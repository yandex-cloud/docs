---
title: "How to run performance diagnostics in {{ mpg-full-name }}"
description: "Follow this guide to run performance diagnostics."
---

# Performance diagnostics

For performance diagnostics, the {{ mgp-name }} cluster uses:

* In versions 6.22 and lower, a dedicated `gpperfmon` database.
* In versions 6.25 or higher, the [{{ GP }} command center](../concepts/command-center.md).

{% note info %}

Access to the `gpperfmon` database is granted on request. To get such access, contact [support]({{ link-console-support }}) or your account manager.

{% endnote %}

The `gpperfmon` database saves the statistics on the system queries and states. The `gpperfmon` database can be accessed by:

* Admin user.
* User with the `mdb_admin` role.
* User with the `gpperfmon` database privileges.

The `gpperfmon` database contains the following information tables:

* `database_history`: {{ GP }} database workload.
* `diskspace_history`: Disk space usage.
* `dynamic_memory_info`: All segments and the amount of dynamic memory used in total for each host.
* `memory_info`: Information about memory for each host from the `system_history` and `segment_history` tables.
* `network_interface_history`: Networking for each active {{ GP }} database interface.
* `queries_history`: Status of high-level queries.
* `segment_history`: Memory allocation for a {{ GP }} database segment.
* `socket_history`: Use of {{ GP }} database sockets.
* `system_history`: System usage.

To view the table, [connect to the `gpperfmon` database](../operations/connect.md) and execute the query:

```sql
SELECT * FROM <table_name>;
```

To learn more about information tables of the `gpperfmon` database, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/GUID-ref_guide-gpperfmon-dbref.html).

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
