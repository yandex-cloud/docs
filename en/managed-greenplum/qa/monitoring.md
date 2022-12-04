# Monitoring in {{ mgp-name }}

#### What metrics and processes can be tracked using monitoring? {#monitoring}

For all DBMS types, you can track:

* CPU, memory, network, or disk usage, in absolute terms.
* Memory, network, or disk usage as a percentage of the set limits for the corresponding cluster's host class.
* The amount of data in the DB cluster and the remaining free space in data storage.

For DB hosts, you can track metrics specific to the corresponding type of DBMS. For example, for {{ GP }}, you can track:

* Average query execution time
* Number of queries per second
* Number of errors in logs.

You can monitor with a minimum resolution of 5 seconds.

For more information about monitoring, see [#T](../operations/monitoring.md).

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
