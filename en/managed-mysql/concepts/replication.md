# Replication

[!KEYREF mmy-name] clusters use asynchronous row-based replication. The result of a write request is reflected on the cluster replicas with a delay relative to the master. For more information about row-based replication, see the [DBMS documentation](https://dev.mysql.com/doc/refman/5.7/en/replication-rbr-usage.html).

Global transaction identifiers ([GTID](https://dev.mysql.com/doc/refman/5.7/en/replication-gtids-concepts.html)) are used, too. They help maintain the consistency of data across cluster hosts.

